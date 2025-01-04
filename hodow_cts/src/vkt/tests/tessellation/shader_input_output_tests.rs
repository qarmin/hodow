// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationShaderInputOutputTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Every case's programs are pre-expanded in the manifest
// (`shaders/manifest/tessellation_shader_input_output.toml`) instead of generated from strings, and the reference PNGs are
// embedded from `data/tessellation/`.
//
// These tests correspond to dEQP-GLES31.functional.tessellation.shader_input_output.*

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_shader_input_output::*;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::png::load_png;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 256;

/// The reference PNG of a case, by its path under upstream's `data/vulkan/data/tessellation`.
fn reference_png(name: &str) -> Option<&'static [u8]> {
    match name {
        "patch_vertices_5_in_10_out_ref" => Some(include_bytes!(
            "../../../../data/tessellation/patch_vertices_5_in_10_out_ref.png"
        )),
        "patch_vertices_10_in_5_out_ref" => Some(include_bytes!(
            "../../../../data/tessellation/patch_vertices_10_in_5_out_ref.png"
        )),
        "primitive_id_tcs_ref" => Some(include_bytes!("../../../../data/tessellation/primitive_id_tcs_ref.png")),
        "primitive_id_tes_ref" => Some(include_bytes!("../../../../data/tessellation/primitive_id_tes_ref.png")),
        "gl_position_ref" => Some(include_bytes!("../../../../data/tessellation/gl_position_ref.png")),
        "barrier_ref" => Some(include_bytes!("../../../../data/tessellation/barrier_ref.png")),
        _ => None,
    }
}

/// `initializeWhiteReferenceImage` - an image of the given size filled with white.
fn white_reference_image(width: u32, height: u32) -> Result<TextureLevel, TestError> {
    debug_assert!(width > 0 && height > 0);

    let mut image = TextureLevel::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        width,
        height,
        1,
    )?;
    {
        let mut access = image.get_access();
        for y in 0..height {
            for x in 0..width {
                access.set_pixel([1.0, 1.0, 1.0, 1.0], x, y, 0);
            }
        }
    }
    Ok(image)
}

/// What a case renders and the image it expects.
struct RunParams {
    num_primitives: u32,
    in_patch_size: u32,
    vertex_format: vk::Format,
    vertex_data: Vec<f32>,
    /// The upstream PNG name, or `None` for the white reference image.
    reference_png: Option<&'static str>,
}

/// `runTest` - generic test code used by all test cases.
fn run_test(context: &Context<'_>, params: &RunParams) -> Result<TestStatus, TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();

    // Vertex input: may be just some abstract numbers
    let vertex_buffer = create_host_buffer(context, &params.vertex_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;
    // No barrier needed, flushed memory is automatically visible

    // Color attachment, and the buffer its image is copied to for verification
    let color_format = vk::Format::R8G8B8A8_UNORM;
    let color_target = ImageWithBuffer::new(
        context,
        RENDER_SIZE,
        RENDER_SIZE,
        color_format,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        4,
    )?;

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
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_target.view], RENDER_SIZE, RENDER_SIZE, 1)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
    let tese_module = create_shader_module(device, binaries.get("tese")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let vertex_stride = match params.vertex_format {
        vk::Format::R32_SFLOAT => 4,
        _ => 16,
    };
    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: vertex_stride,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: params.vertex_format,
        offset: 0,
    }];
    state.patch_control_points = Some(params.in_patch_size);
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    // Draw commands
    begin_command_buffer(device, *cmd_buffer)?;

    // Change color attachment image layout
    {
        let color_attachment_layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_target.image.get(),
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        );
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
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

        // Process enough vertices to make a patch.
        device.cmd_draw(*cmd_buffer, params.num_primitives * params.in_patch_size, 1, 0, 0);
        device.cmd_end_render_pass(*cmd_buffer);
    }

    // Copy render result to a host-visible buffer
    copy_image_to_buffer(
        device,
        *cmd_buffer,
        color_target.image.get(),
        color_target.buffer.get(),
        RENDER_SIZE,
        RENDER_SIZE,
    );

    end_command_buffer(device, *cmd_buffer)?;
    submit_commands_and_wait(device, queue, *cmd_buffer)?;

    // Verify case result
    let result_bytes = color_target.read_bytes(device)?;
    let result_image = ConstPixelBufferAccess::new(
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
        [RENDER_SIZE, RENDER_SIZE, 1],
        result_bytes,
    );

    let ok = match params.reference_png {
        Some(name) => {
            let png = reference_png(name)
                .ok_or_else(|| TestError::NotPorted(format!("no reference image embedded for {name}")))?;
            let reference =
                load_png(png).map_err(|e| TestError::InternalError(format!("data/tessellation/{name}.png: {e}")))?;
            fuzzy_compare_ok(&reference.get_const_access(), &result_image, 0.002) == Some(true)
        }
        None => {
            let reference = white_reference_image(RENDER_SIZE, RENDER_SIZE)?;
            fuzzy_compare_ok(&reference.get_const_access(), &result_image, 0.002) == Some(true)
        }
    };

    Ok(if ok {
        TestStatus::pass("OK")
    } else {
        TestStatus::fail("Failure")
    })
}

/// `FEATURE_TESSELLATION_SHADER` of `requireFeatures`
fn require_tessellation(context: &Context<'_>) -> Result<(), TestError> {
    if context.get_device_features().tessellation_shader == vk::FALSE {
        return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
    }
    Ok(())
}

/// The inputs of one case, as `test` of its namespace builds them.
#[derive(Clone, Copy)]
enum CaseKind {
    /// `PatchVertexCount::test`
    PatchVertexCount {
        in_patch_size: u32,
        reference: &'static str,
    },
    /// `PerPatchData::test`; `reference` is `None` for the white image
    PerPatchData {
        num_primitives: u32,
        reference: Option<&'static str>,
    },
    /// `GLPosition::test`
    GlPosition,
    /// `Barrier::test`
    Barrier,
    /// `CrossInvocation::test`
    CrossInvocation,
}

struct ShaderInputOutputCase {
    name: String,
    kind: CaseKind,
    programs: BinaryCollection,
}

impl TestCase for ShaderInputOutputCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        require_tessellation(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderInputOutputInstance {
            context,
            kind: self.kind,
        })
    }
}

struct ShaderInputOutputInstance<'a> {
    context: &'a Context<'a>,
    kind: CaseKind,
}

const PER_PATCH_INPUT_PATCH_SIZE: u32 = 10;
const CROSS_INVOCATION_INPUT_PATCH_SIZE: u32 = 10;
const BARRIER_NUM_VERTICES: u32 = 32;

impl TestInstance for ShaderInputOutputInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = match self.kind {
            CaseKind::PatchVertexCount {
                in_patch_size,
                reference,
            } => {
                // Input vertex attribute data
                let vertex_data = (0..in_patch_size)
                    .map(|i| {
                        let f = i as f32 / (in_patch_size - 1) as f32;
                        f * f
                    })
                    .collect();

                RunParams {
                    num_primitives: 1,
                    in_patch_size,
                    vertex_format: vk::Format::R32_SFLOAT,
                    vertex_data,
                    reference_png: Some(reference),
                }
            }
            CaseKind::PerPatchData {
                num_primitives,
                reference,
            } => {
                // Input vertex attribute data
                let mut vertex_data = vec![0.0f32; (PER_PATCH_INPUT_PATCH_SIZE * num_primitives) as usize];

                for i in 0..num_primitives {
                    vertex_data[(PER_PATCH_INPUT_PATCH_SIZE * i) as usize] = i as f32 / num_primitives as f32;
                }

                RunParams {
                    num_primitives,
                    in_patch_size: PER_PATCH_INPUT_PATCH_SIZE,
                    vertex_format: vk::Format::R32_SFLOAT,
                    vertex_data,
                    reference_png: reference,
                }
            }
            CaseKind::GlPosition => {
                // Input vertex attribute data
                let vertex_data = vec![-0.8f32, -0.7, 0.1, 0.7, -0.5, 0.4, 0.2, 0.5, 0.3, 0.2, 0.3, 0.45];

                RunParams {
                    num_primitives: 1,
                    in_patch_size: 3,
                    vertex_format: vk::Format::R32G32B32A32_SFLOAT,
                    vertex_data,
                    reference_png: Some("gl_position_ref"),
                }
            }
            CaseKind::Barrier => {
                // Input vertex attribute data
                let vertex_data = (0..BARRIER_NUM_VERTICES)
                    .map(|i| i as f32 / (BARRIER_NUM_VERTICES - 1) as f32)
                    .collect();

                RunParams {
                    num_primitives: 1,
                    in_patch_size: BARRIER_NUM_VERTICES,
                    vertex_format: vk::Format::R32_SFLOAT,
                    vertex_data,
                    reference_png: Some("barrier_ref"),
                }
            }
            CaseKind::CrossInvocation => {
                // Input vertex attribute data
                let num_primitives = 8;
                let mut vertex_data = vec![0.0f32; (CROSS_INVOCATION_INPUT_PATCH_SIZE * num_primitives) as usize];

                for i in 0..num_primitives {
                    vertex_data[(CROSS_INVOCATION_INPUT_PATCH_SIZE * i) as usize] = i as f32 / num_primitives as f32;
                }

                RunParams {
                    num_primitives,
                    in_patch_size: CROSS_INVOCATION_INPUT_PATCH_SIZE,
                    vertex_format: vk::Format::R32_SFLOAT,
                    vertex_data,
                    reference_png: None,
                }
            }
        };

        run_test(self.context, &params)
    }
}

/// `createShaderInputOutputTests`
pub fn create_shader_input_output_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_input_output");

    // Patch vertex counts
    {
        // Test input and output patch vertex counts
        group.add_child(Box::new(ShaderInputOutputCase {
            name: "patch_vertices_5_in_10_out".to_string(),
            kind: CaseKind::PatchVertexCount {
                in_patch_size: 5,
                reference: "patch_vertices_5_in_10_out_ref",
            },
            programs: SIO_PATCH_VERTICES_5_IN_10_OUT.programs,
        }) as Box<dyn TestCase>);
        group.add_child(Box::new(ShaderInputOutputCase {
            name: "patch_vertices_10_in_5_out".to_string(),
            kind: CaseKind::PatchVertexCount {
                in_patch_size: 10,
                reference: "patch_vertices_10_in_5_out_ref",
            },
            programs: SIO_PATCH_VERTICES_10_IN_5_OUT.programs,
        }) as Box<dyn TestCase>);
    }

    // Per patch data
    {
        let cases: [(&str, u32, Option<&'static str>, BinaryCollection); 10] = [
            // Read gl_PrimitiveID in TCS and pass it as patch output to TES
            (
                "primitive_id_tcs",
                8,
                Some("primitive_id_tcs_ref"),
                SIO_PER_PATCH_PRIMITIVE_ID_TCS.programs,
            ),
            // Read gl_PrimitiveID in TES
            (
                "primitive_id_tes",
                8,
                Some("primitive_id_tes_ref"),
                SIO_PER_PATCH_PRIMITIVE_ID_TES.programs,
            ),
            // Read gl_PatchVerticesIn in TCS and pass it as patch output to TES
            (
                "patch_vertices_in_tcs",
                1,
                None,
                SIO_PER_PATCH_PATCH_VERTICES_IN_TCS.programs,
            ),
            // Read gl_PatchVerticesIn in TES
            (
                "patch_vertices_in_tes",
                1,
                None,
                SIO_PER_PATCH_PATCH_VERTICES_IN_TES.programs,
            ),
            // Read gl_TessLevelInner[0] in TES
            (
                "tess_level_inner_0_tes",
                1,
                None,
                SIO_PER_PATCH_TESS_LEVEL_INNER_0_TES.programs,
            ),
            // Read gl_TessLevelInner[1] in TES
            (
                "tess_level_inner_1_tes",
                1,
                None,
                SIO_PER_PATCH_TESS_LEVEL_INNER_1_TES.programs,
            ),
            // Read gl_TessLevelOuter[0] in TES
            (
                "tess_level_outer_0_tes",
                1,
                None,
                SIO_PER_PATCH_TESS_LEVEL_OUTER_0_TES.programs,
            ),
            // Read gl_TessLevelOuter[1] in TES
            (
                "tess_level_outer_1_tes",
                1,
                None,
                SIO_PER_PATCH_TESS_LEVEL_OUTER_1_TES.programs,
            ),
            // Read gl_TessLevelOuter[2] in TES
            (
                "tess_level_outer_2_tes",
                1,
                None,
                SIO_PER_PATCH_TESS_LEVEL_OUTER_2_TES.programs,
            ),
            // Read gl_TessLevelOuter[3] in TES
            (
                "tess_level_outer_3_tes",
                1,
                None,
                SIO_PER_PATCH_TESS_LEVEL_OUTER_3_TES.programs,
            ),
        ];

        for (name, num_primitives, reference, programs) in cases {
            group.add_child(Box::new(ShaderInputOutputCase {
                name: name.to_string(),
                kind: CaseKind::PerPatchData {
                    num_primitives,
                    reference,
                },
                programs,
            }) as Box<dyn TestCase>);
        }
    }

    // gl_Position
    {
        let cases = [
            ("gl_position_vs_to_tcs", SIO_GL_POSITION_VS_TO_TCS.programs),
            ("gl_position_tcs_to_tes", SIO_GL_POSITION_TCS_TO_TES.programs),
            (
                "gl_position_vs_to_tcs_to_tes",
                SIO_GL_POSITION_VS_TO_TCS_TO_TES.programs,
            ),
        ];

        for (name, programs) in cases {
            // Pass gl_Position between VS and TCS, or between TCS and TES
            group.add_child(Box::new(ShaderInputOutputCase {
                name: name.to_string(),
                kind: CaseKind::GlPosition,
                programs,
            }) as Box<dyn TestCase>);
        }
    }

    // Barrier
    group.add_child(Box::new(ShaderInputOutputCase {
        name: "barrier".to_string(),
        kind: CaseKind::Barrier,
        programs: SIO_BARRIER.programs,
    }) as Box<dyn TestCase>);

    // Cross invocation communication
    {
        let per_vertex = [
            ("int", SIO_CROSS_PER_VERTEX_INT.programs),
            ("uint", SIO_CROSS_PER_VERTEX_UINT.programs),
            ("float", SIO_CROSS_PER_VERTEX_FLOAT.programs),
            ("vec3", SIO_CROSS_PER_VERTEX_VEC3.programs),
            ("vec4", SIO_CROSS_PER_VERTEX_VEC4.programs),
            ("mat4x3", SIO_CROSS_PER_VERTEX_MAT4X3.programs),
        ];
        let per_patch = [
            ("int", SIO_CROSS_PER_PATCH_INT.programs),
            ("uint", SIO_CROSS_PER_PATCH_UINT.programs),
            ("float", SIO_CROSS_PER_PATCH_FLOAT.programs),
            ("vec3", SIO_CROSS_PER_PATCH_VEC3.programs),
            ("vec4", SIO_CROSS_PER_PATCH_VEC4.programs),
            ("mat4x3", SIO_CROSS_PER_PATCH_MAT4X3.programs),
        ];

        for (case_name, data_types) in [
            ("cross_invocation_per_vertex", per_vertex),
            ("cross_invocation_per_patch", per_patch),
        ] {
            for (data_type_name, programs) in data_types {
                // Write output varyings from multiple invocations.
                group.add_child(Box::new(ShaderInputOutputCase {
                    name: format!("{case_name}_{data_type_name}"),
                    kind: CaseKind::CrossInvocation,
                    programs,
                }) as Box<dyn TestCase>);
            }
        }
    }

    group
}
