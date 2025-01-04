// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktGlobalPriorityQueueTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `preemption` is ported (`PreemptionInstance`: two devices of their own, one queue each with a
// global priority, a large workload on the lower priority and a small one on the higher); the `from_*_to_*` cases (`GPQInstanceBase`, a device of
// queues of given families with protected and sparse resources moving between two of them) are stubs that check the extension and report
// NotPorted. The shaders are in shaders/manifest/synchronization_global_priority.toml.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::synchronization_global_priority::{
    PREEMPTION_COMPUTE, PREEMPTION_GRAPHICS, PREEMPTION_GRAPHICS_COMPUTE,
};
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_graphics_pipeline, make_pipeline_layout,
    make_pipeline_layout_with_push_constants, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};
use crate::vkt::tests::api::case_util::is_instance_extension_available;
use crate::vkt::tests::draw::util::{ImageWithBuffer, clear_value_color};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct GlobalPriorityStubCase {
    name: String,
}

impl TestCase for GlobalPriorityStubCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_global_priority")
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn is_stub(&self) -> bool {
        true
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GlobalPriorityStubInstance)
    }
}

struct GlobalPriorityStubInstance;

impl TestInstance for GlobalPriorityStubInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(
            "the global priority cases need a device made of queues of given families and priorities".to_string(),
        ))
    }
}

fn stub(name: String) -> Box<dyn TestCase> {
    Box::new(GlobalPriorityStubCase { name })
}

const LOCAL_SIZE: u32 = 32;

#[derive(Clone, Copy, PartialEq, Eq)]
enum QueueType {
    Graphics,
    Compute,
    ComputeExclusive,
    Transfer,
    TransferExclusive,
}

impl QueueType {
    /// `getQueueTypeName`
    fn name(self) -> &'static str {
        match self {
            QueueType::Graphics => "graphics",
            QueueType::Compute => "compute",
            QueueType::ComputeExclusive => "exclusive-compute",
            QueueType::Transfer => "transfer",
            QueueType::TransferExclusive => "exclusive-transfer",
        }
    }

    fn is_compute(self) -> bool {
        matches!(self, QueueType::Compute | QueueType::ComputeExclusive)
    }

    fn is_transfer(self) -> bool {
        matches!(self, QueueType::Transfer | QueueType::TransferExclusive)
    }
}

/// `getPriorityName`
fn priority_name(priority: vk::QueueGlobalPriority) -> &'static str {
    match priority {
        vk::QueueGlobalPriority::LOW => "low",
        vk::QueueGlobalPriority::MEDIUM => "medium",
        vk::QueueGlobalPriority::HIGH => "high",
        _ => "realtime",
    }
}

#[derive(Clone, Copy)]
struct PreemptionParams {
    queue_a: QueueType,
    priority_a: vk::QueueGlobalPriority,
    queue_b: QueueType,
    priority_b: vk::QueueGlobalPriority,
    double_preemption: bool,
}

impl PreemptionParams {
    fn any_queue_needs(&self, queue_type: QueueType) -> bool {
        self.queue_a == queue_type || self.queue_b == queue_type
    }

    fn needs_graphics(&self) -> bool {
        self.any_queue_needs(QueueType::Graphics)
    }

    fn needs_compute(&self) -> bool {
        self.any_queue_needs(QueueType::Compute) || self.any_queue_needs(QueueType::ComputeExclusive)
    }
}

/// `findQueueByTypeAndPriority`
fn find_queue_by_type_and_priority(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    queue_type: QueueType,
    priority: vk::QueueGlobalPriority,
) -> Result<Option<u32>, TestError> {
    let get_properties2 = instance.commands().get_physical_device_queue_family_properties2;
    let mut count = 0u32;
    unsafe { get_properties2(physical_device, &raw mut count, std::ptr::null_mut()) };
    let count = count as usize;
    if count == 0 {
        return Err(TestError::Fail("queueFamilyPropertyCount is zero".to_string()));
    }

    let mut global_priorities = vec![vk::QueueFamilyGlobalPriorityProperties::default(); count];
    let mut properties2: Vec<vk::QueueFamilyProperties2> = global_priorities
        .iter_mut()
        .map(|priorities| vk::QueueFamilyProperties2 {
            next: (priorities as *mut vk::QueueFamilyGlobalPriorityProperties).cast(),
            ..Default::default()
        })
        .collect();
    let mut returned = count as u32;
    unsafe { get_properties2(physical_device, &raw mut returned, properties2.as_mut_ptr()) };

    for (qf_index, properties) in properties2.iter().enumerate() {
        let flags = properties.queue_family_properties.queue_flags;
        let has = |flag: vk::QueueFlags| flags.contains(flag);
        let matches = match queue_type {
            QueueType::Graphics => has(vk::QueueFlags::GRAPHICS),
            QueueType::Compute => has(vk::QueueFlags::COMPUTE),
            QueueType::ComputeExclusive => has(vk::QueueFlags::COMPUTE) && !has(vk::QueueFlags::GRAPHICS),
            QueueType::Transfer => has(vk::QueueFlags::TRANSFER),
            QueueType::TransferExclusive => {
                has(vk::QueueFlags::TRANSFER) && !has(vk::QueueFlags::GRAPHICS) && !has(vk::QueueFlags::COMPUTE)
            }
        };
        if !matches {
            continue;
        }

        let priorities = &global_priorities[qf_index];
        if priorities.priorities[..priorities.priority_count as usize].contains(&priority) {
            return Ok(Some(qf_index as u32));
        }
    }
    Ok(None)
}

/// `throwNotSupported`
fn not_supported_queue(queue_type: QueueType, priority: vk::QueueGlobalPriority) -> TestError {
    TestError::NotSupported(format!(
        "Unable to find queue supporting {} and priority {}",
        queue_type.name(),
        priority_name(priority)
    ))
}

/// `DeviceHelper`: a device of its own with one queue of the given type and global priority.
struct DeviceHelper {
    device: Device,
    allocator: SimpleAllocator,
    qf_index: u32,
    queue: vk::Queue,
}

impl Drop for DeviceHelper {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

impl DeviceHelper {
    fn new(context: &Context<'_>, queue_type: QueueType, priority: vk::QueueGlobalPriority) -> Result<Self, TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let qf_index = find_queue_by_type_and_priority(instance, physical_device, queue_type, priority)?
            .ok_or_else(|| not_supported_queue(queue_type, priority))?;

        let numeric_priority = [1.0f32];
        let mut queue_priority = vk::DeviceQueueGlobalPriorityCreateInfo {
            global_priority: priority,
            ..Default::default()
        };
        let queue_infos = [vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(qf_index)
            .queue_priorities(&numeric_priority)
            .push_next(&mut queue_priority)
            .build()];
        let extensions = [c"VK_KHR_global_priority".as_ptr()];
        let features = *context.get_device_features();
        let create_info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_extension_names(&extensions)
            .enabled_features(&features);

        let device = match unsafe { instance.create_device(physical_device, &create_info, None) } {
            Ok(device) => device,
            Err(code) if code == vk::ErrorCode::NOT_PERMITTED || code == vk::ErrorCode::INITIALIZATION_FAILED => {
                return Err(TestError::NotSupported(format!(
                    "Got {code:?} when attempting to create device"
                )));
            }
            Err(code) => return Err(TestError::InternalError(format!("vkCreateDevice returned {code:?}"))),
        };
        let queue = unsafe { device.get_device_queue(qf_index, 0) };
        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
        Ok(Self {
            device,
            allocator: SimpleAllocator::new(memory_properties),
            qf_index,
            queue,
        })
    }
}

/// `PreemptionCase`
struct PreemptionCase {
    name: String,
    params: PreemptionParams,
}

impl TestCase for PreemptionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !is_instance_extension_available(context, "VK_KHR_get_physical_device_properties2")
            && context.api_version() < (1, 1, 0)
        {
            return Err(TestError::NotSupported(
                "VK_KHR_get_physical_device_properties2 is not supported by this implementation".to_string(),
            ));
        }
        context.require_device_functionality("VK_KHR_global_priority")?;

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        for (queue_type, priority) in [
            (self.params.queue_a, self.params.priority_a),
            (self.params.queue_b, self.params.priority_b),
        ] {
            if find_queue_by_type_and_priority(instance, physical_device, queue_type, priority)?.is_none() {
                return Err(not_supported_queue(queue_type, priority));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.params.needs_graphics(), self.params.needs_compute()) {
            (true, true) => PREEMPTION_GRAPHICS_COMPUTE.programs,
            (true, false) => PREEMPTION_GRAPHICS.programs,
            _ => PREEMPTION_COMPUTE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PreemptionInstance {
            context,
            params: self.params,
        })
    }
}

struct PreemptionInstance<'a> {
    context: &'a Context<'a>,
    params: PreemptionParams,
}

/// `WorkLoadData`: the objects and the recorded command buffer of one workload.
struct WorkLoadData<'d> {
    _modules: Vec<Unique<'d, vk::ShaderModule>>,
    _render_pass: Option<Unique<'d, vk::RenderPass>>,
    _framebuffer: Option<Unique<'d, vk::Framebuffer>>,
    _set_layout: Option<Unique<'d, vk::DescriptorSetLayout>>,
    _pipeline_layout: Unique<'d, vk::PipelineLayout>,
    _pipeline: Option<Unique<'d, vk::Pipeline>>,
    _descriptor_set: Option<UniqueDescriptorSet<'d>>,
    _descriptor_pool: Option<Unique<'d, vk::DescriptorPool>>,
    _command_buffer: UniqueCommandBuffer<'d>,
    _command_pool: Unique<'d, vk::CommandPool>,
    command_buffer: vk::CommandBuffer,
}

struct WorkLoadBuffers<'a, 'd> {
    image: Option<&'a ImageWithBuffer<'d>>,
    vertex_buffer: Option<&'a BufferWithMemory<'d>>,
    comp_output: Option<&'a BufferWithMemory<'d>>,
    transfer_in: Option<&'a BufferWithMemory<'d>>,
    transfer_out: Option<&'a BufferWithMemory<'d>>,
}

impl<'d> WorkLoadData<'d> {
    fn new(
        queue_type: QueueType,
        device: &'d Device,
        qf_index: u32,
        binaries: &BinaryCollection,
        color_format: vk::Format,
        extent: vk::Extent3D,
        buffers: &WorkLoadBuffers<'_, 'd>,
    ) -> Result<Self, TestError> {
        let graphics = queue_type == QueueType::Graphics;
        let compute = queue_type.is_compute();
        let transfer = queue_type.is_transfer();

        // Must match the frag shader.
        let graphics_pc_size = std::mem::size_of::<[u32; 2]>() as u32;
        let graphics_pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: graphics_pc_size,
        };

        let mut modules = Vec::new();
        let mut render_pass = None;
        let mut framebuffer = None;
        let mut set_layout = None;
        let mut descriptor_pool = None;
        let mut descriptor_set = None;
        let pipeline_layout;
        let mut pipeline = None;

        if graphics {
            let image = buffers.image.expect("graphics workload has an image");
            let vert_module = create_shader_module(device, binaries.get("vert")?)?;
            let frag_module = create_shader_module(device, binaries.get("frag")?)?;

            let pass = make_render_pass(device, color_format)?;
            framebuffer = Some(make_framebuffer(
                device,
                *pass,
                &[*image.view],
                extent.width,
                extent.height,
                1,
            )?);

            pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[graphics_pc_range])?;
            pipeline = Some(make_graphics_pipeline(
                device,
                *pipeline_layout,
                *vert_module,
                *frag_module,
                *pass,
                (extent.width, extent.height),
                vk::PrimitiveTopology::POINT_LIST,
            )?);
            render_pass = Some(pass);
            modules.push(vert_module);
            modules.push(frag_module);
        } else if compute {
            let layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .build(device)?;
            pipeline_layout = make_pipeline_layout(device, &[*layout])?;

            let comp_module = create_shader_module(device, binaries.get("comp")?)?;
            let stage = vk::PipelineShaderStageCreateInfo {
                stage: vk::ShaderStageFlags::COMPUTE,
                module: *comp_module,
                name: c"main".as_ptr(),
                ..Default::default()
            };
            let info = vk::ComputePipelineCreateInfo {
                stage,
                layout: *pipeline_layout,
                base_pipeline_index: -1,
                ..Default::default()
            };
            let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateComputePipelines")?;
            pipeline = Some(Unique::new(device, pipelines.0[0]));

            let pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let set = make_descriptor_set(device, *pool, *layout)?;

            let comp_output = buffers.comp_output.expect("compute workload has an output buffer");
            let desc_info = make_descriptor_buffer_info(comp_output.get(), 0, vk::WHOLE_SIZE);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    set.get(),
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &desc_info,
                )
                .update(device);

            set_layout = Some(layout);
            descriptor_pool = Some(pool);
            descriptor_set = Some(set);
            modules.push(comp_module);
        } else {
            // No need for pipelines, descriptor sets, etc.
            pipeline_layout = make_pipeline_layout(device, &[])?;
        }

        let command_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();

        begin_command_buffer(device, cmd)?;

        if graphics {
            let image = buffers.image.expect("graphics workload has an image");
            let clear_color = [0.0f32, 0.0, 0.0, 1.0];
            let extent_vec = [extent.width, extent.height];
            let vertex_count = extent.width * extent.height * extent.depth;
            let vertex_buffer = buffers.vertex_buffer.expect("graphics workload has a vertex buffer");
            let render_pass = render_pass.as_ref().expect("graphics workload has a render pass");
            let framebuffer = framebuffer.as_ref().expect("graphics workload has a framebuffer");
            let pipeline = pipeline.as_ref().expect("graphics workload has a pipeline");

            begin_render_pass(
                device,
                cmd,
                **render_pass,
                **framebuffer,
                make_rect_2d(0, 0, extent.width, extent.height),
                clear_value_color(clear_color),
            );
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, **pipeline);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_push_constants(
                    cmd,
                    *pipeline_layout,
                    vk::ShaderStageFlags::FRAGMENT,
                    0,
                    std::slice::from_raw_parts(extent_vec.as_ptr().cast::<u8>(), graphics_pc_size as usize),
                );
                device.cmd_draw(cmd, vertex_count, 1, 0, 0);
            }
            end_render_pass(device, cmd);
            copy_image_to_buffer(
                device,
                cmd,
                image.image.get(),
                image.buffer.get(),
                extent.width,
                extent.height,
            );
        } else if compute {
            let total_invocations = extent.width * extent.height * extent.depth;
            debug_assert!(total_invocations % LOCAL_SIZE == 0);
            let wg_count = total_invocations / LOCAL_SIZE;
            let descriptor_set = descriptor_set.as_ref().expect("compute workload has a descriptor set");
            let pipeline = pipeline.as_ref().expect("compute workload has a pipeline");

            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, **pipeline);
                device.cmd_dispatch(cmd, wg_count, 1, 1);

                let pre_host_barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                    .dst_access_mask(vk::AccessFlags::HOST_READ);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[pre_host_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        } else {
            let transfer_in = buffers.transfer_in.expect("transfer workload has an input buffer");
            let transfer_out = buffers.transfer_out.expect("transfer workload has an output buffer");
            let transfer_count = extent.height * extent.depth;
            let stride = (std::mem::size_of::<u32>() as u32 * extent.width) as vk::DeviceSize;

            for i in 0..transfer_count {
                let offset = i as vk::DeviceSize * stride;
                let copy_region = vk::BufferCopy {
                    src_offset: offset,
                    dst_offset: offset,
                    size: stride,
                };
                unsafe { device.cmd_copy_buffer(cmd, transfer_in.get(), transfer_out.get(), &[copy_region]) };
            }
        }
        debug_assert!(graphics || compute || transfer);

        end_command_buffer(device, cmd)?;
        let command_buffer = cmd_buffer.get();

        Ok(Self {
            _modules: modules,
            _render_pass: render_pass,
            _framebuffer: framebuffer,
            _set_layout: set_layout,
            _pipeline_layout: pipeline_layout,
            _pipeline: pipeline,
            _descriptor_set: descriptor_set,
            _descriptor_pool: descriptor_pool,
            _command_buffer: cmd_buffer,
            _command_pool: command_pool,
            command_buffer,
        })
    }
}

/// `makeBlankBuffer`
fn make_blank_buffer<'d>(
    device: &'d Device,
    allocator: &SimpleAllocator,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'d>, TestError> {
    let buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(size, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let allocation = buffer.get_allocation();
    unsafe { std::ptr::write_bytes(allocation.get_host_ptr(), 0, size as usize) };
    flush_alloc(device, allocation)?;
    Ok(buffer)
}

/// `getTransferValueOffset`
const TRANSFER_VALUE_OFFSET: u32 = 1000;

/// `makePrefilledBuffer`
fn make_prefilled_buffer<'d>(
    device: &'d Device,
    allocator: &SimpleAllocator,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'d>, TestError> {
    let item_count = size as usize / std::mem::size_of::<u32>();
    let values: Vec<u32> = (0..item_count as u32).map(|i| TRANSFER_VALUE_OFFSET + i).collect();
    let buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(size, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            values.as_ptr().cast::<u8>(),
            buffer.get_allocation().get_host_ptr(),
            size as usize,
        )
    };
    Ok(buffer)
}

/// `makeVertexBuffer`: coordinates for one point per pixel.
fn make_vertex_buffer<'d>(
    device: &'d Device,
    allocator: &SimpleAllocator,
    width: u32,
    height: u32,
) -> Result<BufferWithMemory<'d>, TestError> {
    let mut vertices: Vec<[f32; 4]> = Vec::with_capacity((width * height) as usize);
    for y in 0..height {
        for x in 0..width {
            let x_coord = ((x as f32 + 0.5) / width as f32) * 2.0 - 1.0;
            let y_coord = ((y as f32 + 0.5) / height as f32) * 2.0 - 1.0;
            vertices.push([x_coord, y_coord, 0.0, 1.0]);
        }
    }

    let buffer_size = std::mem::size_of_val(vertices.as_slice()) as vk::DeviceSize;
    let buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            vertices.as_ptr().cast::<u8>(),
            buffer.get_allocation().get_host_ptr(),
            buffer_size as usize,
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// `verifyIncreasingValues`
fn verify_increasing_values(
    device: &Device,
    buffer_name: &str,
    buffer: &BufferWithMemory<'_>,
    size: vk::DeviceSize,
    value_offset: u32,
) -> Result<bool, TestError> {
    invalidate_alloc(device, buffer.get_allocation())?;
    let item_count = size as usize / std::mem::size_of::<u32>();
    let items = unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast::<u32>(), item_count) };

    let mut good = true;
    for (i, &result) in items.iter().enumerate() {
        let expected = value_offset + i as u32;
        if result != expected {
            log::error!("Unexpected value in buffer {buffer_name} item {i}: expected {expected} but found {result}");
            good = false;
        }
    }
    Ok(good)
}

/// `verifyGradient`
fn verify_gradient(
    device: &Device,
    image_name: &str,
    image: &ImageWithBuffer<'_>,
    width: u32,
    height: u32,
) -> Result<bool, TestError> {
    let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let mut reference_level = TextureLevel::new(format, width, height, 1)?;
    {
        let mut reference = reference_level.get_access();
        for y in 0..height {
            for x in 0..width {
                let green = (x as f32 + 0.5) / width as f32;
                let blue = (y as f32 + 0.5) / height as f32;
                reference.set_pixel([0.0, green, blue, 1.0], x, y, 0);
            }
        }
    }

    let result = ConstPixelBufferAccess::new(format, [width, height, 1], image.read_bytes(device)?);
    let reference = reference_level.get_const_access();

    // 1/255 < 0.005 < 2/255
    let threshold = 0.005f32;
    let thresholds = [0.0, threshold, threshold, 0.0];
    let mut good = true;
    for y in 0..height {
        for x in 0..width {
            let want = reference.get_pixel(x, y, 0);
            let got = result.get_pixel(x, y, 0);
            if (0..4).any(|c| (want[c] - got[c]).abs() > thresholds[c]) {
                good = false;
            }
        }
    }
    if !good {
        log::error!("{image_name}: the image does not match the gradient");
    }
    Ok(good)
}

fn submit_commands(
    device: &Device,
    queue: vk::Queue,
    cmd_buffer: vk::CommandBuffer,
) -> Result<Unique<'_, vk::Fence>, TestError> {
    let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
    let fence = Unique::new(device, fence);
    let cmd_buffers = [cmd_buffer];
    let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
    unsafe { device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
    Ok(fence)
}

impl PreemptionInstance<'_> {
    /// `PreemptionInstance::iterate`
    fn run(&self) -> TestOutcome {
        let params = &self.params;
        // A is always the big workload device, and B the small workload device.
        let device_a = DeviceHelper::new(self.context, params.queue_a, params.priority_a)?;
        let device_b = DeviceHelper::new(self.context, params.queue_b, params.priority_b)?;
        let (dev_a, dev_b) = (&device_a.device, &device_b.device);

        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;

        let (large_width, large_height) = (512u32, 512u32);
        let (small_width, small_height) = (8u32, 8u32);
        let large_extent = vk::Extent3D {
            width: large_width,
            height: large_height,
            depth: 1,
        };
        let small_extent = vk::Extent3D {
            width: small_width,
            height: small_height,
            depth: 1,
        };
        let large_buffer_size = (large_width * large_height * std::mem::size_of::<u32>() as u32) as vk::DeviceSize;
        let small_buffer_size = (small_width * small_height * std::mem::size_of::<u32>() as u32) as vk::DeviceSize;
        let xfer_usage = vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;

        struct Resources<'d> {
            image: Option<ImageWithBuffer<'d>>,
            comp_out: Option<BufferWithMemory<'d>>,
            transfer_in: Option<BufferWithMemory<'d>>,
            transfer_out: Option<BufferWithMemory<'d>>,
            vertex: Option<BufferWithMemory<'d>>,
        }

        impl<'d> Resources<'d> {
            fn buffers(&self) -> WorkLoadBuffers<'_, 'd> {
                WorkLoadBuffers {
                    image: self.image.as_ref(),
                    vertex_buffer: self.vertex.as_ref(),
                    comp_output: self.comp_out.as_ref(),
                    transfer_in: self.transfer_in.as_ref(),
                    transfer_out: self.transfer_out.as_ref(),
                }
            }
        }

        #[allow(clippy::too_many_arguments)]
        fn make_resources<'d>(
            helper: &'d DeviceHelper,
            queue_type: QueueType,
            width: u32,
            height: u32,
            buffer_size: vk::DeviceSize,
            color_format: vk::Format,
            color_usage: vk::ImageUsageFlags,
            xfer_usage: vk::BufferUsageFlags,
        ) -> Result<Resources<'d>, TestError> {
            let device = &helper.device;
            let allocator = &helper.allocator;
            let mut resources = Resources {
                image: None,
                comp_out: None,
                transfer_in: None,
                transfer_out: None,
                vertex: None,
            };
            if queue_type == QueueType::Graphics {
                resources.image = Some(ImageWithBuffer::new_on(
                    device,
                    allocator,
                    width,
                    height,
                    color_format,
                    color_usage,
                    4,
                )?);
                resources.vertex = Some(make_vertex_buffer(device, allocator, width, height)?);
            } else if queue_type.is_compute() {
                resources.comp_out = Some(make_blank_buffer(
                    device,
                    allocator,
                    buffer_size,
                    vk::BufferUsageFlags::STORAGE_BUFFER,
                )?);
            } else {
                resources.transfer_in = Some(make_prefilled_buffer(device, allocator, buffer_size, xfer_usage)?);
                resources.transfer_out = Some(make_blank_buffer(device, allocator, buffer_size, xfer_usage)?);
            }
            Ok(resources)
        }

        let res_a = make_resources(
            &device_a,
            params.queue_a,
            large_width,
            large_height,
            large_buffer_size,
            color_format,
            color_usage,
            xfer_usage,
        )?;
        let res_b = make_resources(
            &device_b,
            params.queue_b,
            small_width,
            small_height,
            small_buffer_size,
            color_format,
            color_usage,
            xfer_usage,
        )?;

        let binaries = self.context.get_binary_collection();
        let wl_data_a = WorkLoadData::new(
            params.queue_a,
            dev_a,
            device_a.qf_index,
            &binaries,
            color_format,
            large_extent,
            &res_a.buffers(),
        )?;
        let wl_data_b = WorkLoadData::new(
            params.queue_b,
            dev_b,
            device_b.qf_index,
            &binaries,
            color_format,
            small_extent,
            &res_b.buffers(),
        )?;

        if let Some(buffer) = &res_a.transfer_in {
            flush_alloc(dev_a, buffer.get_allocation())?;
        }
        if let Some(buffer) = &res_b.transfer_in {
            flush_alloc(dev_b, buffer.get_allocation())?;
        }

        // Submit both workloads, with the large one first.
        let fence_a = submit_commands(dev_a, device_a.queue, wl_data_a.command_buffer)?;
        let fence_b = submit_commands(dev_b, device_b.queue, wl_data_b.command_buffer)?;

        unsafe { dev_b.wait_for_fences(&[*fence_b], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        if params.double_preemption {
            let new_fence_b = submit_commands(dev_b, device_b.queue, wl_data_b.command_buffer)?;
            unsafe { dev_b.wait_for_fences(&[*new_fence_b], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        }
        unsafe { dev_a.wait_for_fences(&[*fence_a], true, u64::MAX) }.vk_check("vkWaitForFences")?;

        // Verify output data.
        let mut ok = true;
        if let Some(buffer) = &res_a.comp_out {
            ok &= verify_increasing_values(dev_a, "A", buffer, large_buffer_size, 0)?;
        }
        if let Some(buffer) = &res_b.comp_out {
            ok &= verify_increasing_values(dev_b, "B", buffer, small_buffer_size, 0)?;
        }
        if let Some(image) = &res_a.image {
            ok &= verify_gradient(dev_a, "ImageA", image, large_width, large_height)?;
        }
        if let Some(image) = &res_b.image {
            ok &= verify_gradient(dev_b, "ImageB", image, small_width, small_height)?;
        }
        if let Some(buffer) = &res_a.transfer_out {
            ok &= verify_increasing_values(dev_a, "A", buffer, large_buffer_size, TRANSFER_VALUE_OFFSET)?;
        }
        if let Some(buffer) = &res_b.transfer_out {
            ok &= verify_increasing_values(dev_b, "B", buffer, small_buffer_size, TRANSFER_VALUE_OFFSET)?;
        }

        Ok(if ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Failed; check log for details")
        })
    }
}

impl TestInstance for PreemptionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `createGlobalPriorityQueueTests`
pub fn create_global_priority_queue_tests() -> TestCaseGroup {
    let transitions = ["graphics", "compute", "transfer"];
    let modifiers = ["no_modifiers", "sparse", "protected"];
    let priorities = ["low", "medium", "high", "realtime"];
    let syncs = ["no_sync", "semaphore"];

    let mut root_group = TestCaseGroup::new("global_priority_transition");

    for priority in priorities {
        let mut priority_group = TestCaseGroup::new(priority);

        for sync in syncs {
            let mut sync_group = TestCaseGroup::new(sync);

            for modifier in modifiers {
                let mut modifier_group = TestCaseGroup::new(modifier);

                for from in transitions {
                    for to in transitions {
                        // skip identical queue transitions
                        if from == to {
                            continue;
                        }

                        // ensure we only run the required combinations: graphics <-> compute and compute <-> transfer
                        let is_graphics_compute =
                            (from == "graphics" && to == "compute") || (from == "compute" && to == "graphics");
                        let is_compute_transfer =
                            (from == "compute" && to == "transfer") || (from == "transfer" && to == "compute");
                        if !is_graphics_compute && !is_compute_transfer {
                            continue;
                        }

                        modifier_group.add_child(stub(format!("from_{from}_to_{to}")));
                    }
                }

                sync_group.add_child(modifier_group);
            }

            priority_group.add_child(sync_group);
        }

        root_group.add_child(priority_group);
    }

    let mut preemption_group = TestCaseGroup::new("preemption");

    let queue_types = [
        QueueType::Graphics,
        QueueType::Compute,
        QueueType::ComputeExclusive,
        QueueType::Transfer,
        QueueType::TransferExclusive,
    ];
    let global_priorities = [
        vk::QueueGlobalPriority::LOW,
        vk::QueueGlobalPriority::MEDIUM,
        vk::QueueGlobalPriority::HIGH,
        vk::QueueGlobalPriority::REALTIME,
    ];
    for queue_a in queue_types {
        for queue_b in queue_types {
            for priority_a in global_priorities {
                for priority_b in global_priorities {
                    // These variants would not cause preemption.
                    if priority_a.as_raw() >= priority_b.as_raw() {
                        continue;
                    }

                    for double_preemption in [false, true] {
                        let params = PreemptionParams {
                            queue_a,
                            priority_a,
                            queue_b,
                            priority_b,
                            double_preemption,
                        };
                        let name = format!(
                            "{}_{}_to_{}_{}{}",
                            queue_a.name(),
                            priority_name(priority_a),
                            queue_b.name(),
                            priority_name(priority_b),
                            if double_preemption { "_double_preemption" } else { "" }
                        );
                        preemption_group.add_child(Box::new(PreemptionCase { name, params }) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }

    root_group.add_child(preemption_group);
    root_group
}
