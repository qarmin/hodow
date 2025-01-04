// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawOutputLocationTests.cpp (the Amber scripts under
//   data/vulkan/amber/draw/output_location/array)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What an Amber graphics pipeline does for these scripts is done directly: one
// pass writes three 60x60 attachments through an array of outputs, three passes write the same colours to one attachment each as
// references, and three passes sample an attachment and its reference (nearest filtering) and write green where they agree. The
// verification images must be green everywhere. The `shuffle` cases (outputs written at other locations than the inputs arrive at) are in `ShuffleCase`: the first compares the
// two attachments with references pixel by pixel, the second goes through the sampling verification like the array ones.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_output_location::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE: u32 = 60;
const RESULT_FORMAT: vk::Format = vk::Format::B8G8R8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Data {
    Float4,
    Bytes4,
    Half2,
    Float1,
    Uint8x2,
}

#[derive(Clone, Copy)]
struct Family {
    prefix: &'static str,
    format: vk::Format,
    vertex_format: vk::Format,
    data: Data,
    outs: &'static [&'static str],
}

const FAMILIES: [Family; 6] = [
    Family {
        prefix: "b10g11r11-ufloat-pack32",
        format: vk::Format::B10G11R11_UFLOAT_PACK32,
        vertex_format: vk::Format::R32G32B32A32_SFLOAT,
        data: Data::Float4,
        outs: &["", "float", "vec2"],
    },
    Family {
        prefix: "b8g8r8a8-unorm",
        format: vk::Format::B8G8R8A8_UNORM,
        vertex_format: vk::Format::B8G8R8A8_UNORM,
        data: Data::Bytes4,
        outs: &["", "vec2", "vec3"],
    },
    Family {
        prefix: "r16g16-sfloat",
        format: vk::Format::R16G16_SFLOAT,
        vertex_format: vk::Format::R16G16_SFLOAT,
        data: Data::Half2,
        outs: &["", "float"],
    },
    Family {
        prefix: "r32g32b32a32-sfloat",
        format: vk::Format::R32G32B32A32_SFLOAT,
        vertex_format: vk::Format::R32G32B32A32_SFLOAT,
        data: Data::Float4,
        outs: &["", "vec2", "vec3"],
    },
    Family {
        prefix: "r32-sfloat",
        format: vk::Format::R32_SFLOAT,
        vertex_format: vk::Format::R32_SFLOAT,
        data: Data::Float1,
        outs: &[""],
    },
    Family {
        prefix: "r8g8-uint",
        format: vk::Format::R8G8_UINT,
        vertex_format: vk::Format::R8G8_UINT,
        data: Data::Uint8x2,
        outs: &["", "uint"],
    },
];

/// The four vertices of colour buffer `n`, in the vertex format's memory layout.
fn color_bytes(data: Data, n: usize) -> Vec<u8> {
    const F4: [[[f32; 4]; 4]; 3] = [
        [
            [1.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ],
        [
            [0.0, 1.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
        ],
        [
            [0.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
        ],
    ];
    const F2: [[[u8; 2]; 4]; 3] = [
        [[1, 0], [0, 1], [0, 0], [1, 1]],
        [[0, 1], [0, 0], [1, 1], [1, 0]],
        [[0, 0], [1, 1], [1, 0], [0, 1]],
    ];
    const F1: [[f32; 4]; 3] = [[1.0, 0.0, 0.0, 1.0], [0.0, 0.0, 1.0, 1.0], [0.0, 1.0, 1.0, 0.0]];
    let half = |v: u8| -> u16 { if v == 0 { 0x0000 } else { 0x3C00 } };
    match data {
        Data::Float4 => F4[n].iter().flatten().flat_map(|v| v.to_ne_bytes()).collect(),
        Data::Bytes4 => F4[n].iter().flatten().map(|v| (v * 255.0) as u8).collect(),
        Data::Half2 => F2[n].iter().flatten().flat_map(|&v| half(v).to_ne_bytes()).collect(),
        Data::Float1 => F1[n].iter().flat_map(|v| v.to_ne_bytes()).collect(),
        Data::Uint8x2 => F2[n].iter().flatten().map(|&v| v * 255).collect(),
    }
}

fn format_size(format: vk::Format) -> u32 {
    match format {
        vk::Format::R32G32B32A32_SFLOAT => 16,
        vk::Format::R8G8_UINT => 2,
        _ => 4,
    }
}

struct OutputLocationCase {
    name: String,
    family: Family,
}

impl TestCase for OutputLocationCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let image = unsafe { instance.get_physical_device_format_properties(physical_device, self.family.format) }
            .optimal_tiling_features;
        if !image.contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::SAMPLED_IMAGE) {
            return Err(TestError::NotSupported(
                "Format not supported as a sampled colour attachment".to_string(),
            ));
        }
        let vertex =
            unsafe { instance.get_physical_device_format_properties(physical_device, self.family.vertex_format) }
                .buffer_features;
        if !vertex.contains(vk::FormatFeatureFlags::VERTEX_BUFFER) {
            return Err(TestError::NotSupported("Vertex format not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let program: &'static SharedProgram = ALL_SHARED_PROGRAM
            .iter()
            .copied()
            .find(|p| p.name == self.name)
            .expect("the manifest has every case");
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OutputLocationInstance {
            context,
            family: self.family,
        })
    }
}

struct OutputLocationInstance<'a> {
    context: &'a Context<'a>,
    family: Family,
}

struct Target<'a> {
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
}

impl<'a> OutputLocationInstance<'a> {
    fn target(&self, format: vk::Format, usage: vk::ImageUsageFlags) -> Result<Target<'a>, TestError> {
        let device = self.context.get_device();
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: SIZE,
                height: SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(
            device,
            self.context.get_default_allocator(),
            info,
            MemoryRequirement::ANY,
        )?;
        let view = make_image_view(
            device,
            *image,
            vk::ImageViewType::_2D,
            format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        Ok(Target { image, view })
    }

    fn host_buffer(&self, bytes: &[u8]) -> Result<BufferWithMemory<'a>, TestError> {
        let device = self.context.get_device();
        let buffer = BufferWithMemory::new(
            device,
            self.context.get_default_allocator(),
            make_buffer_create_info(bytes.len() as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
        flush_alloc(device, buffer.get_allocation())?;
        Ok(buffer)
    }

    fn render_pass(
        &self,
        format: vk::Format,
        count: usize,
        final_layout: vk::ImageLayout,
    ) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        self.render_pass_formats(&vec![format; count], final_layout)
    }

    fn render_pass_formats(
        &self,
        formats: &[vk::Format],
        final_layout: vk::ImageLayout,
    ) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let count = formats.len();
        let attachments: Vec<vk::AttachmentDescription> = formats
            .iter()
            .map(|&format| {
                vk::AttachmentDescription::builder()
                    .format(format)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(final_layout)
                    .build()
            })
            .collect();
        let references: Vec<vk::AttachmentReference> = (0..count as u32)
            .map(|attachment| vk::AttachmentReference {
                attachment,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            })
            .collect();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&references)
            .build()];
        let dependencies = [vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: vk::SUBPASS_EXTERNAL,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::SHADER_READ,
            dependency_flags: vk::DependencyFlags::empty(),
        }];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .dependencies(&dependencies);
        Ok(Unique::new(
            device,
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
        ))
    }

    /// `vertex_formats` are the formats of the vertex buffers bound from binding 1 on, one attribute each at locations 1, 2, ...
    fn pipeline(
        &self,
        render_pass: vk::RenderPass,
        layout: vk::PipelineLayout,
        vert: &str,
        frag: &str,
        vertex_formats: &[(vk::Format, u32)],
        attachments: usize,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let binaries = self.context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get(vert)?)?;
        let fs = create_shader_module(device, binaries.get(frag)?)?;
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
        let mut bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 8,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let mut attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];
        for (i, &(format, stride)) in vertex_formats.iter().enumerate() {
            bindings.push(vk::VertexInputBindingDescription {
                binding: i as u32 + 1,
                stride,
                input_rate: vk::VertexInputRate::VERTEX,
            });
            attributes.push(vk::VertexInputAttributeDescription {
                location: i as u32 + 1,
                binding: i as u32 + 1,
                format,
                offset: 0,
            });
        }
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: SIZE as f32,
            height: SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, SIZE, SIZE)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);
        let multisample =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let blend = vec![
            vk::PipelineColorBlendAttachmentState::builder()
                .blend_enable(false)
                .color_write_mask(vk::ColorComponentFlags::all())
                .build();
            attachments
        ];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend);
        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .color_blend_state(&color_blend)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }
}

impl TestInstance for OutputLocationInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let family = self.family;
        let sampled = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED;
        let framebuffers = [
            self.target(family.format, sampled)?,
            self.target(family.format, sampled)?,
            self.target(family.format, sampled)?,
        ];
        let refs = [
            self.target(family.format, sampled)?,
            self.target(family.format, sampled)?,
            self.target(family.format, sampled)?,
        ];
        let results = [
            self.target(
                RESULT_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            )?,
            self.target(
                RESULT_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            )?,
            self.target(
                RESULT_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            )?,
        ];

        let rp_main = self.render_pass(family.format, 3, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)?;
        let rp_ref = self.render_pass(family.format, 1, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)?;
        let rp_verify = self.render_pass(RESULT_FORMAT, 1, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)?;
        let fb_main = make_framebuffer(
            device,
            *rp_main,
            &[*framebuffers[0].view, *framebuffers[1].view, *framebuffers[2].view],
            SIZE,
            SIZE,
            1,
        )?;
        let fb_refs: Vec<_> = refs
            .iter()
            .map(|t| make_framebuffer(device, *rp_ref, &[*t.view], SIZE, SIZE, 1))
            .collect::<Result<_, _>>()?;
        let fb_results: Vec<_> = results
            .iter()
            .map(|t| make_framebuffer(device, *rp_verify, &[*t.view], SIZE, SIZE, 1))
            .collect::<Result<_, _>>()?;

        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .max_lod(1.0);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
        let bindings = [
            vk::DescriptorSetLayoutBinding::builder()
                .binding(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .descriptor_count(1)
                .stage_flags(vk::ShaderStageFlags::FRAGMENT)
                .build(),
            vk::DescriptorSetLayoutBinding::builder()
                .binding(1)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .descriptor_count(1)
                .stage_flags(vk::ShaderStageFlags::FRAGMENT)
                .build(),
        ];
        let set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&set_layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let pool_sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            descriptor_count: 6,
        }];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .max_sets(3)
            .pool_sizes(&pool_sizes);
        let pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );
        let layouts = [*set_layout; 3];
        let allocate_info = vk::DescriptorSetAllocateInfo::builder()
            .descriptor_pool(*pool)
            .set_layouts(&layouts);
        let sets = unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?;
        for i in 0..3 {
            let infos = [
                [vk::DescriptorImageInfo {
                    sampler: *sampler,
                    image_view: *framebuffers[i].view,
                    image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                }],
                [vk::DescriptorImageInfo {
                    sampler: *sampler,
                    image_view: *refs[i].view,
                    image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                }],
            ];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(sets[i])
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                    .image_info(&infos[0])
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(sets[i])
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                    .image_info(&infos[1])
                    .build(),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        let layout_plain = make_pipeline_layout(device, &[])?;
        let layout_verify = make_pipeline_layout(device, &[*set_layout])?;
        let stride = format_size(family.vertex_format);
        let color_format = (family.vertex_format, stride);
        let pipeline_main = self.pipeline(
            *rp_main,
            *layout_plain,
            "vert_shader",
            "frag_shader",
            &[color_format; 3],
            3,
        )?;
        let pipeline_ref = self.pipeline(
            *rp_ref,
            *layout_plain,
            "vert_shader_ref",
            "frag_shader_ref",
            &[color_format],
            1,
        )?;
        let pipeline_verify = self.pipeline(
            *rp_verify,
            *layout_verify,
            "vert_shader_verify",
            "frag_shader_verify",
            &[(vk::Format::R32G32_SFLOAT, 8)],
            1,
        )?;

        let position: Vec<u8> = [-1.0f32, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0]
            .iter()
            .flat_map(|v| v.to_ne_bytes())
            .collect();
        let texcoord: Vec<u8> = [0.0f32, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0]
            .iter()
            .flat_map(|v| v.to_ne_bytes())
            .collect();
        let position = self.host_buffer(&position)?;
        let texcoord = self.host_buffer(&texcoord)?;
        let colors = [
            self.host_buffer(&color_bytes(family.data, 0))?,
            self.host_buffer(&color_bytes(family.data, 1))?,
            self.host_buffer(&color_bytes(family.data, 2))?,
        ];

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;

        let clear = |count: usize| {
            vec![
                vk::ClearValue {
                    color: vk::ClearColorValue { uint32: [0; 4] }
                };
                count
            ]
        };
        let begin = |render_pass: vk::RenderPass, framebuffer: vk::Framebuffer, clears: &[vk::ClearValue]| {
            let info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass)
                .framebuffer(framebuffer)
                .render_area(make_rect_2d(0, 0, SIZE, SIZE))
                .clear_values(clears);
            unsafe { device.cmd_begin_render_pass(*cmd, &info, vk::SubpassContents::INLINE) };
        };

        unsafe {
            begin(*rp_main, *fb_main, &clear(3));
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_main);
            device.cmd_bind_vertex_buffers(
                *cmd,
                0,
                &[position.get(), colors[0].get(), colors[1].get(), colors[2].get()],
                &[0; 4],
            );
            device.cmd_draw(*cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(*cmd);

            for i in 0..3 {
                begin(*rp_ref, *fb_refs[i], &clear(1));
                device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_ref);
                device.cmd_bind_vertex_buffers(*cmd, 0, &[position.get(), colors[i].get()], &[0; 2]);
                device.cmd_draw(*cmd, 4, 1, 0, 0);
                device.cmd_end_render_pass(*cmd);
            }

            for i in 0..3 {
                begin(*rp_verify, *fb_results[i], &clear(1));
                device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_verify);
                device.cmd_bind_descriptor_sets(
                    *cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *layout_verify,
                    0,
                    &[sets[i]],
                    &[],
                );
                device.cmd_bind_vertex_buffers(*cmd, 0, &[position.get(), texcoord.get()], &[0; 2]);
                device.cmd_draw(*cmd, 4, 1, 0, 0);
                device.cmd_end_render_pass(*cmd);
            }
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        for (i, result) in results.iter().enumerate() {
            let image = read_color_attachment(
                context,
                *result.image,
                RESULT_FORMAT,
                (SIZE, SIZE),
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?;
            let pixels = image.get_const_access();
            for y in 0..SIZE {
                for x in 0..SIZE {
                    if pixels.get_pixel(x, y, 0) != [0.0, 1.0, 0.0, 1.0] {
                        return Ok(TestStatus::fail(format!(
                            "Attachment {i} differs from its reference at ({x}, {y})"
                        )));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Shuffle {
    InputsOutputs,
    InputsOutputsMod,
}

struct ShuffleCase {
    name: &'static str,
    shuffle: Shuffle,
}

impl TestCase for ShuffleCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let formats: &[vk::Format] = match self.shuffle {
            Shuffle::InputsOutputs => &[vk::Format::B8G8R8A8_UNORM],
            Shuffle::InputsOutputsMod => &[
                vk::Format::B8G8R8A8_UNORM,
                vk::Format::R8G8_UINT,
                vk::Format::R16_SFLOAT,
            ],
        };
        for &format in formats {
            let properties = unsafe { instance.get_physical_device_format_properties(physical_device, format) };
            let needed = vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::SAMPLED_IMAGE;
            if !properties.optimal_tiling_features.contains(needed)
                || !properties
                    .buffer_features
                    .contains(vk::FormatFeatureFlags::VERTEX_BUFFER)
            {
                return Err(TestError::NotSupported(format!(
                    "{format:?} not supported as a sampled colour attachment and vertex format"
                )));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let program: &'static SharedProgram = ALL_SHARED_PROGRAM
            .iter()
            .copied()
            .find(|p| p.name == self.name)
            .expect("the manifest has every case");
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShuffleInstance {
            context,
            shuffle: self.shuffle,
        })
    }
}

struct ShuffleInstance<'a> {
    context: &'a Context<'a>,
    shuffle: Shuffle,
}

impl ShuffleInstance<'_> {
    fn same_pixels(
        &self,
        first: vk::Image,
        second: vk::Image,
        format: vk::Format,
        label: &str,
    ) -> Result<Option<TestStatus>, TestError> {
        let a = read_color_attachment(
            self.context,
            first,
            format,
            (SIZE, SIZE),
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        )?;
        let b = read_color_attachment(
            self.context,
            second,
            format,
            (SIZE, SIZE),
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        )?;
        let (a, b) = (a.get_const_access(), b.get_const_access());
        for y in 0..SIZE {
            for x in 0..SIZE {
                if a.get_pixel(x, y, 0) != b.get_pixel(x, y, 0) {
                    return Ok(Some(TestStatus::fail(format!(
                        "{label} differs from its reference at ({x}, {y})"
                    ))));
                }
            }
        }
        Ok(None)
    }
}

impl TestInstance for ShuffleInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let helper = OutputLocationInstance {
            context,
            family: FAMILIES[1],
        };
        let sampled =
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_SRC;
        let mod_case = self.shuffle == Shuffle::InputsOutputsMod;

        let formats: Vec<vk::Format> = if mod_case {
            vec![
                vk::Format::R16_SFLOAT,
                vk::Format::R8G8_UINT,
                vk::Format::B8G8R8A8_UNORM,
            ]
        } else {
            vec![vk::Format::B8G8R8A8_UNORM; 2]
        };
        let framebuffers: Vec<Target> = formats
            .iter()
            .map(|&f| helper.target(f, sampled))
            .collect::<Result<_, _>>()?;
        let refs: Vec<Target> = formats
            .iter()
            .map(|&f| helper.target(f, sampled))
            .collect::<Result<_, _>>()?;
        let results: Vec<Target> = if mod_case {
            (0..3)
                .map(|_| {
                    helper.target(
                        RESULT_FORMAT,
                        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                    )
                })
                .collect::<Result<_, _>>()?
        } else {
            Vec::new()
        };

        let rp_main = helper.render_pass_formats(&formats, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)?;
        let rp_refs: Vec<_> = formats
            .iter()
            .map(|&f| helper.render_pass(f, 1, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL))
            .collect::<Result<_, _>>()?;
        let rp_verify = helper.render_pass(RESULT_FORMAT, 1, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)?;
        let views: Vec<vk::ImageView> = framebuffers.iter().map(|t| *t.view).collect();
        let fb_main = make_framebuffer(device, *rp_main, &views, SIZE, SIZE, 1)?;
        let fb_refs: Vec<_> = refs
            .iter()
            .zip(&rp_refs)
            .map(|(t, rp)| make_framebuffer(device, **rp, &[*t.view], SIZE, SIZE, 1))
            .collect::<Result<_, _>>()?;
        let fb_results: Vec<_> = results
            .iter()
            .map(|t| make_framebuffer(device, *rp_verify, &[*t.view], SIZE, SIZE, 1))
            .collect::<Result<_, _>>()?;

        let layout_plain = make_pipeline_layout(device, &[])?;
        let position: Vec<u8> = [-1.0f32, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0]
            .iter()
            .flat_map(|v| v.to_ne_bytes())
            .collect();
        let position = helper.host_buffer(&position)?;

        let bgra: Vec<u8> = if mod_case {
            vec![255, 0, 0, 255, 0, 255, 0, 255, 0, 0, 255, 255, 255, 255, 0, 255]
        } else {
            [255u8, 0, 0, 255].repeat(4)
        };
        let color0 = helper.host_buffer(&bgra)?;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color1_bytes: Vec<u8> = if mod_case {
            vec![0, 255, 0, 0, 255, 255, 255, 0]
        } else {
            [0u8, 255, 0, 255].repeat(4)
        };
        let color1 = helper.host_buffer(&color1_bytes)?;
        let color1_format = if mod_case {
            vk::Format::R8G8_UINT
        } else {
            vk::Format::R8G8B8A8_UNORM
        };
        let color1_stride = if mod_case { 2 } else { 4 };
        let color2_bytes: Vec<u8> = [0.5f32, 1.0, 0.3, 0.2]
            .iter()
            .flat_map(|&v| half_bits(v).to_ne_bytes())
            .collect();
        let color2 = helper.host_buffer(&color2_bytes)?;

        let main_formats: Vec<(vk::Format, u32)> = if mod_case {
            vec![
                (vk::Format::B8G8R8A8_UNORM, 4),
                (color1_format, color1_stride),
                (vk::Format::R16_SFLOAT, 2),
            ]
        } else {
            vec![(color_format, 4), (color1_format, color1_stride)]
        };
        let pipeline_main = helper.pipeline(
            *rp_main,
            *layout_plain,
            "vert_shader",
            "frag_shader",
            &main_formats,
            formats.len(),
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;
        let clear = |count: usize| {
            vec![
                vk::ClearValue {
                    color: vk::ClearColorValue { uint32: [0; 4] }
                };
                count
            ]
        };
        let begin = |render_pass: vk::RenderPass, framebuffer: vk::Framebuffer, clears: &[vk::ClearValue]| {
            let info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass)
                .framebuffer(framebuffer)
                .render_area(make_rect_2d(0, 0, SIZE, SIZE))
                .clear_values(clears);
            unsafe { device.cmd_begin_render_pass(*cmd, &info, vk::SubpassContents::INLINE) };
        };

        let mut main_buffers = vec![position.get(), color0.get(), color1.get()];
        if mod_case {
            main_buffers.push(color2.get());
        }
        unsafe {
            begin(*rp_main, *fb_main, &clear(formats.len()));
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_main);
            device.cmd_bind_vertex_buffers(*cmd, 0, &main_buffers, &vec![0; main_buffers.len()]);
            device.cmd_draw(*cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(*cmd);
        }

        let mut ref_pipelines = Vec::new();
        let mut ref_buffers: Vec<Vec<vk::Buffer>> = Vec::new();
        if mod_case {
            ref_pipelines.push(helper.pipeline(
                *rp_refs[0],
                *layout_plain,
                "vert_shader_ref0",
                "frag_shader_ref0",
                &[(vk::Format::R16_SFLOAT, 2)],
                1,
            )?);
            ref_pipelines.push(helper.pipeline(
                *rp_refs[1],
                *layout_plain,
                "vert_shader_ref1",
                "frag_shader_ref1",
                &[(vk::Format::R8G8_UINT, 2)],
                1,
            )?);
            ref_pipelines.push(helper.pipeline(
                *rp_refs[2],
                *layout_plain,
                "vert_shader_ref2",
                "frag_shader_ref2",
                &[(vk::Format::B8G8R8A8_UNORM, 4)],
                1,
            )?);
            ref_buffers.push(vec![position.get(), color2.get()]);
            ref_buffers.push(vec![position.get(), color1.get()]);
            ref_buffers.push(vec![position.get(), color0.get()]);
        } else {
            ref_pipelines.push(helper.pipeline(
                *rp_refs[0],
                *layout_plain,
                "vert_shader_ref",
                "frag_shader_ref0",
                &[],
                1,
            )?);
            ref_pipelines.push(helper.pipeline(
                *rp_refs[1],
                *layout_plain,
                "vert_shader_ref",
                "frag_shader_ref1",
                &[],
                1,
            )?);
            ref_buffers.push(vec![position.get()]);
            ref_buffers.push(vec![position.get()]);
        }
        for i in 0..ref_pipelines.len() {
            unsafe {
                begin(*rp_refs[i], *fb_refs[i], &clear(1));
                device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *ref_pipelines[i]);
                device.cmd_bind_vertex_buffers(*cmd, 0, &ref_buffers[i], &vec![0; ref_buffers[i].len()]);
                device.cmd_draw(*cmd, 4, 1, 0, 0);
                device.cmd_end_render_pass(*cmd);
            }
        }

        if mod_case {
            let texcoord: Vec<u8> = [0.0f32, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0]
                .iter()
                .flat_map(|v| v.to_ne_bytes())
                .collect();
            let texcoord = helper.host_buffer(&texcoord)?;
            let sampler_info = vk::SamplerCreateInfo::builder()
                .mag_filter(vk::Filter::NEAREST)
                .min_filter(vk::Filter::NEAREST)
                .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
                .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
                .max_lod(1.0);
            let sampler = Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
            );
            let bindings = [
                vk::DescriptorSetLayoutBinding::builder()
                    .binding(0)
                    .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                    .descriptor_count(1)
                    .stage_flags(vk::ShaderStageFlags::FRAGMENT)
                    .build(),
                vk::DescriptorSetLayoutBinding::builder()
                    .binding(1)
                    .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                    .descriptor_count(1)
                    .stage_flags(vk::ShaderStageFlags::FRAGMENT)
                    .build(),
            ];
            let set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
            let set_layout = Unique::new(
                device,
                unsafe { device.create_descriptor_set_layout(&set_layout_info, None) }
                    .vk_check("vkCreateDescriptorSetLayout")?,
            );
            let pool_sizes = [vk::DescriptorPoolSize {
                type_: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                descriptor_count: 6,
            }];
            let pool_info = vk::DescriptorPoolCreateInfo::builder()
                .max_sets(3)
                .pool_sizes(&pool_sizes);
            let pool = Unique::new(
                device,
                unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
            );
            let layouts = [*set_layout; 3];
            let allocate_info = vk::DescriptorSetAllocateInfo::builder()
                .descriptor_pool(*pool)
                .set_layouts(&layouts);
            let sets =
                unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?;
            for i in 0..3 {
                let infos = [
                    [vk::DescriptorImageInfo {
                        sampler: *sampler,
                        image_view: *framebuffers[i].view,
                        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    }],
                    [vk::DescriptorImageInfo {
                        sampler: *sampler,
                        image_view: *refs[i].view,
                        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    }],
                ];
                let writes = [
                    vk::WriteDescriptorSet::builder()
                        .dst_set(sets[i])
                        .dst_binding(0)
                        .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                        .image_info(&infos[0])
                        .build(),
                    vk::WriteDescriptorSet::builder()
                        .dst_set(sets[i])
                        .dst_binding(1)
                        .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                        .image_info(&infos[1])
                        .build(),
                ];
                unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
            }
            let layout_verify = make_pipeline_layout(device, &[*set_layout])?;
            let mut verify_pipelines = Vec::new();
            let verify_frag = [
                "frag_shader_verify_float",
                "frag_shader_verify_uvec2",
                "frag_shader_verify_vec4",
            ];
            let texcoord_format = (vk::Format::R32G32_SFLOAT, 8);
            for i in 0..3 {
                let pipeline = helper.pipeline(
                    *rp_verify,
                    *layout_verify,
                    "vert_shader_verify",
                    verify_frag[i],
                    &[texcoord_format],
                    1,
                )?;
                unsafe {
                    begin(*rp_verify, *fb_results[i], &clear(1));
                    device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                    device.cmd_bind_descriptor_sets(
                        *cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *layout_verify,
                        0,
                        &[sets[i]],
                        &[],
                    );
                    device.cmd_bind_vertex_buffers(*cmd, 0, &[position.get(), texcoord.get()], &[0; 2]);
                    device.cmd_draw(*cmd, 4, 1, 0, 0);
                    device.cmd_end_render_pass(*cmd);
                }
                verify_pipelines.push(pipeline);
            }
            end_command_buffer(device, *cmd)?;
            submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;
            for (i, result) in results.iter().enumerate() {
                let image = read_color_attachment(
                    context,
                    *result.image,
                    RESULT_FORMAT,
                    (SIZE, SIZE),
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                )?;
                let pixels = image.get_const_access();
                for y in 0..SIZE {
                    for x in 0..SIZE {
                        if pixels.get_pixel(x, y, 0) != [0.0, 1.0, 0.0, 1.0] {
                            return Ok(TestStatus::fail(format!(
                                "Attachment {i} differs from its reference at ({x}, {y})"
                            )));
                        }
                    }
                }
            }
            return Ok(TestStatus::pass("Pass"));
        }

        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;
        for i in 0..framebuffers.len() {
            if let Some(failure) = self.same_pixels(
                *framebuffers[i].image,
                *refs[i].image,
                formats[i],
                &format!("Framebuffer {i}"),
            )? {
                return Ok(failure);
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// IEEE binary16 of a value in [0, 1] rounded to nearest, which is all the colour data here needs.
fn half_bits(value: f32) -> u16 {
    if value == 0.0 {
        return 0;
    }
    let bits = value.to_bits();
    let exponent = ((bits >> 23) & 0xff) as i32 - 127 + 15;
    let mantissa = bits & 0x7f_ffff;
    let rounded = (mantissa + 0x1000) >> 13;
    ((exponent as u32) << 10) as u16 + rounded as u16
}

/// `createOutputLocationTests`, the `array` and `shuffle` groups.
pub fn create_output_location_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("output_location");
    let mut array = TestCaseGroup::new("array");
    for family in FAMILIES {
        for precision in ["highp", "mediump"] {
            for out in family.outs {
                let name = format!(
                    "{}-{precision}{}",
                    family.prefix,
                    if out.is_empty() {
                        String::new()
                    } else {
                        format!("-output-{out}")
                    }
                );
                array.add_child(Box::new(OutputLocationCase { name, family }) as Box<dyn TestCase>);
            }
        }
    }
    group.add_child(array);
    let mut shuffle = TestCaseGroup::new("shuffle");
    shuffle.add_child(Box::new(ShuffleCase {
        name: "inputs-outputs",
        shuffle: Shuffle::InputsOutputs,
    }) as Box<dyn TestCase>);
    shuffle.add_child(Box::new(ShuffleCase {
        name: "inputs-outputs-mod",
        shuffle: Shuffle::InputsOutputsMod,
    }) as Box<dyn TestCase>);
    group.add_child(shuffle);
    group
}
