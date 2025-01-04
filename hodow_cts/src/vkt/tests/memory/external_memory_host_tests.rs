// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryExternalMemoryHostTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Copyright (c) 2017 Samsung Electronics Co., Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's class chain
// (Base <- RenderImage <- Synchronization, and Base <- BindBuffer) shares a block of
// members; here `ExternalMemoryHostBase` carries the shared ones and each test is a
// function over it. The one shader pair the render cases use is in
// shaders/manifest/memory_external_memory_host.toml.
//
// Not carried over: the `VK_KHR_portability_subset` events check in
// `checkHostSynchronizationSupport` - the Context has no portability-subset features.
//
// Drop order: `device_memory` is declared before `host_memory_alloc` so the imported
// VkDeviceMemory is freed before the host block under it; upstream's destructor frees the
// block first.

use std::alloc::{Layout, alloc, dealloc};
use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtExternalMemoryHostExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_graphics_pipeline, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entry holding the render cases' shader pair (`AddPrograms`).
#[derive(Clone, Copy)]
pub struct ExternalMemoryHostPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    format: vk::Format,
    use_offset: bool,
}

impl TestParams {
    fn new(format: vk::Format, use_offset: bool) -> Self {
        Self { format, use_offset }
    }
}

/// `checkExternalMemoryProperties`
fn check_external_memory_properties(properties: &vk::ExternalMemoryProperties) -> Result<(), TestError> {
    // If obtaining the properties did not fail, the compatible handle types should indicate our handle type at least.
    if !properties
        .compatible_handle_types
        .contains(vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT)
    {
        return Err(TestError::Fail(
            "compatibleHandleTypes does not include the host allocation bit".to_string(),
        ));
    }

    // If this is host memory, it cannot require dedicated allocation.
    if properties
        .external_memory_features
        .contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY)
    {
        return Err(TestError::Fail(
            "externalMemoryFeatures for host allocated format includes dedicated allocation bit".to_string(),
        ));
    }

    // Memory should be importable to bind it to an image or buffer.
    if !properties
        .external_memory_features
        .contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE)
    {
        return Err(TestError::Fail(
            "externalMemoryFeatures for host allocated format does not include the importable bit".to_string(),
        ));
    }
    Ok(())
}

/// `deAlignedMalloc` / `deAlignedRealloc` / `deAlignedFree`, over one owned block.
struct HostAllocation {
    ptr: *mut u8,
    size: usize,
    alignment: usize,
}

impl HostAllocation {
    fn new(size: usize, alignment: usize, failure: &str) -> Result<Self, TestError> {
        let layout = Layout::from_size_align(size, alignment).map_err(|_| TestError::Fail(failure.to_string()))?;
        let ptr = unsafe { alloc(layout) };
        if ptr.is_null() {
            return Err(TestError::Fail(failure.to_string()));
        }
        Ok(Self { ptr, size, alignment })
    }

    /// `deAlignedRealloc`: a new aligned block with the old contents copied over, then the old one freed.
    fn realloc(&mut self, new_size: usize, failure: &str) -> Result<(), TestError> {
        let mut new_block = Self::new(new_size, self.alignment, failure)?;
        unsafe { std::ptr::copy_nonoverlapping(self.ptr, new_block.ptr, self.size.min(new_size)) };
        std::mem::swap(self, &mut new_block);
        Ok(())
    }
}

impl Drop for HostAllocation {
    fn drop(&mut self) {
        if let Ok(layout) = Layout::from_size_align(self.size, self.alignment) {
            unsafe { dealloc(self.ptr, layout) };
        }
    }
}

/// `ExternalMemoryHostBaseTestInstance`'s members and helpers.
struct ExternalMemoryHostBase<'a> {
    context: &'a Context<'a>,
    memory_props: vk::PhysicalDeviceMemoryProperties,
    min_imported_host_pointer_alignment: vk::DeviceSize,
    allocation_size: vk::DeviceSize,
    device_memory_allocated_from_host_pointer: Option<Unique<'a, vk::DeviceMemory>>,
    host_memory_alloc: HostAllocation,
}

impl<'a> ExternalMemoryHostBase<'a> {
    /// The constructor, `allocationSize` being a multiple of `minImportedHostPointerAlignment`.
    fn new(context: &'a Context<'a>, allocation_size: vk::DeviceSize) -> Result<Self, TestError> {
        let memory_props = unsafe {
            context
                .get_instance()
                .get_physical_device_memory_properties(context.get_physical_device())
        };
        let min_imported_host_pointer_alignment = Self::get_min_imported_host_pointer_alignment(context)?;
        let allocation_size = min_imported_host_pointer_alignment * allocation_size;

        let host_memory_alloc = HostAllocation::new(
            allocation_size as usize,
            min_imported_host_pointer_alignment as usize,
            "Failed to allocate memory block.",
        )?;

        Ok(Self {
            context,
            memory_props,
            min_imported_host_pointer_alignment,
            allocation_size,
            device_memory_allocated_from_host_pointer: None,
            host_memory_alloc,
        })
    }

    /// `getMinImportedHostPointerAlignment`
    fn get_min_imported_host_pointer_alignment(context: &Context<'_>) -> Result<vk::DeviceSize, TestError> {
        let mut external_memory_host_properties = vk::PhysicalDeviceExternalMemoryHostPropertiesEXT::default();
        let mut properties_device_properties2 =
            vk::PhysicalDeviceProperties2::builder().push_next(&mut external_memory_host_properties);

        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties_device_properties2)
        };

        let alignment = external_memory_host_properties.min_imported_host_pointer_alignment;
        log::info!("VkPhysicalDeviceExternalMemoryHostPropertiesEXT::minImportedHostPointerAlignment is {alignment}");

        if alignment > 65536 {
            return Err(TestError::Fail(
                "minImportedHostPointerAlignment is exceeding the supported limit".to_string(),
            ));
        }

        if !alignment.is_power_of_two() {
            return Err(TestError::Fail(
                "minImportedHostPointerAlignment is not a power of two".to_string(),
            ));
        }

        Ok(alignment)
    }

    /// `getHostPointerMemoryTypeBits`
    fn get_host_pointer_memory_type_bits(&self) -> Result<u32, TestError> {
        let mut memory_host_pointer_properties = vk::MemoryHostPointerPropertiesEXT::default();

        unsafe {
            self.context.get_device().get_memory_host_pointer_properties_ext(
                vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
                self.host_memory_alloc.ptr.cast::<c_void>().cast_const(),
                &mut memory_host_pointer_properties,
            )
        }
        .vk_check("vkGetMemoryHostPointerPropertiesEXT")?;

        log::info!(
            "memoryTypeBits value: {}",
            memory_host_pointer_properties.memory_type_bits
        );

        Ok(memory_host_pointer_properties.memory_type_bits)
    }

    /// `allocateMemoryFromHostPointer`
    fn allocate_memory_from_host_pointer(
        &self,
        memory_type_index: u32,
    ) -> Result<Unique<'a, vk::DeviceMemory>, TestError> {
        let import_memory_host_pointer_info = vk::ImportMemoryHostPointerInfoEXT {
            s_type: vk::StructureType::IMPORT_MEMORY_HOST_POINTER_INFO_EXT,
            next: std::ptr::null(),
            handle_type: vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
            host_pointer: self.host_memory_alloc.ptr.cast::<c_void>(),
        };

        let memory_allocate_info = vk::MemoryAllocateInfo {
            s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
            next: (&import_memory_host_pointer_info as *const vk::ImportMemoryHostPointerInfoEXT).cast::<c_void>(),
            allocation_size: self.allocation_size,
            memory_type_index,
        };

        let device: &'a Device = self.context.get_device();
        let memory = unsafe { device.allocate_memory(&memory_allocate_info, None) }.vk_check("vkAllocateMemory")?;
        Ok(Unique::new(device, memory))
    }

    /// `logMemoryTypeIndexPropertyFlags`
    fn log_memory_type_index_property_flags(&self, index: u32) {
        log::info!("Memory Type index {index} property flags:");
        log::info!("{:?}", self.memory_props.memory_types[index as usize].property_flags);
    }

    /// `findCompatibleMemoryTypeIndexToTest`
    fn find_compatible_memory_type_index_to_test(
        &self,
        resource_memory_type_bits: u32,
        host_pointer_memory_type_bits: u32,
        memory_property_flag_bits: vk::MemoryPropertyFlags,
    ) -> Option<u32> {
        for bit_mask_position in 0..vk::MAX_MEMORY_TYPES as u32 {
            if ((resource_memory_type_bits & host_pointer_memory_type_bits) >> bit_mask_position) & 1 != 0
                && self.memory_props.memory_types[bit_mask_position as usize]
                    .property_flags
                    .contains(memory_property_flag_bits)
            {
                self.log_memory_type_index_property_flags(bit_mask_position);
                return Some(bit_mask_position);
            }
        }
        None
    }

    /// `findMemoryTypeIndexToTest`
    fn find_memory_type_index_to_test(&self, host_pointer_memory_type_bits: u32) -> Option<u32> {
        self.find_compatible_memory_type_index_to_test(
            !0u32,
            host_pointer_memory_type_bits,
            vk::MemoryPropertyFlags::empty(),
        )
    }

    /// `alignedRealloc`, followed by the `m_allocationSize` update every caller does.
    fn aligned_realloc_to(&mut self, size: vk::DeviceSize) -> Result<(), TestError> {
        self.host_memory_alloc
            .realloc(size as usize, "Failed to reallocate memory block.")?;
        self.allocation_size = size;
        Ok(())
    }

    /// `de::roundUp(requiredSize, m_minImportedHostPointerAlignment)`
    fn round_up_to_alignment(&self, size: vk::DeviceSize) -> vk::DeviceSize {
        size.div_ceil(self.min_imported_host_pointer_alignment) * self.min_imported_host_pointer_alignment
    }

    /// `ExternalMemoryHostBaseTestInstance::iterate`
    fn iterate_base(&mut self) -> TestOutcome {
        // realocate to meet requirements for host memory alignment
        self.aligned_realloc_to(self.min_imported_host_pointer_alignment)?;

        // find the usable memory type index
        let host_pointer_memory_type_bits = self.get_host_pointer_memory_type_bits()?;
        if let Some(memory_type_index_to_test) = self.find_memory_type_index_to_test(host_pointer_memory_type_bits) {
            self.device_memory_allocated_from_host_pointer =
                Some(self.allocate_memory_from_host_pointer(memory_type_index_to_test)?);
        } else {
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }

    fn imported_memory(&self) -> vk::DeviceMemory {
        self.device_memory_allocated_from_host_pointer
            .as_ref()
            .map_or(vk::DeviceMemory::null(), |m| m.get())
    }
}

/// The three per-region colours `prepareReferenceImage` paints.
fn reference_color(x: u32) -> [f32; 4] {
    if x < 50 {
        [0.0, 1.0, 0.0, 1.0]
    } else if x < 75 {
        [1.0, 0.0, 0.0, 1.0]
    } else {
        [0.0, 0.0, 1.0, 1.0]
    }
}

/// `prepareReferenceImage` into an R8G8B8A8_UNORM host block (the synchronization case asserts that format).
fn prepare_reference_image_rgba8(dst: *mut u8) {
    for w in 0..100u32 {
        for h in 0..100u32 {
            let color = reference_color(w);
            let texel = [
                (color[0] * 255.0) as u8,
                (color[1] * 255.0) as u8,
                (color[2] * 255.0) as u8,
                (color[3] * 255.0) as u8,
            ];
            unsafe { std::ptr::copy_nonoverlapping(texel.as_ptr(), dst.add(((h * 100 + w) * 4) as usize), 4) };
        }
    }
}

/// `tcu::floatThresholdCompare(..., tcu::Vec4(0.01f), ...)` of `result` against `prepareReferenceImage`'s colours.
fn compare_with_reference(result: &ConstPixelBufferAccess<'_>) -> bool {
    let threshold = 0.01f32;
    let mut max_diff = [0.0f32; 4];
    for y in 0..100 {
        for x in 0..100 {
            let pixel = result.get_pixel(x, y, 0);
            let reference = reference_color(x);
            for c in 0..4 {
                max_diff[c] = max_diff[c].max((pixel[c] - reference[c]).abs());
            }
        }
    }
    let ok = max_diff.iter().all(|&d| d <= threshold);
    if !ok {
        log::info!("Comparison failed: max difference per channel {max_diff:?}, threshold {threshold}");
    }
    ok
}

/// `createBindMemoryResultBuffer`
fn create_bind_memory_result_buffer<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
) -> Result<BufferWithMemory<'a>, TestError> {
    let pixel_size = map_vk_format(format)
        .and_then(|f| f.pixel_size())
        .ok_or_else(|| TestError::InternalError("no pixel size for the test format".to_string()))?;
    let size = 10000 * u64::from(pixel_size);

    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(
            size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )
}

/// `VkExternalMemoryBufferCreateInfo` chained buffer, as `createDataBuffer` and the bind-buffer case build it.
fn create_external_host_buffer<'a>(
    device: &'a Device,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
) -> Result<Unique<'a, vk::Buffer>, TestError> {
    let external_info = vk::ExternalMemoryBufferCreateInfo {
        s_type: vk::StructureType::EXTERNAL_MEMORY_BUFFER_CREATE_INFO,
        next: std::ptr::null(),
        handle_types: vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
    };

    let data_buffer_create_info = vk::BufferCreateInfo {
        s_type: vk::StructureType::BUFFER_CREATE_INFO,
        next: (&external_info as *const vk::ExternalMemoryBufferCreateInfo).cast::<c_void>(),
        flags: vk::BufferCreateFlags::empty(),
        size,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
    };
    let buffer = unsafe { device.create_buffer(&data_buffer_create_info, None) }.vk_check("vkCreateBuffer")?;
    Ok(Unique::new(device, buffer))
}

/// `ExternalMemoryHostRenderImageTestInstance::createImage`
fn create_image<'a>(
    device: &'a Device,
    format: vk::Format,
    tiling: vk::ImageTiling,
    usage: vk::ImageUsageFlags,
) -> Result<Unique<'a, vk::Image>, TestError> {
    let external_info = vk::ExternalMemoryImageCreateInfo {
        s_type: vk::StructureType::EXTERNAL_MEMORY_IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        handle_types: vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
    };

    let image_create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: (&external_info as *const vk::ExternalMemoryImageCreateInfo).cast::<c_void>(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: 100,
            height: 100,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };

    let image = unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?;
    Ok(Unique::new(device, image))
}

/// `ExternalMemoryHostRenderImageTestInstance::createRenderPass`
fn create_render_pass(device: &Device, format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [vk::AttachmentDescription::builder()
        .format(format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let color_attachment_ref = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_attachment_ref)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `ExternalMemoryHostRenderImageTestInstance::iterate`
fn iterate_render_image(base: &mut ExternalMemoryHostBase<'_>, params: TestParams) -> TestOutcome {
    let context = base.context;
    let vk = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();

    let clear_color_blue = vk::ClearColorValue {
        float32: [0.0, 0.0, 1.0, 1.0],
    };
    let tiling = vk::ImageTiling::LINEAR;
    let usage_flags =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

    // Create image with external host memory.
    let image = create_image(vk, params.format, tiling, usage_flags)?;

    // Check memory requirements and reallocate memory if needed.
    let image_memory_requirements = unsafe { vk.get_image_memory_requirements(*image) };

    let required_size = image_memory_requirements.size
        + if params.use_offset {
            image_memory_requirements.alignment
        } else {
            0
        };
    if required_size > base.allocation_size {
        // Reallocate block with a size that is a multiple of minImportedHostPointerAlignment.
        let new_host_allocation_size = base.round_up_to_alignment(required_size);
        base.aligned_realloc_to(new_host_allocation_size)?;

        log::info!(
            "Realloc needed (required size: {required_size}). New host allocation size: {new_host_allocation_size})."
        );
    }

    // Find the usable memory type index.
    let host_pointer_memory_type_bits = base.get_host_pointer_memory_type_bits()?;

    let Some(memory_type_index_to_test) = base.find_compatible_memory_type_index_to_test(
        image_memory_requirements.memory_type_bits,
        host_pointer_memory_type_bits,
        vk::MemoryPropertyFlags::empty(),
    ) else {
        return Err(TestError::NotSupported("Compatible memory type not found".to_string()));
    };
    base.device_memory_allocated_from_host_pointer =
        Some(base.allocate_memory_from_host_pointer(memory_type_index_to_test)?);

    unsafe {
        vk.bind_image_memory(
            *image,
            base.imported_memory(),
            if params.use_offset {
                image_memory_requirements.alignment
            } else {
                0
            },
        )
    }
    .vk_check("vkBindImageMemory")?;

    let image_view = make_image_view(
        vk,
        *image,
        vk::ImageViewType::_2D,
        params.format,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    let render_pass = create_render_pass(vk, params.format)?;
    let framebuffer = make_framebuffer(vk, *render_pass, &[*image_view], 100, 100, 1)?;

    // createBindMemoryInitializeVertexBuffer
    let triangle_data: [f32; 16] = [
        -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, -1.0, 0.0, 1.0,
    ];
    let vertex_buffer = BufferWithMemory::new(
        vk,
        context.get_default_allocator(),
        make_buffer_create_info(
            std::mem::size_of_val(&triangle_data) as u64,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let alloc = vertex_buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                triangle_data.as_ptr().cast::<u8>(),
                alloc.get_host_ptr(),
                std::mem::size_of_val(&triangle_data),
            )
        };
        flush_alloc(vk, alloc)?;
    }
    let result_buffer = create_bind_memory_result_buffer(context, params.format)?;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL)
        .build(vk)?;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;

    // createAndUpdateDescriptorSet
    let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;
    let descriptor_info = make_descriptor_buffer_info(vertex_buffer.get(), 0, (std::mem::size_of::<f32>() * 16) as u64);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            *descriptor_set,
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &descriptor_info,
        )
        .update(vk);

    let binaries = context.get_binary_collection();
    let vertex_shader_module = create_shader_module(vk, binaries.get("position_only.vert")?)?;
    let fragment_shader_module = create_shader_module(vk, binaries.get("only_color_out.frag")?)?;

    let pipeline = make_graphics_pipeline(
        vk,
        *pipeline_layout,
        *vertex_shader_module,
        *fragment_shader_module,
        *render_pass,
        (100, 100),
        vk::PrimitiveTopology::TRIANGLE_FAN,
    )?;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    begin_command_buffer(vk, *cmd_buffer)?;

    let sub_range_color = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

    // clear(clearColorBlue)
    {
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            *image,
            sub_range_color,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            vk.cmd_clear_color_image(
                *cmd_buffer,
                *image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color_blue,
                &[sub_range_color],
            );
        }
    }

    // draw()
    {
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            *image,
            sub_range_color,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
        }

        let render_pass_clear = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [1.0, 0.0, 0.0, 1.0],
            },
        };
        begin_render_pass(
            vk,
            *cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, 75, 100),
            render_pass_clear,
        );
        unsafe {
            vk.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            vk.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[],
            );
            vk.cmd_draw(*cmd_buffer, 4, 1, 0, 0);
        }
        end_render_pass(vk, *cmd_buffer);
    }

    // copyResultImagetoBuffer
    copy_image_to_buffer(vk, *cmd_buffer, *image, result_buffer.get(), (100, 100));

    end_command_buffer(vk, *cmd_buffer)?;

    submit_commands_and_wait(vk, queue, *cmd_buffer)?;

    let tcu_format = map_vk_format(params.format)
        .ok_or_else(|| TestError::InternalError("no texture format for the test format".to_string()))?;
    let pixel_size = tcu_format.pixel_size().unwrap_or(4) as usize;
    let result_data = unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr().cast_const(),
            100 * 100 * pixel_size,
        )
    };
    let result = ConstPixelBufferAccess::new(tcu_format, [100, 100, 1], result_data);

    if !compare_with_reference(&result) {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `vk::copyImageToBuffer` for a single-layer 2D colour image left in COLOR_ATTACHMENT_OPTIMAL.
fn copy_image_to_buffer(
    vk: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    size: (u32, u32),
) {
    let image_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );

        let subresource = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width: size.0,
                height: size.1,
                depth: 1,
            },
            subresource,
        );
        vk.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[region],
        );

        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer,
            0,
            vk::WHOLE_SIZE,
        );
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `ExternalMemoryHostSynchronizationTestInstance::iterate`
fn iterate_synchronization(base: &mut ExternalMemoryHostBase<'_>, params: TestParams) -> TestOutcome {
    debug_assert!(params.format == vk::Format::R8G8B8A8_UNORM);

    let context = base.context;
    let vk = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();

    let pixel_size = map_vk_format(params.format)
        .and_then(|f| f.pixel_size())
        .ok_or_else(|| TestError::InternalError("no pixel size for the test format".to_string()))?;
    let data_buffer_size: vk::DeviceSize = 10000 * u64::from(pixel_size);
    let usage_flags = vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC;

    let data_buffer = create_external_host_buffer(vk, data_buffer_size, usage_flags)?;

    // check memory requirements
    let buffer_memory_requirements = unsafe { vk.get_buffer_memory_requirements(*data_buffer) };
    let required_size = buffer_memory_requirements.size;
    // reallocate memory if needed
    if required_size > base.allocation_size {
        let new_host_allocation_size = base.round_up_to_alignment(required_size);

        log::info!(
            "Realloc needed (required size: {required_size}). New host allocation size: {new_host_allocation_size})."
        );

        base.aligned_realloc_to(new_host_allocation_size)?;
    }

    // find the usable memory type index
    let host_pointer_memory_type_bits = base.get_host_pointer_memory_type_bits()?;
    let Some(memory_type_index_to_test) = base.find_compatible_memory_type_index_to_test(
        buffer_memory_requirements.memory_type_bits,
        host_pointer_memory_type_bits,
        vk::MemoryPropertyFlags::HOST_VISIBLE,
    ) else {
        return Err(TestError::NotSupported("Compatible memory type not found".to_string()));
    };
    base.device_memory_allocated_from_host_pointer =
        Some(base.allocate_memory_from_host_pointer(memory_type_index_to_test)?);

    unsafe { vk.bind_buffer_memory(*data_buffer, base.imported_memory(), 0) }.vk_check("vkBindBufferMemory")?;

    let result_buffer = create_bind_memory_result_buffer(context, params.format)?;
    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer_copy = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let fence_1 = create_fence(vk)?;
    let fence_2 = create_fence(vk)?;

    // record first command buffer
    begin_command_buffer(vk, *cmd_buffer)?;
    fill_buffer(vk, *cmd_buffer, *data_buffer, data_buffer_size);
    end_command_buffer(vk, *cmd_buffer)?;

    // record second command buffer
    begin_command_buffer(vk, *cmd_buffer_copy)?;
    copy_result_buffer_to_buffer(
        vk,
        *cmd_buffer_copy,
        *data_buffer,
        result_buffer.get(),
        data_buffer_size,
    );
    end_command_buffer(vk, *cmd_buffer_copy)?;

    submit_commands(vk, queue, *cmd_buffer, *fence_1)?;

    let semaphore_wait_value: u64 = 1;
    let semaphore_wait_stage = vk::PipelineStageFlags::TRANSFER;
    let semaphore = {
        let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
            .semaphore_type(vk::SemaphoreType::TIMELINE)
            .initial_value(0);
        let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
        let semaphore = unsafe { vk.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
        Unique::new(vk, semaphore)
    };

    // Use timeline semaphore to signal from host.
    let wait_semaphore_values = [semaphore_wait_value];
    let mut timeline_wait_submit_info =
        vk::TimelineSemaphoreSubmitInfo::builder().wait_semaphore_values(&wait_semaphore_values);
    let wait_semaphores = [*semaphore];
    let wait_stages = [semaphore_wait_stage];
    let command_buffers = [*cmd_buffer_copy];
    let submit = vk::SubmitInfo::builder()
        .push_next(&mut timeline_wait_submit_info)
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&wait_stages)
        .command_buffers(&command_buffers);
    unsafe { vk.queue_submit(queue, &[submit], *fence_2) }.vk_check("vkQueueSubmit")?;

    // wait for fence_1 and modify image on host
    unsafe { vk.wait_for_fences(&[*fence_1], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    let imported_memory = base.imported_memory();
    let pointer_returned_by_map_memory =
        unsafe { vk.map_memory(imported_memory, 0, base.allocation_size, vk::MemoryMapFlags::empty()) }
            .vk_check("vkMapMemory")?;
    let whole_range = vk::MappedMemoryRange {
        s_type: vk::StructureType::MAPPED_MEMORY_RANGE,
        next: std::ptr::null(),
        memory: imported_memory,
        offset: 0,
        size: vk::WHOLE_SIZE,
    };
    unsafe { vk.invalidate_mapped_memory_ranges(&[whole_range]) }.vk_check("vkInvalidateMappedMemoryRanges")?;
    prepare_reference_image_rgba8(base.host_memory_alloc.ptr);
    unsafe { vk.flush_mapped_memory_ranges(&[whole_range]) }.vk_check("vkFlushMappedMemoryRanges")?;
    // compare memory pointed by both pointers
    let host_bytes =
        unsafe { std::slice::from_raw_parts(base.host_memory_alloc.ptr.cast_const(), data_buffer_size as usize) };
    let mapped_bytes = unsafe {
        std::slice::from_raw_parts(
            pointer_returned_by_map_memory.cast::<u8>().cast_const(),
            data_buffer_size as usize,
        )
    };
    if host_bytes != mapped_bytes {
        unsafe { vk.unmap_memory(imported_memory) };
        return Ok(TestStatus::fail("Failed memcmp check."));
    }
    unsafe { vk.unmap_memory(imported_memory) };

    // Signal from host
    let signal_info = vk::SemaphoreSignalInfo {
        s_type: vk::StructureType::SEMAPHORE_SIGNAL_INFO,
        next: std::ptr::null(),
        semaphore: *semaphore,
        value: semaphore_wait_value,
    };
    unsafe { vk.signal_semaphore(&signal_info) }.vk_check("vkSignalSemaphore")?;

    // wait for fence_2 before checking result
    unsafe { vk.wait_for_fences(&[*fence_2], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    let result_data = unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr().cast_const(),
            100 * 100 * pixel_size as usize,
        )
    };
    let tcu_format = map_vk_format(params.format)
        .ok_or_else(|| TestError::InternalError("no texture format for the test format".to_string()))?;
    let result = ConstPixelBufferAccess::new(tcu_format, [100, 100, 1], result_data);

    if !compare_with_reference(&result) {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `createFence(vk, device)`
fn create_fence(vk: &Device) -> Result<Unique<'_, vk::Fence>, TestError> {
    let info = vk::FenceCreateInfo::builder();
    let fence = unsafe { vk.create_fence(&info, None) }.vk_check("vkCreateFence")?;
    Ok(Unique::new(vk, fence))
}

/// `ExternalMemoryHostSynchronizationTestInstance::submitCommands`
fn submit_commands(
    vk: &Device,
    queue: vk::Queue,
    command_buffer: vk::CommandBuffer,
    fence: vk::Fence,
) -> Result<(), TestError> {
    let command_buffers = [command_buffer];
    let submit_info = vk::SubmitInfo::builder().command_buffers(&command_buffers);
    unsafe { vk.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")
}

/// `ExternalMemoryHostSynchronizationTestInstance::fillBuffer`
fn fill_buffer(vk: &Device, cmd_buffer: vk::CommandBuffer, data_buffer: vk::Buffer, size: vk::DeviceSize) {
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        data_buffer,
        0,
        size,
    );
    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );

        vk.cmd_fill_buffer(cmd_buffer, data_buffer, 0, size, 0xFFFFFFFF);
    }

    let mut buffer_barrier = buffer_barrier;
    buffer_barrier.src_access_mask = vk::AccessFlags::TRANSFER_WRITE;
    buffer_barrier.dst_access_mask = vk::AccessFlags::HOST_WRITE;

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `ExternalMemoryHostSynchronizationTestInstance::copyResultBuffertoBuffer`
fn copy_result_buffer_to_buffer(
    vk: &Device,
    cmd_buffer_copy: vk::CommandBuffer,
    data_buffer: vk::Buffer,
    result_buffer: vk::Buffer,
    size: vk::DeviceSize,
) {
    let mut buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::HOST_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        data_buffer,
        0,
        size,
    );

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer_copy,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );

        let region_all = vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size,
        };

        vk.cmd_copy_buffer(cmd_buffer_copy, data_buffer, result_buffer, &[region_all]);
    }

    buffer_barrier.src_access_mask = vk::AccessFlags::TRANSFER_WRITE;
    buffer_barrier.dst_access_mask = vk::AccessFlags::HOST_READ;
    buffer_barrier.buffer = result_buffer;

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer_copy,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `ExternalMemoryHostBindBufferTestInstance::iterate`
fn iterate_bind_buffer(base: &mut ExternalMemoryHostBase<'_>) -> TestOutcome {
    let context = base.context;
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();

    let offset = 3u32;
    let element_count = 64u32;
    let buffer_size = u64::from(element_count) * std::mem::size_of::<u32>() as u64;

    let buffer = create_external_host_buffer(
        vk,
        buffer_size,
        vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
    )?;
    let buffer_memory_requirements = unsafe { vk.get_buffer_memory_requirements(*buffer) };

    let bind_offset: vk::DeviceSize = u64::from(offset) * buffer_memory_requirements.alignment;
    let required_size = bind_offset + buffer_memory_requirements.size;

    if required_size > base.allocation_size {
        // Reallocate block with a size that is a multiple of minImportedHostPointerAlignment.
        let new_host_allocation_size = base.round_up_to_alignment(required_size);
        base.aligned_realloc_to(new_host_allocation_size)?;

        log::info!(
            "Realloc needed (required size: {required_size}). New host allocation size: {new_host_allocation_size})."
        );
    }

    let host_pointer_memory_type_bits = base.get_host_pointer_memory_type_bits()?;
    let Some(memory_type_index_to_test) = base.find_compatible_memory_type_index_to_test(
        buffer_memory_requirements.memory_type_bits,
        host_pointer_memory_type_bits,
        vk::MemoryPropertyFlags::HOST_VISIBLE,
    ) else {
        return Err(TestError::NotSupported("Compatible memory type not found".to_string()));
    };
    base.device_memory_allocated_from_host_pointer =
        Some(base.allocate_memory_from_host_pointer(memory_type_index_to_test)?);
    let imported_memory = base.imported_memory();

    // Upstream drops this result too.
    let _ = unsafe { vk.bind_buffer_memory(*buffer, imported_memory, bind_offset) };

    let source_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let result_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let host_data: Vec<u32> = (0..element_count).map(|i| element_count + i).collect();
    let device_data: Vec<u32> = (0..element_count).collect();

    let source_buffer_alloc = source_buffer.get_allocation();
    unsafe {
        std::ptr::copy_nonoverlapping(
            device_data.as_ptr().cast::<u8>(),
            source_buffer_alloc.get_host_ptr(),
            buffer_size as usize,
        )
    };
    flush_alloc(vk, source_buffer_alloc)?;

    let host_allocation_size = base.allocation_size as usize;
    let mut initial_contents = vec![123u8; host_allocation_size];
    let host_data_bytes = unsafe { std::slice::from_raw_parts(host_data.as_ptr().cast::<u8>(), buffer_size as usize) };
    initial_contents[bind_offset as usize..bind_offset as usize + buffer_size as usize]
        .copy_from_slice(host_data_bytes);

    let mapped_ptr = unsafe { vk.map_memory(imported_memory, 0, base.allocation_size, vk::MemoryMapFlags::empty()) }
        .vk_check("vkMapMemory")?;
    unsafe { std::ptr::copy_nonoverlapping(initial_contents.as_ptr(), mapped_ptr.cast::<u8>(), host_allocation_size) };
    let whole_range = vk::MappedMemoryRange {
        s_type: vk::StructureType::MAPPED_MEMORY_RANGE,
        next: std::ptr::null(),
        memory: imported_memory,
        offset: 0,
        size: vk::WHOLE_SIZE,
    };
    unsafe { vk.flush_mapped_memory_ranges(&[whole_range]) }.vk_check("vkFlushMappedMemoryRanges")?;

    let cmd_pool = {
        let info = vk::CommandPoolCreateInfo::builder().queue_family_index(queue_family_index);
        let pool = unsafe { vk.create_command_pool(&info, None) }.vk_check("vkCreateCommandPool")?;
        Unique::new(vk, pool)
    };
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    begin_command_buffer(vk, *cmd_buffer)?;
    let host_write_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::HOST_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        *buffer,
        0,
        buffer_size,
    );
    unsafe {
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[host_write_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    let region = vk::BufferCopy {
        src_offset: 0,
        dst_offset: 0,
        size: buffer_size,
    };
    unsafe { vk.cmd_copy_buffer(*cmd_buffer, *buffer, result_buffer.get(), &[region]) };

    let copy_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_READ,
        vk::AccessFlags::TRANSFER_WRITE,
        *buffer,
        0,
        buffer_size,
    );
    unsafe {
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[copy_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );

        vk.cmd_copy_buffer(*cmd_buffer, source_buffer.get(), *buffer, &[region]);
    }

    let host_read_barriers = [
        make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            *buffer,
            0,
            buffer_size,
        ),
        make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            result_buffer.get(),
            0,
            buffer_size,
        ),
    ];
    unsafe {
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &host_read_barriers,
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(vk, *cmd_buffer)?;
    submit_commands_and_wait(vk, queue, *cmd_buffer)?;

    let result_buffer_alloc = result_buffer.get_allocation();
    invalidate_alloc(vk, result_buffer_alloc)?;
    unsafe { vk.invalidate_mapped_memory_ranges(&[whole_range]) }.vk_check("vkInvalidateMappedMemoryRanges")?;

    let result_bytes =
        unsafe { std::slice::from_raw_parts(result_buffer_alloc.get_host_ptr().cast_const(), buffer_size as usize) };
    if result_bytes != host_data_bytes {
        log::info!("Buffer contents read by the device do not match the values written by host");
        return Ok(TestStatus::fail("Fail"));
    }

    let device_data_bytes =
        unsafe { std::slice::from_raw_parts(device_data.as_ptr().cast::<u8>(), buffer_size as usize) };
    let bind_offset = bind_offset as usize;
    let buffer_size = buffer_size as usize;
    for i in 0..2 {
        let ptr = if i == 0 {
            mapped_ptr.cast::<u8>().cast_const()
        } else {
            base.host_memory_alloc.ptr.cast_const()
        };
        let ptr_name = if i == 0 {
            "Mapped pointer memory"
        } else {
            "Imported host pointer memory"
        };
        let bytes = unsafe { std::slice::from_raw_parts(ptr, host_allocation_size) };

        if bytes[..bind_offset] != initial_contents[..bind_offset] {
            log::info!("{ptr_name} 0 to {bind_offset}was modified");
            return Ok(TestStatus::fail("Fail"));
        }
        if bytes[bind_offset..bind_offset + buffer_size] != *device_data_bytes {
            log::info!(
                "{ptr_name} {bind_offset} to {} doesn't match",
                bind_offset + buffer_size
            );
            return Ok(TestStatus::fail("Fail"));
        }

        let exact_size = bind_offset + buffer_memory_requirements.size as usize;
        if bytes[exact_size..] != initial_contents[exact_size..] {
            log::info!("{ptr_name} was modified after bufferMemoryRequirements.size ({exact_size})");
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `checkSupport`
fn check_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_external_memory_host")
}

/// `checkRenderImageSupport`
fn check_render_image_support(context: &Context<'_>, params: TestParams) -> Result<(), TestError> {
    check_support(context)?;

    let vki = context.get_instance();
    let physical_device = context.get_physical_device();

    let format_properties = unsafe { vki.get_physical_device_format_properties(physical_device, params.format) };
    let color_attachment_bit = vk::FormatFeatureFlags::COLOR_ATTACHMENT;
    if !format_properties.linear_tiling_features.contains(color_attachment_bit) {
        return Err(TestError::NotSupported(
            "Format does not support linear tiling for color attachment".to_string(),
        ));
    }

    let image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;

    let mut external_info = vk::PhysicalDeviceExternalImageFormatInfo {
        handle_type: vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
        ..Default::default()
    };

    let format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
        .push_next(&mut external_info)
        .format(params.format)
        .type_(vk::ImageType::_2D)
        .tiling(vk::ImageTiling::LINEAR)
        .usage(image_usage)
        .flags(vk::ImageCreateFlags::empty());

    let mut external_properties = vk::ExternalImageFormatProperties::default();
    let mut format_properties2 = vk::ImageFormatProperties2::builder().push_next(&mut external_properties);

    let result = unsafe {
        vki.get_physical_device_image_format_properties2(physical_device, &format_info, &mut format_properties2)
    };
    if let Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) = result {
        return Err(TestError::NotSupported(
            "Image format not supported for external host memory".to_string(),
        ));
    }

    result.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?;

    check_external_memory_properties(&external_properties.external_memory_properties)
}

/// `checkHostSynchronizationSupport`
fn check_host_synchronization_support(context: &Context<'_>, _params: TestParams) -> Result<(), TestError> {
    check_support(context)?;

    // VK_KHR_timeline_semaphore is core in 1.2, where the Context's promotion table has no entry for it.
    if context.api_version() < (1, 2, 0) {
        context.require_device_functionality("VK_KHR_timeline_semaphore")?;
    }

    let vki = context.get_instance();
    let physical_device = context.get_physical_device();

    let buffer_usage = vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC;

    let buffer_info = vk::PhysicalDeviceExternalBufferInfo {
        s_type: vk::StructureType::PHYSICAL_DEVICE_EXTERNAL_BUFFER_INFO,
        next: std::ptr::null(),
        flags: vk::BufferCreateFlags::empty(),
        usage: buffer_usage,
        handle_type: vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
    };
    let mut props = vk::ExternalBufferProperties::default();
    unsafe { vki.get_physical_device_external_buffer_properties(physical_device, &buffer_info, &mut props) };

    check_external_memory_properties(&props.external_memory_properties)
}

/// Which upstream instance class a case runs.
#[derive(Clone, Copy)]
enum Kind {
    /// `ExternalMemoryHostBaseTestInstance`, with `allocationSize` as its argument.
    SimpleAllocation(vk::DeviceSize),
    /// `ExternalMemoryHostRenderImageTestInstance`
    RenderImage(TestParams),
    /// `ExternalMemoryHostSynchronizationTestInstance`
    Synchronization(TestParams),
    /// `ExternalMemoryHostBindBufferTestInstance`, with `allocationSize` as its argument.
    BindBuffer(vk::DeviceSize),
}

struct ExternalMemoryHostCase {
    name: String,
    kind: Kind,
    programs: BinaryCollection,
}

impl TestCase for ExternalMemoryHostCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            Kind::SimpleAllocation(_) | Kind::BindBuffer(_) => check_support(context),
            Kind::RenderImage(params) => check_render_image_support(context, params),
            Kind::Synchronization(params) => check_host_synchronization_support(context, params),
        }
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExternalMemoryHostInstance {
            context,
            kind: self.kind,
        })
    }
}

struct ExternalMemoryHostInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

impl TestInstance for ExternalMemoryHostInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // The upstream constructors run in createInstance and may fail there; here that happens on first iterate.
        match self.kind {
            Kind::SimpleAllocation(allocation_size) => {
                ExternalMemoryHostBase::new(self.context, allocation_size)?.iterate_base()
            }
            Kind::RenderImage(params) => {
                iterate_render_image(&mut ExternalMemoryHostBase::new(self.context, 1)?, params)
            }
            Kind::Synchronization(params) => {
                iterate_synchronization(&mut ExternalMemoryHostBase::new(self.context, 1)?, params)
            }
            Kind::BindBuffer(allocation_size) => {
                iterate_bind_buffer(&mut ExternalMemoryHostBase::new(self.context, allocation_size)?)
            }
        }
    }
}

/// `createMemoryExternalMemoryHostTests`
pub fn create_memory_external_memory_host_tests() -> TestCaseGroup {
    use crate::generated::shaders::memory_external_memory_host as g;

    let no_programs = BinaryCollection::new(&[]);
    let programs = g::EXTERNAL_MEMORY_HOST_PROGRAMS.programs;

    let mut group = TestCaseGroup::new("external_memory_host");
    let mut simple_allocation = TestCaseGroup::new("simple_allocation");
    let mut bind_image_memory_and_render = TestCaseGroup::new("bind_image_memory_and_render");
    let mut with_zero_offset = TestCaseGroup::new("with_zero_offset");
    let mut with_non_zero_offset = TestCaseGroup::new("with_non_zero_offset");
    let mut synchronization = TestCaseGroup::new("synchronization");

    // test cases:
    simple_allocation.add_child(Box::new(ExternalMemoryHostCase {
        name: "minImportedHostPointerAlignment_x1".to_string(),
        kind: Kind::SimpleAllocation(1),
        programs: no_programs,
    }) as Box<dyn TestCase>);
    simple_allocation.add_child(Box::new(ExternalMemoryHostCase {
        name: "minImportedHostPointerAlignment_x3".to_string(),
        kind: Kind::SimpleAllocation(3),
        programs: no_programs,
    }) as Box<dyn TestCase>);
    group.add_child(simple_allocation);

    let test_formats = [
        (vk::Format::R8G8B8A8_UNORM, "r8g8b8a8_unorm"),
        (vk::Format::R16G16B16A16_UNORM, "r16g16b16a16_unorm"),
        (vk::Format::R16G16B16A16_SFLOAT, "r16g16b16a16_sfloat"),
        (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
    ];

    for (format, name) in test_formats {
        with_zero_offset.add_child(Box::new(ExternalMemoryHostCase {
            name: name.to_string(),
            kind: Kind::RenderImage(TestParams::new(format, false)),
            programs,
        }) as Box<dyn TestCase>);
    }
    bind_image_memory_and_render.add_child(with_zero_offset);

    for (format, name) in test_formats {
        with_non_zero_offset.add_child(Box::new(ExternalMemoryHostCase {
            name: name.to_string(),
            kind: Kind::RenderImage(TestParams::new(format, true)),
            programs,
        }) as Box<dyn TestCase>);
    }
    bind_image_memory_and_render.add_child(with_non_zero_offset);

    group.add_child(bind_image_memory_and_render);

    synchronization.add_child(Box::new(ExternalMemoryHostCase {
        name: "synchronization".to_string(),
        kind: Kind::Synchronization(TestParams::new(test_formats[0].0, true)),
        programs,
    }) as Box<dyn TestCase>);
    group.add_child(synchronization);

    let mut bind_buffer_memory_and_copy = TestCaseGroup::new("bind_buffer_memory_and_copy");
    bind_buffer_memory_and_copy.add_child(Box::new(ExternalMemoryHostCase {
        name: "offset".to_string(),
        kind: Kind::BindBuffer(1),
        programs: no_programs,
    }) as Box<dyn TestCase>);
    group.add_child(bind_buffer_memory_and_copy);

    group
}
