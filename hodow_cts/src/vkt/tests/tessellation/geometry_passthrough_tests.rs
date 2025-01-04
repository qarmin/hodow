// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationGeometryPassthroughTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders upstream generates from strings are pre-expanded per
// primitive type in the manifest (`shaders/manifest/tessellation_passthrough.toml`), and the test's explanatory log
// messages are not produced.
//
// Ported from dEQP-GLES31.functional.tessellation_geometry_interaction.render.passthrough.*

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_passthrough::{
    PASSTHROUGH_GEOMETRY_ISOLINES, PASSTHROUGH_GEOMETRY_QUADS, PASSTHROUGH_GEOMETRY_TRIANGLES,
    PASSTHROUGH_TESSELLATION_ISOLINES, PASSTHROUGH_TESSELLATION_TRIANGLES,
};
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::vector::UVec4;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::tessellation::util::{TessLevels, TessPrimitiveType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const PIPELINE_CASES: usize = 2;
const RENDER_SIZE: u32 = 256;

/// When a test case disables tessellation stage and we need to derive a primitive type.
fn get_primitive_topology(primitive_type: TessPrimitiveType) -> vk::PrimitiveTopology {
    match primitive_type {
        TessPrimitiveType::Triangles | TessPrimitiveType::Quads => vk::PrimitiveTopology::TRIANGLE_LIST,
        TessPrimitiveType::Isolines => vk::PrimitiveTopology::LINE_LIST,
    }
}

#[derive(Clone, Copy)]
struct PipelineDescription {
    use_tessellation: bool,
    use_geometry: bool,
    tess_eval_shader_name: &'static str,
    geom_shader_name: &'static str,
}

/// `PassthroughTestInstance::Params`
#[derive(Clone)]
struct Params {
    use_tess_levels: bool,
    tess_levels: TessLevels,
    primitive_type: TessPrimitiveType,
    input_patch_vertices: u32,
    vertices: Vec<[f32; 4]>,
    pipeline_cases: [PipelineDescription; PIPELINE_CASES], // Each test case renders with two pipelines and compares results
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseKind {
    /// `IdentityGeometryShaderTestCase`
    IdentityGeometry,
    /// `IdentityTessellationShaderTestCase`
    IdentityTessellation,
}

struct PassthroughTestCase {
    name: String,
    kind: CaseKind,
    primitive_type: TessPrimitiveType,
}

impl TestCase for PassthroughTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.kind, self.primitive_type) {
            (CaseKind::IdentityGeometry, TessPrimitiveType::Triangles) => PASSTHROUGH_GEOMETRY_TRIANGLES.programs,
            (CaseKind::IdentityGeometry, TessPrimitiveType::Quads) => PASSTHROUGH_GEOMETRY_QUADS.programs,
            (CaseKind::IdentityGeometry, TessPrimitiveType::Isolines) => PASSTHROUGH_GEOMETRY_ISOLINES.programs,
            (CaseKind::IdentityTessellation, TessPrimitiveType::Triangles) => {
                PASSTHROUGH_TESSELLATION_TRIANGLES.programs
            }
            (CaseKind::IdentityTessellation, _) => PASSTHROUGH_TESSELLATION_ISOLINES.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let primitive_type = self.primitive_type;

        let params = match self.kind {
            CaseKind::IdentityGeometry => {
                let level = 14.0;
                Params {
                    use_tess_levels: true,
                    tess_levels: TessLevels {
                        inner: [level; 2],
                        outer: [level; 4],
                    },
                    primitive_type,
                    input_patch_vertices: if primitive_type == TessPrimitiveType::Triangles {
                        3
                    } else {
                        4
                    },
                    vertices: vec![
                        [-0.9, -0.9, 0.0, 1.0],
                        [-0.9, 0.9, 0.0, 1.0],
                        [0.9, -0.9, 0.0, 1.0],
                        [0.9, 0.9, 0.0, 1.0],
                    ],
                    pipeline_cases: [
                        // passthrough geometry shader
                        PipelineDescription {
                            use_tessellation: true,
                            use_geometry: true,
                            tess_eval_shader_name: "tese_to_geom",
                            geom_shader_name: "geom",
                        },
                        // no geometry shader in the pipeline
                        PipelineDescription {
                            use_tessellation: true,
                            use_geometry: false,
                            tess_eval_shader_name: "tese_to_frag",
                            geom_shader_name: "geom",
                        },
                    ],
                }
            }
            CaseKind::IdentityTessellation => {
                let input_patch_vertices = if primitive_type == TessPrimitiveType::Triangles {
                    3
                } else {
                    2
                };
                let mut vertices = vec![[-0.4, 0.4, 0.0, 1.0], [0.0, -0.5, 0.0, 1.0]];
                if input_patch_vertices == 3 {
                    vertices.push([0.4, 0.4, 0.0, 1.0]);
                }
                Params {
                    use_tess_levels: false,
                    tess_levels: TessLevels {
                        inner: [0.0; 2],
                        outer: [0.0; 4],
                    },
                    primitive_type,
                    input_patch_vertices,
                    vertices,
                    pipeline_cases: [
                        // passthrough tessellation shaders
                        PipelineDescription {
                            use_tessellation: true,
                            use_geometry: true,
                            tess_eval_shader_name: "tese",
                            geom_shader_name: "geom_from_tese",
                        },
                        // no tessellation shaders in the pipeline
                        PipelineDescription {
                            use_tessellation: false,
                            use_geometry: true,
                            tess_eval_shader_name: "tese",
                            geom_shader_name: "geom_from_vert",
                        },
                    ],
                }
            }
        };

        Box::new(PassthroughTestInstance { context, params })
    }
}

struct PassthroughTestInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for PassthroughTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();

        // Tessellation levels
        let tess_levels_size = std::mem::size_of::<TessLevels>() as vk::DeviceSize;
        let tess_levels_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(tess_levels_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        if params.use_tess_levels {
            let buffer_alloc = tess_levels_buffer.get_allocation();
            unsafe { std::ptr::write_unaligned(buffer_alloc.get_host_ptr().cast::<TessLevels>(), params.tess_levels) };
            flush_alloc(device, buffer_alloc)?;
        }

        // Vertex attributes
        let vertex_buffer = create_host_buffer(context, &params.vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Descriptors - make descriptor for tessellation levels, even if we don't use them, to simplify code
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::TESSELLATION_CONTROL,
            )
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let tess_levels_buffer_info = vk::DescriptorBufferInfo {
            buffer: tess_levels_buffer.get(),
            offset: 0,
            range: tess_levels_size,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &tess_levels_buffer_info,
            )
            .update(device);

        // Color attachment, and the buffer of the first case; the second case gets a buffer of its own.
        // Color output buffer: image will be copied here for verification.
        //                      We use two buffers, one for each case.
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_attachment = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let color_buffer_size_bytes = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
        let color_buffer2 = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(color_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let color_buffers = [color_attachment.buffer.get(), color_buffer2.get()];

        // Pipeline
        let render_pass = make_color_render_pass(
            device,
            color_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_attachment.view],
            RENDER_SIZE,
            RENDER_SIZE,
            1,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let binaries = context.get_binary_collection();
        let color_image_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        for pipeline_ndx in 0..PIPELINE_CASES {
            let pipeline_description = &params.pipeline_cases[pipeline_ndx];

            let vert_module = create_shader_module(device, binaries.get("vert")?)?;
            let frag_module = create_shader_module(device, binaries.get("frag")?)?;
            let tesc_module = if pipeline_description.use_tessellation {
                Some(create_shader_module(device, binaries.get("tesc")?)?)
            } else {
                None
            };
            let tese_module = if pipeline_description.use_tessellation {
                Some(create_shader_module(
                    device,
                    binaries.get(pipeline_description.tess_eval_shader_name)?,
                )?)
            } else {
                None
            };
            let geom_module = if pipeline_description.use_geometry {
                Some(create_shader_module(
                    device,
                    binaries.get(pipeline_description.geom_shader_name)?,
                )?)
            } else {
                None
            };

            let mut stages = vec![
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ];
            if let (Some(tesc_module), Some(tese_module)) = (&tesc_module, &tese_module) {
                stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tesc_module));
                stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tese_module));
            }
            if let Some(geom_module) = &geom_module {
                stages.push((vk::ShaderStageFlags::GEOMETRY, **geom_module));
            }

            let mut state = DrawPipelineState::new(if pipeline_description.use_tessellation {
                vk::PrimitiveTopology::PATCH_LIST
            } else {
                get_primitive_topology(params.primitive_type)
            })
            .with_position_input()
            .with_full_viewport(RENDER_SIZE, RENDER_SIZE);
            if pipeline_description.use_tessellation {
                state.patch_control_points = Some(params.input_patch_vertices);
            }
            state.color_blend_attachment = Some(vk::PipelineColorBlendAttachmentState {
                blend_enable: vk::TRUE,
                src_color_blend_factor: vk::BlendFactor::SRC_ALPHA,
                dst_color_blend_factor: vk::BlendFactor::ONE,
                color_blend_op: vk::BlendOp::ADD,
                src_alpha_blend_factor: vk::BlendFactor::SRC_ALPHA,
                dst_alpha_blend_factor: vk::BlendFactor::ONE,
                alpha_blend_op: vk::BlendOp::ADD,
                color_write_mask: vk::ColorComponentFlags::all(),
            });
            let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

            // Draw commands
            begin_command_buffer(device, *cmd_buffer)?;

            // Change color attachment image layout
            {
                // State is slightly different on the first iteration.
                let current_layout = if pipeline_ndx == 0 {
                    vk::ImageLayout::UNDEFINED
                } else {
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL
                };
                let src_flags = if pipeline_ndx == 0 {
                    vk::AccessFlags::empty()
                } else {
                    vk::AccessFlags::TRANSFER_READ
                };

                let color_attachment_layout_barrier = make_image_memory_barrier(
                    src_flags,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    current_layout,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_attachment.image.get(),
                    color_image_subresource_range,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        *cmd_buffer,
                        vk::PipelineStageFlags::TOP_OF_PIPE | vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[color_attachment_layout_barrier],
                    );
                }
            }

            // Begin render pass
            let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);

                device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);

                if params.use_tess_levels {
                    device.cmd_bind_descriptor_sets(
                        *cmd_buffer,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layout,
                        0,
                        &[descriptor_set.get()],
                        &[] as &[u32],
                    );
                }

                device.cmd_draw(*cmd_buffer, params.vertices.len() as u32, 1, 0, 0);
                device.cmd_end_render_pass(*cmd_buffer);
            }

            // Copy render result to a host-visible buffer
            copy_image_to_buffer(
                device,
                *cmd_buffer,
                color_attachment.image.get(),
                color_buffers[pipeline_ndx],
                RENDER_SIZE,
                RENDER_SIZE,
            );

            end_command_buffer(device, *cmd_buffer)?;
            submit_commands_and_wait(device, queue, *cmd_buffer)?;
        }

        // Verify results
        invalidate_alloc(device, color_attachment.buffer.get_allocation())?;
        invalidate_alloc(device, color_buffer2.get_allocation())?;
        let size = color_buffer_size_bytes as usize;
        let image0_bytes =
            unsafe { std::slice::from_raw_parts(color_attachment.buffer.get_allocation().get_host_ptr(), size) };
        let image1_bytes = unsafe { std::slice::from_raw_parts(color_buffer2.get_allocation().get_host_ptr(), size) };
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let image0 = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], image0_bytes);
        let image1 = ConstPixelBufferAccess::new(format, [RENDER_SIZE, RENDER_SIZE, 1], image1_bytes);

        let color_threshold = UVec4::new(8, 8, 8, 255);
        let position_deviation = [1, 1, 0]; // 3x3 search kernel
        let ignore_out_of_bounds = true;

        let ok = int_threshold_position_deviation_compare(
            &image0,
            &image1,
            color_threshold,
            position_deviation,
            ignore_out_of_bounds,
        );

        Ok(if ok {
            TestStatus::pass("OK")
        } else {
            TestStatus::fail("Image comparison failed")
        })
    }
}

/// `createGeometryPassthroughTests`
pub fn create_geometry_passthrough_tests() -> TestCaseGroup {
    // Render various types with either passthrough geometry or tessellation shader
    let mut group = TestCaseGroup::new("passthrough");

    // Passthrough geometry shader
    for primitive_type in TessPrimitiveType::ALL {
        // Passthrough geometry shader has no effect
        group.add_child(Box::new(PassthroughTestCase {
            name: format!(
                "tessellate_{}_passthrough_geometry_no_change",
                primitive_type.shader_name()
            ),
            kind: CaseKind::IdentityGeometry,
            primitive_type,
        }) as Box<dyn TestCase>);
    }

    // Passthrough tessellation shader
    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Isolines] {
        // Passthrough tessellation shader has no effect
        group.add_child(Box::new(PassthroughTestCase {
            name: format!(
                "passthrough_tessellation_geometry_shade_{}_no_change",
                primitive_type.shader_name()
            ),
            kind: CaseKind::IdentityTessellation,
            primitive_type,
        }) as Box<dyn TestCase>);
    }

    group
}
