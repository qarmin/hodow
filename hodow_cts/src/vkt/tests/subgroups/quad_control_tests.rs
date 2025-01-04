// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsQuadControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in `shaders/manifest/subgroups_quad_control.toml` (written by
// `scripts/gen_subgroups_quad_control_manifest.py`); the four `DrawWithQuadControlInstanceBase` subclasses are one instance with a `TestMode` here,
// whose vertices, render size and check are the ones of the subclass. The graphics pipeline is built here because the shared helper has one vertex attribute.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::subgroups_quad_control::ALL_QUAD_CONTROL_CASE;
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
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

const MIP_COLORS: [[f32; 4]; 5] = [
    [0.9, 0.4, 0.2, 1.0], // orange
    [0.2, 0.8, 0.9, 1.0], // blue
    [0.2, 0.9, 0.2, 1.0], // green
    [0.9, 0.9, 0.2, 1.0], // yellow
    [0.6, 0.1, 0.9, 1.0], // violet
];

/// The `rust_type` of the manifest entries: one `DrawWithQuadControlTestCase`.
#[derive(Clone, Copy)]
pub struct QuadControlCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    QuadDerivatives,
    RequireFullQuads,
    DivergentCondition,
    TerminatedInvocation,
}

impl QuadControlCase {
    fn mode(&self) -> TestMode {
        match self.name {
            "quad_derivatives" => TestMode::QuadDerivatives,
            "require_full_quads" => TestMode::RequireFullQuads,
            "divergent_condition" => TestMode::DivergentCondition,
            "terminated_invocation" => TestMode::TerminatedInvocation,
            _ => panic!("unknown quad control case {}", self.name),
        }
    }
}

impl TestCase for QuadControlCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `DrawWithQuadControlTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_shader_quad_control")?;

        if self.mode() == TestMode::TerminatedInvocation {
            context.require_device_functionality("VK_KHR_shader_terminate_invocation")?;
            if !context.is_device_functionality_supported("VK_KHR_shader_maximal_reconvergence")
                && !context.is_device_functionality_supported("VK_KHR_shader_subgroup_uniform_control_flow")
            {
                return Err(TestError::NotSupported(
                    "maximal_reconvergence and uniform_control_flow are not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(QuadControlInstance::new(context, self.mode()))
    }
}

/// The fields of `DrawWithQuadControlInstanceBase` that the subclasses set.
struct QuadControlInstance<'a> {
    context: &'a Context<'a>,
    mode: TestMode,
    render_size: u32,
    topology: vk::PrimitiveTopology,
    vertices: Vec<f32>,
    frag_shader_name: &'static str,
}

impl<'a> QuadControlInstance<'a> {
    fn new(context: &'a Context<'a>, mode: TestMode) -> Self {
        let mut instance = Self {
            context,
            mode,
            render_size: 32,
            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            vertices: Vec::new(),
            frag_shader_name: "frag",
        };
        match mode {
            TestMode::QuadDerivatives => {
                // vertices for 5 triangles - defined in order from displayed on the left to the right
                #[rustfmt::skip]
                let vertices = [
                    // position               uvCoords
                    0.0f32,  1.2,  0.0, 1.0, 0.0,  0.0, // uv adjusted to get lod 1
                    -1.2,  -2.0,  0.0, 1.0, 1.0,  1.0,
                    -1.2,   1.2,  0.0, 1.0, 0.0,  1.0,

                    -0.2,   0.3,  0.0, 1.0, 1.0,  1.0, // uv adjusted to get lod 2
                    -0.7,  -0.9,  0.0, 1.0, 0.0,  0.0,
                    -0.3,  -0.8,  0.0, 1.0, 0.0,  1.0,

                    0.0,    0.2,  0.0, 1.0, 10.0, 10.0, // uv adjusted to get lod 5
                    0.1,   -1.0,  0.0, 1.0, 0.0,  0.0,
                    -0.3,  -1.0,  0.0, 1.0, 0.0,  10.0,

                    0.2,   -0.1,  0.0, 1.0, 4.0,  4.0, // uv adjusted to get lod 4
                    0.7,   -1.2,  0.0, 1.0, 0.0,  0.0,
                    0.2,   -1.8,  0.0, 1.0, 0.0,  4.0,

                    -0.1,   0.5,  0.0, 1.0, 0.0,  0.0, // uv adjusted to get lod 3
                    0.8,   -0.8,  0.0, 1.0, 5.0,  5.0,
                    0.9,    0.8,  0.0, 1.0, 0.0,  5.0,
                ];
                instance.vertices = vertices.to_vec();
            }
            TestMode::RequireFullQuads => {
                // vertices for 4 connected triangles with odd angles
                #[rustfmt::skip]
                let vertices = [
                    // position               uvCoords
                    -0.9f32, 0.6,  0.0, 1.0, 0.0,  1.0,
                    -0.7,   -0.8,  0.0, 1.0, 1.0,  1.0,
                    -0.2,    0.9,  0.0, 1.0, 0.0,  0.0,

                    0.0,     0.2,  0.0, 1.0, 20.0, 20.0, // for second triangle
                    0.6,     0.5,  0.0, 1.0, 21.0, 0.0,  // for third triangle
                    1.2,    -0.9,  0.0, 1.0, 0.0,  75.0, // for fourth triangle
                ];
                instance.vertices = vertices.to_vec();
                instance.topology = vk::PrimitiveTopology::TRIANGLE_STRIP;
                instance.render_size = 128;
            }
            TestMode::DivergentCondition => {
                // vertices for 2 triangles forming a full screen quad
                #[rustfmt::skip]
                let vertices = [
                    // position               uvCoords
                    -1.0f32,  1.0, 0.0, 1.0, 0.0, 1.0,
                    1.0,      1.0, 0.0, 1.0, 1.0, 1.0,
                    -1.0,    -1.0, 0.0, 1.0, 0.0, 0.0,
                    1.0,     -1.0, 0.0, 1.0, 1.0, 0.0,
                ];
                instance.vertices = vertices.to_vec();
                instance.topology = vk::PrimitiveTopology::TRIANGLE_STRIP;
                instance.render_size = 16;
            }
            TestMode::TerminatedInvocation => {
                // vertices for a single triangle, half covering the screen quad
                #[rustfmt::skip]
                let vertices = [
                    // position               uvCoords
                    -1.0f32,  1.0, 0.0, 1.0, 0.0, 1.0,
                    1.0,      1.0, 0.0, 1.0, 1.0, 1.0,
                    -1.0,    -1.0, 0.0, 1.0, 0.0, 0.0,
                ];
                instance.vertices = vertices.to_vec();
                instance.topology = vk::PrimitiveTopology::TRIANGLE_STRIP;
                instance.render_size = 32;

                // use subgroup_uniform_control_flow when maximal reconvergence is not supported
                if !context.is_device_functionality_supported("VK_KHR_shader_maximal_reconvergence") {
                    instance.frag_shader_name = "frag_ucf";
                }
            }
        }
        instance
    }

    /// `getImageCreateInfo`
    fn image_create_info(extent: vk::Extent3D, mip_levels: u32, usage: vk::ImageUsageFlags) -> vk::ImageCreateInfo {
        vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: COLOR_FORMAT,
            extent,
            mip_levels,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    /// `isResultCorrect` of the subclass of the mode, on the RGBA8 pixels read back.
    fn is_result_correct(&self, pixels: &[u8]) -> bool {
        let size = self.render_size;
        let pixel = |x: u32, y: u32| -> [f32; 4] {
            let offset = ((y * size + x) * 4) as usize;
            [0, 1, 2, 3].map(|c| f32::from(pixels[offset + c]) / 255.0)
        };

        match self.mode {
            TestMode::QuadDerivatives => {
                let fragment_on_first_triangle = (3u32, 8u32);
                let expected_color_per_fragment = [0usize, 1, 4, 3, 2];
                let color_precision = 0.1f32;

                for triangle_index in 0..5u32 {
                    // on each triangle the checked fragment is 6 fragments away from the fragment on the previous triangle
                    let (x, y) = (
                        fragment_on_first_triangle.0 + 6 * triangle_index,
                        fragment_on_first_triangle.1,
                    );
                    let expected_color = MIP_COLORS[expected_color_per_fragment[triangle_index as usize]];
                    let fragment_color = pixel(x, y);

                    // make sure that the fragment has the colour of the proper mipmap level
                    if (0..4).any(|c| (fragment_color[c] - expected_color[c]).abs() > color_precision) {
                        return false;
                    }
                }
                true
            }
            TestMode::RequireFullQuads => {
                let reference = 0.9f32;
                let mut rendered_count = 0u32;
                let mut proper_ids_count = 0u32;
                let mut with_helpers_count = 0u32;
                let mut without_helpers_count = 0u32;

                // ensure at least some invocations have the vote return true and are filled with the red colour
                for x in 0..size {
                    for y in 0..size {
                        let pixel = pixel(x, y);
                        if pixel[0] < reference {
                            continue;
                        }

                        rendered_count += 1;

                        // if the green channel is 1 then the quads had proper IDs
                        proper_ids_count += u32::from(pixel[1] > reference);

                        // at least some invocations should have voted true if any helper invocations existed
                        with_helpers_count += u32::from(pixel[2] > reference);

                        // at least some invocations should have voted true if there were quads without helper invocations
                        without_helpers_count += u32::from(pixel[3] > reference);
                    }
                }

                rendered_count == proper_ids_count
                    && rendered_count == with_helpers_count + without_helpers_count
                    && without_helpers_count > 50
                    && with_helpers_count > 50
            }
            TestMode::DivergentCondition => {
                let mut test_passed = true;
                let reference = 0.99f32;
                let lambda = 0.01f32;

                let check_condition = |x: u32, y: u32| ((x % 8) > 4) || (((x % 8) == 2) && (y % 2 != 0));

                for x in 0..size {
                    for y in 0..size {
                        let pixel = pixel(x, y);

                        // if the fragment coord does not meet the first condition then r and g must be 0
                        if !check_condition(x, y) {
                            if pixel[0] > lambda || pixel[1] > lambda {
                                test_passed = false;
                            }
                            continue;
                        }

                        let qx = x - (x % 2);
                        let qy = y - (y % 2);
                        let both = |ax: u32, ay: u32| u32::from(check_condition(ax, ay) && check_condition(ay, ax));
                        let sum = both(qx, qy) + both(qx, qy + 1) + both(qx + 1, qy) + both(qx + 1, qy + 1);
                        let active_count = u32::from(check_condition(qx, qy))
                            + u32::from(check_condition(qx, qy + 1))
                            + u32::from(check_condition(qx + 1, qy))
                            + u32::from(check_condition(qx + 1, qy + 1));

                        // if none of the fragments in the quad meets the second condition then r and g must be 0
                        if sum == 0 {
                            if pixel[0] > lambda || pixel[1] > lambda {
                                test_passed = false;
                            }
                            continue;
                        }

                        // if all active quad fragments meet the second condition then r and g must be 1
                        if sum == active_count {
                            if pixel[0] < reference || pixel[1] < reference {
                                test_passed = false;
                            }
                            continue;
                        }

                        // if at least one active quad fragment meets the second condition then r must be 1 and g 0
                        if pixel[0] < reference || pixel[1] > lambda {
                            test_passed = false;
                        }
                    }
                }
                test_passed
            }
            TestMode::TerminatedInvocation => {
                let mut wrong_fragments = 0u32;
                let mut triangle_fragments = 0u32;
                let threshold = 0.01f32;

                for x in 0..size {
                    for y in 0..size {
                        let pixel = pixel(x, y);

                        // skip bottom-right fragments - terminated invocations
                        if x % 2 != 0 && y % 2 != 0 {
                            continue;
                        }

                        // skip fragments with background colour
                        if pixel[1] < 0.9 {
                            continue;
                        }

                        // expect all fragments where the triangle is drawn to be green (0,1,0,1);
                        // any value greater than zero in the red or blue channel indicates an error
                        wrong_fragments += u32::from(pixel[0] > threshold || pixel[2] > threshold);
                        triangle_fragments += 1;
                    }
                }

                wrong_fragments == 0 && triangle_fragments > size
            }
        }
    }
}

impl TestInstance for QuadControlInstance<'_> {
    /// `DrawWithQuadControlInstanceBase::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let render_size = self.render_size;

        assert!(!self.vertices.is_empty());
        let vertex_bytes: Vec<u8> = self.vertices.iter().flat_map(|v| v.to_ne_bytes()).collect();
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                vertex_bytes.len() as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex_bytes.as_ptr(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_bytes.len(),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // the output buffer that the rendered image is read from
        let output_buffer_size = (render_size * render_size * 4) as vk::DeviceSize;
        let output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                output_buffer_size,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // the colour buffer
        let color_image_extent = vk::Extent3D {
            width: render_size,
            height: render_size,
            depth: 1,
        };
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            Self::image_create_info(
                color_image_extent,
                1,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;

        // the image that is used as a texture
        let mip_levels = MIP_COLORS.len() as u32;
        let texture_image = ImageWithMemory::new(
            device,
            allocator,
            Self::image_create_info(
                vk::Extent3D {
                    width: 16,
                    height: 16,
                    depth: 1,
                },
                mip_levels,
                vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;
        let texture_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, mip_levels, 0, 1);
        let texture_image_view = make_image_view(
            device,
            texture_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            texture_srr,
        )?;

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
            .max_lod(5.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        let vertex_input_binding_description = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: (6 * std::mem::size_of::<f32>()) as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_input_attribute_description = [
            // position: 4 floats
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            // uv: 2 floats
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32_SFLOAT,
                offset: (4 * std::mem::size_of::<f32>()) as u32,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_input_binding_description)
            .vertex_attribute_descriptions(&vertex_input_attribute_description);

        // the descriptor set
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_info = vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *texture_image_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let image_infos = [image_info];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(&image_infos);
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // the shader modules, the render pass, the framebuffer and the pipeline
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get(self.frag_shader_name)?)?;
        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;
        let attachments = [*color_image_view];
        let framebuffer = make_framebuffer(device, *render_pass, &attachments, render_size, render_size, 1)?;

        let entry = c"main";
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vert_module)
                .name(entry.to_bytes_with_nul())
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(entry.to_bytes_with_nul())
                .build(),
        ];
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(self.topology)
            .primitive_restart_enable(false);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: render_size as f32,
            height: render_size as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, render_size, render_size)];
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
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .color_blend_state(&color_blend)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .build();
        let graphics_pipeline = Unique::new(
            device,
            unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateGraphicsPipelines")?
                .0[0],
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let barrier = |src_stage: vk::PipelineStageFlags,
                       dst_stage: vk::PipelineStageFlags,
                       barrier: vk::ImageMemoryBarrier| unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            )
        };

        begin_command_buffer(device, cmd)?;

        // transition the colour buffer layout to attachment optimal
        barrier(
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::SHADER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                color_srr,
            ),
        );

        // transition the texture layout to transfer destination optimal
        barrier(
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                texture_image.get(),
                texture_srr,
            ),
        );

        // clear the texture lod levels to different colours
        for (mip_level, color) in MIP_COLORS.iter().enumerate() {
            let texture_mip_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, mip_level as u32, 1, 0, 1);
            unsafe {
                device.cmd_clear_color_image(
                    cmd,
                    texture_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &vk::ClearColorValue { float32: *color },
                    &[texture_mip_srr],
                );
            }
        }

        // transition the texture layout to shader read optimal
        barrier(
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                texture_image.get(),
                texture_srr,
            ),
        );

        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, render_size, render_size),
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, (self.vertices.len() / 6) as u32, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        // transition the colour buffer layout to transfer source optimal
        barrier(
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_image.get(),
                color_srr,
            ),
        );

        // read back the colour image
        let copy_region = make_buffer_image_copy(
            color_image_extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer.get(),
                &[copy_region],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, output_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                output_buffer_size as usize,
            )
        };

        Ok(if self.is_result_correct(pixels) {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `createSubgroupsQuadControlTests`
pub fn create_quad_control_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_quad_control");
    for case in ALL_QUAD_CONTROL_CASE.iter() {
        group.add_child(Box::new(**case) as Box<dyn TestCase>);
    }
    group
}
