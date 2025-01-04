// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiBufferMarkerTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Advanced Micro Devices, Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. VK_AMD_buffer_marker: the ``sequential`, `overwrite` and `memory_dep` groups of every queue
// family, memory kind and stage. Upstream creates a device with a queue of the tested family; here the default device's universal,
// compute-only or transfer-only queue is used, and a missing family is NotSupported. The buffer's offset in its memory is bound
// like `SimpleAllocator::OptionalOffsetParams` does (for imported host memory the aligned offset into the block). The `memory_dep`
// group is ported too: markers and ordinary writes (buffer updates, draws, dispatches) to random slots with a barrier between the
// writers of one slot, then a check of the final contents.

use std::alloc::{Layout, alloc, dealloc};
use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    AmdBufferMarkerExtensionDeviceCommands, ExtExternalMemoryHostExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::api_buffer_marker::{MEMORY_DEP_DISPATCH, MEMORY_DEP_DRAW};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, OffsetParams, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_descriptor_set, make_framebuffer};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestQueue {
    Graphics,
    Compute,
    Transfer,
}

#[derive(Clone, Copy)]
struct BaseTestParams {
    test_queue: TestQueue,
    stage: vk::PipelineStageFlags,
    size: u32,
    use_host_ptr: bool,
    offset: usize,
}

/// `getTestCaseName`
fn test_case_name(base: &str, offset: usize) -> String {
    if offset == 0 {
        base.to_string()
    } else {
        format!("{base}_offset_{offset}")
    }
}

/// `ExternalHostMemory`: an aligned block the device imports.
struct ExternalHostMemory {
    ptr: *mut u8,
    layout: Layout,
}

impl ExternalHostMemory {
    fn new(size: usize, alignment: usize) -> Result<Self, TestError> {
        let size = size.div_ceil(alignment) * alignment;
        let layout = Layout::from_size_align(size, alignment)
            .map_err(|_| TestError::Fail("invalid host memory layout".to_string()))?;
        let ptr = unsafe { alloc(layout) };
        if ptr.is_null() {
            return Err(TestError::ResourceError("Failed to allocate host memory".to_string()));
        }
        unsafe { std::ptr::write_bytes(ptr, 0, size) };
        Ok(Self { ptr, layout })
    }

    fn size(&self) -> usize {
        self.layout.size()
    }
}

impl Drop for ExternalHostMemory {
    fn drop(&mut self) {
        unsafe { dealloc(self.ptr, self.layout) };
    }
}

struct BufferMarkerCase {
    name: String,
    params: BaseTestParams,
    overwrite: bool,
}

impl TestCase for BufferMarkerCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.use_host_ptr {
            context.require_device_functionality("VK_EXT_external_memory_host")?;
        }
        context.require_device_functionality("VK_AMD_buffer_marker")?;
        select_queue(context, self.params.test_queue).map(|_| ())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferMarkerInstance {
            context,
            params: self.params,
            overwrite: self.overwrite,
        })
    }
}

/// The queue and family of the tested kind.
fn select_queue(context: &Context<'_>, kind: TestQueue) -> Result<(vk::Queue, u32), TestError> {
    match kind {
        TestQueue::Graphics => Ok((
            context.get_universal_queue(),
            context.get_universal_queue_family_index(),
        )),
        TestQueue::Compute => context
            .get_compute_queue()
            .ok_or_else(|| TestError::NotSupported("No compute-only queue family".to_string())),
        TestQueue::Transfer => context
            .get_transfer_queue()
            .ok_or_else(|| TestError::NotSupported("No transfer-only queue family".to_string())),
    }
}

struct BufferMarkerInstance<'a> {
    context: &'a Context<'a>,
    params: BaseTestParams,
    overwrite: bool,
}

/// What backs the marker buffer, and how the host reads it.
enum MarkerMemory<'a> {
    Allocated(crate::vk::mem_util::Allocation<'a>),
    Imported {
        memory: Unique<'a, vk::DeviceMemory>,
        host: ExternalHostMemory,
    },
}

impl BufferMarkerInstance<'_> {
    /// `createMarkerBufferMemory`
    fn create_marker_memory<'b>(&'b self, buffer: vk::Buffer) -> Result<(MarkerMemory<'b>, vk::DeviceSize), TestError> {
        let context = self.context;
        let device = context.get_device();
        let requirements = unsafe { device.get_buffer_memory_requirements(buffer) };

        if !self.params.use_host_ptr {
            let memory_properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_memory_properties(context.get_physical_device())
            };
            let allocator = SimpleAllocator::with_offset(
                memory_properties,
                OffsetParams {
                    non_coherent_atom_size: context.get_device_properties().limits.non_coherent_atom_size,
                    offset: self.params.offset as vk::DeviceSize,
                },
            );
            let allocation = allocator.allocate(device, requirements, MemoryRequirement::HOST_VISIBLE)?;
            let offset = allocation.get_offset();
            return Ok((MarkerMemory::Allocated(allocation), offset));
        }

        let mut host_properties = vk::PhysicalDeviceExternalMemoryHostPropertiesEXT::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut host_properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
        }
        let alignment = host_properties.min_imported_host_pointer_alignment as usize;
        let buffer_offset = (self.params.offset as vk::DeviceSize).div_ceil(requirements.alignment.max(1))
            * requirements.alignment.max(1);
        let host = ExternalHostMemory::new(requirements.size as usize + buffer_offset as usize, alignment)?;

        let mut pointer_properties = vk::MemoryHostPointerPropertiesEXT::default();
        let mut allowed_bits = requirements.memory_type_bits;
        if unsafe {
            device.get_memory_host_pointer_properties_ext(
                vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
                host.ptr.cast::<c_void>().cast_const(),
                &mut pointer_properties,
            )
        }
        .is_ok()
        {
            allowed_bits &= pointer_properties.memory_type_bits;
        }
        if allowed_bits == 0 {
            return Err(TestError::Fail(
                "Failed to find compatible external host memory type for marker buffer".to_string(),
            ));
        }
        let memory_type_index = allowed_bits.trailing_zeros();

        let import_info = vk::ImportMemoryHostPointerInfoEXT {
            s_type: vk::StructureType::IMPORT_MEMORY_HOST_POINTER_INFO_EXT,
            next: std::ptr::null(),
            handle_type: vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
            host_pointer: host.ptr.cast::<c_void>(),
        };
        let allocate_info = vk::MemoryAllocateInfo {
            s_type: vk::StructureType::MEMORY_ALLOCATE_INFO,
            next: (&import_info as *const vk::ImportMemoryHostPointerInfoEXT).cast::<c_void>(),
            allocation_size: host.size() as vk::DeviceSize,
            memory_type_index,
        };
        let memory = Unique::new(
            device,
            unsafe { device.allocate_memory(&allocate_info, None) }.vk_check("vkAllocateMemory")?,
        );
        Ok((MarkerMemory::Imported { memory, host }, buffer_offset))
    }

    fn memory_handle(memory: &MarkerMemory<'_>) -> vk::DeviceMemory {
        match memory {
            MarkerMemory::Allocated(allocation) => allocation.get_memory(),
            MarkerMemory::Imported { memory, .. } => **memory,
        }
    }

    /// `writeHostMemory` and the flush after a `deMemcpy`: the host's initial contents of the markers.
    fn write_markers(
        &self,
        memory: &MarkerMemory<'_>,
        offset: vk::DeviceSize,
        values: &[u32],
    ) -> Result<(), TestError> {
        let device = self.context.get_device();
        let bytes = unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) };
        match memory {
            MarkerMemory::Allocated(allocation) => {
                unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), allocation.get_host_ptr(), bytes.len()) };
                flush_alloc(device, allocation)
            }
            MarkerMemory::Imported { memory, host } => {
                let mapped = unsafe {
                    device.map_memory(**memory, 0, host.size() as vk::DeviceSize, vk::MemoryMapFlags::empty())
                }
                .vk_check("vkMapMemory")?;
                unsafe {
                    std::ptr::copy_nonoverlapping(bytes.as_ptr(), mapped.cast::<u8>().add(offset as usize), bytes.len())
                };
                let range = vk::MappedMemoryRange::builder()
                    .memory(**memory)
                    .offset(0)
                    .size(vk::WHOLE_SIZE)
                    .build();
                unsafe { device.flush_mapped_memory_ranges(&[range]) }.vk_check("vkFlushMappedMemoryRanges")?;
                unsafe { device.unmap_memory(**memory) };
                Ok(())
            }
        }
    }

    /// `checkMarkerBuffer`
    fn check_markers(
        &self,
        memory: &MarkerMemory<'_>,
        offset: vk::DeviceSize,
        expected: &[u32],
    ) -> Result<bool, TestError> {
        let device = self.context.get_device();
        let read = |base: *const u8| -> bool {
            (0..expected.len()).all(|i| unsafe { base.cast::<u32>().add(i).read_unaligned() } == expected[i])
        };
        match memory {
            MarkerMemory::Allocated(allocation) => {
                invalidate_alloc(device, allocation)?;
                Ok(read(allocation.get_host_ptr()))
            }
            MarkerMemory::Imported { memory, host } => {
                let mapped = unsafe {
                    device.map_memory(**memory, 0, host.size() as vk::DeviceSize, vk::MemoryMapFlags::empty())
                }
                .vk_check("vkMapMemory")?;
                let range = vk::MappedMemoryRange::builder()
                    .memory(**memory)
                    .offset(0)
                    .size(vk::WHOLE_SIZE)
                    .build();
                unsafe { device.invalidate_mapped_memory_ranges(&[range]) }
                    .vk_check("vkInvalidateMappedMemoryRanges")?;
                let ok = read(unsafe { mapped.cast::<u8>().add(offset as usize) });
                unsafe { device.unmap_memory(**memory) };
                Ok(ok)
            }
        }
    }
}

impl TestInstance for BufferMarkerInstance<'_> {
    /// `bufferMarkerSequential` and `bufferMarkerOverwrite`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let params = self.params;
        let (queue, family) = select_queue(context, params.test_queue)?;
        let marker_buffer_size = (params.size as usize * std::mem::size_of::<u32>()) as vk::DeviceSize;

        let external_info = vk::ExternalMemoryBufferCreateInfo {
            s_type: vk::StructureType::EXTERNAL_MEMORY_BUFFER_CREATE_INFO,
            next: std::ptr::null(),
            handle_types: vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
        };
        let mut buffer_info = vk::BufferCreateInfo::builder()
            .size(marker_buffer_size)
            .usage(vk::BufferUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();
        if params.use_host_ptr {
            buffer_info.next = (&external_info as *const vk::ExternalMemoryBufferCreateInfo).cast::<c_void>();
        }
        let buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&buffer_info, None) }.vk_check("vkCreateBuffer")?,
        );

        let (memory, offset) = self.create_marker_memory(*buffer)?;
        unsafe { device.bind_buffer_memory(*buffer, Self::memory_handle(&memory), offset) }
            .vk_check("vkBindBufferMemory")?;

        let mut rng = Random::new(12345 ^ params.size);
        let mut expected = vec![0u32; params.size as usize];
        self.write_markers(&memory, offset, &expected)?;

        let cmd_pool = make_command_pool(device, family)?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;

        if self.overwrite {
            for i in 0..params.size * 10 {
                let slot = rng.get_uint32() % params.size;
                expected[slot as usize] = i;
                unsafe {
                    device.cmd_write_buffer_marker_amd(
                        *cmd,
                        params.stage,
                        *buffer,
                        (std::mem::size_of::<u32>() * slot as usize) as vk::DeviceSize,
                        i,
                    )
                };
            }
        } else {
            for value in expected.iter_mut() {
                *value = rng.get_uint32();
            }
            for (i, &value) in expected.iter().enumerate() {
                unsafe {
                    device.cmd_write_buffer_marker_amd(
                        *cmd,
                        params.stage,
                        *buffer,
                        (std::mem::size_of::<u32>() * i) as vk::DeviceSize,
                        value,
                    )
                };
            }
        }

        let memory_dep = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[memory_dep],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, queue, *cmd)?;

        if !self.check_markers(&memory, offset, &expected)? {
            return Ok(TestStatus::fail("Some marker values were incorrect"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `MemoryDepMethod`
#[derive(Clone, Copy, PartialEq, Eq)]
enum MemoryDepMethod {
    Draw,
    Dispatch,
    Copy,
}

/// `MemoryDepOwner`
#[derive(Clone, Copy, PartialEq, Eq)]
enum Owner {
    Nobody,
    Marker,
    NonMarker,
}

struct MemoryDepCase {
    name: String,
    base: BaseTestParams,
    method: MemoryDepMethod,
}

impl TestCase for MemoryDepCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.base.use_host_ptr {
            context.require_device_functionality("VK_EXT_external_memory_host")?;
        }
        context.require_device_functionality("VK_AMD_buffer_marker")?;

        // VUID-RuntimeSpirv-NonWritable-06340
        if self.method == MemoryDepMethod::Draw
            && context.get_device_features().fragment_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }
        select_queue(context, self.base.test_queue).map(|_| ())
    }

    fn programs(&self) -> BinaryCollection {
        match self.method {
            MemoryDepMethod::Draw => MEMORY_DEP_DRAW.programs,
            MemoryDepMethod::Dispatch => MEMORY_DEP_DISPATCH.programs,
            MemoryDepMethod::Copy => BinaryCollection::new(&[]),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MemoryDepInstance {
            context,
            base: self.base,
            method: self.method,
        })
    }
}

struct MemoryDepInstance<'a> {
    context: &'a Context<'a>,
    base: BaseTestParams,
    method: MemoryDepMethod,
}

impl MemoryDepInstance<'_> {
    /// `computeMemoryDepBarrier`
    fn barrier_scope(&self, owner: Owner) -> (vk::AccessFlags, vk::PipelineStageFlags) {
        debug_assert!(owner != Owner::Nobody);
        if owner == Owner::Marker {
            return (
                vk::AccessFlags::TRANSFER_WRITE,
                self.base.stage | vk::PipelineStageFlags::TRANSFER,
            );
        }
        match self.method {
            MemoryDepMethod::Copy => (vk::AccessFlags::TRANSFER_WRITE, vk::PipelineStageFlags::TRANSFER),
            MemoryDepMethod::Dispatch => (vk::AccessFlags::SHADER_WRITE, vk::PipelineStageFlags::COMPUTE_SHADER),
            MemoryDepMethod::Draw => (vk::AccessFlags::SHADER_WRITE, vk::PipelineStageFlags::FRAGMENT_SHADER),
        }
    }
}

impl TestInstance for MemoryDepInstance<'_> {
    /// `bufferMarkerMemoryDep`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let base = self.base;
        let (queue, family) = select_queue(context, base.test_queue)?;
        let helper = BufferMarkerInstance {
            context,
            params: base,
            overwrite: false,
        };

        let mut usage = vk::BufferUsageFlags::TRANSFER_DST;
        usage |= if self.method == MemoryDepMethod::Copy {
            vk::BufferUsageFlags::TRANSFER_SRC
        } else {
            vk::BufferUsageFlags::STORAGE_BUFFER
        };
        const NUM_ITERS: u32 = 1000;
        let size = base.size;
        let marker_buffer_size = (size as usize * std::mem::size_of::<u32>()) as vk::DeviceSize;

        let external_info = vk::ExternalMemoryBufferCreateInfo {
            s_type: vk::StructureType::EXTERNAL_MEMORY_BUFFER_CREATE_INFO,
            next: std::ptr::null(),
            handle_types: vk::ExternalMemoryHandleTypeFlags::HOST_ALLOCATION_EXT,
        };
        let mut buffer_info = vk::BufferCreateInfo::builder()
            .size(marker_buffer_size)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();
        if base.use_host_ptr {
            buffer_info.next = (&external_info as *const vk::ExternalMemoryBufferCreateInfo).cast::<c_void>();
        }
        let buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&buffer_info, None) }.vk_check("vkCreateBuffer")?,
        );
        let (memory, offset) = helper.create_marker_memory(*buffer)?;
        unsafe { device.bind_buffer_memory(*buffer, BufferMarkerInstance::memory_handle(&memory), offset) }
            .vk_check("vkBindBufferMemory")?;

        let mut rng = Random::new(size ^ base.size);
        let mut expected = vec![0u32; size as usize];

        // The set, the push constants and the pipeline of the draw and dispatch methods.
        let uses_shader = self.method != MemoryDepMethod::Copy;
        let push_constant_stage = if self.method == MemoryDepMethod::Dispatch {
            vk::ShaderStageFlags::COMPUTE
        } else {
            vk::ShaderStageFlags::FRAGMENT
        };
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL)
            .build(device)?;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *pool, *set_layout)?;
        let buffer_descriptor = [vk::DescriptorBufferInfo {
            buffer: *buffer,
            offset: 0,
            range: vk::WHOLE_SIZE,
        }];
        if uses_shader {
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_descriptor)
                .build();
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        }
        let set_layouts = [*set_layout];
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: push_constant_stage,
            offset: 0,
            size: 2 * std::mem::size_of::<u32>() as u32,
        }];
        let pipeline_layout_info = if uses_shader {
            vk::PipelineLayoutCreateInfo::builder()
                .set_layouts(&set_layouts)
                .push_constant_ranges(&push_constant_ranges)
        } else {
            vk::PipelineLayoutCreateInfo::builder()
        };
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let render_pass = if self.method == MemoryDepMethod::Draw {
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .build()];
            let info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
            Some(Unique::new(
                device,
                unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
            ))
        } else {
            None
        };
        let framebuffer = match &render_pass {
            Some(render_pass) => Some(make_framebuffer(device, **render_pass, &[], 1, 1, 1)?),
            None => None,
        };
        let pipeline = match self.method {
            MemoryDepMethod::Draw => {
                let vs = create_shader_module(device, binaries.get("vert")?)?;
                let fs = create_shader_module(device, binaries.get("frag")?)?;
                let stages = [
                    vk::PipelineShaderStageCreateInfo::builder()
                        .stage(vk::ShaderStageFlags::VERTEX)
                        .module(*vs)
                        .name(b"main\0")
                        .build(),
                    vk::PipelineShaderStageCreateInfo::builder()
                        .stage(vk::ShaderStageFlags::FRAGMENT)
                        .module(*fs)
                        .name(b"main\0")
                        .build(),
                ];
                let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
                let input_assembly =
                    vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::POINT_LIST);
                let viewports = [vk::Viewport {
                    x: 0.0,
                    y: 0.0,
                    width: 1.0,
                    height: 1.0,
                    min_depth: 0.0,
                    max_depth: 1.0,
                }];
                let scissors = [crate::vk::cmd_util::make_rect_2d(0, 0, 1, 1)];
                let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                    .viewports(&viewports)
                    .scissors(&scissors);
                let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
                    .polygon_mode(vk::PolygonMode::FILL)
                    .cull_mode(vk::CullModeFlags::NONE)
                    .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
                    .line_width(1.0);
                let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
                    .rasterization_samples(vk::SampleCountFlags::_1)
                    .min_sample_shading(1.0);
                let no_stencil_op = vk::StencilOpState {
                    fail_op: vk::StencilOp::KEEP,
                    pass_op: vk::StencilOp::KEEP,
                    depth_fail_op: vk::StencilOp::KEEP,
                    compare_op: vk::CompareOp::NEVER,
                    compare_mask: 0,
                    write_mask: 0,
                    reference: 0,
                };
                let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
                    .depth_compare_op(vk::CompareOp::ALWAYS)
                    .front(no_stencil_op)
                    .back(no_stencil_op)
                    .min_depth_bounds(0.0)
                    .max_depth_bounds(1.0);
                let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().logic_op(vk::LogicOp::COPY);
                let info = vk::GraphicsPipelineCreateInfo::builder()
                    .stages(&stages)
                    .vertex_input_state(&vertex_input)
                    .input_assembly_state(&input_assembly)
                    .viewport_state(&viewport_state)
                    .rasterization_state(&rasterization)
                    .multisample_state(&multisample)
                    .depth_stencil_state(&depth_stencil)
                    .color_blend_state(&color_blend)
                    .layout(*pipeline_layout)
                    .render_pass(**render_pass.as_ref().expect("a render pass"))
                    .subpass(0)
                    .base_pipeline_index(0);
                let created = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
                    .vk_check("vkCreateGraphicsPipelines")?;
                Some(Unique::new(device, created.0[0]))
            }
            MemoryDepMethod::Dispatch => {
                let cs = create_shader_module(device, binaries.get("comp")?)?;
                let stage = vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::COMPUTE)
                    .module(*cs)
                    .name(b"main\0")
                    .build();
                let info = vk::ComputePipelineCreateInfo::builder()
                    .stage(stage)
                    .layout(*pipeline_layout)
                    .base_pipeline_index(0);
                let created = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                    .vk_check("vkCreateComputePipelines")?;
                Some(Unique::new(device, created.0[0]))
            }
            MemoryDepMethod::Copy => None,
        };

        helper.write_markers(&memory, offset, &expected)?;

        let cmd_pool = make_command_pool(device, family)?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;

        match self.method {
            MemoryDepMethod::Draw => unsafe {
                device.cmd_bind_pipeline(
                    *cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    **pipeline.as_ref().expect("a pipeline"),
                );
                device.cmd_bind_descriptor_sets(
                    *cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[],
                );
            },
            MemoryDepMethod::Dispatch => unsafe {
                device.cmd_bind_pipeline(
                    *cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    **pipeline.as_ref().expect("a pipeline"),
                );
                device.cmd_bind_descriptor_sets(
                    *cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[],
                );
            },
            MemoryDepMethod::Copy => {}
        }

        let mut data_owner = vec![Owner::Nobody; size as usize];
        let mut write_stages = vk::PipelineStageFlags::empty();
        let mut write_access = vk::AccessFlags::empty();

        for i in 0..NUM_ITERS {
            let slot = rng.get_uint32() % size;
            let old_owner = data_owner[slot as usize];
            let new_owner = if 1 + rng.get_uint32() % 2 == 1 {
                Owner::Marker
            } else {
                Owner::NonMarker
            };

            if (old_owner != new_owner && old_owner != Owner::Nobody)
                || (old_owner == Owner::NonMarker && new_owner == Owner::NonMarker)
            {
                let (src_access, src_stage) = self.barrier_scope(old_owner);
                let (dst_access, dst_stage) = self.barrier_scope(new_owner);
                let memory_dep = vk::BufferMemoryBarrier::builder()
                    .src_access_mask(src_access)
                    .dst_access_mask(dst_access)
                    .src_queue_family_index(family)
                    .dst_queue_family_index(family)
                    .buffer(*buffer)
                    .offset((std::mem::size_of::<u32>() * slot as usize) as vk::DeviceSize)
                    .size(std::mem::size_of::<u32>() as vk::DeviceSize)
                    .build();
                unsafe {
                    device.cmd_pipeline_barrier(
                        *cmd,
                        src_stage,
                        dst_stage,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[memory_dep],
                        &[] as &[vk::ImageMemoryBarrier],
                    )
                };
            }

            if self.method == MemoryDepMethod::Draw {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(**render_pass.as_ref().expect("a render pass"))
                    .framebuffer(**framebuffer.as_ref().expect("a framebuffer"))
                    .render_area(crate::vk::cmd_util::make_rect_2d(0, 0, 1, 1));
                unsafe { device.cmd_begin_render_pass(*cmd, &begin_info, vk::SubpassContents::INLINE) };
            }

            let value = i;
            let byte_offset = (std::mem::size_of::<u32>() * slot as usize) as vk::DeviceSize;

            if new_owner == Owner::Marker {
                unsafe { device.cmd_write_buffer_marker_amd(*cmd, base.stage, *buffer, byte_offset, value) };
                write_stages |= vk::PipelineStageFlags::TRANSFER;
                write_access |= vk::AccessFlags::TRANSFER_WRITE;
            } else {
                match self.method {
                    MemoryDepMethod::Copy => {
                        unsafe { device.cmd_update_buffer(*cmd, *buffer, byte_offset, &value.to_ne_bytes()) };
                        write_stages |= vk::PipelineStageFlags::TRANSFER;
                        write_access |= vk::AccessFlags::TRANSFER_WRITE;
                    }
                    MemoryDepMethod::Draw => {
                        let push_const: Vec<u8> = [slot, value].iter().flat_map(|v| v.to_ne_bytes()).collect();
                        unsafe {
                            device.cmd_push_constants(*cmd, *pipeline_layout, push_constant_stage, 0, &push_const);
                            device.cmd_draw(*cmd, 1, 1, i, 0);
                        }
                        write_stages |= vk::PipelineStageFlags::FRAGMENT_SHADER;
                        write_access |= vk::AccessFlags::SHADER_WRITE;
                    }
                    MemoryDepMethod::Dispatch => {
                        let push_const: Vec<u8> = [slot, value].iter().flat_map(|v| v.to_ne_bytes()).collect();
                        unsafe {
                            device.cmd_push_constants(*cmd, *pipeline_layout, push_constant_stage, 0, &push_const);
                            device.cmd_dispatch(*cmd, 1, 1, 1);
                        }
                        write_stages |= vk::PipelineStageFlags::COMPUTE_SHADER;
                        write_access |= vk::AccessFlags::SHADER_WRITE;
                    }
                }
            }

            data_owner[slot as usize] = new_owner;
            expected[slot as usize] = value;

            if self.method == MemoryDepMethod::Draw {
                unsafe { device.cmd_end_render_pass(*cmd) };
            }
        }

        let memory_dep = vk::MemoryBarrier::builder()
            .src_access_mask(write_access)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                write_stages,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[memory_dep],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, queue, *cmd)?;

        if !helper.check_markers(&memory, offset, &expected)? {
            return Ok(TestStatus::fail("Some marker values were incorrect"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createBufferMarkerTests`
pub fn create_buffer_marker_tests() -> TestCaseGroup {
    let mut root = TestCaseGroup::new("buffer_marker");

    for (queue_name, test_queue) in [
        ("graphics", TestQueue::Graphics),
        ("compute", TestQueue::Compute),
        ("transfer", TestQueue::Transfer),
    ] {
        let mut queue_group = TestCaseGroup::new(queue_name);

        for (memory_name, use_host_ptr) in [("external_host_mem", true), ("default_mem", false)] {
            let mut memory_group = TestCaseGroup::new(memory_name);

            for (stage_name, stage) in [
                ("top_of_pipe", vk::PipelineStageFlags::TOP_OF_PIPE),
                ("bottom_of_pipe", vk::PipelineStageFlags::BOTTOM_OF_PIPE),
            ] {
                let mut stage_group = TestCaseGroup::new(stage_name);
                let base = BaseTestParams {
                    test_queue,
                    stage,
                    size: 0,
                    use_host_ptr,
                    offset: 0,
                };
                let case = |name: String, size: u32, offset: usize, overwrite: bool| {
                    Box::new(BufferMarkerCase {
                        name,
                        params: BaseTestParams { size, offset, ..base },
                        overwrite,
                    }) as Box<dyn TestCase>
                };

                let mut sequential = TestCaseGroup::new("sequential");
                sequential.add_child(case("4".to_string(), 4, 0, false));
                sequential.add_child(case("64".to_string(), 64, 0, false));
                sequential.add_child(case(test_case_name("64", 16), 64, 16, false));
                sequential.add_child(case("65536".to_string(), 65536, 0, false));
                sequential.add_child(case(test_case_name("65536", 1024), 65536, 1024, false));
                stage_group.add_child(sequential);

                let mut overwrite = TestCaseGroup::new("overwrite");
                overwrite.add_child(case("1".to_string(), 1, 0, true));
                overwrite.add_child(case("4".to_string(), 4, 0, true));
                overwrite.add_child(case("64".to_string(), 64, 0, true));
                overwrite.add_child(case(test_case_name("64", 24), 64, 24, true));
                stage_group.add_child(overwrite);

                let mut memory_dep = TestCaseGroup::new("memory_dep");
                for offset in [0usize, 24] {
                    let params = BaseTestParams {
                        size: 128,
                        offset,
                        ..base
                    };
                    if test_queue == TestQueue::Graphics {
                        memory_dep.add_child(Box::new(MemoryDepCase {
                            name: test_case_name("draw", offset),
                            base: params,
                            method: MemoryDepMethod::Draw,
                        }) as Box<dyn TestCase>);
                    }
                    if test_queue != TestQueue::Transfer {
                        memory_dep.add_child(Box::new(MemoryDepCase {
                            name: test_case_name("dispatch", offset),
                            base: params,
                            method: MemoryDepMethod::Dispatch,
                        }) as Box<dyn TestCase>);
                    }
                    memory_dep.add_child(Box::new(MemoryDepCase {
                        name: test_case_name("buffer_copy", offset),
                        base: params,
                        method: MemoryDepMethod::Copy,
                    }) as Box<dyn TestCase>);
                }
                stage_group.add_child(memory_dep);

                memory_group.add_child(stage_group);
            }
            queue_group.add_child(memory_group);
        }
        root.add_child(queue_group);
    }

    root
}
