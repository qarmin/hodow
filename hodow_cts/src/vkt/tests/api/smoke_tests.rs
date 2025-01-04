// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiSmokeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported: create_sampler, create_shader, compute, transfer, and the four triangle cases (triangle, asm_triangle,
// asm_triangle_no_opname, unused_resolve_attachment) in `smoke_triangle_tests.rs`.
//
// The shaders are in `shaders/manifest/api_smoke.toml`.

use vulkanalia::prelude::v1_0::*;

use super::case_util::{add_case, add_function_case_no_support};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set,
};
// Re-exported so the generated shader module, which imports this module wholesale,
// can name the types its manifest entries are declared with.
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the `compute` manifest entry.
pub struct SmokeComputeProgram {
    pub name: &'static str,
    pub local_size: u32,
    pub programs: BinaryCollection,
}

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `createSamplerTest`
fn create_sampler_test(context: &Context<'_>) -> TestOutcome {
    let vk_device = context.get_device();

    {
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::ALWAYS)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);

        let _sampler = Unique::new(
            vk_device,
            unsafe { vk_device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
    }

    Ok(TestStatus::pass("Creating sampler succeeded"))
}

/// `createShaderModuleTest`
fn create_shader_module_test(context: &Context<'_>) -> TestOutcome {
    let _shader = create_shader_module(context.get_device(), context.get_binary_collection().get("test")?)?;

    Ok(TestStatus::pass("Creating shader module succeeded"))
}

/// `NonGraphicsSmokeConfig`
#[derive(Clone, Copy)]
struct NonGraphicsSmokeConfig {
    /// produce the data with a copy instead of a dispatch
    transfer_work: bool,
}

const NON_GRAPHICS_SMOKE_IMAGE_SIZE: u32 = 32;
const NON_GRAPHICS_SMOKE_VALUE_COUNT: u32 = NON_GRAPHICS_SMOKE_IMAGE_SIZE * NON_GRAPHICS_SMOKE_IMAGE_SIZE;

/// Copies are whole subresource at offset (0,0,0), so minImageTransferGranularity holds on every family.
fn non_graphics_smoke_test(
    context: &Context<'_>,
    queue: vk::Queue,
    family_index: u32,
    config: NonGraphicsSmokeConfig,
) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let buffer_size = (NON_GRAPHICS_SMOKE_VALUE_COUNT as usize * std::mem::size_of::<u32>()) as vk::DeviceSize;

    let expected: Vec<u32> = (0..NON_GRAPHICS_SMOKE_VALUE_COUNT).map(|ndx| ndx + 1).collect();

    let work_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(
            buffer_size,
            vk::BufferUsageFlags::STORAGE_BUFFER
                | vk::BufferUsageFlags::TRANSFER_DST
                | vk::BufferUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::ANY,
    )?;
    let result_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let image_params = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(vk::Format::R8G8B8A8_UNORM)
        .extent(vk::Extent3D {
            width: NON_GRAPHICS_SMOKE_IMAGE_SIZE,
            height: NON_GRAPHICS_SMOKE_IMAGE_SIZE,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let image = ImageWithMemory::new(vk, allocator, image_params, MemoryRequirement::ANY)?;

    // compute flavour only, but must outlive the command buffer
    // Field order is drop order: the pipeline goes first and the set layout last, with the set freed before its pool.
    let mut compute_resources: Option<(
        ComputePipelineWrapper<'_>,
        crate::vk::UniqueDescriptorSet<'_>,
        Unique<'_, vk::DescriptorPool>,
        Unique<'_, vk::DescriptorSetLayout>,
    )> = None;

    if !config.transfer_work {
        use crate::generated::shaders::api_smoke::SMOKE_COMPUTE;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *set_layout)?;
        let buffer_description = make_descriptor_buffer_info(work_buffer.get(), 0, buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer_description,
            )
            .update(vk);

        let mut pipeline = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            SMOKE_COMPUTE.programs.get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*set_layout);
        pipeline.build_pipeline()?;

        compute_resources = Some((pipeline, descriptor_set, descriptor_pool, set_layout));
    }

    let cmd_pool = make_command_pool(vk, family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    begin_command_buffer(vk, *cmd_buffer)?;

    if config.transfer_work {
        let data: Vec<u8> = expected.iter().flat_map(|v| v.to_ne_bytes()).collect();
        unsafe { vk.cmd_update_buffer(*cmd_buffer, work_buffer.get(), 0, &data) };
    } else if let Some((pipeline, descriptor_set, _, _)) = &compute_resources {
        use crate::generated::shaders::api_smoke::SMOKE_COMPUTE;

        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                pipeline.get_pipeline_layout(),
                0,
                &[descriptor_set.get()],
                &[],
            );
            vk.cmd_dispatch(
                *cmd_buffer,
                NON_GRAPHICS_SMOKE_VALUE_COUNT / SMOKE_COMPUTE.local_size,
                1,
                1,
            );
        }
    }

    let work_stage = if config.transfer_work {
        vk::PipelineStageFlags::TRANSFER
    } else {
        vk::PipelineStageFlags::COMPUTE_SHADER
    };
    let work_access = if config.transfer_work {
        vk::AccessFlags::TRANSFER_WRITE
    } else {
        vk::AccessFlags::SHADER_WRITE
    };
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: NON_GRAPHICS_SMOKE_IMAGE_SIZE,
            height: NON_GRAPHICS_SMOKE_IMAGE_SIZE,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );

    // work buffer -> image
    {
        let buffer_barrier = make_buffer_memory_barrier(
            work_access,
            vk::AccessFlags::TRANSFER_READ,
            work_buffer.get(),
            0,
            buffer_size,
        );
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image.get(),
            subresource_range,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                work_stage,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[image_barrier],
            );
            vk.cmd_copy_buffer_to_image(
                *cmd_buffer,
                work_buffer.get(),
                image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[copy_region],
            );
        }
    }

    // image -> result buffer
    {
        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image.get(),
            subresource_range,
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
            vk.cmd_copy_image_to_buffer(
                *cmd_buffer,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                result_buffer.get(),
                &[copy_region],
            );
        }

        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            result_buffer.get(),
            0,
            buffer_size,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }

    end_command_buffer(vk, *cmd_buffer)?;
    submit_commands_and_wait(vk, queue, *cmd_buffer)?;
    invalidate_alloc(vk, result_buffer.get_allocation())?;

    let result = unsafe {
        std::slice::from_raw_parts(
            result_buffer.get_allocation().get_host_ptr().cast::<u32>(),
            NON_GRAPHICS_SMOKE_VALUE_COUNT as usize,
        )
    };
    for (ndx, (&got, &want)) in result.iter().zip(expected.iter()).enumerate() {
        if got != want {
            log::info!("Unexpected value at index {ndx}, got {got}, expected {want}");
            return Ok(TestStatus::fail("Unexpected value in the result buffer"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `MultiQueueRunnerTestInstance` for a default context: the universal queue, plus the
/// compute-only one, plus (for transfer work) the transfer-only one.
fn smoke_queues(context: &Context<'_>, include_transfer_only: bool) -> Vec<(vk::Queue, u32)> {
    let mut queues = vec![(
        context.get_universal_queue(),
        context.get_universal_queue_family_index(),
    )];
    if let Some((queue, family)) = context.get_compute_queue()
        && family != context.get_universal_queue_family_index()
    {
        queues.push((queue, family));
    }
    if include_transfer_only
        && let Some((queue, family)) = context.get_transfer_queue()
        && family != context.get_universal_queue_family_index()
        && Some(family) != context.get_compute_queue().map(|(_, f)| f)
    {
        queues.push((queue, family));
    }
    queues
}

/// `MultiQueueRunnerTestInstance::iterate`
fn run_on_queues(context: &Context<'_>, config: NonGraphicsSmokeConfig) -> TestOutcome {
    let queues = smoke_queues(context, config.transfer_work);

    if queues.len() == 1 {
        return non_graphics_smoke_test(context, queues[0].0, queues[0].1, config);
    }

    let mut result_collector = ResultCollector::new("");

    for (queue, family_index) in queues {
        match non_graphics_smoke_test(context, queue, family_index, config) {
            Ok(result) => {
                if result.is_fail() {
                    result_collector.add_result(
                        result.code(),
                        format!(
                            "Test failed on queue family {family_index} with description: {}\n",
                            result.description()
                        ),
                    );
                }
            }
            Err(e) => {
                let status = e.to_status();
                result_collector.add_result(
                    status.code(),
                    format!(
                        "Test exception ({}) thrown on queue family {family_index} with description: {}",
                        status.code().as_str(),
                        status.description()
                    ),
                );
            }
        }
    }

    Ok(result_collector.to_status())
}

struct NonGraphicsSmokeCase {
    name: &'static str,
    config: NonGraphicsSmokeConfig,
}

impl TestCase for NonGraphicsSmokeCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        // nothing optional is used
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.config.transfer_work {
            NO_PROGRAMS
        } else {
            crate::generated::shaders::api_smoke::SMOKE_COMPUTE.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NonGraphicsSmokeInstance {
            context,
            config: self.config,
        })
    }
}

struct NonGraphicsSmokeInstance<'a> {
    context: &'a Context<'a>,
    config: NonGraphicsSmokeConfig,
}

impl TestInstance for NonGraphicsSmokeInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_on_queues(self.context, self.config)
    }
}

/// The `create_shader` case: its program collection is the manifest's.
struct CreateShaderCase;

impl TestCase for CreateShaderCase {
    fn name(&self) -> &str {
        "create_shader"
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::api_smoke::SMOKE_CREATE_SHADER.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CreateShaderInstance { context })
    }
}

struct CreateShaderInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for CreateShaderInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        create_shader_module_test(self.context)
    }
}

/// The ported part of `createSmokeTests`.
pub fn create_smoke_tests() -> TestCaseGroup {
    let mut smoke_tests = TestCaseGroup::new("smoke");

    add_function_case_no_support(&mut smoke_tests, "create_sampler", create_sampler_test);
    add_case(&mut smoke_tests, CreateShaderCase);
    super::smoke_triangle_tests::add_smoke_triangle_tests(&mut smoke_tests);

    add_case(
        &mut smoke_tests,
        NonGraphicsSmokeCase {
            name: "compute",
            config: NonGraphicsSmokeConfig { transfer_work: false },
        },
    );
    add_case(
        &mut smoke_tests,
        NonGraphicsSmokeCase {
            name: "transfer",
            config: NonGraphicsSmokeConfig { transfer_work: true },
        },
    );

    smoke_tests
}
