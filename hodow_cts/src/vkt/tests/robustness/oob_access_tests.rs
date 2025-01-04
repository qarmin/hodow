// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustnessOOBAccessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's per-case `DevCaps` device is `context::RobustnessDevice` with the
// features the case asks for (robustBufferAccess2, robustImageAccess, shaderImageInt64Atomics); every case runs on one, the non
// robust image ones included, which differ from the robust ones only in what they verify. `misc.fma_test_hang` is an Amber test, converted by
// scripts/gen_spirv_assembly_amber_manifest.py and registered from spirv_assembly/amber_tests.rs.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::robustness_oob_access::{
    OOB_BUF_STORAGE_READ_32, OOB_BUF_STORAGE_READ_64, OOB_BUF_STORAGE_WRITE_32, OOB_BUF_STORAGE_WRITE_64,
    OOB_BUF_UNIFORM_READ_32, OOB_BUF_UNIFORM_READ_64, OOB_IMG_READ_32, OOB_IMG_READ_64, OOB_IMG_WRITE_32,
    OOB_IMG_WRITE_64,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::context::{RobustnessDevice, RobustnessFeatures};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum OobAccessType {
    OffByOne = 0,
    Off,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TexelBufferType {
    Uniform = 0,
    Storage,
}

#[derive(Clone, Copy, PartialEq, Eq)]
#[allow(dead_code)] // `None` is upstream's first value and what the level names are indexed from
enum RobustnessLevel {
    None = 0,
    RobustBufferAccess,
    RobustBufferAccess2,
}

#[derive(Clone, Copy)]
struct OobCommonParams {
    format: vk::Format,
    is_robust: bool,
    is_read: bool,
    oob_access: OobAccessType,
}

#[derive(Clone, Copy)]
struct OobBufferParams {
    robustness_level: RobustnessLevel,
    buffer_type: TexelBufferType,
    backing_size: u32,
}

#[derive(Clone, Copy)]
struct OobImageParams {
    image_extent: [u32; 2],
}

fn format_is_r64(format: vk::Format) -> bool {
    matches!(format, vk::Format::R64_SINT | vk::Format::R64_UINT)
}

fn texel_size(format: vk::Format) -> u32 {
    if format_is_r64(format) { 8 } else { 4 }
}

/// `commonCheckSupport`
fn common_check_support(context: &Context<'_>, params: &OobCommonParams) -> Result<(), TestError> {
    if format_is_r64(params.format) {
        context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;

        let mut atomic_int64_features = vk::PhysicalDeviceShaderAtomicInt64Features::default();
        let mut image_atomic_int64_features = vk::PhysicalDeviceShaderImageAtomicInt64FeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut atomic_int64_features)
                .push_next(&mut image_atomic_int64_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if context.get_device_features().shader_int64 == vk::FALSE
            || atomic_int64_features.shader_buffer_int64_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "64-bit integers not supported in shaders".to_string(),
            ));
        }

        if image_atomic_int64_features.shader_image_int64_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderImageInt64Atomics is not supported".to_string(),
            ));
        }
    }
    Ok(())
}

fn create_robustness_device(
    context: &Context<'_>,
    features: RobustnessFeatures,
) -> Result<RobustnessDevice, TestError> {
    RobustnessDevice::new(
        context.get_instance(),
        context.get_physical_device(),
        context.get_universal_queue_family_index(),
        features,
    )
}

/// A pipeline over one descriptor set layout and a compute push constant range, which `ComputePipelineWrapper` cannot build.
fn create_compute_pipeline<'a>(
    device: &'a Device,
    set_layout: vk::DescriptorSetLayout,
    push_constant_size: u32,
    module: vk::ShaderModule,
) -> Result<(Unique<'a, vk::PipelineLayout>, Unique<'a, vk::Pipeline>), TestError> {
    let set_layouts = [set_layout];
    let push_constant_ranges = [vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::COMPUTE,
        offset: 0,
        size: push_constant_size,
    }];
    let layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&push_constant_ranges);
    let layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(*layout)
        .base_pipeline_index(-1)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok((layout, Unique::new(device, pipelines.0[0])))
}

fn host_buffer<'a>(
    device: &'a Device,
    context: &Context<'_>,
    size: u64,
    usage: vk::BufferUsageFlags,
    fill: &[u8],
) -> Result<BufferWithMemory<'a>, TestError> {
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::copy_nonoverlapping(fill.as_ptr(), buffer.get_allocation().get_host_ptr(), fill.len()) };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

fn buffer_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::BufferMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[barrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };
}

fn reference_pattern(size: u32) -> Vec<u8> {
    (0..size).map(|i| ((i % 255) + 1) as u8).collect()
}

// ---------------------------------------------------------------------------------------------------------------------
// OOBBufferTestCase
// ---------------------------------------------------------------------------------------------------------------------

fn run_oob_buffer(context: &Context<'_>, params: OobCommonParams, buffer_params: OobBufferParams) -> TestOutcome {
    let robust_device = create_robustness_device(
        context,
        RobustnessFeatures {
            robust_buffer_access2: buffer_params.robustness_level == RobustnessLevel::RobustBufferAccess2,
            robust_image_access: false,
            shader_image_int64_atomics: format_is_r64(params.format),
            ..Default::default()
        },
    )?;
    let device = robust_device.device();
    let queue = robust_device.queue();
    let queue_family_index = context.get_universal_queue_family_index();

    let is_texel_uniform_buffer = buffer_params.buffer_type == TexelBufferType::Uniform;

    let buffer_view_size_in_bytes = buffer_params.backing_size / 2; // half of backing size
    let texel_size_in_bytes = texel_size(params.format);
    let buffer_view_size_in_texels = buffer_view_size_in_bytes / texel_size_in_bytes;
    let off_by_one_texel_idx = buffer_view_size_in_texels;
    let off_texel_idx = buffer_view_size_in_texels + (buffer_view_size_in_texels / 2);
    let access_texel_index = if params.oob_access == OobAccessType::OffByOne {
        off_by_one_texel_idx
    } else {
        off_texel_idx
    };
    let num_of_workgroups = 1u32; // access only 1 texel

    let buffer_usage_flags = if is_texel_uniform_buffer {
        vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER
    } else {
        vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
    };

    // Create texel buffer
    let texel_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(
            u64::from(buffer_params.backing_size),
            vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC | buffer_usage_flags,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Create a texel buffer view
    let view_info = vk::BufferViewCreateInfo {
        s_type: vk::StructureType::BUFFER_VIEW_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::BufferViewCreateFlags::empty(),
        buffer: texel_buffer.get(),
        format: params.format,
        offset: 0,
        range: u64::from(buffer_view_size_in_bytes),
    };
    let texel_buffer_view = Unique::new(
        device,
        unsafe { device.create_buffer_view(&view_info, None) }.vk_check("vkCreateBufferView")?,
    );

    // Initialize initalization buffer - input or output
    let reference_data = reference_pattern(buffer_params.backing_size);
    let init_buffer = host_buffer(
        device,
        context,
        u64::from(buffer_params.backing_size),
        vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::STORAGE_BUFFER,
        &reference_data,
    )?;

    // Create in-out buffer for read/write values, initialized with all 0xFF
    let io_buffer = host_buffer(
        device,
        context,
        u64::from(texel_size_in_bytes),
        vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::STORAGE_BUFFER,
        &vec![0xFFu8; texel_size_in_bytes as usize],
    )?;

    // Now bind the buffer as a uniform/storage texel buffer in a descriptor set
    let descriptor_type = if is_texel_uniform_buffer {
        vk::DescriptorType::UNIFORM_TEXEL_BUFFER
    } else {
        vk::DescriptorType::STORAGE_TEXEL_BUFFER
    };

    // Create descriptor set
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(descriptor_type, 1)
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    let io_buffer_desc_info = make_descriptor_buffer_info(io_buffer.get(), 0, u64::from(texel_size_in_bytes));
    let view = *texel_buffer_view;
    let writes = [
        vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: *descriptor_set,
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type,
            image_info: std::ptr::null(),
            buffer_info: std::ptr::null(),
            texel_buffer_view: std::ptr::addr_of!(view),
        },
        vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: *descriptor_set,
            dst_binding: 1,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            image_info: std::ptr::null(),
            buffer_info: std::ptr::addr_of!(io_buffer_desc_info),
            texel_buffer_view: std::ptr::null(),
        },
    ];
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    // Create compute pipeline
    let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
    let (pipeline_layout, compute_pipeline) = create_compute_pipeline(
        device,
        *descriptor_set_layout,
        std::mem::size_of::<u32>() as u32,
        *shader_module,
    )?;

    // Create command buffer
    let command_pool = make_command_pool(device, queue_family_index)?;
    let command_buffer_ptr = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let command_buffer = *command_buffer_ptr;

    // Start recording command buffer
    begin_command_buffer(device, command_buffer)?;

    // Create barrier to update buffers
    {
        buffer_barrier(
            device,
            command_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                init_buffer.get(),
                0,
                u64::from(buffer_params.backing_size),
            ),
        );

        buffer_barrier(
            device,
            command_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                if params.is_read {
                    vk::AccessFlags::SHADER_WRITE
                } else {
                    vk::AccessFlags::SHADER_READ
                },
                io_buffer.get(),
                0,
                u64::from(texel_size_in_bytes),
            ),
        );
    }

    // Copy initial data to texel buffer
    let copy_region = vk::BufferCopy {
        src_offset: 0,
        dst_offset: 0,
        size: u64::from(buffer_params.backing_size),
    };
    unsafe {
        device.cmd_copy_buffer(command_buffer, init_buffer.get(), texel_buffer.get(), &[copy_region]);

        device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::COMPUTE, compute_pipeline.get());
        device.cmd_bind_descriptor_sets(
            command_buffer,
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[*descriptor_set],
            &[] as &[u32],
        );
        device.cmd_push_constants(
            command_buffer,
            *pipeline_layout,
            vk::ShaderStageFlags::COMPUTE,
            0,
            &access_texel_index.to_ne_bytes(),
        );
    }

    buffer_barrier(
        device,
        command_buffer,
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::COMPUTE_SHADER,
        make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            if params.is_read {
                vk::AccessFlags::SHADER_READ
            } else {
                vk::AccessFlags::SHADER_WRITE
            },
            texel_buffer.get(),
            0,
            u64::from(buffer_params.backing_size),
        ),
    );

    unsafe { device.cmd_dispatch(command_buffer, num_of_workgroups, 1, 1) };

    if params.is_read {
        buffer_barrier(
            device,
            command_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                io_buffer.get(),
                0,
                u64::from(texel_size_in_bytes),
            ),
        );
    } else {
        buffer_barrier(
            device,
            command_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                texel_buffer.get(),
                0,
                u64::from(buffer_params.backing_size),
            ),
        );
    }

    end_command_buffer(device, command_buffer)?;

    // Submit commands
    submit_commands_and_wait(device, queue, command_buffer)?;

    // Retrieve data from output buffer to host memory
    let output_buffer_alloc = if params.is_read {
        io_buffer.get_allocation()
    } else {
        texel_buffer.get_allocation()
    };
    invalidate_alloc(device, output_buffer_alloc)?;

    if buffer_params.robustness_level == RobustnessLevel::RobustBufferAccess2 {
        if params.is_read {
            // check that the OOB read (but inside the backing memory) reads 0 at the OOB index
            let output_data = unsafe {
                std::slice::from_raw_parts(
                    output_buffer_alloc.get_host_ptr().cast_const(),
                    texel_size_in_bytes as usize,
                )
            };
            if output_data.iter().any(|&byte| byte != 0) {
                return Ok(TestStatus::fail("Failed"));
            }
        } else {
            // Check that OOB write did not change anything inside the buffer
            let output_data = unsafe {
                std::slice::from_raw_parts(
                    output_buffer_alloc.get_host_ptr().cast_const(),
                    buffer_params.backing_size as usize,
                )
            };
            if output_data != reference_data.as_slice() {
                return Ok(TestStatus::fail("Failed"));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

fn buffer_program(params: &OobCommonParams, buffer_params: &OobBufferParams) -> BinaryCollection {
    let is64 = format_is_r64(params.format);
    match (buffer_params.buffer_type, params.is_read, is64) {
        (TexelBufferType::Uniform, _, false) => OOB_BUF_UNIFORM_READ_32.programs,
        (TexelBufferType::Uniform, _, true) => OOB_BUF_UNIFORM_READ_64.programs,
        (TexelBufferType::Storage, true, false) => OOB_BUF_STORAGE_READ_32.programs,
        (TexelBufferType::Storage, true, true) => OOB_BUF_STORAGE_READ_64.programs,
        (TexelBufferType::Storage, false, false) => OOB_BUF_STORAGE_WRITE_32.programs,
        (TexelBufferType::Storage, false, true) => OOB_BUF_STORAGE_WRITE_64.programs,
    }
}

struct OobBufferTestCase {
    name: String,
    params: OobCommonParams,
    buffer_params: OobBufferParams,
}

impl TestCase for OobBufferTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let max_device_texels = context.get_device_properties().limits.max_texel_buffer_elements;
        let num_texels = (self.buffer_params.backing_size / 2) / texel_size(self.params.format);

        if self.params.is_robust {
            if context.is_device_functionality_supported("VK_KHR_portability_subset")
                && context.get_device_features().robust_buffer_access == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "VK_KHR_portability_subset: robustBufferAccess not supported by this implementation".to_string(),
                ));
            }

            if self.buffer_params.robustness_level == RobustnessLevel::RobustBufferAccess2 {
                let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
                {
                    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut robustness2_features);
                    unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
                }

                context.require_device_functionality("VK_EXT_robustness2")?;

                if robustness2_features.robust_buffer_access2 == vk::FALSE {
                    return Err(TestError::NotSupported("robustBufferAccess2 not supported".to_string()));
                }
            }
        }

        let format_properties =
            unsafe { instance.get_physical_device_format_properties(physical_device, self.params.format) };
        if self.buffer_params.buffer_type == TexelBufferType::Uniform
            && !format_properties
                .buffer_features
                .contains(vk::FormatFeatureFlags::UNIFORM_TEXEL_BUFFER)
        {
            return Err(TestError::NotSupported(
                "Format not supported for uniform texel buffers".to_string(),
            ));
        }

        if self.buffer_params.buffer_type == TexelBufferType::Storage
            && !format_properties
                .buffer_features
                .contains(vk::FormatFeatureFlags::STORAGE_TEXEL_BUFFER)
        {
            return Err(TestError::NotSupported(
                "Format not supported for storage texel buffers".to_string(),
            ));
        }

        if num_texels > max_device_texels {
            return Err(TestError::NotSupported(
                "maxTexelBufferElements not large enough".to_string(),
            ));
        }

        common_check_support(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        buffer_program(&self.params, &self.buffer_params)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OobBufferTestInstance {
            context,
            params: self.params,
            buffer_params: self.buffer_params,
        })
    }
}

struct OobBufferTestInstance<'a> {
    context: &'a Context<'a>,
    params: OobCommonParams,
    buffer_params: OobBufferParams,
}

impl TestInstance for OobBufferTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_oob_buffer(self.context, self.params, self.buffer_params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// OOBImageTestCase
// ---------------------------------------------------------------------------------------------------------------------

fn run_oob_image(context: &Context<'_>, params: OobCommonParams, image_params: OobImageParams) -> TestOutcome {
    let robust_device = create_robustness_device(
        context,
        RobustnessFeatures {
            robust_buffer_access2: false,
            robust_image_access: params.is_robust,
            shader_image_int64_atomics: format_is_r64(params.format),
            ..Default::default()
        },
    )?;
    let device = robust_device.device();
    let queue = robust_device.queue();
    let queue_family_index = context.get_universal_queue_family_index();

    let texel_size_in_bytes = texel_size(params.format);
    let image_view_size_in_texels = image_params.image_extent;
    let image_size_in_bytes = image_view_size_in_texels[0] * image_view_size_in_texels[1] * texel_size_in_bytes;
    let off_by_one_texel_idx = image_view_size_in_texels;
    let off_texel_idx = [image_view_size_in_texels[0] + 64, image_view_size_in_texels[1] + 64];
    let access_texel_index = if params.oob_access == OobAccessType::OffByOne {
        off_by_one_texel_idx
    } else {
        off_texel_idx
    };
    let num_of_workgroups = 1u32; // access only 1 texel

    // Create image
    let storage_image_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format: params.format,
        extent: vk::Extent3D {
            width: image_view_size_in_texels[0],
            height: image_view_size_in_texels[1],
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage: vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    let storage_image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        storage_image_info,
        MemoryRequirement::ANY,
    )?;

    // Create image view
    let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let storage_image_view = make_image_view(
        device,
        storage_image.get(),
        vk::ImageViewType::_2D,
        params.format,
        color_subresource_range,
    )?;

    // Create buffer (for initialization and result image in case of write)
    let reference_data = reference_pattern(image_size_in_bytes);
    let image_buffer = host_buffer(
        device,
        context,
        u64::from(image_size_in_bytes),
        vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::STORAGE_BUFFER,
        &reference_data,
    )?;

    // Create in-out buffer for read/write values, initialized with all 0xFF
    let io_buffer = host_buffer(
        device,
        context,
        u64::from(texel_size_in_bytes),
        vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::STORAGE_BUFFER,
        &vec![0xFFu8; texel_size_in_bytes as usize],
    )?;

    // Push constant data
    let push_constants: Vec<u8> = access_texel_index
        .iter()
        .flat_map(|&component| (component as i32).to_ne_bytes())
        .collect();

    // Now bind the storage image in a descriptor set
    let descriptor_type = vk::DescriptorType::STORAGE_IMAGE;

    // Create descriptor set
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(descriptor_type, 1)
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    let storage_image_desc_info = vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view: *storage_image_view,
        image_layout: vk::ImageLayout::GENERAL,
    };
    let io_buffer_desc_info = make_descriptor_buffer_info(io_buffer.get(), 0, u64::from(texel_size_in_bytes));
    let writes = [
        vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(descriptor_type)
            .image_info(std::slice::from_ref(&storage_image_desc_info))
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(1)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(std::slice::from_ref(&io_buffer_desc_info))
            .build(),
    ];
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    // Create compute pipeline
    let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
    let (pipeline_layout, compute_pipeline) = create_compute_pipeline(
        device,
        *descriptor_set_layout,
        push_constants.len() as u32,
        *shader_module,
    )?;

    let image_subresource_layers = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: image_view_size_in_texels[0],
            height: image_view_size_in_texels[1],
            depth: 1,
        },
        image_subresource_layers,
    );

    // Create command buffer
    let command_pool = make_command_pool(device, queue_family_index)?;
    let command_buffer_ptr = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    let command_buffer = *command_buffer_ptr;

    // Start recording command buffer
    begin_command_buffer(device, command_buffer)?;

    // Create barrier to update buffers
    {
        buffer_barrier(
            device,
            command_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                image_buffer.get(),
                0,
                u64::from(image_size_in_bytes),
            ),
        );

        buffer_barrier(
            device,
            command_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                if params.is_read {
                    vk::AccessFlags::SHADER_WRITE
                } else {
                    vk::AccessFlags::SHADER_READ
                },
                io_buffer.get(),
                0,
                u64::from(texel_size_in_bytes),
            ),
        );
    }

    // Copy initial data to image: `copyBufferToImage` with the destination in the general layout
    {
        let dst_access = if params.is_read {
            vk::AccessFlags::SHADER_READ
        } else {
            vk::AccessFlags::SHADER_WRITE
        };
        let pre_buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            image_buffer.get(),
            0,
            u64::from(image_size_in_bytes),
        );
        let pre_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            storage_image.get(),
            color_subresource_range,
        );
        let post_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            dst_access,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
            storage_image.get(),
            color_subresource_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[pre_buffer_barrier],
                &[pre_image_barrier],
            );
            device.cmd_copy_buffer_to_image(
                command_buffer,
                image_buffer.get(),
                storage_image.get(),
                vk::ImageLayout::GENERAL,
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_image_barrier],
            );
        }
    }

    unsafe {
        device.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::COMPUTE, compute_pipeline.get());
        device.cmd_bind_descriptor_sets(
            command_buffer,
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[*descriptor_set],
            &[] as &[u32],
        );
        device.cmd_push_constants(
            command_buffer,
            *pipeline_layout,
            vk::ShaderStageFlags::COMPUTE,
            0,
            &push_constants,
        );

        device.cmd_dispatch(command_buffer, num_of_workgroups, 1, 1);
    }

    if params.is_read {
        buffer_barrier(
            device,
            command_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                io_buffer.get(),
                0,
                u64::from(texel_size_in_bytes),
            ),
        );
    } else {
        // `copyImageToBuffer` from the general layout
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
            storage_image.get(),
            color_subresource_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                command_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            device.cmd_copy_image_to_buffer(
                command_buffer,
                storage_image.get(),
                vk::ImageLayout::GENERAL,
                image_buffer.get(),
                &[copy_region],
            );
        }
        buffer_barrier(
            device,
            command_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                image_buffer.get(),
                0,
                vk::WHOLE_SIZE,
            ),
        );
    }

    end_command_buffer(device, command_buffer)?;

    // Submit commands
    submit_commands_and_wait(device, queue, command_buffer)?;

    // Retrieve data from output buffer to host memory
    let output_buffer_alloc = if params.is_read {
        io_buffer.get_allocation()
    } else {
        image_buffer.get_allocation()
    };
    invalidate_alloc(device, output_buffer_alloc)?;

    if params.is_robust {
        if params.is_read {
            // Check that the OOB read at the OOB index reads 0
            let output_data = unsafe {
                std::slice::from_raw_parts(
                    output_buffer_alloc.get_host_ptr().cast_const(),
                    texel_size_in_bytes as usize,
                )
            };
            if output_data.iter().any(|&byte| byte != 0) {
                return Ok(TestStatus::fail("Failed"));
            }
        } else {
            // Check that OOB write did not change anything inside the image
            let output_data = unsafe {
                std::slice::from_raw_parts(
                    output_buffer_alloc.get_host_ptr().cast_const(),
                    image_size_in_bytes as usize,
                )
            };
            if output_data != reference_data.as_slice() {
                return Ok(TestStatus::fail("Failed"));
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct OobImageTestCase {
    name: String,
    params: OobCommonParams,
    image_params: OobImageParams,
}

impl TestCase for OobImageTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        if self.params.is_robust {
            context.require_device_functionality("VK_EXT_image_robustness")?;
        }

        let format_properties =
            unsafe { instance.get_physical_device_format_properties(physical_device, self.params.format) };
        if !format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
        {
            return Err(TestError::NotSupported(
                "Format not supported for storage images".to_string(),
            ));
        }

        let usage =
            vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let result = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                self.params.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };

        if matches!(result, Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED)) {
            return Err(TestError::NotSupported(
                "Image format is not supported for required usage".to_string(),
            ));
        }

        common_check_support(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        match (self.params.is_read, format_is_r64(self.params.format)) {
            (true, false) => OOB_IMG_READ_32.programs,
            (true, true) => OOB_IMG_READ_64.programs,
            (false, false) => OOB_IMG_WRITE_32.programs,
            (false, true) => OOB_IMG_WRITE_64.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OobImageTestInstance {
            context,
            params: self.params,
            image_params: self.image_params,
        })
    }
}

struct OobImageTestInstance<'a> {
    context: &'a Context<'a>,
    params: OobCommonParams,
    image_params: OobImageParams,
}

impl TestInstance for OobImageTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_oob_image(self.context, self.params, self.image_params)
    }
}

/// `getFormatShortString`
fn format_short_string(format: vk::Format) -> &'static str {
    if format == vk::Format::R64_UINT {
        "r64_uint"
    } else {
        "r32_uint"
    }
}

/// `createOOBAccessTests`
pub fn create_oob_access_tests() -> TestCaseGroup {
    let mut oob_access_tests = TestCaseGroup::new("oob_access");

    let texel_buffer_name = ["texel_buffer_uniform", "texel_buffer_storage"];
    let oob_access_name = ["off_by_one", "off"];
    let robustness_level_name = ["none", "rba", "rba2"];

    for is_robust in [true, false] {
        let grp_name = format!("robust_{}", if is_robust { "on" } else { "off" });

        let mut robust_tests = TestCaseGroup::new(grp_name);

        for oob_access in [OobAccessType::OffByOne, OobAccessType::Off] {
            let access_type_idx = oob_access as usize;

            // Texel buffer tests
            for (tex_buff_type_idx, buffer_type) in [TexelBufferType::Uniform, TexelBufferType::Storage]
                .into_iter()
                .enumerate()
            {
                // OOB access on texel buffers without robustness is undefined behavior
                if !is_robust {
                    continue;
                }

                for is_read in [true, false] {
                    if !is_read && buffer_type == TexelBufferType::Uniform {
                        continue;
                    }

                    for format in [vk::Format::R32_UINT, vk::Format::R64_UINT] {
                        for size in [256u32, 1024, 4096] {
                            // In bytes
                            for robustness_level in [
                                RobustnessLevel::RobustBufferAccess,
                                RobustnessLevel::RobustBufferAccess2,
                            ] {
                                let params = OobCommonParams {
                                    format,
                                    is_robust,
                                    is_read,
                                    oob_access,
                                };

                                let buffer_params = OobBufferParams {
                                    robustness_level,
                                    buffer_type,
                                    backing_size: size,
                                };

                                let test_name = format!(
                                    "{}_{}_{}_{}_{}_{}",
                                    robustness_level_name[robustness_level as usize],
                                    texel_buffer_name[tex_buff_type_idx],
                                    format_short_string(format),
                                    if is_read { "read" } else { "write" },
                                    oob_access_name[access_type_idx],
                                    size
                                );
                                robust_tests.add_child(Box::new(OobBufferTestCase {
                                    name: test_name,
                                    params,
                                    buffer_params,
                                }) as Box<dyn TestCase>);
                            }
                        }
                    }
                }
            }

            // Storage image tests

            for is_read in [true, false] {
                for format in [vk::Format::R32_UINT, vk::Format::R64_UINT] {
                    for extent in [[16u32, 16], [64, 64], [128, 128]] {
                        let params = OobCommonParams {
                            format,
                            is_robust,
                            is_read,
                            oob_access,
                        };

                        let image_params = OobImageParams { image_extent: extent };

                        let test_name = format!(
                            "storage_image_{}_{}_{}_{}x{}",
                            format_short_string(format),
                            if is_read { "read" } else { "write" },
                            oob_access_name[access_type_idx],
                            extent[0],
                            extent[1]
                        );
                        robust_tests.add_child(Box::new(OobImageTestCase {
                            name: test_name,
                            params,
                            image_params,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }

        oob_access_tests.add_child(robust_tests);
    }

    oob_access_tests.add_child(crate::vkt::tests::spirv_assembly::amber_tests::create_robustness_misc_group());

    oob_access_tests
}
