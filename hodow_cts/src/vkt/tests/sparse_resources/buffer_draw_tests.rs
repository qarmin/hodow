// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferTests.cpp (SparseAllocationBuilder, Renderer,
//   SparseBufferTestInstance, BufferObjectTestInstance, DrawGridTestInstance, VertexBufferTestInstance, IndexBufferTestInstance,
//   IndirectBufferTestInstance and the groups that register them)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A sparse buffer backs a uniform or storage buffer (`ubo`, `ssbo.read_write`), a vertex buffer,
// an index buffer or an indirect buffer, and a fragment shader or the grid of triangles itself says whether the memory was where it should be.
// The `device_group_*` cases are registered and end in what `device_group_tests` reports; `memory_copy_indirect` (VK_KHR_copy_memory_indirect) is the vertex buffer path with the upload done by one indirect copy. The shaders are `shaders/manifest/sparse_resources_buffer_draw.toml`
// (scripts/gen_sparse_buffer_draw_manifest.py).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_2, ExtTransformFeedbackExtensionDeviceCommands, KhrCopyMemoryIndirectExtensionDeviceCommands,
};

use super::base::{Queue, QueueRequirements, SparseDevice};
use super::device_group_tests::device_group_unavailable;
use crate::generated::shaders::sparse_resources_buffer_draw::{
    SPARSE_DRAW_GRID, SPARSE_INDIRECT_DISPATCH, SPARSE_SSBO_READ_WRITE, SPARSE_TRANSFORM_FEEDBACK,
    SPARSE_UBO_SPARSE_BINDING, SPARSE_UBO_SPARSE_BINDING_ALIASED, SPARSE_UBO_SPARSE_RESIDENCY,
    SPARSE_UBO_SPARSE_RESIDENCY_ALIASED, SPARSE_UBO_SPARSE_RESIDENCY_NON_RESIDENT_STRICT,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{Allocation, MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// framebuffer size in pixels
const RENDER_SIZE: u32 = 128;
/// number of grid tiles in a row
const GRID_SIZE: u32 = RENDER_SIZE / 8;

/// `TestFlagBits`; sparseBinding is implied
#[derive(Clone, Copy, PartialEq, Eq)]
struct Flags {
    /// sparseResidencyAliased
    aliased: bool,
    /// sparseResidencyBuffer
    residency: bool,
    /// residencyNonResidentStrict
    non_resident_strict: bool,
    /// device groups are enabled
    device_groups: bool,
}

const GROUPS: [(&str, Flags); 5] = [
    ("sparse_binding", Flags::new(false, false, false)),
    ("sparse_binding_aliased", Flags::new(true, false, false)),
    ("sparse_residency", Flags::new(false, true, false)),
    ("sparse_residency_aliased", Flags::new(true, true, false)),
    ("sparse_residency_non_resident_strict", Flags::new(false, true, true)),
];

impl Flags {
    const fn new(aliased: bool, residency: bool, non_resident_strict: bool) -> Self {
        Self {
            aliased,
            residency,
            non_resident_strict,
            device_groups: false,
        }
    }

    fn with_device_groups(mut self) -> Self {
        self.device_groups = true;
        self
    }
}

/// `commonCheckSupport`
fn common_check_support(context: &Context<'_>, flags: Flags) -> Result<(), TestError> {
    let features = context.get_device_features();
    if features.sparse_binding == vk::FALSE {
        return Err(TestError::NotSupported(
            "Core feature sparseBinding not supported".to_string(),
        ));
    }
    if flags.residency && features.sparse_residency_buffer == vk::FALSE {
        return Err(TestError::NotSupported(
            "Core feature sparseResidencyBuffer not supported".to_string(),
        ));
    }
    if flags.aliased && features.sparse_residency_aliased == vk::FALSE {
        return Err(TestError::NotSupported(
            "Core feature sparseResidencyAliased not supported".to_string(),
        ));
    }
    if flags.non_resident_strict
        && context
            .get_device_properties()
            .sparse_properties
            .residency_non_resident_strict
            == vk::FALSE
    {
        return Err(TestError::NotSupported(
            "Missing sparse property: residencyNonResidentStrict".to_string(),
        ));
    }
    Ok(())
}

/// `SparseAllocation` - owns the allocated memory
struct SparseAllocation<'a> {
    num_resource_chunks: u32,
    /// buffer size in bytes
    resource_size: vk::DeviceSize,
    /// actual allocated memory
    _allocations: Vec<Allocation<'a>>,
    /// memory binds backing the resource
    memory_binds: Vec<vk::SparseMemoryBind>,
}

struct MemoryBind {
    allocation_ndx: usize,
    resource_chunk_ndx: u32,
    memory_chunk_ndx: u32,
    num_chunks: u32,
}

/// Utility to lay out memory allocations for a sparse buffer, including holes and aliased regions. "chunk" is the smallest (due to alignment) bindable
/// amount of memory.
struct SparseAllocationBuilder {
    allocation_ndx: usize,
    resource_chunk_ndx: u32,
    memory_chunk_ndx: u32,
    memory_binds: Vec<MemoryBind>,
    chunks_per_allocation: Vec<u32>,
}

impl SparseAllocationBuilder {
    fn new() -> Self {
        Self {
            allocation_ndx: 0,
            resource_chunk_ndx: 0,
            memory_chunk_ndx: 0,
            memory_binds: Vec::new(),
            chunks_per_allocation: vec![0],
        }
    }

    fn add_memory_hole(&mut self, num_chunks: u32) -> &mut Self {
        self.memory_chunk_ndx += num_chunks;
        self.chunks_per_allocation[self.allocation_ndx] += num_chunks;
        self
    }

    fn add_resource_hole(&mut self, num_chunks: u32) -> &mut Self {
        self.resource_chunk_ndx += num_chunks;
        self
    }

    fn add_memory_allocation(&mut self) -> &mut Self {
        assert!(self.memory_chunk_ndx != 0, "an empty allocation does not make sense");
        self.allocation_ndx += 1;
        self.memory_chunk_ndx = 0;
        self.chunks_per_allocation.push(0);
        self
    }

    fn add_memory_bind(&mut self, num_chunks: u32) -> &mut Self {
        self.memory_binds.push(MemoryBind {
            allocation_ndx: self.allocation_ndx,
            resource_chunk_ndx: self.resource_chunk_ndx,
            memory_chunk_ndx: self.memory_chunk_ndx,
            num_chunks,
        });
        self.resource_chunk_ndx += num_chunks;
        self.memory_chunk_ndx += num_chunks;
        self.chunks_per_allocation[self.allocation_ndx] += num_chunks;
        self
    }

    fn add_aliased_memory_bind(&mut self, allocation_ndx: usize, chunk_offset: u32, num_chunks: u32) -> &mut Self {
        assert!(allocation_ndx <= self.allocation_ndx);
        self.memory_binds.push(MemoryBind {
            allocation_ndx,
            resource_chunk_ndx: self.resource_chunk_ndx,
            memory_chunk_ndx: chunk_offset,
            num_chunks,
        });
        self.resource_chunk_ndx += num_chunks;
        self
    }

    /// `SparseAllocationBuilder::build`; the size of `reference_create_info` is ignored, `min_chunk_size` makes sure the chunks are at least this big
    fn build<'a>(
        &self,
        device: &'a Device,
        allocator: &SimpleAllocator,
        mut reference_create_info: vk::BufferCreateInfo,
        min_chunk_size: vk::DeviceSize,
    ) -> Result<SparseAllocation<'a>, TestError> {
        reference_create_info.size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let ref_buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&reference_create_info, None) }.vk_check("vkCreateBuffer")?,
        );
        let memory_requirements = unsafe { device.get_buffer_memory_requirements(*ref_buffer) };
        let alignment = memory_requirements.alignment;
        let chunk_size = alignment.max(min_chunk_size.div_ceil(alignment) * alignment);

        let requirement = if reference_create_info
            .usage
            .contains(vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS)
        {
            MemoryRequirement::DEVICE_ADDRESS
        } else {
            MemoryRequirement::ANY
        };
        let mut allocations = Vec::new();
        for &num_chunks in &self.chunks_per_allocation {
            allocations.push(allocator.allocate(
                device,
                vk::MemoryRequirements {
                    size: vk::DeviceSize::from(num_chunks) * chunk_size,
                    alignment,
                    memory_type_bits: memory_requirements.memory_type_bits,
                },
                requirement,
            )?);
        }

        let mut memory_binds = Vec::new();
        for bind in &self.memory_binds {
            let alloc = &allocations[bind.allocation_ndx];
            let sparse_bind = vk::SparseMemoryBind {
                resource_offset: vk::DeviceSize::from(bind.resource_chunk_ndx) * chunk_size,
                size: vk::DeviceSize::from(bind.num_chunks) * chunk_size,
                memory: alloc.get_memory(),
                memory_offset: alloc.get_offset() + vk::DeviceSize::from(bind.memory_chunk_ndx) * chunk_size,
                flags: vk::SparseMemoryBindFlags::empty(),
            };
            reference_create_info.size = reference_create_info
                .size
                .max(sparse_bind.resource_offset + sparse_bind.size);
            memory_binds.push(sparse_bind);
        }

        Ok(SparseAllocation {
            num_resource_chunks: self.resource_chunk_ndx,
            resource_size: reference_create_info.size,
            _allocations: allocations,
            memory_binds,
        })
    }
}

/// `bindSparseBuffer`
fn bind_sparse_buffer(
    device: &Device,
    sparse_queue: vk::Queue,
    buffer: vk::Buffer,
    sparse_allocation: &SparseAllocation<'_>,
) -> Result<(), TestError> {
    let buffer_binds = [vk::SparseBufferMemoryBindInfo::builder()
        .buffer(buffer)
        .binds(&sparse_allocation.memory_binds)
        .build()];
    let bind_info = vk::BindSparseInfo::builder().buffer_binds(&buffer_binds);

    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    unsafe { device.queue_bind_sparse(sparse_queue, &[bind_info], *fence) }.vk_check("vkQueueBindSparse")?;
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

/// `imageHasErrorPixels`: true if there are any red (or all zero) pixels in the image
fn image_has_error_pixels(rgba: &[u8]) -> bool {
    rgba.chunks_exact(4)
        .any(|pixel| *pixel == [255, 0, 0, 255] || *pixel == [0, 0, 0, 0])
}

/// The state `SparseBufferTestInstance` keeps for every test: the device with a sparse and a universal queue and the colour buffer the renderer reads
/// back into
struct SparseBufferFixture<'a> {
    sparse_device: &'a SparseDevice,
    flags: Flags,
    sparse_queue: Queue,
    universal_queue: Queue,
    shared_queue_family_indices: [u32; 2],
    color_buffer: BufferWithMemory<'a>,
}

fn create_fixture<'a>(
    context: &Context<'_>,
    sparse_device: &'a SparseDevice,
    flags: Flags,
) -> Result<SparseBufferFixture<'a>, TestError> {
    let _ = context;
    let device = sparse_device.device();
    let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
    let universal_queue = sparse_device.get_queue(vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE, 0);

    let color_buffer_size = u64::from(RENDER_SIZE * RENDER_SIZE) * 4;
    let color_buffer = BufferWithMemory::new(
        device,
        sparse_device.allocator(),
        make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::write_bytes(
            color_buffer.get_allocation().get_host_ptr(),
            0,
            color_buffer_size as usize,
        )
    };
    flush_alloc(device, color_buffer.get_allocation())?;

    Ok(SparseBufferFixture {
        sparse_device,
        flags,
        sparse_queue,
        universal_queue,
        shared_queue_family_indices: [sparse_queue.family_index, universal_queue.family_index],
        color_buffer,
    })
}

impl SparseBufferFixture<'_> {
    fn device(&self) -> &Device {
        self.sparse_device.device()
    }

    /// `getSparseBufferCreateInfo`; the buffer size is set by the caller
    fn sparse_buffer_create_info(&self, usage: vk::BufferUsageFlags) -> vk::BufferCreateInfo {
        let mut flags = vk::BufferCreateFlags::SPARSE_BINDING;
        if self.flags.residency {
            flags |= vk::BufferCreateFlags::SPARSE_RESIDENCY;
        }
        if self.flags.aliased {
            flags |= vk::BufferCreateFlags::SPARSE_ALIASED;
        }

        let mut info = vk::BufferCreateInfo {
            s_type: vk::StructureType::BUFFER_CREATE_INFO,
            next: std::ptr::null(),
            flags,
            size: 0,
            usage: vk::BufferUsageFlags::TRANSFER_DST | usage,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
        };

        if self.sparse_queue.family_index != self.universal_queue.family_index {
            info.sharing_mode = vk::SharingMode::CONCURRENT;
            info.queue_family_index_count = 2;
            info.queue_family_indices = self.shared_queue_family_indices.as_ptr();
        }
        info
    }

    fn create_buffer(&self, info: &vk::BufferCreateInfo) -> Result<Unique<'_, vk::Buffer>, TestError> {
        Ok(Unique::new(
            self.device(),
            unsafe { self.device().create_buffer(info, None) }.vk_check("vkCreateBuffer")?,
        ))
    }

    /// The copy of `staging_buffer` regions into `sparse_buffer`, submitted to the universal queue and waited for
    fn copy_to_sparse_buffer(
        &self,
        staging_buffer: vk::Buffer,
        sparse_buffer: vk::Buffer,
        regions: &[vk::BufferCopy],
    ) -> Result<(), TestError> {
        let device = self.device();
        let cmd_pool = make_command_pool(device, self.universal_queue.family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe { device.cmd_copy_buffer(*cmd_buffer, staging_buffer, sparse_buffer, regions) };
        end_command_buffer(device, *cmd_buffer)?;
        crate::vk::cmd_util::submit_commands_and_wait(device, self.universal_queue.handle, *cmd_buffer)
    }

    /// The copy of regions of `src_buffer` into `dst_buffer` on the universal queue (`copy_to_sparse_buffer` in the other direction)
    fn copy_from_sparse_buffer(
        &self,
        src_buffer: vk::Buffer,
        dst_buffer: vk::Buffer,
        regions: &[vk::BufferCopy],
    ) -> Result<(), TestError> {
        self.copy_to_sparse_buffer(src_buffer, dst_buffer, regions)
    }

    /// `SparseBufferTestInstance::draw` through the `Renderer`: renders into an RGBA8 image that is cleared to red, with the `draw_delegate` recording the draw
    fn draw(
        &self,
        context: &Context<'_>,
        topology: vk::PrimitiveTopology,
        descriptor_set_layout: Option<vk::DescriptorSetLayout>,
        specialization: Option<(Vec<vk::SpecializationMapEntry>, Vec<u8>)>,
        draw_delegate: &dyn Fn(vk::PipelineLayout, vk::CommandBuffer),
    ) -> Result<(), TestError> {
        let device = self.device();
        let render_size = RENDER_SIZE;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: color_format,
            extent: vk::Extent3D {
                width: render_size,
                height: render_size,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let color_image = ImageWithMemory::new(
            device,
            self.sparse_device.allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        let color_attachment = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_srr,
        )?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_attachment], render_size, render_size, 1)?;
        let set_layouts: Vec<vk::DescriptorSetLayout> = descriptor_set_layout.into_iter().collect();
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

        let mut state = DrawPipelineState::new(topology);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        state.viewports = vec![viewport(0.0, 0.0, render_size as f32, render_size as f32, 0.0, 1.0)];
        state.scissors = vec![rect_2d(render_size, render_size)];
        state.specialization = specialization;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, self.universal_queue.family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            rect_2d(render_size, render_size),
            clear_value_color([1.0, 0.0, 0.0, 1.0]),
        );

        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get()) };
        draw_delegate(*pipeline_layout, cmd);

        end_render_pass(device, cmd);

        // copyImageToBuffer
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            color_srr,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.color_buffer.get(),
                &[make_buffer_image_copy(
                    vk::Extent3D {
                        width: render_size,
                        height: render_size,
                        depth: 1,
                    },
                    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                )],
            );
        }
        let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };

        end_command_buffer(device, cmd)?;
        crate::vk::cmd_util::submit_commands_and_wait(device, self.universal_queue.handle, cmd)
    }

    /// `SparseBufferTestInstance::isResultCorrect`
    fn is_result_correct(&self) -> Result<bool, TestError> {
        let allocation = self.color_buffer.get_allocation();
        invalidate_alloc(self.device(), allocation)?;
        let bytes = unsafe {
            std::slice::from_raw_parts(
                allocation.get_host_ptr().cast_const(),
                (RENDER_SIZE * RENDER_SIZE * 4) as usize,
            )
        };
        Ok(!image_has_error_pixels(bytes))
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BufferObjectType {
    Uniform,
    Storage,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawGridKind {
    Vertex,
    Index,
    Indirect,
    TransformFeedback,
    MemoryCopyIndirect,
}

#[derive(Clone, Copy)]
enum Kind {
    BufferObject(BufferObjectType),
    DrawGrid(DrawGridKind),
}

struct SparseBufferCase {
    name: String,
    flags: Flags,
    kind: Kind,
}

impl SparseBufferCase {
    fn manifest_programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::DrawGrid(DrawGridKind::TransformFeedback) => SPARSE_TRANSFORM_FEEDBACK.programs,
            Kind::DrawGrid(_) => SPARSE_DRAW_GRID.programs,
            Kind::BufferObject(BufferObjectType::Storage) => SPARSE_SSBO_READ_WRITE.programs,
            Kind::BufferObject(BufferObjectType::Uniform) => {
                let f = self.flags;
                match (f.aliased, f.residency, f.non_resident_strict) {
                    (false, false, _) => SPARSE_UBO_SPARSE_BINDING.programs,
                    (true, false, _) => SPARSE_UBO_SPARSE_BINDING_ALIASED.programs,
                    (false, true, false) => SPARSE_UBO_SPARSE_RESIDENCY.programs,
                    (true, true, _) => SPARSE_UBO_SPARSE_RESIDENCY_ALIASED.programs,
                    (false, true, true) => SPARSE_UBO_SPARSE_RESIDENCY_NON_RESIDENT_STRICT.programs,
                }
            }
        }
    }
}

impl TestCase for SparseBufferCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context, self.flags)?;
        if matches!(self.kind, Kind::DrawGrid(DrawGridKind::TransformFeedback)) {
            context.require_device_functionality("VK_EXT_transform_feedback")?;
        }
        if matches!(self.kind, Kind::DrawGrid(DrawGridKind::MemoryCopyIndirect)) {
            context.require_device_functionality("VK_KHR_copy_memory_indirect")?;
            context.require_device_functionality("VK_KHR_buffer_device_address")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.manifest_programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SparseBufferInstance {
            context,
            flags: self.flags,
            kind: self.kind,
        })
    }
}

struct SparseBufferInstance<'a> {
    context: &'a Context<'a>,
    flags: Flags,
    kind: Kind,
}

impl TestInstance for SparseBufferInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.flags.device_groups {
            return Err(device_group_unavailable(self.context));
        }

        let sparse_device = SparseDevice::new(
            self.context,
            &[
                QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1),
                QueueRequirements::new(vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE, 1),
            ],
            false,
        )?;
        let fixture = create_fixture(self.context, &sparse_device, self.flags)?;

        match self.kind {
            Kind::BufferObject(buffer_type) => run_buffer_object(self.context, &fixture, buffer_type),
            Kind::DrawGrid(kind) => run_draw_grid(self.context, &fixture, kind),
        }
    }
}

/// `BufferObjectTestInstance::iterate`
fn run_buffer_object(
    context: &Context<'_>,
    fixture: &SparseBufferFixture<'_>,
    buffer_type: BufferObjectType,
) -> TestOutcome {
    let device = fixture.device();
    let allocator = fixture.sparse_device.allocator();
    let flags = fixture.flags;

    let uniform = buffer_type == BufferObjectType::Uniform;
    let buffer_usage_flags = if uniform {
        vk::BufferUsageFlags::UNIFORM_BUFFER
    } else {
        vk::BufferUsageFlags::STORAGE_BUFFER
    };
    let limits = &context.get_device_properties().limits;
    let max_buffer_type_range = if uniform {
        limits.max_uniform_buffer_range
    } else {
        limits.max_storage_buffer_range
    };
    let descriptor_type = if uniform {
        vk::DescriptorType::UNIFORM_BUFFER
    } else {
        vk::DescriptorType::STORAGE_BUFFER
    };

    // Set up the sparse buffer
    let mut reference_buffer_create_info = fixture.sparse_buffer_create_info(buffer_usage_flags);
    let min_chunk_size = 512;

    // Check how many chunks can be allocated given the alignment and size requirements of UBOs or SSBOs
    let min_allocation = SparseAllocationBuilder::new().add_memory_bind(1).build(
        device,
        allocator,
        reference_buffer_create_info,
        min_chunk_size,
    )?;
    let num_max_chunks = ((u64::from(max_buffer_type_range) / min_allocation.resource_size) as u32).max(1);

    let sparse_allocation = if num_max_chunks < 4 {
        SparseAllocationBuilder::new().add_memory_bind(1).build(
            device,
            allocator,
            reference_buffer_create_info,
            min_chunk_size,
        )?
    } else {
        // Try to use a non-trivial memory allocation scheme to make it different from a non-sparse binding
        let mut builder = SparseAllocationBuilder::new();
        builder.add_memory_bind(1);

        if flags.residency {
            builder.add_resource_hole(1);
        }

        builder.add_memory_allocation().add_memory_hole(1).add_memory_bind(1);

        if flags.aliased {
            builder.add_aliased_memory_bind(0, 0, 1);
        }

        let allocation = builder.build(device, allocator, reference_buffer_create_info, min_chunk_size)?;
        assert!(allocation.resource_size <= u64::from(max_buffer_type_range));
        allocation
    };

    // Create the buffer
    reference_buffer_create_info.size = sparse_allocation.resource_size;
    let sparse_buffer = fixture.create_buffer(&reference_buffer_create_info)?;
    bind_sparse_buffer(device, fixture.sparse_queue.handle, *sparse_buffer, &sparse_allocation)?;

    let sparse_buffer_aliased = if flags.aliased {
        let buffer = fixture.create_buffer(&reference_buffer_create_info)?;
        bind_sparse_buffer(device, fixture.sparse_queue.handle, *buffer, &sparse_allocation)?;
        Some(buffer)
    } else {
        None
    };

    // Set the uniform data
    {
        let has_aliased_chunk = flags.aliased && sparse_allocation.memory_binds.len() > 1;
        let chunk_size = sparse_allocation.resource_size / vk::DeviceSize::from(sparse_allocation.num_resource_chunks);
        let staging_buffer_size = sparse_allocation.resource_size - if has_aliased_chunk { chunk_size } else { 0 };
        let num_buffer_entries = (staging_buffer_size / 16) as u32;

        let staging_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(staging_buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // If an aliased chunk is used, the staging buffer is smaller than the sparse buffer and the last chunk is not overwritten
        let data = unsafe {
            std::slice::from_raw_parts_mut(
                staging_buffer.get_allocation().get_host_ptr().cast::<i32>(),
                num_buffer_entries as usize * 4,
            )
        };
        for i in 0..num_buffer_entries {
            let entry = &mut data[i as usize * 4..i as usize * 4 + 4];
            entry.copy_from_slice(&[((3 * i) ^ 127) as i32, 0, 0, 0]);
        }
        flush_alloc(device, staging_buffer.get_allocation())?;

        fixture.copy_to_sparse_buffer(
            staging_buffer.get(),
            *sparse_buffer,
            &[vk::BufferCopy {
                src_offset: 0,
                dst_offset: 0,
                size: staging_buffer_size,
            }],
        )?;
        // Once the fence is signaled, the write is also available to the aliasing buffer.
    }

    // Make sure that a larger range than is allowed is not accessed. This only applies to a single chunk case.
    let max_buffer_range = (sparse_allocation.resource_size.min(u64::from(u32::MAX)) as u32).min(max_buffer_type_range);

    // Descriptor sets
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(descriptor_type, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 1).build(
        device,
        vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
        1,
    )?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    {
        let buffer = match &sparse_buffer_aliased {
            Some(aliased) => **aliased,
            None => *sparse_buffer,
        };
        let sparse_buffer_info = vk::DescriptorBufferInfo {
            buffer,
            offset: 0,
            range: vk::DeviceSize::from(max_buffer_range),
        };
        let write = vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type,
            image_info: std::ptr::null(),
            buffer_info: &sparse_buffer_info,
            texel_buffer_view: std::ptr::null(),
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
    }

    // Vertex data
    let vertex_data: [[f32; 4]; 4] = [
        [-1.0, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
    ];
    let vertex_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            std::mem::size_of_val(&vertex_data) as u64,
            vk::BufferUsageFlags::VERTEX_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            vertex_data.as_ptr().cast::<u8>(),
            vertex_buffer.get_allocation().get_host_ptr(),
            std::mem::size_of_val(&vertex_data),
        )
    };
    flush_alloc(device, vertex_buffer.get_allocation())?;

    // Draw
    let num_buffer_entries = max_buffer_range / 16;
    let num_entries_per_chunk = num_buffer_entries / sparse_allocation.num_resource_chunks;
    let mut specialization_data = Vec::new();
    specialization_data.extend_from_slice(&(num_buffer_entries as i32).to_ne_bytes());
    specialization_data.extend_from_slice(&(num_entries_per_chunk as i32).to_ne_bytes());
    let spec_map_entries = vec![
        vk::SpecializationMapEntry {
            constant_id: 1,
            offset: 0,
            size: 4,
        },
        vk::SpecializationMapEntry {
            constant_id: 2,
            offset: 4,
            size: 4,
        },
    ];

    fixture.draw(
        context,
        vk::PrimitiveTopology::TRIANGLE_STRIP,
        Some(*descriptor_set_layout),
        Some((spec_map_entries, specialization_data)),
        &|pipeline_layout, cmd| unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 4, 1, 0, 0);
        },
    )?;

    if !fixture.is_result_correct()? {
        return Ok(TestStatus::fail("Some buffer values were incorrect"));
    }
    Ok(TestStatus::pass("Pass"))
}

fn buffer_device_address(device: &Device, buffer: vk::Buffer) -> u64 {
    let info = vk::BufferDeviceAddressInfo::builder().buffer(buffer);
    unsafe { device.get_buffer_device_address(&info) }
}

/// The upload of `IndirectMemoryCopyTestInstance::iterate`: the staging data is copied into the two chunks of the sparse buffer by one
/// `vkCmdCopyMemoryIndirectKHR` over a buffer of copy commands
fn copy_with_memory_copy_indirect(
    fixture: &SparseBufferFixture<'_>,
    staging_buffer: &BufferWithMemory<'_>,
    sparse_buffer: vk::Buffer,
    staging_buffer_size: vk::DeviceSize,
    per_draw_buffer_offset: vk::DeviceSize,
) -> Result<(), TestError> {
    let device = fixture.device();
    let allocator = fixture.sparse_device.allocator();
    let flags = fixture.flags;

    // Recreate the staging buffer with device address capability
    let staging_buffer_with_address = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            staging_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;

    // Copy the data from the original staging buffer
    unsafe {
        std::ptr::copy_nonoverlapping(
            staging_buffer.get_allocation().get_host_ptr().cast_const(),
            staging_buffer_with_address.get_allocation().get_host_ptr(),
            staging_buffer_size as usize,
        )
    };
    flush_alloc(device, staging_buffer_with_address.get_allocation())?;

    // Create an indirect buffer for the memory copy commands
    let indirect_buffer_size = 2 * std::mem::size_of::<vk::CopyMemoryIndirectCommandKHR>() as vk::DeviceSize;
    let indirect_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            indirect_buffer_size,
            vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
    )?;

    let mut first_chunk_offset = 0;
    let mut second_chunk_offset = per_draw_buffer_offset;

    if flags.residency {
        second_chunk_offset += per_draw_buffer_offset;
    }

    if flags.aliased {
        first_chunk_offset = second_chunk_offset + per_draw_buffer_offset;
    }

    let staging_address = buffer_device_address(device, staging_buffer_with_address.get());
    let sparse_address = buffer_device_address(device, sparse_buffer);
    let commands = unsafe {
        std::slice::from_raw_parts_mut(
            indirect_buffer
                .get_allocation()
                .get_host_ptr()
                .cast::<vk::CopyMemoryIndirectCommandKHR>(),
            2,
        )
    };
    commands[0] = vk::CopyMemoryIndirectCommandKHR {
        src_address: staging_address,
        dst_address: sparse_address + first_chunk_offset,
        size: per_draw_buffer_offset,
    };
    commands[1] = vk::CopyMemoryIndirectCommandKHR {
        src_address: staging_address + per_draw_buffer_offset,
        dst_address: sparse_address + second_chunk_offset,
        size: per_draw_buffer_offset,
    };
    flush_alloc(device, indirect_buffer.get_allocation())?;

    let cmd_pool = make_command_pool(device, fixture.universal_queue.family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    // Set up the indirect copy info
    let copy_info = vk::CopyMemoryIndirectInfoKHR {
        s_type: vk::StructureType::COPY_MEMORY_INDIRECT_INFO_KHR,
        next: std::ptr::null(),
        src_copy_flags: vk::AddressCopyFlagsKHR::DEVICE_LOCAL,
        dst_copy_flags: vk::AddressCopyFlagsKHR::SPARSE,
        copy_count: 2,
        copy_address_range: vk::StridedDeviceAddressRangeKHR {
            address: buffer_device_address(device, indirect_buffer.get()),
            size: indirect_buffer_size,
            stride: std::mem::size_of::<vk::CopyMemoryIndirectCommandKHR>() as vk::DeviceSize,
        },
    };

    // Perform the indirect memory copy
    unsafe { device.cmd_copy_memory_indirect_khr(cmd, &copy_info) };

    // Memory barrier to ensure the copy completes before rendering
    let buffer_barrier = crate::vk::obj_util::make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::VERTEX_ATTRIBUTE_READ,
        sparse_buffer,
        0,
        vk::WHOLE_SIZE,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::VERTEX_INPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };

    end_command_buffer(device, cmd)?;
    crate::vk::cmd_util::submit_commands_and_wait(device, fixture.universal_queue.handle, cmd)
}

/// `generateGrid`: vertex positions for a grid of tiles composed of two triangles each (6 vertices)
fn generate_grid(data: &mut [f32], step: f32, ox: f32, oy: f32, num_x: u32, num_y: u32, z: f32) {
    for iy in 0..num_y {
        for ix in 0..num_x {
            let ndx = (ix + num_x * iy) as usize;
            let x = ox + step * ix as f32;
            let y = oy + step * iy as f32;

            let tile = &mut data[ndx * 24..ndx * 24 + 24];
            let vertices = [
                [x + step, y, z, 1.0],
                [x, y, z, 1.0],
                [x, y + step, z, 1.0],
                [x, y + step, z, 1.0],
                [x + step, y + step, z, 1.0],
                [x + step, y, z, 1.0],
            ];
            for (vertex_ndx, vertex) in vertices.iter().enumerate() {
                tile[vertex_ndx * 4..vertex_ndx * 4 + 4].copy_from_slice(vertex);
            }
        }
    }
}

/// `DrawGridTestInstance::iterate` with the `initializeBuffers` and `rendererDraw` of the vertex, index and indirect buffer instances
fn run_draw_grid(context: &Context<'_>, fixture: &SparseBufferFixture<'_>, kind: DrawGridKind) -> TestOutcome {
    let device = fixture.device();
    let allocator = fixture.sparse_device.allocator();
    let flags = fixture.flags;

    let (buffer_usage, min_chunk_size) = match kind {
        DrawGridKind::Vertex => (
            vk::BufferUsageFlags::VERTEX_BUFFER,
            u64::from(GRID_SIZE * GRID_SIZE * 6) * 16,
        ),
        DrawGridKind::Index => (
            vk::BufferUsageFlags::INDEX_BUFFER,
            u64::from(GRID_SIZE * GRID_SIZE * 6) * 4,
        ),
        DrawGridKind::Indirect => (
            vk::BufferUsageFlags::INDIRECT_BUFFER,
            std::mem::size_of::<vk::DrawIndirectCommand>() as u64,
        ),
        DrawGridKind::TransformFeedback => (
            vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT | vk::BufferUsageFlags::TRANSFER_SRC,
            u64::from(GRID_SIZE * GRID_SIZE * 6) * 4,
        ),
        DrawGridKind::MemoryCopyIndirect => (
            vk::BufferUsageFlags::VERTEX_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
            u64::from(GRID_SIZE * GRID_SIZE * 6) * 16,
        ),
    };
    let half_vertex_count = 6 * (GRID_SIZE * GRID_SIZE) / 2;

    let mut reference_buffer_create_info = fixture.sparse_buffer_create_info(buffer_usage);

    // Allocate two chunks, each covering half of the viewport
    let mut builder = SparseAllocationBuilder::new();
    builder.add_memory_bind(1);

    if flags.residency {
        builder.add_resource_hole(1);
    }

    builder.add_memory_allocation().add_memory_hole(1).add_memory_bind(1);

    if flags.aliased {
        builder.add_aliased_memory_bind(0, 0, 1);
    }

    let sparse_allocation = builder.build(device, allocator, reference_buffer_create_info, min_chunk_size)?;

    // Create the buffer
    reference_buffer_create_info.size = sparse_allocation.resource_size;
    let sparse_buffer = fixture.create_buffer(&reference_buffer_create_info)?;

    let per_draw_buffer_offset =
        sparse_allocation.resource_size / vk::DeviceSize::from(sparse_allocation.num_resource_chunks);
    let staging_buffer_size = 2 * per_draw_buffer_offset;
    let staging_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            staging_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Bind the memory
    bind_sparse_buffer(device, fixture.sparse_queue.handle, *sparse_buffer, &sparse_allocation)?;

    // initializeBuffers
    let staging_ptr = staging_buffer.get_allocation().get_host_ptr();
    let step = 2.0 / GRID_SIZE as f32;
    let vertex_buffer = match kind {
        DrawGridKind::Vertex | DrawGridKind::MemoryCopyIndirect => {
            // Prepare data for two draw calls
            let first = unsafe {
                std::slice::from_raw_parts_mut(staging_ptr.cast::<f32>(), (per_draw_buffer_offset / 4) as usize)
            };
            generate_grid(first, step, -1.0, -1.0, GRID_SIZE, GRID_SIZE / 2, 0.0);
            let second = unsafe {
                std::slice::from_raw_parts_mut(
                    staging_ptr.add(per_draw_buffer_offset as usize).cast::<f32>(),
                    (per_draw_buffer_offset / 4) as usize,
                )
            };
            generate_grid(second, step, -1.0, 0.0, GRID_SIZE, GRID_SIZE / 2, 0.0);
            None
        }
        DrawGridKind::Index => {
            // Vertex buffer
            let vertex_buffer_size = 2 * u64::from(half_vertex_count) * 16;
            let vertex_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let vertices = unsafe {
                std::slice::from_raw_parts_mut(
                    vertex_buffer.get_allocation().get_host_ptr().cast::<f32>(),
                    (vertex_buffer_size / 4) as usize,
                )
            };
            generate_grid(vertices, step, -1.0, -1.0, GRID_SIZE, GRID_SIZE, 0.0);
            flush_alloc(device, vertex_buffer.get_allocation())?;

            // Sparse index buffer
            for chunk_ndx in 0..2u32 {
                let indices = unsafe {
                    std::slice::from_raw_parts_mut(
                        staging_ptr
                            .add(chunk_ndx as usize * per_draw_buffer_offset as usize)
                            .cast::<u32>(),
                        half_vertex_count as usize,
                    )
                };
                let ndx_base = chunk_ndx * half_vertex_count;
                for (i, index) in indices.iter_mut().enumerate() {
                    *index = ndx_base + i as u32;
                }
            }
            Some(vertex_buffer)
        }
        DrawGridKind::Indirect => {
            // Vertex buffer
            let vertex_buffer_size = 2 * 3 * 16;
            let vertex_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let vertices = unsafe {
                std::slice::from_raw_parts_mut(
                    vertex_buffer.get_allocation().get_host_ptr().cast::<f32>(),
                    (vertex_buffer_size / 4) as usize,
                )
            };
            generate_grid(vertices, 2.0, -1.0, -1.0, 1, 1, 0.0);
            flush_alloc(device, vertex_buffer.get_allocation())?;

            // Indirect buffer
            for chunk_ndx in 0..2u32 {
                let command = unsafe {
                    &mut *staging_ptr
                        .add(chunk_ndx as usize * per_draw_buffer_offset as usize)
                        .cast::<vk::DrawIndirectCommand>()
                };
                command.first_vertex = 3 * chunk_ndx;
                command.first_instance = 0;
                command.vertex_count = 3;
                command.instance_count = 1;
            }
            Some(vertex_buffer)
        }
        DrawGridKind::TransformFeedback => {
            // Create the vertex buffer
            let vertex_buffer_size = u64::from(GRID_SIZE * GRID_SIZE * 6) * 16;
            let vertex_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let vertices = unsafe {
                std::slice::from_raw_parts_mut(
                    vertex_buffer.get_allocation().get_host_ptr().cast::<f32>(),
                    (vertex_buffer_size / 4) as usize,
                )
            };
            generate_grid(vertices, step, -1.0, -1.0, GRID_SIZE, GRID_SIZE, 0.0);
            flush_alloc(device, vertex_buffer.get_allocation())?;

            // The sparse buffer that will be used for transform feedback is filled with random data from the staging buffer
            Some(vertex_buffer)
        }
    };

    // Upload to the sparse buffer
    {
        flush_alloc(device, staging_buffer.get_allocation())?;

        if kind == DrawGridKind::MemoryCopyIndirect {
            copy_with_memory_copy_indirect(
                fixture,
                &staging_buffer,
                *sparse_buffer,
                staging_buffer_size,
                per_draw_buffer_offset,
            )?;
        } else {
            let mut first_chunk_offset = 0;
            let mut second_chunk_offset = per_draw_buffer_offset;

            if flags.residency {
                second_chunk_offset += per_draw_buffer_offset;
            }

            if flags.aliased {
                first_chunk_offset = second_chunk_offset + per_draw_buffer_offset;
            }

            fixture.copy_to_sparse_buffer(
                staging_buffer.get(),
                *sparse_buffer,
                &[
                    vk::BufferCopy {
                        src_offset: 0,
                        dst_offset: first_chunk_offset,
                        size: per_draw_buffer_offset,
                    },
                    vk::BufferCopy {
                        src_offset: per_draw_buffer_offset,
                        dst_offset: second_chunk_offset,
                        size: per_draw_buffer_offset,
                    },
                ],
            )?;
        }
    }

    let second_draw_offset = per_draw_buffer_offset * if flags.residency { 2 } else { 1 };
    fixture.draw(
        context,
        vk::PrimitiveTopology::TRIANGLE_LIST,
        None,
        None,
        &|_pipeline_layout, cmd| unsafe {
            match kind {
                DrawGridKind::Vertex | DrawGridKind::MemoryCopyIndirect => {
                    let vertex_count = 6 * (GRID_SIZE * GRID_SIZE) / 2;
                    device.cmd_bind_vertex_buffers(cmd, 0, &[*sparse_buffer], &[0]);
                    device.cmd_draw(cmd, vertex_count, 1, 0, 0);

                    device.cmd_bind_vertex_buffers(cmd, 0, &[*sparse_buffer], &[second_draw_offset]);
                    device.cmd_draw(cmd, vertex_count, 1, 0, 0);
                }
                DrawGridKind::Index => {
                    if let Some(vertex_buffer) = &vertex_buffer {
                        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    }

                    device.cmd_bind_index_buffer(cmd, *sparse_buffer, 0, vk::IndexType::UINT32);
                    device.cmd_draw_indexed(cmd, half_vertex_count, 1, 0, 0, 0);

                    device.cmd_bind_index_buffer(cmd, *sparse_buffer, second_draw_offset, vk::IndexType::UINT32);
                    device.cmd_draw_indexed(cmd, half_vertex_count, 1, 0, 0, 0);
                }
                DrawGridKind::Indirect => {
                    if let Some(vertex_buffer) = &vertex_buffer {
                        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    }
                    device.cmd_draw_indirect(cmd, *sparse_buffer, 0, 1, 0);

                    device.cmd_draw_indirect(cmd, *sparse_buffer, second_draw_offset, 1, 0);
                }
                DrawGridKind::TransformFeedback => {
                    let vertex_count = 6 * GRID_SIZE * GRID_SIZE;
                    if let Some(vertex_buffer) = &vertex_buffer {
                        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    }
                    device.cmd_bind_transform_feedback_buffers_ext(
                        cmd,
                        0,
                        &[*sparse_buffer],
                        &[second_draw_offset],
                        &[per_draw_buffer_offset],
                    );

                    (device.commands().cmd_begin_transform_feedback_ext)(cmd, 0, 0, std::ptr::null(), std::ptr::null());
                    device.cmd_draw(cmd, vertex_count, 1, 0, 0);
                    (device.commands().cmd_end_transform_feedback_ext)(cmd, 0, 0, std::ptr::null(), std::ptr::null());
                }
            }
        },
    )?;

    let correct = if kind == DrawGridKind::TransformFeedback {
        // `TransformFeedbackTestInstance::isResultCorrect`: the captured indices are copied back out of the sparse buffer
        fixture.copy_from_sparse_buffer(
            *sparse_buffer,
            staging_buffer.get(),
            &[vk::BufferCopy {
                src_offset: second_draw_offset,
                dst_offset: 0,
                size: per_draw_buffer_offset,
            }],
        )?;

        // verify the selected number of items
        let vertex_count = 6 * GRID_SIZE * GRID_SIZE;
        invalidate_alloc(device, staging_buffer.get_allocation())?;
        let data = unsafe {
            std::slice::from_raw_parts(
                staging_buffer
                    .get_allocation()
                    .get_host_ptr()
                    .cast_const()
                    .cast::<u32>(),
                vertex_count as usize,
            )
        };
        let mut correct = true;
        let mut i = 0;
        while i < vertex_count {
            if data[i as usize] != i {
                correct = false;
                break;
            }
            i += if i < GRID_SIZE { 1 } else { GRID_SIZE };
        }
        correct
    } else {
        fixture.is_result_correct()?
    };

    if !correct {
        return Ok(TestStatus::fail("Some buffer values were incorrect"));
    }
    Ok(TestStatus::pass("Pass"))
}

struct IndirectDispatchCase {
    name: String,
    flags: Flags,
}

impl TestCase for IndirectDispatchCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        common_check_support(context, self.flags)
    }

    fn programs(&self) -> BinaryCollection {
        SPARSE_INDIRECT_DISPATCH.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IndirectDispatchInstance {
            context,
            flags: self.flags,
        })
    }
}

struct IndirectDispatchInstance<'a> {
    context: &'a Context<'a>,
    flags: Flags,
}

impl TestInstance for IndirectDispatchInstance<'_> {
    /// `IndirectDispatchTestInstance::iterate`: a sparse buffer, with a hole at its start, is the source of the dispatch parameters
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let sparse_device = SparseDevice::new(
            context,
            &[
                QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1),
                QueueRequirements::new(vk::QueueFlags::COMPUTE, 1),
            ],
            false,
        )?;
        let device = sparse_device.device();
        let allocator = sparse_device.allocator();
        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);
        let compute_queue = sparse_device.get_queue(vk::QueueFlags::COMPUTE, 0);

        // create the buffer that will be used as output for the compute shader and as staging buffer for the sparse buffer
        let output_item_count = 15u32;
        let inout_buffer_size = vk::DeviceSize::from(output_item_count) * 4;
        let inout_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                inout_buffer_size,
                vk::BufferUsageFlags::STORAGE_BUFFER
                    | vk::BufferUsageFlags::TRANSFER_SRC
                    | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // create the sparse buffer that will be used for the indirect dispatch
        let sparse_buffer_size: vk::DeviceSize = 1 << 18;
        let mut buffer_flags = vk::BufferCreateFlags::SPARSE_BINDING;
        if self.flags.residency {
            buffer_flags |= vk::BufferCreateFlags::SPARSE_RESIDENCY;
        }
        let sparse_buffer = Unique::new(
            device,
            unsafe {
                device.create_buffer(
                    &vk::BufferCreateInfo::builder()
                        .flags(buffer_flags)
                        .size(sparse_buffer_size)
                        .usage(vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::TRANSFER_DST)
                        .sharing_mode(vk::SharingMode::EXCLUSIVE),
                    None,
                )
            }
            .vk_check("vkCreateBuffer")?,
        );

        let mut memory_requirements = unsafe { device.get_buffer_memory_requirements(*sparse_buffer) };
        let sparse_chunk_size = memory_requirements.alignment;

        // allocate a single chunk deliberately leaving a hole at the beginning of the resource
        memory_requirements.size = sparse_chunk_size;
        let allocation = allocator.allocate(device, memory_requirements, MemoryRequirement::ANY)?;
        let sparse_memory_binds = [vk::SparseMemoryBind {
            resource_offset: sparse_chunk_size,
            size: sparse_chunk_size,
            memory: allocation.get_memory(),
            memory_offset: 0,
            flags: vk::SparseMemoryBindFlags::empty(),
        }];
        let sparse_buffer_memory_bind_info = [vk::SparseBufferMemoryBindInfo::builder()
            .buffer(*sparse_buffer)
            .binds(&sparse_memory_binds)
            .build()];
        let bind_info = vk::BindSparseInfo::builder().buffer_binds(&sparse_buffer_memory_bind_info);

        // bind memory to the sparse buffer
        let fence = Unique::new(
            device,
            unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
        );
        unsafe { device.queue_bind_sparse(sparse_queue.handle, &[bind_info], *fence) }.vk_check("vkQueueBindSparse")?;
        unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

        // copy the data for the indirect dispatch to the output buffer
        let indirect_command = [1u32, output_item_count, 1u32];
        unsafe {
            std::ptr::copy_nonoverlapping(
                indirect_command.as_ptr().cast::<u8>(),
                inout_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&indirect_command),
            )
        };
        flush_alloc(device, inout_buffer.get_allocation())?;

        // create the descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let inout_buffer_info = vk::DescriptorBufferInfo {
            buffer: inout_buffer.get(),
            offset: 0,
            range: inout_buffer_size,
        };
        let write = vk::WriteDescriptorSet {
            s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
            next: std::ptr::null(),
            dst_set: descriptor_set.get(),
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            image_info: std::ptr::null(),
            buffer_info: &inout_buffer_info,
            texel_buffer_view: std::ptr::null(),
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // create the compute pipeline
        let shader_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(-1)
            .build();
        let compute_pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        // create the command buffer for compute
        let cmd_pool = make_command_pool(device, compute_queue.family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        // wait for the inout buffer to be ready with the dispatch values
        let in_buffer_barrier = crate::vk::obj_util::make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            inout_buffer.get(),
            0,
            inout_buffer_size,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[in_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };

        // copy the indirect dispatch data to a location in the sparse buffer that has bound memory (offset by additional 4 bytes just for the test)
        let dispatch_data_offset = sparse_chunk_size + 4;
        unsafe {
            device.cmd_copy_buffer(
                cmd,
                inout_buffer.get(),
                *sparse_buffer,
                &[vk::BufferCopy {
                    src_offset: 0,
                    dst_offset: dispatch_data_offset,
                    size: 3 * 4,
                }],
            )
        };

        // wait for the sparse buffer to be ready with the dispatch values
        let sparse_buffer_barrier = crate::vk::obj_util::make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::INDIRECT_COMMAND_READ,
            *sparse_buffer,
            dispatch_data_offset,
            sparse_chunk_size,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::DRAW_INDIRECT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[sparse_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };

        // dispatch the compute shader but read the dispatch parameters from the sparse buffer
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch_indirect(cmd, *sparse_buffer, dispatch_data_offset);
        }

        // wait for the compute shader to finish writing to the output buffer
        let out_buffer_barrier = crate::vk::obj_util::make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            inout_buffer.get(),
            0,
            inout_buffer_size,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[out_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };

        end_command_buffer(device, cmd)?;
        crate::vk::cmd_util::submit_commands_and_wait(device, compute_queue.handle, cmd)?;

        // verify the output buffer
        invalidate_alloc(device, inout_buffer.get_allocation())?;
        let output_data = unsafe {
            std::slice::from_raw_parts(
                inout_buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                output_item_count as usize,
            )
        };
        for (i, &value) in output_data.iter().enumerate() {
            if value != 135 + i as u32 {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `indirect_dispatch` group: only the sparse residency variant
pub fn create_sparse_buffer_indirect_dispatch_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("indirect_dispatch");
    group.add_child(Box::new(IndirectDispatchCase {
        name: "sparse_residency".to_string(),
        flags: Flags::new(false, true, false),
    }) as Box<dyn TestCase>);
    group
}

fn add_flag_cases(group: &mut TestCaseGroup, kind: Kind, count: usize) {
    for (name, flags) in &GROUPS[..count] {
        group.add_child(Box::new(SparseBufferCase {
            name: (*name).to_string(),
            flags: *flags,
            kind,
        }) as Box<dyn TestCase>);
    }
    for (name, flags) in &GROUPS[..count] {
        group.add_child(Box::new(SparseBufferCase {
            name: format!("device_group_{name}"),
            flags: flags.with_device_groups(),
            kind,
        }) as Box<dyn TestCase>);
    }
}

/// The `ubo` group of `createSparseBufferTests`: all five flag combinations, with the device group variants
pub fn create_sparse_buffer_ubo_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ubo");
    add_flag_cases(&mut group, Kind::BufferObject(BufferObjectType::Uniform), GROUPS.len());
    group
}

/// The `read_write` group of the `ssbo` group
pub fn create_sparse_buffer_read_write_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("read_write");
    let flags = Flags::new(false, true, true);
    group.add_child(Box::new(SparseBufferCase {
        name: "sparse_residency_non_resident_strict".to_string(),
        flags,
        kind: Kind::BufferObject(BufferObjectType::Storage),
    }) as Box<dyn TestCase>);
    group
}

/// The `memory_copy_indirect` group: the four flag combinations without non-resident strict
pub fn create_sparse_buffer_memory_copy_indirect_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("memory_copy_indirect");
    for (name, flags) in &GROUPS[..GROUPS.len() - 1] {
        group.add_child(Box::new(SparseBufferCase {
            name: (*name).to_string(),
            flags: *flags,
            kind: Kind::DrawGrid(DrawGridKind::MemoryCopyIndirect),
        }) as Box<dyn TestCase>);
    }
    group
}

/// The `transform_feedback` group: only the sparse residency variant
pub fn create_sparse_buffer_transform_feedback_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("transform_feedback");
    group.add_child(Box::new(SparseBufferCase {
        name: "sparse_residency".to_string(),
        flags: Flags::new(false, true, false),
        kind: Kind::DrawGrid(DrawGridKind::TransformFeedback),
    }) as Box<dyn TestCase>);
    group
}

/// The `vertex_buffer`, `index_buffer` and `indirect_buffer` groups (the four flag combinations without non-resident strict, with the device group
/// variants)
pub fn create_sparse_buffer_draw_grid_groups() -> Vec<TestCaseGroup> {
    let mut groups = Vec::new();
    for (name, kind) in [
        ("vertex_buffer", DrawGridKind::Vertex),
        ("index_buffer", DrawGridKind::Index),
        ("indirect_buffer", DrawGridKind::Indirect),
    ] {
        let mut group = TestCaseGroup::new(name);
        add_flag_cases(&mut group, Kind::DrawGrid(kind), GROUPS.len() - 1);
        groups.push(group);
    }
    groups
}
