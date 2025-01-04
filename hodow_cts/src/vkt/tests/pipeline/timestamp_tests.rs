// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineTimestampTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. The transfer-only queue variants run on the transfer
// queue of the default device instead of a custom device created for the case (`Context::get_transfer_queue`; a board without a
// transfer-only family reports NotSupported, which is what upstream's device creation does too). The base class of upstream's
// instances is `TimestampCore` here and each variant records its commands through a closure handed to `TimestampCore::iterate`.
// `SequentialTimestampTest` draws its operation sequence from `de::Random(0)`, upstream's default base seed.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtHostQueryResetExtensionDeviceCommands, InstanceV1_1};

use super::cache_tests::{Vertex4Rgba, create_overlapping_quads, make_render_pass};
use crate::generated::shaders::pipeline_timestamp::{
    TS_ADV_GRAPHICS, TS_BASIC_COMPUTE, TS_BASIC_GRAPHICS, TS_SEQUENTIAL,
};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, ShaderObjectDraw, begin_dynamic_rendering, end_draw, make_shader_objects_stages,
};
use crate::vkt::tests::pipeline::timestamp_calibrated_tests::create_calibrated_timestamp_tests;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const ENTRY_COUNT: u32 = 8;
const MIN_TIMESTAMP_VALID_BITS: u32 = 36;
const MAX_TIMESTAMP_VALID_BITS: u32 = 64;
const RENDER_SIZE: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;
const DEFAULT_CLEAR_COLOR: [f32; 4] = [0.39, 0.58, 0.93, 1.0];

type Stage = vk::PipelineStageFlags;

/// `getPipelineStageFlagStr` for every stage the group uses.
fn pipeline_stage_name(stage: Stage) -> &'static str {
    const NAMES: [(Stage, &str); 16] = [
        (Stage::TOP_OF_PIPE, "top_of_pipe_stage"),
        (Stage::DRAW_INDIRECT, "draw_indirect_stage"),
        (Stage::VERTEX_INPUT, "vertex_input_stage"),
        (Stage::VERTEX_SHADER, "vertex_shader_stage"),
        (Stage::TESSELLATION_CONTROL_SHADER, "tessellation_control_shader_stage"),
        (
            Stage::TESSELLATION_EVALUATION_SHADER,
            "tessellation_evaluation_shader_stage",
        ),
        (Stage::GEOMETRY_SHADER, "geometry_shader_stage"),
        (Stage::FRAGMENT_SHADER, "fragment_shader_stage"),
        (Stage::EARLY_FRAGMENT_TESTS, "early_fragment_tests_stage"),
        (Stage::LATE_FRAGMENT_TESTS, "late_fragment_tests_stage"),
        (Stage::COLOR_ATTACHMENT_OUTPUT, "color_attachment_output_stage"),
        (Stage::COMPUTE_SHADER, "compute_shader_stage"),
        (Stage::TRANSFER, "transfer_stage"),
        (Stage::HOST, "host_stage"),
        (Stage::ALL_GRAPHICS, "all_graphics_stage"),
        (Stage::ALL_COMMANDS, "all_commands_stage"),
    ];
    NAMES
        .iter()
        .find(|(s, _)| *s == stage)
        .map_or("unknown_stage", |&(_, name)| name)
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TransferMethod {
    CopyBuffer,
    CopyImage,
    BlitImage,
    CopyBufferToImage,
    CopyImageToBuffer,
    UpdateBuffer,
    FillBuffer,
    ClearColorImage,
    ClearDepthStencilImage,
    ResolveImage,
    CopyQueryPoolResults,
    CopyQueryPoolResultsStrideZero,
}

const TRANSFER_METHODS: [TransferMethod; 12] = [
    TransferMethod::CopyBuffer,
    TransferMethod::CopyImage,
    TransferMethod::BlitImage,
    TransferMethod::CopyBufferToImage,
    TransferMethod::CopyImageToBuffer,
    TransferMethod::UpdateBuffer,
    TransferMethod::FillBuffer,
    TransferMethod::ClearColorImage,
    TransferMethod::ClearDepthStencilImage,
    TransferMethod::ResolveImage,
    TransferMethod::CopyQueryPoolResults,
    TransferMethod::CopyQueryPoolResultsStrideZero,
];

impl TransferMethod {
    /// `getTransferMethodStr`
    fn name(self) -> &'static str {
        match self {
            TransferMethod::CopyBuffer => "copy_buffer_method",
            TransferMethod::CopyImage => "copy_image_method",
            TransferMethod::BlitImage => "blit_image_method",
            TransferMethod::CopyBufferToImage => "copy_buffer_to_image_method",
            TransferMethod::CopyImageToBuffer => "copy_image_to_buffer_method",
            TransferMethod::UpdateBuffer => "update_buffer_method",
            TransferMethod::FillBuffer => "fill_buffer_method",
            TransferMethod::ClearColorImage => "clear_color_image_method",
            TransferMethod::ClearDepthStencilImage => "clear_depth_stencil_image_method",
            TransferMethod::ResolveImage => "resolve_image_method",
            TransferMethod::CopyQueryPoolResults => "copy_query_pool_results_method",
            TransferMethod::CopyQueryPoolResultsStrideZero => "copy_query_pool_results_stride_zero_method",
        }
    }

    /// The methods upstream skips on a transfer-only queue.
    fn needs_graphics_or_compute_queue(self) -> bool {
        matches!(
            self,
            TransferMethod::BlitImage
                | TransferMethod::ClearColorImage
                | TransferMethod::ClearDepthStencilImage
                | TransferMethod::ResolveImage
                | TransferMethod::CopyQueryPoolResults
                | TransferMethod::CopyQueryPoolResultsStrideZero
        )
    }
}

/// `TimestampTestParam`, `TransferTimestampTestParam` and `TwoCmdBuffersTestParam` in one.
#[derive(Clone)]
struct Param {
    stages: Vec<Stage>,
    in_render_pass: bool,
    host_query_reset: bool,
    transfer_only_queue: bool,
    query_result_flags: vk::QueryResultFlags,
}

impl Param {
    fn new(
        stages: &[Stage],
        in_render_pass: bool,
        host_query_reset: bool,
        transfer_only_queue: bool,
        query_result_flags: vk::QueryResultFlags,
    ) -> Self {
        Self {
            stages: stages.to_vec(),
            in_render_pass,
            host_query_reset,
            transfer_only_queue,
            query_result_flags,
        }
    }

    fn stage_prefix(&self) -> String {
        self.stages
            .iter()
            .filter(|&&stage| stage != Stage::TOP_OF_PIPE)
            .map(|&stage| format!("{}_", pipeline_stage_name(stage)))
            .collect()
    }

    fn name_suffix(&self) -> String {
        let mut suffix = String::new();
        if self.host_query_reset {
            suffix += "_host_query_reset";
        }
        if self.transfer_only_queue {
            suffix += "_transfer_queue";
        }
        if self
            .query_result_flags
            .contains(vk::QueryResultFlags::WITH_AVAILABILITY)
        {
            suffix += "_with_availability_bit";
        }
        suffix
    }

    /// `TimestampTestParam::generateTestName`
    fn generate_test_name(&self) -> String {
        format!(
            "{}{}{}",
            self.stage_prefix(),
            if self.in_render_pass {
                "in_render_pass"
            } else {
                "out_of_render_pass"
            },
            self.name_suffix()
        )
    }

    /// `TransferTimestampTestParam::generateTestName`
    fn generate_transfer_test_name(&self, method: TransferMethod) -> String {
        format!("{}with_{}{}", self.stage_prefix(), method.name(), self.name_suffix())
    }

    fn availability_bit(&self) -> bool {
        self.query_result_flags
            .contains(vk::QueryResultFlags::WITH_AVAILABILITY)
    }
}

/// `checkValidBits`, `checkTimestampValidBitsSupport` and `getTimestampMask` for one queue family.
fn check_timestamp_valid_bits_support(context: &Context<'_>, queue_family_index: u32) -> Result<(), TestError> {
    let queue_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };
    if queue_properties[queue_family_index as usize].timestamp_valid_bits == 0 {
        return Err(TestError::NotSupported("Queue does not support timestamps".to_string()));
    }
    Ok(())
}

fn get_timestamp_mask(context: &Context<'_>, queue_family_index: u32) -> Result<u64, TestError> {
    let queue_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };
    let valid_bits = queue_properties[queue_family_index as usize].timestamp_valid_bits;

    if !(MIN_TIMESTAMP_VALID_BITS..=MAX_TIMESTAMP_VALID_BITS).contains(&valid_bits) {
        return Err(TestError::Fail(format!(
            "Invalid value for timestampValidBits ({valid_bits}) in queue index {queue_family_index}"
        )));
    }
    Ok(if valid_bits == MAX_TIMESTAMP_VALID_BITS {
        u64::MAX
    } else {
        (1u64 << valid_bits) - 1
    })
}

fn check_timestamp_bits(timestamp: u64, mask: u64) -> Result<(), TestError> {
    // timestampValidBits is the unsigned integer count of meaningful bits in the timestamps written via vkCmdWriteTimestamp. Bits
    // outside the valid range are guaranteed to be zeros.
    if timestamp > mask {
        return Err(TestError::Fail(format!(
            "Invalid device timestamp value 0x{timestamp:x} according to device timestamp mask 0x{mask:x}"
        )));
    }
    Ok(())
}

/// The family and queue a case runs on.
fn select_queue(context: &Context<'_>, transfer_only_queue: bool) -> Result<(vk::Queue, u32), TestError> {
    if transfer_only_queue {
        context
            .get_transfer_queue()
            .ok_or_else(|| TestError::NotSupported("No transfer-only queue family".to_string()))
    } else {
        Ok((
            context.get_universal_queue(),
            context.get_universal_queue_family_index(),
        ))
    }
}

/// `TimestampTest::checkSupport`
fn check_timestamp_test_support(context: &Context<'_>, param: &Param) -> Result<(), TestError> {
    let (_, queue_family_index) = select_queue(context, param.transfer_only_queue)?;
    check_timestamp_valid_bits_support(context, queue_family_index)?;

    if param.host_query_reset {
        // Check VK_EXT_host_query_reset is supported
        if !context.is_device_functionality_supported("VK_EXT_host_query_reset") && context.api_version() < (1, 2, 0) {
            return Err(TestError::NotSupported(
                "VK_EXT_host_query_reset is not supported".to_string(),
            ));
        }

        let mut host_query_reset_features = vk::PhysicalDeviceHostQueryResetFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut host_query_reset_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if host_query_reset_features.host_query_reset == vk::FALSE {
            return Err(TestError::NotSupported(
                "Implementation doesn't support resetting queries from the host".to_string(),
            ));
        }
    }
    Ok(())
}

/// `vkResetQueryPool`, through the extension on a device older than 1.2.
fn host_reset_query_pool(context: &Context<'_>, query_pool: vk::QueryPool, first_query: u32, query_count: u32) {
    let device = context.get_device();
    if context.api_version() >= (1, 2, 0) {
        unsafe { device.reset_query_pool(query_pool, first_query, query_count) };
    } else {
        unsafe { device.reset_query_pool_ext(query_pool, first_query, query_count) };
    }
}

fn bytes_to_u64s(bytes: &[u8]) -> Vec<u64> {
    bytes
        .chunks_exact(8)
        .map(|chunk| u64::from_ne_bytes(chunk.try_into().expect("eight bytes")))
        .collect()
}

fn create_query_pool<'a>(device: &'a Device, query_count: u32) -> Result<Unique<'a, vk::QueryPool>, TestError> {
    let query_pool_params = vk::QueryPoolCreateInfo::builder()
        .query_type(vk::QueryType::TIMESTAMP)
        .query_count(query_count);
    Ok(Unique::new(
        device,
        unsafe { device.create_query_pool(&query_pool_params, None) }.vk_check("vkCreateQueryPool")?,
    ))
}

fn create_host_visible_buffer<'a>(
    context: &'a Context<'a>,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size, usage),
        MemoryRequirement::HOST_VISIBLE,
    )
}

/// `createImage2DAndBindMemory`, which drops the usages the format cannot do with optimal tiling.
fn create_image_2d<'a>(
    context: &'a Context<'a>,
    format: vk::Format,
    width: u32,
    height: u32,
    mut usage: vk::ImageUsageFlags,
    samples: vk::SampleCountFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let format_property = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };

    if usage.contains(vk::ImageUsageFlags::COLOR_ATTACHMENT)
        && !format_property
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
    {
        // Remove color attachment usage if the optimal tiling feature does not support it
        usage &= !vk::ImageUsageFlags::COLOR_ATTACHMENT;
    }
    if usage.contains(vk::ImageUsageFlags::STORAGE)
        && !format_property
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
    {
        // Remove storage usage if the optimal tiling feature does not support it
        usage &= !vk::ImageUsageFlags::STORAGE;
    }

    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width,
            height,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

/// `TimestampTestInstance`: the query pool, the command buffer and the verification every variant shares.
struct TimestampCore<'a> {
    context: &'a Context<'a>,
    device: &'a Device,
    queue: vk::Queue,
    #[allow(dead_code)]
    queue_family_index: u32,
    param: Param,
    cmd_buffer: UniqueCommandBuffer<'a>,
    cmd_pool: Unique<'a, vk::CommandPool>,
    query_pool: Unique<'a, vk::QueryPool>,
    timestamp_mask: u64,
}

impl<'a> TimestampCore<'a> {
    fn new(context: &'a Context<'a>, param: &Param) -> Result<Self, TestError> {
        let device = context.get_device();
        let (queue, queue_family_index) = select_queue(context, param.transfer_only_queue)?;
        let timestamp_mask = get_timestamp_mask(context, queue_family_index)?;

        // Create Query Pool
        let query_pool = create_query_pool(device, ENTRY_COUNT)?;

        // Create command pool and command buffer
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        Ok(Self {
            context,
            device,
            queue,
            queue_family_index,
            param: param.clone(),
            cmd_buffer,
            cmd_pool,
            query_pool,
            timestamp_mask,
        })
    }

    /// `if (!m_hostQueryReset) vkCmdResetQueryPool(...)`
    fn cmd_reset_queries(&self, cmd: vk::CommandBuffer) {
        if !self.param.host_query_reset {
            unsafe { self.device.cmd_reset_query_pool(cmd, *self.query_pool, 0, ENTRY_COUNT) };
        }
    }

    /// The loop that writes one timestamp per stage.
    fn cmd_write_stage_timestamps(&self, cmd: vk::CommandBuffer) {
        for (timestamp_entry, &stage) in self.param.stages.iter().enumerate() {
            unsafe {
                self.device
                    .cmd_write_timestamp(cmd, stage, *self.query_pool, timestamp_entry as u32)
            };
        }
    }

    /// `TimestampTestInstance::configCommandBuffer`
    fn config_command_buffer(&self) -> Result<(), TestError> {
        let cmd = *self.cmd_buffer;
        begin_command_buffer(self.device, cmd)?;
        self.cmd_reset_queries(cmd);
        self.cmd_write_stage_timestamps(cmd);
        end_command_buffer(self.device, cmd)
    }

    /// `TimestampTestInstance::iterate`, with `configCommandBuffer` (and the pipeline building before it) supplied by the caller.
    fn iterate(&self, config_command_buffer: impl FnOnce() -> Result<(), TestError>) -> TestOutcome {
        let device = self.device;
        let param = &self.param;
        let availability_bit = param.availability_bit();
        let stage_size = param.stages.len() as u32;
        let query_data_size = 8 * if availability_bit { 2u32 } else { 1 };

        config_command_buffer()?;
        if param.host_query_reset {
            host_reset_query_pool(self.context, *self.query_pool, 0, ENTRY_COUNT);
        }
        submit_commands_and_wait(device, self.queue, *self.cmd_buffer)?;

        // Get timestamp value from query pool
        let mut data = vec![0u8; (query_data_size * stage_size) as usize];
        unsafe {
            device.get_query_pool_results(
                *self.query_pool,
                0,
                stage_size,
                &mut data,
                query_data_size as vk::DeviceSize,
                param.query_result_flags,
            )
        }
        .vk_check("vkGetQueryPoolResults")?;
        let mut timestamp_values = bytes_to_u64s(&data);

        // Upstream steps the index over the availability words too, so only every other value of the first `stage_size` is masked.
        let mut ndx = 0usize;
        while ndx < stage_size as usize {
            timestamp_values[ndx] &= self.timestamp_mask;
            if availability_bit {
                ndx += 1;
            }
            ndx += 1;
        }

        if param.host_query_reset {
            // Initialize timestampValuesHostQueryReset values
            let mut host_reset_values = vec![0u64; stage_size as usize * 2];

            for ndx in 0..stage_size as usize {
                let ndx_timestamp_value = ndx * if availability_bit { 2 } else { 1 };
                host_reset_values[2 * ndx] = timestamp_values[ndx_timestamp_value];
            }

            // Host resets the query pool
            host_reset_query_pool(self.context, *self.query_pool, 0, stage_size);
            // Get timestamp value from query pool
            let mut host_reset_bytes: Vec<u8> =
                host_reset_values.iter().flat_map(|value| value.to_ne_bytes()).collect();
            let res = unsafe {
                device.get_query_pool_results(
                    *self.query_pool,
                    0,
                    stage_size,
                    &mut host_reset_bytes,
                    16,
                    vk::QueryResultFlags::_64 | vk::QueryResultFlags::WITH_AVAILABILITY,
                )
            };
            let host_reset_values = bytes_to_u64s(&host_reset_bytes);

            // If VK_QUERY_RESULT_WAIT_BIT and VK_QUERY_RESULT_PARTIAL_BIT are both not set then no result values are written to pData for
            // queries that are in the unavailable state at the time of the call, and vkGetQueryPoolResults returns VK_NOT_READY. However,
            // availability state is still written to pData for those queries if VK_QUERY_RESULT_WITH_AVAILABILITY_BIT is set.
            if !matches!(res, Ok(vk::SuccessCode::NOT_READY)) {
                return Ok(TestStatus::fail("QueryPoolResults incorrect reset"));
            }

            for ndx in 0..stage_size as usize {
                let ndx_timestamp_value = ndx * if availability_bit { 2 } else { 1 };
                if (host_reset_values[2 * ndx] & self.timestamp_mask) != timestamp_values[ndx_timestamp_value] {
                    return Ok(TestStatus::fail("QueryPoolResults returned value was modified"));
                }
                if host_reset_values[2 * ndx + 1] != 0 {
                    return Ok(TestStatus::fail("QueryPoolResults availability status is not zero"));
                }
            }
        }

        Ok(self.verify_timestamp(&timestamp_values))
    }

    /// `TimestampTestInstance::verifyTimestamp`
    fn verify_timestamp(&self, timestamp_values: &[u64]) -> TestStatus {
        let stages = &self.param.stages;
        let availability_bit = self.param.availability_bit();
        let increment = if availability_bit { 2 } else { 1 };

        let mut first = 0usize;
        while first < stages.len() {
            let mut second = 0usize;
            while second < first {
                if availability_bit && (timestamp_values[first + 1] == 0 || timestamp_values[second + 1] == 0) {
                    return TestStatus::fail("Timestamp query not available");
                }

                let can_compare = stages[first] == Stage::TOP_OF_PIPE
                    || stages[second] == Stage::BOTTOM_OF_PIPE
                    || stages[first] == stages[second];
                if can_compare && timestamp_values[first] < timestamp_values[second] {
                    return TestStatus::fail("Latter stage timestamp is smaller than the former stage timestamp.");
                }
                second += increment;
            }
            first += increment;
        }

        TestStatus::pass("Timestamp increases steadily.")
    }
}

/// The ways the param-based cases differ.
#[derive(Clone, Copy)]
enum Kind {
    TimestampOnly,
    BasicGraphics,
    AdvGraphics,
    BasicCompute,
    Transfer(TransferMethod),
    TwoCmdBuffers(vk::CommandBufferLevel),
}

struct TimestampCase {
    name: String,
    param: Param,
    kind: Kind,
}

impl TestCase for TimestampCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_timestamp_test_support(context, &self.param)?;

        if matches!(self.kind, Kind::AdvGraphics) {
            let features = context.get_device_features();
            for &stage in &self.param.stages {
                if stage == Stage::GEOMETRY_SHADER && features.geometry_shader == vk::FALSE {
                    return Err(TestError::NotSupported("Geometry Shader Not Supported".to_string()));
                }
                if (stage == Stage::TESSELLATION_CONTROL_SHADER || stage == Stage::TESSELLATION_EVALUATION_SHADER)
                    && features.tessellation_shader == vk::FALSE
                {
                    return Err(TestError::NotSupported("Tessellation Not Supported".to_string()));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::BasicGraphics => TS_BASIC_GRAPHICS.programs,
            Kind::AdvGraphics => TS_ADV_GRAPHICS.programs,
            Kind::BasicCompute => TS_BASIC_COMPUTE.programs,
            Kind::TimestampOnly | Kind::Transfer(_) | Kind::TwoCmdBuffers(_) => NO_PROGRAMS,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TimestampInstance {
            context,
            param: &self.param,
            kind: self.kind,
        })
    }
}

struct TimestampInstance<'a> {
    context: &'a Context<'a>,
    param: &'a Param,
    kind: Kind,
}

impl TestInstance for TimestampInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let core = TimestampCore::new(context, self.param)?;
        match self.kind {
            Kind::TimestampOnly => core.iterate(|| core.config_command_buffer()),
            Kind::BasicGraphics | Kind::AdvGraphics => {
                let adv = matches!(self.kind, Kind::AdvGraphics);
                let resources = GraphicsResources::new(context, adv)?;
                core.iterate(|| resources.config_command_buffer(&core, adv))
            }
            Kind::BasicCompute => {
                let resources = ComputeResources::new(context)?;
                core.iterate(|| resources.config_command_buffer(&core))
            }
            Kind::Transfer(method) => {
                let resources = TransferResources::new(context, &core)?;
                core.iterate(|| resources.config_command_buffer(&core, method))
            }
            Kind::TwoCmdBuffers(level) => iterate_two_cmd_buffers(&core, level),
        }
    }
}

/// `BasicGraphicsTestInstance` and `AdvGraphicsTestInstance`. Field order is drop order.
struct GraphicsResources<'a> {
    pipeline: Option<Unique<'a, vk::Pipeline>>,
    shader_objects: Option<ShaderObjectDraw<'a>>,
    state: DrawPipelineState,
    #[allow(dead_code)]
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    #[allow(dead_code)]
    depth_view: Unique<'a, vk::ImageView>,
    #[allow(dead_code)]
    color_view: Unique<'a, vk::ImageView>,
    depth_image: ImageWithMemory<'a>,
    color_image: ImageWithMemory<'a>,
    vertex_buffer: BufferWithMemory<'a>,
    num_vertices: u32,
    indirect_buffer: Option<BufferWithMemory<'a>>,
    draw_count: u32,
}

impl<'a> GraphicsResources<'a> {
    fn new(context: &'a Context<'a>, adv: bool) -> Result<Self, TestError> {
        let device = context.get_device();
        let features = context.get_device_features();

        // buildVertexBuffer
        let vertices: Vec<Vertex4Rgba> = create_overlapping_quads();
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // buildRenderPass
        let render_pass = make_render_pass(device, vk::ImageLayout::UNDEFINED)?;

        // buildFrameBuffer
        let color_image = create_image_2d(
            context,
            COLOR_FORMAT,
            RENDER_SIZE,
            RENDER_SIZE,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            vk::SampleCountFlags::_1,
        )?;
        let depth_image = create_image_2d(
            context,
            DEPTH_FORMAT,
            RENDER_SIZE,
            RENDER_SIZE,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
            vk::SampleCountFlags::_1,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view, *depth_view],
            RENDER_SIZE,
            RENDER_SIZE,
            1,
        )?;

        // Create pipeline layout
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // buildPipeline
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("color_vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("color_frag")?)?;
        let has_tessellation = adv && features.tessellation_shader != vk::FALSE;
        let has_geometry = adv && features.geometry_shader != vk::FALSE;
        let tesc_module = if has_tessellation {
            Some(create_shader_module(device, binaries.get("basic_tcs")?)?)
        } else {
            None
        };
        let tese_module = if has_tessellation {
            Some(create_shader_module(device, binaries.get("basic_tes")?)?)
        } else {
            None
        };
        let geom_module = if has_geometry {
            Some(create_shader_module(device, binaries.get("unused_geo")?)?)
        } else {
            None
        };

        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
        if let Some(module) = &tesc_module {
            stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **module));
        }
        if let Some(module) = &tese_module {
            stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **module));
        }
        if let Some(module) = &geom_module {
            stages.push((vk::ShaderStageFlags::GEOMETRY, **module));
        }
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));

        let mut state = DrawPipelineState::new(if has_tessellation {
            vk::PrimitiveTopology::PATCH_LIST
        } else {
            vk::PrimitiveTopology::TRIANGLE_LIST
        })
        .with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: size_of::<Vertex4Rgba>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0)
            .build();
        let stencil = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::NEVER)
            .compare_mask(0)
            .write_mask(0)
            .reference(0)
            .build();
        state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil)
            .back(stencil)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0)
            .build();
        if has_tessellation {
            state.patch_control_points = Some(3);
        }
        let mut stage_names = vec![(vk::ShaderStageFlags::VERTEX, "color_vert")];
        if has_tessellation {
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "basic_tcs"));
            stage_names.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "basic_tes"));
        }
        if has_geometry {
            stage_names.push((vk::ShaderStageFlags::GEOMETRY, "unused_geo"));
        }
        stage_names.push((vk::ShaderStageFlags::FRAGMENT, "color_frag"));
        let shader_objects = make_shader_objects_stages(context, &stage_names, &[], &[])?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?)
        };

        // Prepare the indirect draw buffer
        let (indirect_buffer, draw_count) = if adv {
            let draw_count = if features.multi_draw_indirect != vk::FALSE {
                2
            } else {
                1
            };
            let indirect_commands: [vk::DrawIndirectCommand; 2] = [
                vk::DrawIndirectCommand {
                    vertex_count: 12,
                    instance_count: 1,
                    first_vertex: 0,
                    first_instance: 0,
                },
                vk::DrawIndirectCommand {
                    vertex_count: 12,
                    instance_count: 1,
                    first_vertex: 11,
                    first_instance: 0,
                },
            ];
            // Load data into indirect draw buffer
            let buffer = create_host_buffer(
                context,
                &indirect_commands[..draw_count as usize],
                vk::BufferUsageFlags::INDIRECT_BUFFER,
            )?;
            (Some(buffer), draw_count)
        } else {
            (None, 0)
        };

        Ok(Self {
            pipeline,
            shader_objects,
            state,
            pipeline_layout,
            framebuffer,
            render_pass,
            depth_view,
            color_view,
            depth_image,
            color_image,
            vertex_buffer,
            num_vertices: vertices.len() as u32,
            indirect_buffer,
            draw_count,
        })
    }

    /// `BasicGraphicsTestInstance::configCommandBuffer` and `AdvGraphicsTestInstance::configCommandBuffer`
    fn config_command_buffer(&self, core: &TimestampCore<'_>, adv: bool) -> Result<(), TestError> {
        let device = core.device;
        let cmd = *core.cmd_buffer;

        let attachment_clear_values = [
            clear_value_color(DEFAULT_CLEAR_COLOR),
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];

        begin_command_buffer(device, cmd)?;

        let image_layout_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                self.color_image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                self.depth_image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                Stage::TOP_OF_PIPE,
                Stage::COLOR_ATTACHMENT_OUTPUT | Stage::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_layout_barriers,
            );
        }

        core.cmd_reset_queries(cmd);

        if let Some(shader_objects) = &self.shader_objects {
            begin_dynamic_rendering(
                device,
                cmd,
                rect_2d(RENDER_SIZE, RENDER_SIZE),
                &[RenderingAttachment {
                    view: *self.color_view,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    clear_value: attachment_clear_values[0],
                }],
                Some(RenderingAttachment {
                    view: *self.depth_view,
                    layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    clear_value: attachment_clear_values[1],
                }),
                None,
            );
            shader_objects.bind(cmd, &self.state);
        } else if let Some(pipeline) = &self.pipeline {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*self.render_pass)
                .framebuffer(*self.framebuffer)
                .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
                .clear_values(&attachment_clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            }
        }
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[self.vertex_buffer.get()], &[0]);
            if adv {
                let indirect_buffer = self.indirect_buffer.as_ref().expect("indirect buffer").get();
                device.cmd_draw_indirect(
                    cmd,
                    indirect_buffer,
                    0,
                    self.draw_count,
                    size_of::<vk::DrawIndirectCommand>() as u32,
                );
            } else {
                device.cmd_draw(cmd, self.num_vertices, 1, 0, 0);
            }
        }

        if core.param.in_render_pass {
            core.cmd_write_stage_timestamps(cmd);
        }

        end_draw(device, cmd, self.shader_objects.is_some());

        if !core.param.in_render_pass {
            core.cmd_write_stage_timestamps(cmd);
        }

        end_command_buffer(device, cmd)
    }
}

/// `BasicComputeTestInstance`
struct ComputeResources<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    _shader_module: Unique<'a, vk::ShaderModule>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    descriptor_set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _descriptor_pool: Unique<'a, vk::DescriptorPool>,
    _descriptor_set_layout: Unique<'a, vk::DescriptorSetLayout>,
    _output_buf: BufferWithMemory<'a>,
    _input_buf: BufferWithMemory<'a>,
}

impl<'a> ComputeResources<'a> {
    fn new(context: &'a Context<'a>) -> Result<Self, TestError> {
        let device = context.get_device();

        // Create buffer object, allocate storage, and generate input data
        let size = (size_of::<[f32; 4]>() * 128 * 128) as vk::DeviceSize;

        let input_buf = create_host_visible_buffer(context, size, vk::BufferUsageFlags::STORAGE_BUFFER)?;

        // Load vertices into buffer
        let input_values: Vec<f32> = (0..128u32 * 128)
            .flat_map(|ndx| (0..4u32).map(move |component| (ndx * (component + 1)) as f32))
            .collect();
        unsafe {
            std::ptr::copy_nonoverlapping(
                input_values.as_ptr().cast::<u8>(),
                input_buf.get_allocation().get_host_ptr(),
                size as usize,
            )
        };
        flush_alloc(device, input_buf.get_allocation())?;

        let output_buf = create_host_visible_buffer(context, size, vk::BufferUsageFlags::STORAGE_BUFFER)?;

        let descriptor_infos = [
            [vk::DescriptorBufferInfo::builder()
                .buffer(input_buf.get())
                .offset(0)
                .range(size)
                .build()],
            [vk::DescriptorBufferInfo::builder()
                .buffer(output_buf.get())
                .offset(0)
                .range(size)
                .build()],
        ];

        // Create descriptor set layout
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in 0..2 {
            layout_builder =
                layout_builder.add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE);
        }
        let descriptor_set_layout = layout_builder.build(device)?;

        // Create descriptor pool
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        // Create descriptor set
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let writes: Vec<vk::WriteDescriptorSet> = (0..2usize)
            .map(|descriptor_ndx| {
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(descriptor_ndx as u32)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&descriptor_infos[descriptor_ndx])
                    .build()
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Create compute pipeline layout
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Create compute shader
        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(device, binaries.get("basic_compute")?)?;

        // Create compute pipeline
        let stage_create_info = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();
        let pipeline_create_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage_create_info)
            .layout(*pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let pipelines =
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_create_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        Ok(Self {
            pipeline,
            _shader_module: shader_module,
            pipeline_layout,
            descriptor_set,
            _descriptor_pool: descriptor_pool,
            _descriptor_set_layout: descriptor_set_layout,
            _output_buf: output_buf,
            _input_buf: input_buf,
        })
    }

    /// `BasicComputeTestInstance::configCommandBuffer`
    fn config_command_buffer(&self, core: &TimestampCore<'_>) -> Result<(), TestError> {
        let device = core.device;
        let cmd = *core.cmd_buffer;

        begin_command_buffer(device, cmd)?;

        core.cmd_reset_queries(cmd);

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, self.pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *self.pipeline_layout,
                0,
                &[self.descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, 128, 1, 1);
        }

        core.cmd_write_stage_timestamps(cmd);

        end_command_buffer(device, cmd)
    }
}

/// `TransferTestInstance`
struct TransferResources<'a> {
    buf_size: vk::DeviceSize,
    image_width: u32,
    image_height: u32,
    ms_image: ImageWithMemory<'a>,
    depth_image: ImageWithMemory<'a>,
    dst_image: ImageWithMemory<'a>,
    src_image: ImageWithMemory<'a>,
    dst_buffer: BufferWithMemory<'a>,
    src_buffer: BufferWithMemory<'a>,
}

impl<'a> TransferResources<'a> {
    fn new(context: &'a Context<'a>, core: &TimestampCore<'_>) -> Result<Self, TestError> {
        let device = context.get_device();
        let buf_size: vk::DeviceSize = if core.param.availability_bit() { 512 } else { 256 };
        let image_width = 4;
        let image_height = 4;

        // Create src buffer
        let src_buffer = create_host_visible_buffer(
            context,
            buf_size,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
        )?;

        // Init the source buffer memory
        unsafe { std::ptr::write_bytes(src_buffer.get_allocation().get_host_ptr(), 0xFF, buf_size as usize) };
        flush_alloc(device, src_buffer.get_allocation())?;

        // Create dst buffer
        let dst_buffer = create_host_visible_buffer(
            context,
            buf_size,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
        )?;

        // Create src/dst/depth image
        let src_image = create_image_2d(
            context,
            COLOR_FORMAT,
            image_width,
            image_height,
            vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC,
            vk::SampleCountFlags::_1,
        )?;
        let dst_image = create_image_2d(
            context,
            COLOR_FORMAT,
            image_width,
            image_height,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_DST,
            vk::SampleCountFlags::_1,
        )?;
        let depth_image = create_image_2d(
            context,
            DEPTH_FORMAT,
            image_width,
            image_height,
            vk::ImageUsageFlags::TRANSFER_DST,
            vk::SampleCountFlags::_1,
        )?;
        let ms_image = create_image_2d(
            context,
            COLOR_FORMAT,
            image_width,
            image_height,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
            vk::SampleCountFlags::_4,
        )?;

        Ok(Self {
            buf_size,
            image_width,
            image_height,
            ms_image,
            depth_image,
            dst_image,
            src_image,
            dst_buffer,
            src_buffer,
        })
    }

    /// `TransferTestInstance::initialImageTransition`
    fn initial_image_transition(
        &self,
        device: &Device,
        cmd: vk::CommandBuffer,
        image: vk::Image,
        sub_range: vk::ImageSubresourceRange,
        layout: vk::ImageLayout,
    ) {
        let image_mem_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            layout,
            image,
            sub_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                Stage::HOST,
                Stage::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_mem_barrier],
            );
        }
    }

    /// `TransferTestInstance::configCommandBuffer`
    fn config_command_buffer(&self, core: &TimestampCore<'_>, method: TransferMethod) -> Result<(), TestError> {
        let device = core.device;
        let cmd = *core.cmd_buffer;

        begin_command_buffer(device, cmd)?;

        // Initialize buffer/image
        unsafe { device.cmd_fill_buffer(cmd, self.dst_buffer.get(), 0, self.buf_size, 0) };

        let src_clear_value = vk::ClearColorValue {
            float32: [1.0, 1.0, 1.0, 1.0],
        };
        let dst_clear_value = vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 0.0],
        };
        let sub_range_color = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let sub_range_depth = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);

        self.initial_image_transition(
            device,
            cmd,
            self.src_image.get(),
            sub_range_color,
            vk::ImageLayout::GENERAL,
        );
        self.initial_image_transition(
            device,
            cmd,
            self.dst_image.get(),
            sub_range_color,
            vk::ImageLayout::GENERAL,
        );

        if !core.param.transfer_only_queue {
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    self.src_image.get(),
                    vk::ImageLayout::GENERAL,
                    &src_clear_value,
                    &[sub_range_color],
                );
                device.cmd_clear_color_image(
                    cmd,
                    self.dst_image.get(),
                    vk::ImageLayout::GENERAL,
                    &dst_clear_value,
                    &[sub_range_color],
                );
            }
        }

        // synchronize the Clear commands before starting any copy
        let barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::TRANSFER_WRITE)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                Stage::TRANSFER,
                Stage::TRANSFER,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        core.cmd_reset_queries(cmd);

        // Copy Operations
        let img_sub_res_copy = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);

        let null_offset = vk::Offset3D { x: 0, y: 0, z: 0 };
        let image_extent = vk::Extent3D {
            width: self.image_width,
            height: self.image_height,
            depth: 1,
        };
        let image_offset = vk::Offset3D {
            x: self.image_width as i32,
            y: self.image_height as i32,
            z: 1,
        };

        let buffer_image_copy = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: self.image_width,
            buffer_image_height: self.image_height,
            image_subresource: img_sub_res_copy,
            image_offset: null_offset,
            image_extent,
        };

        match method {
            TransferMethod::CopyBuffer => {
                let copy_buf_region = vk::BufferCopy {
                    src_offset: 0,
                    dst_offset: 0,
                    size: self.buf_size,
                };
                unsafe {
                    device.cmd_copy_buffer(cmd, self.src_buffer.get(), self.dst_buffer.get(), &[copy_buf_region])
                };
            }
            TransferMethod::CopyImage => {
                let copy_image_region = vk::ImageCopy {
                    src_subresource: img_sub_res_copy,
                    src_offset: null_offset,
                    dst_subresource: img_sub_res_copy,
                    dst_offset: null_offset,
                    extent: image_extent,
                };
                unsafe {
                    device.cmd_copy_image(
                        cmd,
                        self.src_image.get(),
                        vk::ImageLayout::GENERAL,
                        self.dst_image.get(),
                        vk::ImageLayout::GENERAL,
                        &[copy_image_region],
                    )
                };
            }
            TransferMethod::CopyBufferToImage => {
                unsafe {
                    device.cmd_copy_buffer_to_image(
                        cmd,
                        self.src_buffer.get(),
                        self.dst_image.get(),
                        vk::ImageLayout::GENERAL,
                        &[buffer_image_copy],
                    )
                };
            }
            TransferMethod::CopyImageToBuffer => {
                unsafe {
                    device.cmd_copy_image_to_buffer(
                        cmd,
                        self.src_image.get(),
                        vk::ImageLayout::GENERAL,
                        self.dst_buffer.get(),
                        &[buffer_image_copy],
                    )
                };
            }
            TransferMethod::BlitImage => {
                let image_blt = vk::ImageBlit {
                    src_subresource: img_sub_res_copy,
                    src_offsets: [null_offset, image_offset],
                    dst_subresource: img_sub_res_copy,
                    dst_offsets: [null_offset, image_offset],
                };
                unsafe {
                    device.cmd_blit_image(
                        cmd,
                        self.src_image.get(),
                        vk::ImageLayout::GENERAL,
                        self.dst_image.get(),
                        vk::ImageLayout::GENERAL,
                        &[image_blt],
                        vk::Filter::NEAREST,
                    )
                };
            }
            TransferMethod::ClearColorImage => {
                unsafe {
                    device.cmd_clear_color_image(
                        cmd,
                        self.dst_image.get(),
                        vk::ImageLayout::GENERAL,
                        &src_clear_value,
                        &[sub_range_color],
                    )
                };
            }
            TransferMethod::ClearDepthStencilImage => {
                self.initial_image_transition(
                    device,
                    cmd,
                    self.depth_image.get(),
                    sub_range_depth,
                    vk::ImageLayout::GENERAL,
                );

                let clear_ds_value = vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 };
                unsafe {
                    device.cmd_clear_depth_stencil_image(
                        cmd,
                        self.depth_image.get(),
                        vk::ImageLayout::GENERAL,
                        &clear_ds_value,
                        &[sub_range_depth],
                    )
                };
            }
            TransferMethod::FillBuffer => {
                unsafe { device.cmd_fill_buffer(cmd, self.dst_buffer.get(), 0, self.buf_size, 0) };
            }
            TransferMethod::UpdateBuffer => {
                let data: [u32; 3] = [0xdeadbeef, 0xabcdef00, 0x12345678];
                let bytes: Vec<u8> = data.iter().flat_map(|value| value.to_ne_bytes()).collect();
                unsafe { device.cmd_update_buffer(cmd, self.dst_buffer.get(), 0x10, &bytes) };
            }
            TransferMethod::CopyQueryPoolResults | TransferMethod::CopyQueryPoolResultsStrideZero => {
                unsafe { device.cmd_write_timestamp(cmd, Stage::TOP_OF_PIPE, *core.query_pool, 0) };
                let copy_stride: vk::DeviceSize = if method == TransferMethod::CopyQueryPoolResultsStrideZero {
                    0
                } else {
                    8
                };
                unsafe {
                    device.cmd_copy_query_pool_results(
                        cmd,
                        *core.query_pool,
                        0,
                        1,
                        self.dst_buffer.get(),
                        0,
                        copy_stride,
                        vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
                    )
                };

                let buffer_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    self.dst_buffer.get(),
                    0,
                    vk::WHOLE_SIZE,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        Stage::TRANSFER,
                        Stage::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[buffer_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                    device.cmd_reset_query_pool(cmd, *core.query_pool, 0, 1);
                }
            }
            TransferMethod::ResolveImage => {
                let image_resolve = vk::ImageResolve {
                    src_subresource: img_sub_res_copy,
                    src_offset: null_offset,
                    dst_subresource: img_sub_res_copy,
                    dst_offset: null_offset,
                    extent: image_extent,
                };

                self.initial_image_transition(
                    device,
                    cmd,
                    self.ms_image.get(),
                    sub_range_color,
                    vk::ImageLayout::GENERAL,
                );
                unsafe {
                    device.cmd_clear_color_image(
                        cmd,
                        self.ms_image.get(),
                        vk::ImageLayout::GENERAL,
                        &src_clear_value,
                        &[sub_range_color],
                    );
                    device.cmd_pipeline_barrier(
                        cmd,
                        Stage::TRANSFER,
                        Stage::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                    device.cmd_resolve_image(
                        cmd,
                        self.ms_image.get(),
                        vk::ImageLayout::GENERAL,
                        self.dst_image.get(),
                        vk::ImageLayout::GENERAL,
                        &[image_resolve],
                    );
                }
            }
        }

        core.cmd_write_stage_timestamps(cmd);

        end_command_buffer(device, cmd)
    }
}

/// `TwoCmdBuffersTestInstance::configCommandBuffer` and `iterate`
fn iterate_two_cmd_buffers(core: &TimestampCore<'_>, cmd_buffer_level: vk::CommandBufferLevel) -> TestOutcome {
    let context = core.context;
    let device = core.device;
    let param = &core.param;

    let second_cmd_buffer = allocate_command_buffer(device, *core.cmd_pool, cmd_buffer_level)?;
    let dst_buffer = create_host_visible_buffer(
        context,
        1024,
        vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
    )?;

    let cmd = *core.cmd_buffer;
    let second_cmd = *second_cmd_buffer;
    let begin_info = vk::CommandBufferBeginInfo::builder();
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        dst_buffer.get(),
        0,
        vk::WHOLE_SIZE,
    );
    let host_barrier = |command_buffer: vk::CommandBuffer| unsafe {
        device.cmd_pipeline_barrier(
            command_buffer,
            Stage::TRANSFER,
            Stage::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    };

    if cmd_buffer_level == vk::CommandBufferLevel::PRIMARY {
        unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
        core.cmd_reset_queries(cmd);
        unsafe { device.cmd_write_timestamp(cmd, Stage::ALL_GRAPHICS, *core.query_pool, 0) };
        unsafe { device.end_command_buffer(cmd) }.vk_check("vkEndCommandBuffer")?;
        unsafe { device.begin_command_buffer(second_cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
        unsafe {
            device.cmd_copy_query_pool_results(
                second_cmd,
                *core.query_pool,
                0,
                1,
                dst_buffer.get(),
                0,
                0,
                param.query_result_flags,
            )
        };
        host_barrier(second_cmd);
        unsafe { device.end_command_buffer(second_cmd) }.vk_check("vkEndCommandBuffer")?;
    } else {
        let inheritance_info = vk::CommandBufferInheritanceInfo::builder();
        let begin_info_secondary = vk::CommandBufferBeginInfo::builder().inheritance_info(&inheritance_info);

        unsafe { device.begin_command_buffer(second_cmd, &begin_info_secondary) }.vk_check("vkBeginCommandBuffer")?;
        core.cmd_reset_queries(second_cmd);
        let pipeline_stage = if param.transfer_only_queue {
            Stage::TRANSFER
        } else {
            Stage::ALL_GRAPHICS
        };
        unsafe { device.cmd_write_timestamp(second_cmd, pipeline_stage, *core.query_pool, 0) };
        unsafe { device.end_command_buffer(second_cmd) }.vk_check("vkEndCommandBuffer")?;
        unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
        unsafe { device.cmd_execute_commands(cmd, &[second_cmd]) };
        if !param.transfer_only_queue {
            unsafe {
                device.cmd_copy_query_pool_results(
                    cmd,
                    *core.query_pool,
                    0,
                    1,
                    dst_buffer.get(),
                    0,
                    0,
                    param.query_result_flags,
                )
            };
        }
        host_barrier(cmd);
        unsafe { device.end_command_buffer(cmd) }.vk_check("vkEndCommandBuffer")?;
    }

    let cmd_buffers = [cmd, second_cmd];
    let submit_count = if cmd_buffer_level == vk::CommandBufferLevel::PRIMARY {
        2
    } else {
        1
    };
    let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffers[..submit_count]);

    if param.host_query_reset {
        // Only reset the pool for the primary command buffer, the secondary command buffer will reset the pool by itself.
        host_reset_query_pool(context, *core.query_pool, 0, ENTRY_COUNT);
    }

    unsafe { device.queue_submit(core.queue, &[submit_info], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
    unsafe { device.queue_wait_idle(core.queue) }.vk_check("vkQueueWaitIdle")?;

    // Always pass in case no crash occurred.
    Ok(TestStatus::pass("Pass"))
}

/// `FillBufferBeforeCopyTest`, `ResetTimestampQueryBeforeCopyTest` and `ConsistentQueryResultsTest` and the other cases without a
/// param.
#[derive(Clone, Copy)]
enum MiscKind {
    FillBufferBeforeCopy,
    ResetQueryBeforeCopy,
    ConsistentResults,
    CheckComputeAndGraphics,
    Sequential,
    PipelineStage(Stage),
}

struct MiscCase {
    name: String,
    kind: MiscKind,
}

impl TestCase for MiscCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            MiscKind::CheckComputeAndGraphics => {
                if context.get_device_properties().limits.timestamp_compute_and_graphics == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "timestampComputeAndGraphics is not supported".to_string(),
                    ));
                }
            }
            MiscKind::PipelineStage(stage) => {
                check_timestamp_valid_bits_support(context, context.get_universal_queue_family_index())?;

                let features = context.get_device_features();
                if (stage == Stage::TESSELLATION_CONTROL_SHADER || stage == Stage::TESSELLATION_EVALUATION_SHADER)
                    && features.tessellation_shader == vk::FALSE
                {
                    return Err(TestError::NotSupported("Tessellation not supported".to_string()));
                }
                if stage == Stage::GEOMETRY_SHADER && features.geometry_shader == vk::FALSE {
                    return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
                }
            }
            _ => check_timestamp_valid_bits_support(context, context.get_universal_queue_family_index())?,
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            MiscKind::Sequential => TS_SEQUENTIAL.programs,
            _ => NO_PROGRAMS,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MiscInstance {
            context,
            kind: self.kind,
        })
    }
}

struct MiscInstance<'a> {
    context: &'a Context<'a>,
    kind: MiscKind,
}

impl TestInstance for MiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            MiscKind::FillBufferBeforeCopy => iterate_fill_buffer_before_copy(self.context),
            MiscKind::ResetQueryBeforeCopy => iterate_reset_query_before_copy(self.context),
            MiscKind::ConsistentResults => iterate_consistent_results(self.context),
            MiscKind::CheckComputeAndGraphics => iterate_check_compute_and_graphics(self.context),
            MiscKind::Sequential => iterate_sequential(self.context),
            MiscKind::PipelineStage(stage) => iterate_pipeline_stage(self.context, stage),
        }
    }
}

/// The query pool, command buffer and result buffer the three single-query copy cases build.
struct CopyFixture<'a> {
    cmd_buffer: UniqueCommandBuffer<'a>,
    _cmd_pool: Unique<'a, vk::CommandPool>,
    query_pool: Unique<'a, vk::QueryPool>,
}

impl<'a> CopyFixture<'a> {
    fn new(context: &'a Context<'a>) -> Result<Self, TestError> {
        let device = context.get_device();
        let query_pool = create_query_pool(device, 1)?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        Ok(Self {
            cmd_buffer,
            _cmd_pool: cmd_pool,
            query_pool,
        })
    }
}

fn cmd_buffer_to_host_barrier(device: &Device, cmd: vk::CommandBuffer, buffer: vk::Buffer) {
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        buffer,
        0,
        vk::WHOLE_SIZE,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            Stage::TRANSFER,
            Stage::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `FillBufferBeforeCopyTestInstance`
fn iterate_fill_buffer_before_copy(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let fixture = CopyFixture::new(context)?;
    let cmd = *fixture.cmd_buffer;

    // Create results buffer: a timestamp and its availability.
    let result_buffer_size = 2 * size_of::<u64>() as vk::DeviceSize;
    let result_buffer = create_host_visible_buffer(context, result_buffer_size, vk::BufferUsageFlags::TRANSFER_DST)?;

    let fill_buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::TRANSFER_WRITE,
        result_buffer.get(),
        0,
        vk::WHOLE_SIZE,
    );

    // Prepare command buffer.
    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_reset_query_pool(cmd, *fixture.query_pool, 0, 1);
        device.cmd_fill_buffer(cmd, result_buffer.get(), 0, result_buffer_size, 0);
        device.cmd_pipeline_barrier(
            cmd,
            Stage::TRANSFER,
            Stage::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[fill_buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
        device.cmd_write_timestamp(cmd, Stage::TOP_OF_PIPE, *fixture.query_pool, 0);
        device.cmd_copy_query_pool_results(
            cmd,
            *fixture.query_pool,
            0,
            1,
            result_buffer.get(),
            0,
            result_buffer_size,
            vk::QueryResultFlags::_64 | vk::QueryResultFlags::WITH_AVAILABILITY,
        );
    }
    cmd_buffer_to_host_barrier(device, cmd, result_buffer.get());
    end_command_buffer(device, cmd)?;

    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
    invalidate_alloc(device, result_buffer.get_allocation())?;
    let ta = bytes_to_u64s(unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr(),
            result_buffer_size as usize,
        )
    });
    let (timestamp, availability) = (ta[0], ta[1]);
    if availability != 0 && timestamp == 0 {
        return Ok(TestStatus::fail("Timestamp not written"));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `ResetTimestampQueryBeforeCopyTestInstance`
fn iterate_reset_query_before_copy(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let fixture = CopyFixture::new(context)?;
    let cmd = *fixture.cmd_buffer;

    let result_buffer_size = 2 * size_of::<u64>() as vk::DeviceSize;
    let result_buffer = create_host_visible_buffer(context, result_buffer_size, vk::BufferUsageFlags::TRANSFER_DST)?;

    // Prepare command buffer.
    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_reset_query_pool(cmd, *fixture.query_pool, 0, 1);
        device.cmd_write_timestamp(cmd, Stage::TOP_OF_PIPE, *fixture.query_pool, 0);
        device.cmd_reset_query_pool(cmd, *fixture.query_pool, 0, 1);
        device.cmd_copy_query_pool_results(
            cmd,
            *fixture.query_pool,
            0,
            1,
            result_buffer.get(),
            0,
            result_buffer_size,
            vk::QueryResultFlags::_64 | vk::QueryResultFlags::WITH_AVAILABILITY,
        );
    }
    cmd_buffer_to_host_barrier(device, cmd, result_buffer.get());
    end_command_buffer(device, cmd)?;

    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
    invalidate_alloc(device, result_buffer.get_allocation())?;
    let ta = bytes_to_u64s(unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr(),
            result_buffer_size as usize,
        )
    });
    if ta[1] != 0 {
        return Ok(TestStatus::fail("Availability bit nonzero after resetting query"));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `ConsistentQueryResultsTestInstance`
fn iterate_consistent_results(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let fixture = CopyFixture::new(context)?;
    let cmd = *fixture.cmd_buffer;

    // Check support for timestamp queries
    let timestamp_mask = get_timestamp_mask(context, queue_family_index)?;

    // Create results buffers.
    let result_buffer_32_bits = create_host_visible_buffer(
        context,
        size_of::<u32>() as vk::DeviceSize,
        vk::BufferUsageFlags::TRANSFER_DST,
    )?;
    let result_buffer_64_bits = create_host_visible_buffer(
        context,
        size_of::<u64>() as vk::DeviceSize,
        vk::BufferUsageFlags::TRANSFER_DST,
    )?;

    // Prepare command buffer.
    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_reset_query_pool(cmd, *fixture.query_pool, 0, 1);
        device.cmd_write_timestamp(cmd, Stage::TOP_OF_PIPE, *fixture.query_pool, 0);

        // 32 bits.
        device.cmd_copy_query_pool_results(
            cmd,
            *fixture.query_pool,
            0,
            1,
            result_buffer_32_bits.get(),
            0,
            size_of::<u32>() as vk::DeviceSize,
            vk::QueryResultFlags::WAIT,
        );
    }
    cmd_buffer_to_host_barrier(device, cmd, result_buffer_32_bits.get());

    // 64 bits.
    unsafe {
        device.cmd_copy_query_pool_results(
            cmd,
            *fixture.query_pool,
            0,
            1,
            result_buffer_64_bits.get(),
            0,
            size_of::<u64>() as vk::DeviceSize,
            vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
        )
    };
    cmd_buffer_to_host_barrier(device, cmd, result_buffer_64_bits.get());

    end_command_buffer(device, cmd)?;

    const MAX_DE_UINT32_VALUE: u64 = u32::MAX as u64;

    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    // Get results from buffers.
    invalidate_alloc(device, result_buffer_32_bits.get_allocation())?;
    invalidate_alloc(device, result_buffer_64_bits.get_allocation())?;
    let ts_buffer_32_bits = unsafe {
        result_buffer_32_bits
            .get_allocation()
            .get_host_ptr()
            .cast::<u32>()
            .read_unaligned()
    };
    let ts_buffer_64_bits = unsafe {
        result_buffer_64_bits
            .get_allocation()
            .get_host_ptr()
            .cast::<u64>()
            .read_unaligned()
    };

    // Get results with vkGetQueryPoolResults().
    let mut get_32_bytes = [0u8; 4];
    let mut get_64_bytes = [0u8; 8];
    unsafe {
        device
            .get_query_pool_results(
                *fixture.query_pool,
                0,
                1,
                &mut get_32_bytes,
                4,
                vk::QueryResultFlags::WAIT,
            )
            .vk_check("vkGetQueryPoolResults")?;
        device
            .get_query_pool_results(
                *fixture.query_pool,
                0,
                1,
                &mut get_64_bytes,
                8,
                vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
            )
            .vk_check("vkGetQueryPoolResults")?;
    }
    let ts_get_32_bits = u32::from_ne_bytes(get_32_bytes);
    let ts_get_64_bits = u64::from_ne_bytes(get_64_bytes);

    // Check timestamp mask for both 64-bit results.
    check_timestamp_bits(ts_buffer_64_bits, timestamp_mask)?;
    check_timestamp_bits(ts_get_64_bits, timestamp_mask)?;

    let mut maintenance7_features = vk::PhysicalDeviceMaintenance7FeaturesKHR::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut maintenance7_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    let has_maint7 = maintenance7_features.maintenance7 != vk::FALSE;

    // Check results are consistent.
    let consistent = ts_buffer_32_bits == ts_get_32_bits && ts_buffer_64_bits == ts_get_64_bits;
    let lower_bits_equal = (ts_get_64_bits & MAX_DE_UINT32_VALUE) == u64::from(ts_get_32_bits);
    if has_maint7 {
        // If maintenance7 is supported, 32 bit queries _must_ be equivalent to the lower 32 bits of the 64 bit query
        if consistent && lower_bits_equal {
            return Ok(TestStatus::pass("Pass"));
        }
    } else if consistent
        && (lower_bits_equal
            || (ts_get_64_bits > MAX_DE_UINT32_VALUE && MAX_DE_UINT32_VALUE == u64::from(ts_get_32_bits)))
    {
        return Ok(TestStatus::pass("Pass"));
    }

    Ok(TestStatus::fail(format!(
        "Results are inconsistent: B32=0x{ts_buffer_32_bits:x} B64=0x{ts_buffer_64_bits:x} G32=0x{ts_get_32_bits:x} G64=0x{ts_get_64_bits:x}"
    )))
}

/// `CheckTimestampComputeAndGraphicsTestInstance`
fn iterate_check_compute_and_graphics(context: &Context<'_>) -> TestOutcome {
    let gc_queue_flags = vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE;

    // When timestampComputeAndGraphics is true then all queues that advertise the VK_QUEUE_GRAPHICS_BIT or VK_QUEUE_COMPUTE_BIT in the
    // queueFlags support VkQueueFamilyProperties::timestampValidBits of at least 36.
    let queue_props = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };
    for qp in &queue_props {
        if qp.queue_flags.intersects(gc_queue_flags) && qp.timestamp_valid_bits < 36 {
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `TimestampPipelineStageTestInstance`
fn iterate_pipeline_stage(context: &Context<'_>, stage: Stage) -> TestOutcome {
    let device = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let timestamp_mask = get_timestamp_mask(context, queue_family_index)?;

    let query_pool = create_query_pool(device, 2)?;
    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_reset_query_pool(cmd, *query_pool, 0, 2);
        device.cmd_write_timestamp(cmd, Stage::ALL_COMMANDS, *query_pool, 0);
        device.cmd_pipeline_barrier(
            cmd,
            Stage::ALL_COMMANDS,
            Stage::ALL_COMMANDS,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
        device.cmd_write_timestamp(cmd, stage, *query_pool, 1);
    }
    end_command_buffer(device, cmd)?;

    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
    let mut data = [0u8; 16];
    unsafe {
        device.get_query_pool_results(
            *query_pool,
            0,
            2,
            &mut data,
            8,
            vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
        )
    }
    .vk_check("vkGetQueryPoolResults")?;
    let timestamp_values: Vec<u64> = bytes_to_u64s(&data)
        .into_iter()
        .map(|value| value & timestamp_mask)
        .collect();

    if timestamp_values[0] > timestamp_values[1] {
        return Ok(TestStatus::fail(format!(
            "Test stage timestamp ({}) is smaller than the preceding guard timestamp ({})",
            timestamp_values[1], timestamp_values[0]
        )));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `SequentialTimestampTestInstance`: a mix of render pass, compute and transfer operations, each followed by a timestamp.
fn iterate_sequential(context: &Context<'_>) -> TestOutcome {
    const OPERATION_COUNT: usize = 5;
    const RENDER_PASS: u32 = 0;
    const COMPUTE_DISPATCH: u32 = 1;
    const TRANSFER: u32 = 2;
    const OPERATION_TYPE_COUNT: u32 = 3;

    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let render_size = 64u32;

    let timestamp_mask = get_timestamp_mask(context, queue_family_index)?;
    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let query_pool = create_query_pool(device, OPERATION_COUNT as u32)?;

    let mut cmd_buffers = Vec::new();
    let mut fences = Vec::new();
    for _ in 0..OPERATION_COUNT {
        cmd_buffers.push(allocate_command_buffer(
            device,
            *cmd_pool,
            vk::CommandBufferLevel::PRIMARY,
        )?);
        fences.push(Unique::new(
            device,
            unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
        ));
    }

    // Determine operation sequence - mix of render pass, compute and transfer operations
    let mut rng = Random::new(0);
    let operations: Vec<u32> = (0..OPERATION_COUNT)
        .map(|_| rng.get_uint32() % OPERATION_TYPE_COUNT)
        .collect();

    // Create resources for render pass operations
    let color_image = create_image_2d(
        context,
        COLOR_FORMAT,
        render_size,
        render_size,
        vk::ImageUsageFlags::COLOR_ATTACHMENT,
        vk::SampleCountFlags::_1,
    )?;
    let color_attachment_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;

    // Create resources for compute operations
    let compute_buffer = create_host_visible_buffer(context, 1024, vk::BufferUsageFlags::STORAGE_BUFFER)?;

    // Create resources for transfer operations
    let buffer_size: vk::DeviceSize = 1024;
    let src_buffer = create_host_visible_buffer(context, buffer_size, vk::BufferUsageFlags::TRANSFER_SRC)?;

    // Initialize source buffer
    let src_data: Vec<u8> = (0..buffer_size as usize).map(|i| (i & 0xFF) as u8).collect();
    unsafe {
        std::ptr::copy_nonoverlapping(
            src_data.as_ptr(),
            src_buffer.get_allocation().get_host_ptr(),
            src_data.len(),
        )
    };
    flush_alloc(device, src_buffer.get_allocation())?;

    let dst_buffer = create_host_visible_buffer(context, buffer_size, vk::BufferUsageFlags::TRANSFER_DST)?;

    // setupRenderPass
    let color_attachment_description = vk::AttachmentDescription::builder()
        .format(COLOR_FORMAT)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();
    let color_attachment_descriptions = [color_attachment_description];
    let color_attachment_ref = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_attachment_ref)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&color_attachment_descriptions)
        .subpasses(&subpasses);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_attachment_view],
        render_size,
        render_size,
        1,
    )?;
    let graphics_pipeline_layout = make_pipeline_layout(device, &[])?;

    let binaries = context.get_binary_collection();
    let vertex_shader_module = create_shader_module(device, binaries.get("vert")?)?;
    let fragment_shader_module = create_shader_module(device, binaries.get("frag")?)?;
    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(render_size, render_size);
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0)
        .build();
    let graphics_pipeline = create_draw_pipeline(
        device,
        *graphics_pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
        ],
        &state,
    )?;

    // setupComputePipeline
    let compute_descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let compute_pipeline_layout = make_pipeline_layout(device, &[*compute_descriptor_set_layout])?;
    let compute_shader_module = create_shader_module(device, binaries.get("comp")?)?;
    let shader_stage_info = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*compute_shader_module)
        .name(b"main\0")
        .build();
    let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(shader_stage_info)
        .layout(*compute_pipeline_layout)
        .base_pipeline_index(0)
        .build();
    let compute_pipelines =
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
    let compute_pipeline = Unique::new(device, compute_pipelines.0[0]);

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *compute_descriptor_set_layout)?;
    let buffer_info = [vk::DescriptorBufferInfo::builder()
        .buffer(compute_buffer.get())
        .offset(0)
        .range(vk::WHOLE_SIZE)
        .build()];
    let descriptor_write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&buffer_info)
        .build();
    unsafe { device.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };

    // Execute operations sequentially, with timestamps after each
    let mut timestamp_values = [0u64; OPERATION_COUNT];
    for i in 0..OPERATION_COUNT {
        // performOperationAndTimestamp
        let cmd = *cmd_buffers[i];
        begin_command_buffer(device, cmd)?;

        unsafe { device.cmd_reset_query_pool(cmd, *query_pool, i as u32, 1) };

        match operations[i] {
            RENDER_PASS => {
                // Transition the image to the correct layout
                let image_barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_image.get(),
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        Stage::TOP_OF_PIPE,
                        Stage::COLOR_ATTACHMENT_OUTPUT,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[image_barrier],
                    );
                }

                let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffer)
                    .render_area(rect_2d(render_size, render_size))
                    .clear_values(&clear_values);
                unsafe {
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline.get());
                    device.cmd_draw(cmd, 3, 1, 0, 0);
                    device.cmd_end_render_pass(cmd);
                }
            }
            COMPUTE_DISPATCH => {
                unsafe {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, compute_pipeline.get());
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::COMPUTE,
                        *compute_pipeline_layout,
                        0,
                        &[descriptor_set.get()],
                        &[] as &[u32],
                    );
                    device.cmd_dispatch(cmd, 16, 1, 1);
                }

                let memory_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::SHADER_READ);
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        Stage::COMPUTE_SHADER,
                        Stage::COMPUTE_SHADER,
                        vk::DependencyFlags::empty(),
                        &[memory_barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }
            TRANSFER => {
                let copy_region = vk::BufferCopy {
                    src_offset: 0,
                    dst_offset: 0,
                    size: 1024,
                };
                unsafe { device.cmd_copy_buffer(cmd, src_buffer.get(), dst_buffer.get(), &[copy_region]) };

                let buffer_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    dst_buffer.get(),
                    0,
                    vk::WHOLE_SIZE,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        Stage::TRANSFER,
                        Stage::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[buffer_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }
            _ => unreachable!("operation types are drawn modulo OPERATION_TYPE_COUNT"),
        }

        unsafe { device.cmd_write_timestamp(cmd, Stage::BOTTOM_OF_PIPE, *query_pool, i as u32) };

        end_command_buffer(device, cmd)?;

        let cmd_buffer_handles = [cmd];
        let submit_info = vk::SubmitInfo::builder().command_buffers(&cmd_buffer_handles);

        unsafe { device.queue_submit(queue, &[submit_info], *fences[i]) }.vk_check("vkQueueSubmit")?;
        unsafe { device.wait_for_fences(&[*fences[i]], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        unsafe { device.reset_fences(&[*fences[i]]) }.vk_check("vkResetFences")?;

        let mut value_bytes = [0u8; 8];
        unsafe {
            device.get_query_pool_results(
                *query_pool,
                i as u32,
                1,
                &mut value_bytes,
                8,
                vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
            )
        }
        .vk_check("vkGetQueryPoolResults")?;
        timestamp_values[i] = u64::from_ne_bytes(value_bytes) & timestamp_mask;
    }

    // Verify timestamps are monotonically increasing
    for i in 1..OPERATION_COUNT {
        if timestamp_values[i] <= timestamp_values[i - 1] {
            return Ok(TestStatus::fail(format!(
                "Timestamp {i} (0x{:x}) is not greater than timestamp {} (0x{:x})",
                timestamp_values[i],
                i - 1,
                timestamp_values[i - 1]
            )));
        }
    }

    Ok(TestStatus::pass("All timestamps are monotonically increasing"))
}

fn add_param_case(group: &mut TestCaseGroup, name: String, param: &Param, kind: Kind) {
    group.add_child(Box::new(TimestampCase {
        name,
        param: param.clone(),
        kind,
    }) as Box<dyn TestCase>);
}

fn add_misc_case(group: &mut TestCaseGroup, name: &str, kind: MiscKind) {
    group.add_child(Box::new(MiscCase {
        name: name.to_string(),
        kind,
    }) as Box<dyn TestCase>);
}

/// `createTimestampTests`
pub fn create_timestamp_tests() -> TestCaseGroup {
    create_timestamp_tests_for(false)
}

/// The shader object types have the basic and advanced graphics groups only.
pub fn create_timestamp_tests_for(shader_object: bool) -> TestCaseGroup {
    let mut timestamp_tests = TestCaseGroup::new("timestamp");
    let result_flags = vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT;
    let query_result_flags_timestamp_test = [result_flags, result_flags | vk::QueryResultFlags::WITH_AVAILABILITY];

    // The four variants every graphics case comes in: in and out of the render pass, with and without host query reset.
    let add_graphics_variants =
        |group: &mut TestCaseGroup, stages: &[Stage], flags: vk::QueryResultFlags, kind: Kind| {
            let mut param = Param::new(stages, true, false, false, flags);
            add_param_case(group, param.generate_test_name(), &param, kind);
            param.in_render_pass = !param.in_render_pass;
            add_param_case(group, param.generate_test_name(), &param, kind);
            // Host Query reset tests
            param.host_query_reset = !param.host_query_reset;
            add_param_case(group, param.generate_test_name(), &param, kind);
            param.in_render_pass = !param.in_render_pass;
            add_param_case(group, param.generate_test_name(), &param, kind);
        };

    // Basic Graphics Tests
    {
        let mut basic_graphics_tests = TestCaseGroup::new("basic_graphics_tests");

        let basic_graphics_stages0 = [
            [Stage::TOP_OF_PIPE, Stage::VERTEX_INPUT],
            [Stage::TOP_OF_PIPE, Stage::VERTEX_SHADER],
            [Stage::TOP_OF_PIPE, Stage::FRAGMENT_SHADER],
            [Stage::TOP_OF_PIPE, Stage::EARLY_FRAGMENT_TESTS],
            [Stage::TOP_OF_PIPE, Stage::LATE_FRAGMENT_TESTS],
            [Stage::TOP_OF_PIPE, Stage::COLOR_ATTACHMENT_OUTPUT],
            [Stage::TOP_OF_PIPE, Stage::ALL_GRAPHICS],
            [Stage::TOP_OF_PIPE, Stage::ALL_COMMANDS],
        ];
        for stages in &basic_graphics_stages0 {
            for flags in query_result_flags_timestamp_test {
                add_graphics_variants(&mut basic_graphics_tests, stages, flags, Kind::BasicGraphics);
            }
        }

        let basic_graphics_stages1 = [
            [Stage::VERTEX_SHADER, Stage::FRAGMENT_SHADER, Stage::LATE_FRAGMENT_TESTS],
            [
                Stage::VERTEX_INPUT,
                Stage::EARLY_FRAGMENT_TESTS,
                Stage::COLOR_ATTACHMENT_OUTPUT,
            ],
        ];
        for stages in &basic_graphics_stages1 {
            for flags in query_result_flags_timestamp_test {
                add_graphics_variants(&mut basic_graphics_tests, stages, flags, Kind::BasicGraphics);
            }
        }

        timestamp_tests.add_child(basic_graphics_tests);
    }

    // Advanced Graphics Tests
    {
        // Record timestamp in different pipeline stages of advanced graphics tests
        let mut adv_graphics_tests = TestCaseGroup::new("advanced_graphics_tests");

        let adv_graphics_stages = [
            [Stage::TOP_OF_PIPE, Stage::DRAW_INDIRECT],
            [Stage::TOP_OF_PIPE, Stage::TESSELLATION_CONTROL_SHADER],
            [Stage::TOP_OF_PIPE, Stage::TESSELLATION_EVALUATION_SHADER],
            [Stage::TOP_OF_PIPE, Stage::GEOMETRY_SHADER],
        ];
        for stages in &adv_graphics_stages {
            for flags in query_result_flags_timestamp_test {
                add_graphics_variants(&mut adv_graphics_tests, stages, flags, Kind::AdvGraphics);
            }
        }

        timestamp_tests.add_child(adv_graphics_tests);
    }

    if shader_object {
        return timestamp_tests;
    }

    // Basic Compute Tests
    {
        // Record timestamp for compute stages
        let mut basic_compute_tests = TestCaseGroup::new("basic_compute_tests");

        let basic_compute_stages = [
            [Stage::TOP_OF_PIPE, Stage::COMPUTE_SHADER],
            [Stage::TOP_OF_PIPE, Stage::ALL_COMMANDS],
        ];
        for stages in &basic_compute_stages {
            for flags in query_result_flags_timestamp_test {
                let mut param = Param::new(stages, false, false, false, flags);
                add_param_case(
                    &mut basic_compute_tests,
                    param.generate_test_name(),
                    &param,
                    Kind::BasicCompute,
                );
                // Host Query reset test
                param.host_query_reset = !param.host_query_reset;
                add_param_case(
                    &mut basic_compute_tests,
                    param.generate_test_name(),
                    &param,
                    Kind::BasicCompute,
                );
            }
        }

        timestamp_tests.add_child(basic_compute_tests);
    }

    // Transfer Tests
    {
        let mut transfer_tests = TestCaseGroup::new("transfer_tests");

        let transfer_stages = [[Stage::TOP_OF_PIPE, Stage::TRANSFER], [Stage::TOP_OF_PIPE, Stage::HOST]];

        for transfer_only_queue in [false, true] {
            for stages in &transfer_stages {
                for method in TRANSFER_METHODS {
                    if transfer_only_queue && method.needs_graphics_or_compute_queue() {
                        // skip tests that use commands not supported on transfer only queue
                        continue;
                    }

                    for flags in query_result_flags_timestamp_test {
                        let mut param = Param::new(stages, false, false, transfer_only_queue, flags);

                        // execute tests that use cmdResetQueryPool only on default device
                        if !transfer_only_queue {
                            add_param_case(
                                &mut transfer_tests,
                                param.generate_transfer_test_name(method),
                                &param,
                                Kind::Transfer(method),
                            );
                        }

                        // Host Query reset test
                        param.host_query_reset = !param.host_query_reset;
                        add_param_case(
                            &mut transfer_tests,
                            param.generate_transfer_test_name(method),
                            &param,
                            Kind::Transfer(method),
                        );
                    }
                }
            }
        }

        timestamp_tests.add_child(transfer_tests);
    }

    // Calibrated Timestamp Tests
    timestamp_tests.add_child(create_calibrated_timestamp_tests());

    // Misc Tests
    {
        let query_result_flags_misc_tests = [
            vk::QueryResultFlags::WAIT,
            vk::QueryResultFlags::WAIT | vk::QueryResultFlags::WITH_AVAILABILITY,
        ];
        let query_results_flags_misc_tests_str = ["", "_with_availability_bit"];

        let mut misc_tests = TestCaseGroup::new("misc_tests");

        for flags_idx in 0..query_result_flags_misc_tests.len() {
            let misc_stages = [Stage::TOP_OF_PIPE];
            let suffix = query_results_flags_misc_tests_str[flags_idx];
            let misc_flags = query_result_flags_misc_tests[flags_idx];

            let mut param = Param::new(
                &misc_stages,
                false,
                false,
                false,
                query_result_flags_timestamp_test[flags_idx],
            );
            // Only write timestamp command in the commmand buffer
            add_param_case(
                &mut misc_tests,
                format!("timestamp_only{suffix}"),
                &param,
                Kind::TimestampOnly,
            );

            // Issue query in a command buffer and copy it on another primary command buffer
            let two_cmd_buffers_param_primary = Param::new(&misc_stages, false, false, false, misc_flags);
            add_param_case(
                &mut misc_tests,
                format!("two_cmd_buffers_primary{suffix}"),
                &two_cmd_buffers_param_primary,
                Kind::TwoCmdBuffers(vk::CommandBufferLevel::PRIMARY),
            );

            // Issue query in a secondary command buffer and copy it on a primary command buffer
            let two_cmd_buffers_param_secondary = Param::new(&misc_stages, false, false, false, misc_flags);
            add_param_case(
                &mut misc_tests,
                format!("two_cmd_buffers_secondary{suffix}"),
                &two_cmd_buffers_param_secondary,
                Kind::TwoCmdBuffers(vk::CommandBufferLevel::SECONDARY),
            );

            // Misc: Host Query Reset tests
            param.host_query_reset = !param.host_query_reset;
            // Only write timestamp command in the commmand buffer
            add_param_case(
                &mut misc_tests,
                format!("timestamp_only_host_query_reset{suffix}"),
                &param,
                Kind::TimestampOnly,
            );

            // Issue query in a command buffer and copy it on another primary command buffer
            let two_cmd_buffers_param_primary_host_query_reset =
                Param::new(&misc_stages, false, true, false, misc_flags);
            add_param_case(
                &mut misc_tests,
                format!("two_cmd_buffers_primary_host_query_reset{suffix}"),
                &two_cmd_buffers_param_primary_host_query_reset,
                Kind::TwoCmdBuffers(vk::CommandBufferLevel::PRIMARY),
            );

            // Issue query in a secondary command buffer and copy it on a primary command buffer
            let two_cmd_buffers_param_secondary_host_query_reset =
                Param::new(&misc_stages, false, true, false, misc_flags);
            add_param_case(
                &mut misc_tests,
                format!("two_cmd_buffers_secondary_host_query_reset{suffix}"),
                &two_cmd_buffers_param_secondary_host_query_reset,
                Kind::TwoCmdBuffers(vk::CommandBufferLevel::SECONDARY),
            );

            let two_cmd_buffers_param_secondary_transfer_queue =
                Param::new(&misc_stages, false, true, true, misc_flags);
            add_param_case(
                &mut misc_tests,
                format!("two_cmd_buffers_secondary_transfer_queue{suffix}"),
                &two_cmd_buffers_param_secondary_transfer_queue,
                Kind::TwoCmdBuffers(vk::CommandBufferLevel::SECONDARY),
            );
        }

        // Reset timestamp query before copying results.
        add_misc_case(
            &mut misc_tests,
            "reset_query_before_copy",
            MiscKind::ResetQueryBeforeCopy,
        );

        // Fill buffer with 0s before copying results.
        add_misc_case(
            &mut misc_tests,
            "fill_buffer_before_copy",
            MiscKind::FillBufferBeforeCopy,
        );

        // Check consistency between 32 and 64 bits.
        add_misc_case(&mut misc_tests, "consistent_results", MiscKind::ConsistentResults);

        // Check if timestamps are supported by every queue family that supports either graphics or compute operations
        add_misc_case(
            &mut misc_tests,
            "check_timestamp_compute_and_graphics",
            MiscKind::CheckComputeAndGraphics,
        );
        add_misc_case(&mut misc_tests, "sequential_timestamps", MiscKind::Sequential);

        let pipeline_stages = [
            Stage::TOP_OF_PIPE,
            Stage::DRAW_INDIRECT,
            Stage::VERTEX_INPUT,
            Stage::VERTEX_SHADER,
            Stage::TESSELLATION_CONTROL_SHADER,
            Stage::TESSELLATION_EVALUATION_SHADER,
            Stage::GEOMETRY_SHADER,
            Stage::FRAGMENT_SHADER,
            Stage::EARLY_FRAGMENT_TESTS,
            Stage::LATE_FRAGMENT_TESTS,
            Stage::COLOR_ATTACHMENT_OUTPUT,
            Stage::COMPUTE_SHADER,
            Stage::TRANSFER,
            Stage::HOST,
            Stage::ALL_GRAPHICS,
            Stage::ALL_COMMANDS,
        ];
        for stage in pipeline_stages {
            add_misc_case(
                &mut misc_tests,
                &format!("timestamp_stage_{}", pipeline_stage_name(stage)),
                MiscKind::PipelineStage(stage),
            );
        }

        timestamp_tests.add_child(misc_tests);
    }

    timestamp_tests
}
