// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/depth/{bias_fs_clamp,bias_outside_range,bias_outside_range_fs_clamp,bias_outside_range_fs_clamp_unrestricted,
//   ez_fs_clamp,fs_clamp,out_of_range,out_of_range_unrestricted}.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What an Amber graphics pipeline does for these scripts is done directly: a 60x60 R8G8B8A8_UNORM
// colour attachment cleared to zero and a D32_SFLOAT depth attachment cleared to 1.0, one draw of two triangles over the whole of clip space with the
// state each script names (depth test and write with the compare op, depth clamp, constant depth bias, the viewport's depth range), and the
// expectations of the script on the colour (green everywhere), on the first texel of the depth attachment and on the float the fragment
// shader stored in a storage buffer. The shaders are in `shaders/manifest/depth_amber.toml`. A script's `DEVICE_FEATURE`s and
// `DEVICE_EXTENSION` are what `check_support` asks for.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::depth_amber::*;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE: u32 = 60;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D32_SFLOAT;
/// The tolerance of an `EXPECT ... EQ` without one: Amber compares floats within this.
const DEFAULT_TOLERANCE: f32 = 1.0e-5;

/// What a script asks of the device and expects of the result.
#[derive(Clone, Copy)]
struct Params {
    /// `DEVICE_FEATURE depthClamp`
    needs_depth_clamp: bool,
    /// `DEVICE_EXTENSION VK_EXT_depth_range_unrestricted`
    needs_unrestricted: bool,
    /// The fragment shader stores gl_FragCoord.z in a storage buffer, which `fragmentStoresAndAtomics` allows.
    stores_depth: bool,
    depth_clamp: bool,
    /// `BIAS constant <factor> clamp 0.0 slope 0.0`
    bias: Option<f32>,
    min_depth: f32,
    max_depth: f32,
    compare_op: vk::CompareOp,
    /// `EXPECT depth0 IDX 0 [TOLERANCE t] EQ <value>`
    expected_depth: f32,
    depth_tolerance: f32,
    /// `EXPECT fs_depth IDX 0 TOLERANCE t EQ <value>`
    expected_stored: Option<(f32, f32)>,
}

const STORED_TOLERANCE: f32 = 1.0e-6;

struct DepthCase {
    name: &'static str,
    params: Params,
    programs: &'static SharedProgram,
}

impl TestCase for DepthCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !context.is_device_functionality_supported("VK_EXT_depth_clamp_zero_one")
            && !context.is_device_functionality_supported("VK_KHR_depth_clamp_zero_one")
        {
            return Err(TestError::NotSupported(
                "VK_EXT_depth_clamp_zero_one is not supported".to_string(),
            ));
        }

        let mut zero_one = vk::PhysicalDeviceDepthClampZeroOneFeaturesKHR::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut zero_one);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if zero_one.depth_clamp_zero_one == vk::FALSE {
            return Err(TestError::NotSupported(
                "DepthClampZeroOneFeatures.depthClampZeroOne not supported".to_string(),
            ));
        }

        let features = context.get_device_features();
        if self.params.needs_depth_clamp && features.depth_clamp == vk::FALSE {
            return Err(TestError::NotSupported("Features.depthClamp not supported".to_string()));
        }
        if self.params.stores_depth && features.fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Features.fragmentStoresAndAtomics not supported".to_string(),
            ));
        }
        if self.params.needs_unrestricted {
            context.require_device_functionality("VK_EXT_depth_range_unrestricted")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthInstance {
            context,
            params: self.params,
        })
    }
}

struct DepthInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for DepthInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let extent = vk::Extent3D {
            width: SIZE,
            height: SIZE,
            depth: 1,
        };

        let image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };
        let color = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let depth = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                DEPTH_FORMAT,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let depth_range = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let depth_view = make_image_view(device, depth.get(), vk::ImageViewType::_2D, DEPTH_FORMAT, depth_range)?;

        let attachments = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(DEPTH_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .build(),
        ];
        let color_reference = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_reference = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_reference)
            .depth_stencil_attachment(&depth_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view, *depth_view], SIZE, SIZE, 1)?;

        // The storage buffer the fragment shader stores its depth in, as `BIND BUFFER fs_depth AS storage DESCRIPTOR_SET 0 BINDING 0`.
        let stored_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(4, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                0.0f32.to_ne_bytes().as_ptr(),
                stored_buffer.get_allocation().get_host_ptr(),
                4,
            )
        };
        flush_alloc(device, stored_buffer.get_allocation())?;

        let descriptor_set_layout = if params.stores_depth {
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
                .build(device)?
        } else {
            DescriptorSetLayoutBuilder::new().build(device)?
        };
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        if params.stores_depth {
            let info = make_descriptor_buffer_info(stored_buffer.get(), 0, 4);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    *descriptor_set,
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &info,
                )
                .update(device);
        }

        // The pipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let entry = c"main";
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vertex_module)
                .name(entry.to_bytes_with_nul())
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fragment_module)
                .name(entry.to_bytes_with_nul())
                .build(),
        ];
        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 8,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: SIZE as f32,
            height: SIZE as f32,
            min_depth: params.min_depth,
            max_depth: params.max_depth,
        }];
        let scissors = [make_rect_2d(0, 0, SIZE, SIZE)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(params.depth_clamp)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(params.bias.is_some())
            .depth_bias_constant_factor(params.bias.unwrap_or(0.0))
            .depth_bias_clamp(0.0)
            .depth_bias_slope_factor(0.0)
            .line_width(1.0);
        let multisample =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(params.compare_op)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        // `DRAW_RECT POS 0 0 SIZE 60 60`: two triangles over the whole of clip space.
        let positions: [[f32; 2]; 6] = [
            [-1.0, -1.0],
            [1.0, -1.0],
            [-1.0, 1.0],
            [-1.0, 1.0],
            [1.0, -1.0],
            [1.0, 1.0],
        ];
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                std::mem::size_of_val(&positions) as u64,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                positions.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&positions),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let depth_result = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(u64::from(SIZE * SIZE) * 4, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;

        // CLEAR_COLOR pipeline 0 0 0 0 / CLEAR_DEPTH pipeline 1.0 are the attachments' clear values.
        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 0.0],
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, SIZE, SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            if params.stores_depth {
                device.cmd_bind_descriptor_sets(
                    *cmd_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[],
                );
            }
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*cmd_buffer, 6, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);

            // The depth attachment goes to a buffer for the host to read, its final layout being the transfer source one.
            let to_transfer_read = make_image_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                depth.get(),
                depth_range,
            );
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer_read],
            );
            let copy = make_buffer_image_copy(
                extent,
                make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
            );
            device.cmd_copy_image_to_buffer(
                *cmd_buffer,
                depth.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                depth_result.get(),
                &[copy],
            );
            let to_host_read = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                depth_result.get(),
                0,
                vk::WHOLE_SIZE,
            );
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[to_host_read],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

        // EXPECT framebuffer0 IDX 0 0 SIZE 60 60 EQ_RGBA 0 255 0 255
        let result = read_color_attachment(
            context,
            color.get(),
            COLOR_FORMAT,
            (SIZE, SIZE),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let pixels = result.get_const_access();
        for y in 0..SIZE {
            for x in 0..SIZE {
                let pixel = pixels.get_pixel(x, y, 0);
                if pixel != [0.0, 1.0, 0.0, 1.0] {
                    return Ok(TestStatus::fail(format!(
                        "Unexpected colour {pixel:?} at ({x}, {y}), expected (0, 255, 0, 255)"
                    )));
                }
            }
        }

        // EXPECT depth0 IDX 0 EQ <value>
        invalidate_alloc(device, depth_result.get_allocation())?;
        let depth_value = f32::from_ne_bytes(
            unsafe { std::slice::from_raw_parts(depth_result.get_allocation().get_host_ptr().cast_const(), 4) }
                .try_into()
                .expect("four bytes"),
        );
        if (depth_value - params.expected_depth).abs() > params.depth_tolerance {
            return Ok(TestStatus::fail(format!(
                "Depth attachment holds {depth_value}, expected {} (tolerance {})",
                params.expected_depth, params.depth_tolerance
            )));
        }

        // EXPECT fs_depth IDX 0 TOLERANCE t EQ <value>
        if let Some((expected, tolerance)) = params.expected_stored {
            invalidate_alloc(device, stored_buffer.get_allocation())?;
            let stored = f32::from_ne_bytes(
                unsafe { std::slice::from_raw_parts(stored_buffer.get_allocation().get_host_ptr().cast_const(), 4) }
                    .try_into()
                    .expect("four bytes"),
            );
            if (stored - expected).abs() > tolerance {
                return Ok(TestStatus::fail(format!(
                    "The fragment shader saw gl_FragCoord.z = {stored}, expected {expected} (tolerance {tolerance})"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createAmberDepthGroup`: the eight scripts of `data/vulkan/amber/depth`.
pub fn create_depth_clamp_tests() -> TestCaseGroup {
    let base = Params {
        needs_depth_clamp: false,
        needs_unrestricted: false,
        stores_depth: true,
        depth_clamp: false,
        bias: None,
        min_depth: 0.1,
        max_depth: 0.9,
        compare_op: vk::CompareOp::ALWAYS,
        expected_depth: 0.9,
        depth_tolerance: DEFAULT_TOLERANCE,
        expected_stored: Some((1.7, STORED_TOLERANCE)),
    };

    let cases: [(&'static str, Params, &'static SharedProgram); 8] = [
        (
            "bias_fs_clamp",
            Params {
                needs_depth_clamp: true,
                depth_clamp: true,
                bias: Some(1.0),
                ..base
            },
            &DEPTH_BIAS_FS_CLAMP,
        ),
        (
            "bias_outside_range",
            Params {
                bias: Some(2097152.0),
                max_depth: 0.5,
                expected_depth: 0.625,
                expected_stored: Some((0.625, STORED_TOLERANCE)),
                ..base
            },
            &DEPTH_BIAS_OUTSIDE_RANGE,
        ),
        (
            "bias_outside_range_fs_clamp",
            Params {
                bias: Some(16777216.0),
                expected_depth: 1.0,
                expected_stored: Some((1.9, STORED_TOLERANCE)),
                ..base
            },
            &DEPTH_BIAS_OUTSIDE_RANGE_FS_CLAMP,
        ),
        (
            "bias_outside_range_fs_clamp_unrestricted",
            Params {
                needs_unrestricted: true,
                bias: Some(16777216.0),
                expected_depth: 1.9,
                depth_tolerance: STORED_TOLERANCE,
                expected_stored: Some((1.9, STORED_TOLERANCE)),
                ..base
            },
            &DEPTH_BIAS_OUTSIDE_RANGE_FS_CLAMP_UNRESTRICTED,
        ),
        (
            "ez_fs_clamp",
            Params {
                needs_depth_clamp: true,
                depth_clamp: true,
                ..base
            },
            &DEPTH_EZ_FS_CLAMP,
        ),
        (
            "fs_clamp",
            Params {
                needs_depth_clamp: true,
                depth_clamp: true,
                ..base
            },
            &DEPTH_FS_CLAMP,
        ),
        (
            "out_of_range",
            Params {
                stores_depth: false,
                compare_op: vk::CompareOp::EQUAL,
                expected_depth: 1.0,
                expected_stored: None,
                ..base
            },
            &DEPTH_OUT_OF_RANGE,
        ),
        (
            "out_of_range_unrestricted",
            Params {
                needs_unrestricted: true,
                stores_depth: false,
                compare_op: vk::CompareOp::NOT_EQUAL,
                expected_depth: 2.0,
                expected_stored: None,
                ..base
            },
            &DEPTH_OUT_OF_RANGE_UNRESTRICTED,
        ),
    ];

    let mut group = TestCaseGroup::new("depth");
    for (name, params, programs) in cases {
        group.add_child(Box::new(DepthCase { name, params, programs }) as Box<dyn TestCase>);
    }
    group
}
