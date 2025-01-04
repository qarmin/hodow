// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_graphics_misc_tg_pc.toml`
// (`scripts/gen_dgc_graphics_misc_tg_pc_manifest.py`). The pipelines are made by `build_draw_pipeline` of the draw tests. Only the
// `tg_push_constants_{tess,geom}[_partial][_descriptor_heap]` cases are here (the heap flavours have no pipeline layout, an empty resource heap, push data tokens and `vkCmdPushDataEXT`).
//
// Four sequences, each updating (part of) the push constants used by the tessellation evaluation or geometry stage and drawing one
// quadrant of a 2x2 framebuffer with an indexed draw.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDescriptorHeapExtensionDeviceCommands, ExtDeviceGeneratedCommandsExtensionDeviceCommands};

use crate::generated::shaders::dgc_graphics_misc_tg_pc::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout_with_push_constants,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, ExtraState, PipelineOptions, StageModules, build_draw_pipeline_with_input, copy_image_to_buffer,
    create_empty_resource_heap, float_threshold_compare, make_address_buffer, maybe_create_module, module_handle,
    push_back_element,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt, check_dgc_ext_support,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

#[derive(Clone, Copy, PartialEq, Eq)]
enum TessGeomType {
    Tess,
    Geom,
}

impl TessGeomType {
    /// `tessGeomTypeToFlags`
    fn flags(self) -> vk::ShaderStageFlags {
        match self {
            TessGeomType::Tess => {
                vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION
            }
            TessGeomType::Geom => vk::ShaderStageFlags::GEOMETRY,
        }
    }
}

#[derive(Clone, Copy)]
struct TessGeomPCParams {
    kind: TessGeomType,
    /// Partial means the red value will be pushed outside execution of the indirect commands.
    partial: bool,
    /// Use VK_EXT_descriptor_heap.
    descriptor_heap: bool,
}

impl TessGeomPCParams {
    fn used_stages(&self) -> vk::ShaderStageFlags {
        vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT | self.kind.flags()
    }
}

struct TessGeomPCCase {
    name: String,
    params: TessGeomPCParams,
}

impl TestCase for TessGeomPCCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `tessGeomPushConstantsCheckSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        match self.params.kind {
            TessGeomType::Tess => {
                if features.tessellation_shader == vk::FALSE {
                    return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
                }
            }
            TessGeomType::Geom => {
                if features.geometry_shader == vk::FALSE {
                    return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
                }
            }
        }
        if self.params.descriptor_heap {
            context.require_device_functionality("VK_EXT_descriptor_heap")?;
        }
        check_dgc_ext_support(
            context,
            self.params.used_stages(),
            vk::ShaderStageFlags::empty(),
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = match self.params.kind {
            TessGeomType::Tess => "tg_pc_tess",
            TessGeomType::Geom => "tg_pc_geom",
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TessGeomPCInstance {
            context,
            params: self.params,
        })
    }
}

struct TessGeomPCInstance<'a> {
    context: &'a Context<'a>,
    params: TessGeomPCParams,
}

impl TestInstance for TessGeomPCInstance<'_> {
    /// `tessGeomPushConstantsRun`: each quadrant will be covered by a triangle quad with a different color.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = 2u32;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        // Different from all quad colors below because red is zero.
        let clear_color: Vec4 = [0.0, 0.0, 0.0, 1.0];

        let color_buffer = ImageWithBuffer::new(context, fb_extent, fb_extent, color_format, color_usage, 4)?;

        // 9 vertices which are the quadrant corners mixing values -1, 0 and 1 for each XY coord.
        let vertices: Vec<Vec4> = vec![
            [-1.0, -1.0, 0.0, 1.0], // 0
            [-1.0, 0.0, 0.0, 1.0],  // 1
            [-1.0, 1.0, 0.0, 1.0],  // 2
            [0.0, -1.0, 0.0, 1.0],  // 3
            [0.0, 0.0, 0.0, 1.0],   // 4
            [0.0, 1.0, 0.0, 1.0],   // 5
            [1.0, -1.0, 0.0, 1.0],  // 6
            [1.0, 0.0, 0.0, 1.0],   // 7
            [1.0, 1.0, 0.0, 1.0],   // 8
        ];

        // Quads with 2 triangles.
        let indices: Vec<u32> = vec![
            0, 1, 3, 4, 3, 1, // NW
            3, 4, 6, 7, 6, 4, // NE
            1, 2, 4, 5, 4, 2, // SW
            4, 5, 7, 8, 7, 5, // SE
        ];

        let (vertex_buffer, _) = make_address_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let (index_buffer, _) = make_address_buffer(context, &indices, vk::BufferUsageFlags::INDEX_BUFFER)?;

        let descriptor_heap = params.descriptor_heap;
        let pc_stages = params.kind.flags();
        let pc_size = (std::mem::size_of::<f32>() * 3) as u32; // red, green and blue floats
        let pc_range = vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_size,
        };
        let pipeline_layout = if descriptor_heap {
            None
        } else {
            Some(make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?)
        };
        let pipeline_layout_handle = pipeline_layout
            .as_ref()
            .map_or(vk::PipelineLayout::null(), |layout| **layout);
        let token_stages = if descriptor_heap {
            vk::ShaderStageFlags::ALL
        } else {
            pc_stages
        };
        let resource_heap = if descriptor_heap {
            create_empty_resource_heap(context)?
        } else {
            None
        };

        let has_tess = params.kind == TessGeomType::Tess;
        let has_geom = params.kind == TessGeomType::Geom;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let tesc_module = if has_tess {
            maybe_create_module(device, &binaries, "tesc")?
        } else {
            None
        };
        let tese_module = if has_tess {
            maybe_create_module(device, &binaries, "tese")?
        } else {
            None
        };
        let geom_module = if has_geom {
            maybe_create_module(device, &binaries, "geom")?
        } else {
            None
        };
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent, fb_extent, 1)?;

        let pipeline = build_draw_pipeline_with_input(
            device,
            pipeline_layout_handle,
            *render_pass,
            &StageModules {
                vert: *vert_module,
                tesc: module_handle(&tesc_module),
                tese: module_handle(&tese_module),
                geom: module_handle(&geom_module),
                frag: *frag_module,
            },
            &PipelineOptions {
                extent: (fb_extent, fb_extent),
                topology: if has_tess {
                    vk::PrimitiveTopology::PATCH_LIST
                } else {
                    vk::PrimitiveTopology::TRIANGLE_LIST
                },
                patch_control_points: if has_tess { 3 } else { 0 },
                dynamic_stride: false,
                dynamic_patch_control_points: false,
                no_vertex_input: false,
                extra_attribute: false,
                indirect_bindable: false,
                construction: Construction::Monolithic,
                depth_test: false,
                rendering: None,
            },
            None,
            ExtraState {
                descriptor_heap,
                ..Default::default()
            },
        )?;

        // Commands layout.
        const SEQUENCE_COUNT: u32 = 4;
        let stage_flags = params.used_stages();
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            pipeline_layout_handle,
        );
        let add_pc_token =
            |builder: &mut IndirectCommandsLayoutBuilderExt, offset: u32, range: vk::PushConstantRange| {
                if descriptor_heap {
                    builder.add_push_data_token(offset, range);
                } else {
                    builder.add_push_constant_token(offset, range);
                }
            };
        if !params.partial {
            // Partial update for the red color.
            let red_range = vk::PushConstantRange {
                stage_flags: token_stages,
                offset: 0,
                size: std::mem::size_of::<f32>() as u32,
            };
            let offset = cmds_layout_builder.get_stream_range();
            add_pc_token(&mut cmds_layout_builder, offset, red_range);
        }
        {
            // Partial update for the green and blue colors.
            let gb_range = vk::PushConstantRange {
                stage_flags: token_stages,
                offset: std::mem::size_of::<f32>() as u32,
                size: (std::mem::size_of::<f32>() * 2) as u32,
            };
            let offset = cmds_layout_builder.get_stream_range();
            add_pc_token(&mut cmds_layout_builder, offset, gb_range);
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_indexed_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Indirect commands.
        let green_blue: [[f32; 2]; 4] = [[0.0, 0.0], [0.0, 1.0], [1.0, 0.0], [1.0, 1.0]];
        let red = 1.0f32;
        let vertices_per_sequence = 6u32; // 2 triangles with 3 vertices each, triangle list.

        let mut dgc_data: Vec<u32> = Vec::new();
        for (i, green_blue) in green_blue.iter().enumerate() {
            if !params.partial {
                push_back_element(&mut dgc_data, &red);
            }
            push_back_element(&mut dgc_data, green_blue);
            let draw_cmd = vk::DrawIndexedIndirectCommand {
                index_count: vertices_per_sequence,
                instance_count: 1,
                first_index: vertices_per_sequence * i as u32,
                vertex_offset: 0,
                first_instance: 0,
            };
            push_back_element(&mut dgc_data, &draw_cmd);
        }

        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = dgc_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            SEQUENCE_COUNT,
            0,
            *pipeline,
            0,
        )?;

        // Commands.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent, fb_extent),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(cmd_buffer, index_buffer.get(), 0, vk::IndexType::UINT32);
        }
        if descriptor_heap {
            if let Some((_, bind_heap_info)) = &resource_heap {
                unsafe { device.cmd_bind_resource_heap_ext(cmd_buffer, bind_heap_info) };
            }
            if params.partial {
                let red_bytes = red.to_ne_bytes();
                let push_data_info = vk::PushDataInfoEXT {
                    offset: 0,
                    data: vk::HostAddressRangeConstEXT {
                        address: red_bytes.as_ptr().cast(),
                        size: red_bytes.len(),
                    },
                    ..Default::default()
                };
                unsafe { device.cmd_push_data_ext(cmd_buffer, &push_data_info) };
            }
        } else if params.partial {
            unsafe { device.cmd_push_constants(cmd_buffer, pipeline_layout_handle, pc_stages, 0, &red.to_ne_bytes()) };
        }
        {
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                SEQUENCE_COUNT,
                0,
                0,
                *pipeline,
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        }
        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            fb_extent,
            fb_extent,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        let result = color_buffer.read_bytes(device)?;
        let reference: [Vec4; 4] = [
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, 1.0, 1.0, 1.0],
        ];
        if !float_threshold_compare(result, &reference, [0.0; 4]) {
            return Ok(TestStatus::fail(
                "Unexpected result in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `tg_push_constants_*` cases without descriptor heap, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_tg_pc_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for descriptor_heap in [false, true] {
        for (kind, suffix) in [(TessGeomType::Tess, "tess"), (TessGeomType::Geom, "geom")] {
            for partial in [false, true] {
                let name = format!(
                    "tg_push_constants_{suffix}{}{}",
                    if partial { "_partial" } else { "" },
                    if descriptor_heap { "_descriptor_heap" } else { "" },
                );
                cases.push((
                    format!("ext.graphics.misc.{name}"),
                    Box::new(TessGeomPCCase {
                        name,
                        params: TessGeomPCParams {
                            kind,
                            partial,
                            descriptor_heap,
                        },
                    }) as Box<dyn TestCase>,
                ));
            }
        }
    }
    cases
}
