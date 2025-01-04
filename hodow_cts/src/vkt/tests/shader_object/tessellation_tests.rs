// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectTessellationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are SPIR-V assembly spliced together by `scripts/gen_shader_object_tessellation.py`
// (`shaders/manifest/shader_object_tessellation.toml`), which also writes the key table and the reference tables of `tessellation_programs.rs`.
// Pixels are compared as bytes: white is 255 on every channel and black is (0, 0, 0, 255).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtShaderObjectExtensionDeviceCommands;

use super::link_tests::{RENDER_SIZE, create_color_target, read_pixels, record_pre_barrier, record_readback};
use super::tessellation_programs::{BASIC, FRACTIONAL_ODD, POINT_MODE, TEST_SIZE, TRIANGLES, tessellation_programs};
use super::util::{
    bind_graphics_shaders, get_mesh_shader_features, make_shader, remove_unsupported_shader_object_extensions,
    set_default_shader_object_dynamic_states,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::invalidate_alloc;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::draw::util::{begin_rendering, end_rendering, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum SourceType {
    Glsl,
    Hlsl,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    OrientationCcw,
    OrientationCw,
    SpacingEqual,
    SpacingFractionalOdd,
    PatchVertices4,
    PatchVertices5,
    PrimitiveQuads,
    PrimitiveTriangles,
    PointMode,
}

struct ShaderObjectTessellationCase {
    name: String,
    key: String,
    source_type: SourceType,
    test_type: TestType,
    rebind: bool,
}

impl TestCase for ShaderObjectTessellationCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;
        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Tessellation shaders are not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        tessellation_programs(&self.key).expect("every case key is in the generated table")
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectTessellationInstance {
            context,
            source_type: self.source_type,
            test_type: self.test_type,
            rebind: self.rebind,
        })
    }
}

struct ShaderObjectTessellationInstance<'a> {
    context: &'a Context<'a>,
    source_type: SourceType,
    test_type: TestType,
    rebind: bool,
}

impl TestInstance for ShaderObjectTessellationInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let extensions = remove_unsupported_shader_object_extensions(context)?;
        let features = *context.get_device_features();
        let mesh_features = get_mesh_shader_features(context);

        let target = create_color_target(context)?;

        let binaries = context.get_binary_collection();
        let vert_shader = make_shader(device, binaries, vk::ShaderStageFlags::VERTEX, "vert", &features, None)?;
        let tesc_shader = make_shader(
            device,
            binaries,
            vk::ShaderStageFlags::TESSELLATION_CONTROL,
            "tesc",
            &features,
            None,
        )?;
        let tese_shader = make_shader(
            device,
            binaries,
            vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            "tese",
            &features,
            None,
        )?;
        let frag_shader = make_shader(
            device,
            binaries,
            vk::ShaderStageFlags::FRAGMENT,
            "frag",
            &features,
            None,
        )?;

        let rebind_shaders = if self.rebind {
            Some((
                make_shader(
                    device,
                    binaries,
                    vk::ShaderStageFlags::TESSELLATION_CONTROL,
                    "tesc_rebind",
                    &features,
                    None,
                )?,
                make_shader(
                    device,
                    binaries,
                    vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                    "tese_rebind",
                    &features,
                    None,
                )?,
            ))
        } else {
            None
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        record_pre_barrier(device, cmd, target.image.get());

        bind_graphics_shaders(
            device,
            cmd,
            vert_shader.get(),
            tesc_shader.get(),
            tese_shader.get(),
            vk::ShaderEXT::null(),
            frag_shader.get(),
            mesh_features.task_shader != vk::FALSE,
            mesh_features.mesh_shader != vk::FALSE,
        );
        if let Some((tesc_rebind, tese_rebind)) = &rebind_shaders {
            unsafe {
                if self.source_type == SourceType::Glsl {
                    device.cmd_bind_shaders_ext(
                        cmd,
                        &[vk::ShaderStageFlags::TESSELLATION_CONTROL],
                        &[tesc_rebind.get()],
                    );
                    device.cmd_bind_shaders_ext(
                        cmd,
                        &[vk::ShaderStageFlags::TESSELLATION_CONTROL],
                        &[tesc_shader.get()],
                    );
                } else {
                    device.cmd_bind_shaders_ext(
                        cmd,
                        &[vk::ShaderStageFlags::TESSELLATION_EVALUATION],
                        &[tese_rebind.get()],
                    );
                    device.cmd_bind_shaders_ext(
                        cmd,
                        &[vk::ShaderStageFlags::TESSELLATION_EVALUATION],
                        &[tese_shader.get()],
                    );
                }
            }
        }
        set_default_shader_object_dynamic_states(
            device,
            cmd,
            &extensions,
            vk::PrimitiveTopology::PATCH_LIST,
            false,
            false,
            RENDER_SIZE,
            RENDER_SIZE,
        );

        unsafe {
            device.cmd_set_polygon_mode_ext(cmd, vk::PolygonMode::LINE);
            if matches!(self.test_type, TestType::OrientationCcw | TestType::OrientationCw) {
                device.cmd_set_cull_mode_ext(cmd, vk::CullModeFlags::BACK);
            }
        }

        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };
        begin_rendering(
            device,
            cmd,
            *target.view,
            rect_2d(RENDER_SIZE, RENDER_SIZE),
            clear_value,
            vk::ImageLayout::GENERAL,
            vk::AttachmentLoadOp::CLEAR,
            vk::RenderingFlags::empty(),
            1,
            0,
        );

        let viewport = vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: RENDER_SIZE as f32,
            height: RENDER_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        };
        let mut vertex_count = 4u32;
        unsafe {
            device.cmd_set_viewport_with_count_ext(cmd, &[viewport]);
            device.cmd_set_scissor_with_count_ext(cmd, &[rect_2d(RENDER_SIZE, RENDER_SIZE)]);
            if matches!(self.test_type, TestType::PatchVertices4 | TestType::PatchVertices5) {
                device.cmd_set_patch_control_points_ext(cmd, 5);
                vertex_count = 5;
            }
            device.cmd_draw(cmd, vertex_count, 1, 0, 0);
        }
        end_rendering(device, cmd);
        record_readback(device, cmd, &target, None);

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, target.output_buffer.get_allocation())?;
        let pixels = read_pixels(&target);

        const WHITE: [u8; 4] = [255, 255, 255, 255];
        const BLACK: [u8; 4] = [0, 0, 0, 255];

        let table = match self.test_type {
            TestType::SpacingFractionalOdd => Some(&FRACTIONAL_ODD),
            TestType::PrimitiveTriangles => Some(&TRIANGLES),
            TestType::PointMode => Some(&POINT_MODE),
            TestType::OrientationCw => None,
            _ => Some(&BASIC),
        };

        for j in 0..TEST_SIZE {
            for i in 0..TEST_SIZE {
                let x = i + 7;
                let mut y = j + 7;
                if self.test_type == TestType::PatchVertices5 {
                    y += 5;
                }
                let offset = (y * RENDER_SIZE as usize + x) * 4;
                let color = [
                    pixels[offset],
                    pixels[offset + 1],
                    pixels[offset + 2],
                    pixels[offset + 3],
                ];

                let should_be_set = table.is_some_and(|table| table[j][i] != 0);
                let expected = if should_be_set { WHITE } else { BLACK };
                if color != expected {
                    log::info!("Color at ({i}, {j}) is expected to be ({expected:?}), but was ({color:?})");
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createShaderObjectTessellationTests`
pub fn create_shader_object_tessellation_tests() -> TestCaseGroup {
    let source_types = [(SourceType::Glsl, "glsl"), (SourceType::Hlsl, "hlsl")];
    let test_types = [
        (TestType::OrientationCcw, "orientation_ccw"),
        (TestType::OrientationCw, "orientation_cw"),
        (TestType::SpacingEqual, "spacing_equal"),
        (TestType::SpacingFractionalOdd, "spacing_fractional_odd"),
        (TestType::PatchVertices4, "patch_vertices_4"),
        (TestType::PatchVertices5, "patch_vertices_5"),
        (TestType::PrimitiveQuads, "primitive_quads"),
        (TestType::PrimitiveTriangles, "primitive_triangles"),
        (TestType::PointMode, "point_mode"),
    ];

    let mut tessellation_group = TestCaseGroup::new("tessellation");
    for (source_type, source_name) in source_types {
        let mut stage_group = TestCaseGroup::new(source_name);
        for (test_type, test_name) in test_types {
            for rebind in [false, true] {
                let name = format!("{test_name}{}", if rebind { "_rebind" } else { "" });
                let key = format!("{source_name}_{name}");
                stage_group.add_child(Box::new(ShaderObjectTessellationCase {
                    name,
                    key,
                    source_type,
                    test_type,
                    rebind,
                }) as Box<dyn TestCase>);
            }
        }
        tessellation_group.add_child(stage_group);
    }
    tessellation_group
}
