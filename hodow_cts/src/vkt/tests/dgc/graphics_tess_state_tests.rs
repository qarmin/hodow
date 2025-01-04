// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsTessStateTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are pre-expanded in `shaders/manifest/dgc_graphics_tess_state.toml`
// (`scripts/gen_dgc_tess_state_manifest.py`), one set per pair of layer parameters; the reference images are the NetPBM files that
// `scripts/gen_dgc_tess_state_refs.py` cuts out of vktDGCGraphicsTessStateRefImages.hpp (`tess_state_ref/*.ppm`). The layer cases
// (`tess_state.{monolithic,fast_lib,shader_objects}.*`) and the `dynamic_states` cases (monolithic and fast_lib) are ported. With shader objects the
// shaders are DGC shaders created here, and dynamic rendering replaces the render pass; the state is the defaults of the shader object utility
// plus the vertex input and the patch control points.
//
// Two pipelines, one per layer of a 2 layer framebuffer, differ in the tessellation shaders (output primitive, spacing, patch size,
// `gl_Layer`). An execution set with both pipelines and two draws select them, and each layer is compared to a reference image.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::dgc_graphics_tess_state::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout_with_push_constants, make_render_pass,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, PipelineOptions, StageModules, bind_shader_object_state, bind_shaders_with_nulls,
    build_draw_pipeline, copy_image_to_buffer, push_back_element,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, create_dgc_shader, preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{ImageWithBuffer, begin_rendering, end_rendering};
use crate::vkt::tests::shader_object::util::ShaderObject;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Spacing {
    Equal,
    Odd,
    Even,
}

impl Spacing {
    /// `toString(Spacing)`
    fn name(self) -> &'static str {
        match self {
            Spacing::Equal => "equal_spacing",
            Spacing::Odd => "fractional_odd_spacing",
            Spacing::Even => "fractional_even_spacing",
        }
    }

    /// The part of a manifest key.
    fn short(self) -> &'static str {
        match self {
            Spacing::Equal => "equal",
            Spacing::Odd => "odd",
            Spacing::Even => "even",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PrimitiveType {
    Triangles,
    Isolines,
    Quads,
}

impl PrimitiveType {
    /// `toString(PrimitiveType)`
    fn name(self) -> &'static str {
        match self {
            PrimitiveType::Triangles => "triangles",
            PrimitiveType::Isolines => "isolines",
            PrimitiveType::Quads => "quads",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
struct LayerParams {
    primitive_type: PrimitiveType,
    spacing: Spacing,
    patch_size: u32,
}

impl LayerParams {
    fn key(&self) -> String {
        format!(
            "{}_{}_{}",
            self.primitive_type.name(),
            self.spacing.short(),
            self.patch_size
        )
    }

    /// The reference image of this layer.
    fn reference(&self) -> &'static [u8] {
        macro_rules! image {
            ($name:literal) => {
                &include_bytes!(concat!("tess_state_ref/", $name, ".ppm"))[..]
            };
        }
        match (self.primitive_type, self.spacing, self.patch_size) {
            (PrimitiveType::Triangles, Spacing::Equal, 3) => image!("triangles__equal_spacing__3"),
            (PrimitiveType::Triangles, Spacing::Equal, _) => image!("triangles__equal_spacing__4"),
            (PrimitiveType::Triangles, Spacing::Odd, 3) => image!("triangles__fractional_odd_spacing__3"),
            (PrimitiveType::Triangles, Spacing::Odd, _) => image!("triangles__fractional_odd_spacing__4"),
            (PrimitiveType::Triangles, Spacing::Even, 3) => image!("triangles__fractional_even_spacing__3"),
            (PrimitiveType::Triangles, Spacing::Even, _) => image!("triangles__fractional_even_spacing__4"),
            (PrimitiveType::Isolines, Spacing::Equal, 3) => image!("isolines__equal_spacing__3"),
            (PrimitiveType::Isolines, Spacing::Equal, _) => image!("isolines__equal_spacing__4"),
            (PrimitiveType::Isolines, Spacing::Odd, 3) => image!("isolines__fractional_odd_spacing__3"),
            (PrimitiveType::Isolines, Spacing::Odd, _) => image!("isolines__fractional_odd_spacing__4"),
            (PrimitiveType::Isolines, Spacing::Even, 3) => image!("isolines__fractional_even_spacing__3"),
            (PrimitiveType::Isolines, Spacing::Even, _) => image!("isolines__fractional_even_spacing__4"),
            (PrimitiveType::Quads, Spacing::Equal, 3) => image!("quads__equal_spacing__3"),
            (PrimitiveType::Quads, Spacing::Equal, _) => image!("quads__equal_spacing__4"),
            (PrimitiveType::Quads, Spacing::Odd, 3) => image!("quads__fractional_odd_spacing__3"),
            (PrimitiveType::Quads, Spacing::Odd, _) => image!("quads__fractional_odd_spacing__4"),
            (PrimitiveType::Quads, Spacing::Even, 3) => image!("quads__fractional_even_spacing__3"),
            (PrimitiveType::Quads, Spacing::Even, _) => image!("quads__fractional_even_spacing__4"),
        }
    }
}

#[derive(Clone, Copy)]
struct TessStateParams {
    construction: Construction,
    shader_objects: bool,
    preprocess: bool,
    first: LayerParams,
    second: LayerParams,
}

const FB_SIZE: u32 = 32;
const LAYER_COUNT: u32 = 2;
/// The `kCommonHeader` of the reference images: "P6\n32 32\n255\n".
const REF_HEADER_SIZE: usize = 13;

impl TessStateParams {
    fn shader_stages(&self) -> vk::ShaderStageFlags {
        vk::ShaderStageFlags::VERTEX
            | vk::ShaderStageFlags::TESSELLATION_CONTROL
            | vk::ShaderStageFlags::TESSELLATION_EVALUATION
            | vk::ShaderStageFlags::FRAGMENT
    }

    fn program_key(&self) -> String {
        format!("tess_state_{}__{}", self.first.key(), self.second.key())
    }
}

struct TessStateCase {
    name: String,
    params: TessStateParams,
}

impl TestCase for TessStateCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("tessellationShader not supported".to_string()));
        }

        // This is required for the layer built-in.
        if context.api_version() >= (1, 2, 0) {
            let mut features12 = vk::PhysicalDeviceVulkan12Features::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features12);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if features12.shader_output_layer == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderOutputLayer feature not supported".to_string(),
                ));
            }
        } else {
            context.require_device_functionality("VK_EXT_shader_viewport_index_layer")?;
        }

        if self.params.construction != Construction::Monolithic {
            check_pipeline_construction_requirements(context, PipelineConstructionType::FastLinkedLibrary)?;
        }
        if self.params.shader_objects {
            check_pipeline_construction_requirements(context, PipelineConstructionType::ShaderObjectUnlinkedSpirv)?;
        }

        let stages = self.params.shader_stages();
        let (bind_pipeline, bind_shader) = if self.params.shader_objects {
            (vk::ShaderStageFlags::empty(), stages)
        } else {
            (stages, vk::ShaderStageFlags::empty())
        };
        check_dgc_ext_support(
            context,
            stages,
            bind_pipeline,
            bind_shader,
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.params.program_key();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TessStateInstance {
            context,
            params: self.params,
        })
    }
}

/// The four shader objects of one layer.
struct StageShaders<'a> {
    vert: ShaderObject<'a>,
    tesc: ShaderObject<'a>,
    tese: ShaderObject<'a>,
    frag: ShaderObject<'a>,
}

struct TessStateInstance<'a> {
    context: &'a Context<'a>,
    params: TessStateParams,
}

impl TestInstance for TessStateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = (FB_SIZE, FB_SIZE);
        let fb_format = vk::Format::R8G8B8A8_UNORM;
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];

        // Color buffer with verification buffer.
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(fb_format)
            .extent(vk::Extent3D {
                width: FB_SIZE,
                height: FB_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(LAYER_COUNT)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D_ARRAY,
            fb_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, LAYER_COUNT),
        )?;
        let layer_bytes = (FB_SIZE * FB_SIZE * 4) as usize;
        let color_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                (layer_bytes * LAYER_COUNT as usize) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let tesc1_module = create_shader_module(device, binaries.get("tesc1")?)?;
        let tesc2_module = create_shader_module(device, binaries.get("tesc2")?)?;
        let vk12_support = context.api_version() >= (1, 2, 0);
        let (tese1_name, tese2_name) = if vk12_support {
            ("tese1-spv15", "tese2-spv15")
        } else {
            ("tese1-spv10", "tese2-spv10")
        };
        let tese1_module = create_shader_module(device, binaries.get(tese1_name)?)?;
        let tese2_module = create_shader_module(device, binaries.get(tese2_name)?)?;

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;
        let render_pass = make_render_pass(device, fb_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], FB_SIZE, FB_SIZE, LAYER_COUNT)?;

        let draw_cmd = vk::DrawIndirectCommand {
            vertex_count: 3,
            instance_count: 1,
            first_vertex: 0,
            first_instance: 0,
        };

        let options = PipelineOptions {
            extent: fb_extent,
            topology: vk::PrimitiveTopology::PATCH_LIST,
            patch_control_points: 3,
            dynamic_stride: false,
            dynamic_patch_control_points: false,
            no_vertex_input: true,
            extra_attribute: false,
            indirect_bindable: true,
            construction: params.construction,
            depth_test: false,
            rendering: None,
        };
        let pipeline1 = if params.shader_objects {
            None
        } else {
            Some(build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_module,
                    tesc: Some(*tesc1_module),
                    tese: Some(*tese1_module),
                    geom: None,
                    frag: *frag_module,
                },
                &options,
            )?)
        };
        let pipeline2 = if params.shader_objects {
            None
        } else {
            Some(build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_module,
                    tesc: Some(*tesc2_module),
                    tese: Some(*tese2_module),
                    geom: None,
                    frag: *frag_module,
                },
                &options,
            )?)
        };

        // One shader set per layer when using shader objects.
        let geometry_feature = context.get_device_features().geometry_shader != vk::FALSE;
        let make_stage_shaders = |tesc_name: &str, tese_name: &str| -> Result<StageShaders<'_>, TestError> {
            let make = |stage: vk::ShaderStageFlags, name: &str| {
                create_dgc_shader(device, stage, &binaries.get(name)?, &[], &[], true, geometry_feature)
            };
            Ok(StageShaders {
                vert: make(vk::ShaderStageFlags::VERTEX, "vert")?,
                tesc: make(vk::ShaderStageFlags::TESSELLATION_CONTROL, tesc_name)?,
                tese: make(vk::ShaderStageFlags::TESSELLATION_EVALUATION, tese_name)?,
                frag: make(vk::ShaderStageFlags::FRAGMENT, "frag")?,
            })
        };
        let stage_shaders = if params.shader_objects {
            Some((
                make_stage_shaders("tesc1", tese1_name)?,
                make_stage_shaders("tesc2", tese2_name)?,
            ))
        } else {
            None
        };

        let pipeline_count = LAYER_COUNT; // One pipeline per layer.
        const PER_PIPELINE_STAGE_COUNT: u32 = 4; // vert, tesc, tese, frag
        let shader_stages = params.shader_stages();

        let mut cmds_layout_flags = vk::IndirectCommandsLayoutUsageFlagsEXT::empty();
        if params.preprocess {
            cmds_layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS;
        }

        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_flags, shader_stages, *pipeline_layout);
        let offset = cmds_layout_builder.get_stream_range();
        let ies_type = if params.shader_objects {
            vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
        } else {
            vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
        };
        cmds_layout_builder.add_execution_set_token(offset, ies_type, shader_stages);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut ies_manager = if let Some((shaders1, shaders2)) = &stage_shaders {
            let no_layouts: Vec<vk::DescriptorSetLayout> = Vec::new();
            let stage_infos = [
                (shaders1.vert.get(), no_layouts.clone()),
                (shaders1.tesc.get(), no_layouts.clone()),
                (shaders1.tese.get(), no_layouts.clone()),
                (shaders1.frag.get(), no_layouts.clone()),
            ];
            let mut manager = ExecutionSetManagerExt::new_shader(
                device,
                &stage_infos,
                &[],
                PER_PIPELINE_STAGE_COUNT * pipeline_count,
            )?;
            manager.add_shader(PER_PIPELINE_STAGE_COUNT, shaders2.vert.get());
            manager.add_shader(PER_PIPELINE_STAGE_COUNT + 1, shaders2.tesc.get());
            manager.add_shader(PER_PIPELINE_STAGE_COUNT + 2, shaders2.tese.get());
            manager.add_shader(PER_PIPELINE_STAGE_COUNT + 3, shaders2.frag.get());
            manager
        } else {
            let (Some(pipeline1), Some(pipeline2)) = (&pipeline1, &pipeline2) else {
                return Err(TestError::InternalError("the pipelines are missing".to_string()));
            };
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, **pipeline1, pipeline_count)?;
            manager.add_pipeline(1, **pipeline2);
            manager
        };
        ies_manager.update();

        // DGC buffer contents.
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..pipeline_count {
            // IES token.
            if params.shader_objects {
                for stage in 0..PER_PIPELINE_STAGE_COUNT {
                    dgc_data.push(i * PER_PIPELINE_STAGE_COUNT + stage);
                }
            } else {
                dgc_data.push(i);
            }
            // Draw token.
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

        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies_manager.get(),
            cmds_layout.get(),
            pipeline_count,
            0,
            vk::Pipeline::null(),
            0,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        if let Some((shaders1, _)) = &stage_shaders {
            // The render pass wrapper of shader objects: a transition and dynamic rendering clearing the layers.
            let to_attachment = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, LAYER_COUNT),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_attachment],
                )
            };
            begin_rendering(
                device,
                cmd_buffer,
                *color_view,
                make_rect_2d(0, 0, FB_SIZE, FB_SIZE),
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: clear_color },
                },
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
                vk::RenderingFlags::empty(),
                LAYER_COUNT,
                0,
            );
            // Bind initial state, including initial shader state.
            bind_shaders_with_nulls(
                context,
                cmd_buffer,
                &[
                    (vk::ShaderStageFlags::VERTEX, shaders1.vert.get()),
                    (vk::ShaderStageFlags::TESSELLATION_CONTROL, shaders1.tesc.get()),
                    (vk::ShaderStageFlags::TESSELLATION_EVALUATION, shaders1.tese.get()),
                    (vk::ShaderStageFlags::FRAGMENT, shaders1.frag.get()),
                ],
            );
            let no_bindings: [vk::VertexInputBindingDescription2EXT; 0] = [];
            let no_attributes: [vk::VertexInputAttributeDescription2EXT; 0] = [];
            bind_shader_object_state(
                context,
                cmd_buffer,
                vk::PrimitiveTopology::PATCH_LIST,
                3,
                fb_extent,
                Some((&no_bindings[..], &no_attributes[..])),
            );
        } else if let Some(pipeline1) = &pipeline1 {
            begin_render_pass(
                device,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, FB_SIZE, FB_SIZE),
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: clear_color },
                },
            );
            // Bind initial state, including initial shader state.
            unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, **pipeline1) };
        }
        let cmds_info = DgcGenCmdsInfo::new(
            shader_stages,
            ies_manager.get(),
            cmds_layout.get(),
            dgc_buffer.get_device_address(),
            dgc_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            pipeline_count,
            0,
            0,
            vk::Pipeline::null(),
        );

        let preprocess_cmd_buffer = if params.preprocess {
            let preprocess = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device, preprocess.get())?;
            unsafe { device.cmd_preprocess_generated_commands_ext(preprocess.get(), cmds_info.get(), cmd_buffer) };
            preprocess_to_execute_barrier_ext(device, preprocess.get());
            end_command_buffer(device, preprocess.get())?;
            Some(preprocess)
        } else {
            None
        };
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, cmds_info.get()) };
        if params.shader_objects {
            end_rendering(device, cmd_buffer);
        } else {
            end_render_pass(device, cmd_buffer);
        }
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_image.get(),
            color_buffer.get(),
            FB_SIZE,
            FB_SIZE,
            LAYER_COUNT,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_cmd_buffer
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |preprocess| preprocess.get()),
        )?;

        // Verify color output.
        let alloc = color_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        // SAFETY: the buffer holds `LAYER_COUNT` layers of `layer_bytes` bytes that the device wrote.
        let result = unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), layer_bytes * LAYER_COUNT as usize) };

        let mut fail = false;
        for (layer, key) in [params.first, params.second].iter().enumerate() {
            let result_layer = &result[layer * layer_bytes..(layer + 1) * layer_bytes];
            let reference = &key.reference()[REF_HEADER_SIZE..];
            // The reference is RGB and the result RGBA; with 0 and 1 only the colors match exactly and alpha is 1.
            let mut mismatches = 0usize;
            for pixel in 0..(FB_SIZE * FB_SIZE) as usize {
                let got = &result_layer[pixel * 4..pixel * 4 + 4];
                let expected = &reference[pixel * 3..pixel * 3 + 3];
                if got[..3] != *expected || got[3] != 255 {
                    mismatches += 1;
                }
            }
            if mismatches > 0 {
                log::error!("Layer{layer}: {mismatches} pixels differ from the reference image");
                fail = true;
            }
        }

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected color in result buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCGraphicsTessStateTestsExt`: the cases by their full dotted path in `dgc`. Only the monolithic and `fast_lib` layer cases are registered.
pub fn create_dgc_graphics_tess_state_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let prims = [PrimitiveType::Triangles, PrimitiveType::Isolines, PrimitiveType::Quads];
    let spacings = [Spacing::Equal, Spacing::Odd, Spacing::Even];

    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (construction, shader_objects, construction_name) in [
        (Construction::Monolithic, false, "monolithic"),
        (Construction::FastLinked, false, "fast_lib"),
        (Construction::Monolithic, true, "shader_objects"),
    ] {
        for first_prim in prims {
            for second_prim in prims {
                for first_spacing in spacings {
                    for second_spacing in spacings {
                        for first_size in [3u32, 4] {
                            for second_size in [3u32, 4] {
                                for preprocess in [false, true] {
                                    let first = LayerParams {
                                        primitive_type: first_prim,
                                        spacing: first_spacing,
                                        patch_size: first_size,
                                    };
                                    let second = LayerParams {
                                        primitive_type: second_prim,
                                        spacing: second_spacing,
                                        patch_size: second_size,
                                    };
                                    if first == second {
                                        continue;
                                    }
                                    let name = format!(
                                        "{first_size}_{second_size}{}",
                                        if preprocess { "_preprocess" } else { "" }
                                    );
                                    let path = format!(
                                        "ext.graphics.tess_state.{construction_name}.{}_{}.{}_{}.{name}",
                                        first_prim.name(),
                                        second_prim.name(),
                                        first_spacing.name(),
                                        second_spacing.name(),
                                    );
                                    cases.push((
                                        path,
                                        Box::new(TessStateCase {
                                            name,
                                            params: TessStateParams {
                                                construction,
                                                shader_objects,
                                                preprocess,
                                                first,
                                                second,
                                            },
                                        }) as Box<dyn TestCase>,
                                    ));
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    cases
}

// ---------------------------------------------------------------------------------------------------------------------------
// tess_state.dynamic_states: the patch control points as dynamic state

const PCP_FB_SIZE: u32 = 64;
const PCP_ACTUAL: u32 = 4; // We will use quads for the patch.
const PCP_STATIC: u32 = 3; // But the static value will hint triangles instead.

#[derive(Clone, Copy)]
struct DynamicPcpParams {
    construction: Construction,
    use_ies: bool,
    use_preprocess: bool,
}

impl DynamicPcpParams {
    fn shader_stages(&self) -> vk::ShaderStageFlags {
        vk::ShaderStageFlags::VERTEX
            | vk::ShaderStageFlags::TESSELLATION_CONTROL
            | vk::ShaderStageFlags::TESSELLATION_EVALUATION
            | vk::ShaderStageFlags::FRAGMENT
    }

    fn draw_offset_count(&self) -> usize {
        4
    }

    fn tess_variation_count(&self) -> usize {
        if self.use_ies { self.draw_offset_count() } else { 1 }
    }

    fn draw_offsets(&self) -> [[f32; 4]; 4] {
        [
            [-1.0, -1.0, 0.0, 0.0],
            [0.0, -1.0, 0.0, 0.0],
            [-1.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
        ]
    }
}

struct DynamicPcpCase {
    name: String,
    params: DynamicPcpParams,
}

impl TestCase for DynamicPcpCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stages = self.params.shader_stages();
        let bind_stages = if self.params.use_ies {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        check_dgc_ext_support(
            context,
            stages,
            bind_stages,
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;

        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("tessellationShader not supported".to_string()));
        }
        if self.params.construction != Construction::Monolithic {
            check_pipeline_construction_requirements(context, PipelineConstructionType::FastLinkedLibrary)?;
        }

        let mut eds2_features = vk::PhysicalDeviceExtendedDynamicState2FeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds2_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if eds2_features.extended_dynamic_state2_patch_control_points == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState2PatchControlPoints not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = if self.params.use_ies {
            "tess_state_pcp_ies"
        } else {
            "tess_state_pcp_noies"
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicPcpInstance {
            context,
            params: self.params,
        })
    }
}

struct DynamicPcpInstance<'a> {
    context: &'a Context<'a>,
    params: DynamicPcpParams,
}

impl TestInstance for DynamicPcpInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = (PCP_FB_SIZE, PCP_FB_SIZE);
        let fb_format = vk::Format::R8G8B8A8_UNORM;
        let fb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue { float32: clear_color },
        };

        // Color buffers for the result and reference images, both with verification buffer.
        let color_buffer_res = ImageWithBuffer::new(context, fb_extent.0, fb_extent.1, fb_format, fb_usage, 4)?;
        let color_buffer_ref = ImageWithBuffer::new(context, fb_extent.0, fb_extent.1, fb_format, fb_usage, 4)?;

        // Vertices. These will be offset with the push constants for each section.
        let vertices: Vec<[f32; 4]> = vec![
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];
        let vertex_count = vertices.len() as u32;
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Push constants.
        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: 16,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[pc_range])?;
        let render_pass = make_render_pass(device, fb_format)?;
        let framebuffer_res = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer_res.view],
            fb_extent.0,
            fb_extent.1,
            1,
        )?;
        let framebuffer_ref = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer_ref.view],
            fb_extent.0,
            fb_extent.1,
            1,
        )?;

        // Modules.
        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
        let tess_count = params.tess_variation_count();
        let mut tesc_shaders = Vec::new();
        let mut tese_shaders = Vec::new();
        for i in 0..tess_count {
            tesc_shaders.push(create_shader_module(device, binaries.get(&format!("tesc{i}"))?)?);
            tese_shaders.push(create_shader_module(device, binaries.get(&format!("tese{i}"))?)?);
        }

        let draw_offsets = params.draw_offsets();

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let res_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let ref_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Result pipelines, using dynamic state.
        let mut res_pipelines = Vec::new();
        for i in 0..tess_count {
            res_pipelines.push(build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_shader,
                    tesc: Some(*tesc_shaders[i]),
                    tese: Some(*tese_shaders[i]),
                    geom: None,
                    frag: *frag_shader,
                },
                &PipelineOptions {
                    extent: fb_extent,
                    topology: vk::PrimitiveTopology::PATCH_LIST,
                    patch_control_points: PCP_STATIC,
                    dynamic_stride: false,
                    dynamic_patch_control_points: true,
                    no_vertex_input: false,
                    extra_attribute: false,
                    indirect_bindable: params.use_ies,
                    construction: params.construction,
                    depth_test: false,
                    rendering: None,
                },
            )?);
        }

        // Commands layout.
        let shader_stages = params.shader_stages();
        let layout_flags = if params.use_preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(layout_flags, shader_stages, *pipeline_layout);
        if params.use_ies {
            cmds_layout_builder.add_execution_set_token(
                0,
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES,
                shader_stages,
            );
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_push_constant_token(offset, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut ies_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if params.use_ies {
            let mut manager =
                ExecutionSetManagerExt::new_pipeline(device, *res_pipelines[0], res_pipelines.len() as u32)?;
            for (i, pipeline) in res_pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, **pipeline);
            }
            manager.update();
            ies_manager = Some(manager);
        }
        let ies_handle = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        // DGC buffer contents.
        let sequence_count = draw_offsets.len() as u32;
        let mut dgc_data: Vec<u32> = Vec::new();
        for (i, draw_offset) in draw_offsets.iter().enumerate() {
            if params.use_ies {
                dgc_data.push(i as u32);
            }
            push_back_element(&mut dgc_data, draw_offset);
            dgc_data.push(vertex_count);
            dgc_data.push(1); // instanceCount
            dgc_data.push(0); // firstVertex
            dgc_data.push(0); // firstInstance
        }

        // DGC buffer and preprocess buffer.
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

        let preprocess_pipeline = if ies_handle != vk::IndirectExecutionSetEXT::null() {
            vk::Pipeline::null()
        } else {
            *res_pipelines[0]
        };
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies_handle,
            cmds_layout.get(),
            sequence_count,
            0,
            preprocess_pipeline,
            0,
        )?;

        let mut cmd_buffer = res_cmd_buffer.get();
        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer_res,
            make_rect_2d(0, 0, fb_extent.0, fb_extent.1),
            clear_value,
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_set_patch_control_points_ext(cmd_buffer, PCP_ACTUAL);
            // Bind initial state.
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *res_pipelines[0]);
        }
        let cmds_info = DgcGenCmdsInfo::new(
            shader_stages,
            ies_handle,
            cmds_layout.get(),
            dgc_buffer.get_device_address(),
            dgc_buffer.get_size(),
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            sequence_count,
            0,
            0,
            preprocess_pipeline,
        );
        let preprocess_cmd_buffer = if params.use_preprocess {
            let preprocess = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device, preprocess.get())?;
            unsafe { device.cmd_preprocess_generated_commands_ext(preprocess.get(), cmds_info.get(), cmd_buffer) };
            preprocess_to_execute_barrier_ext(device, preprocess.get());
            end_command_buffer(device, preprocess.get())?;
            Some(preprocess)
        } else {
            None
        };
        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.use_preprocess, cmds_info.get()) };
        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer_res.image.get(),
            color_buffer_res.buffer.get(),
            fb_extent.0,
            fb_extent.1,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_cmd_buffer
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |preprocess| preprocess.get()),
        )?;

        // Reference pipelines.
        let mut ref_pipelines = Vec::new();
        for i in 0..tess_count {
            ref_pipelines.push(build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_shader,
                    tesc: Some(*tesc_shaders[i]),
                    tese: Some(*tese_shaders[i]),
                    geom: None,
                    frag: *frag_shader,
                },
                &PipelineOptions {
                    extent: fb_extent,
                    topology: vk::PrimitiveTopology::PATCH_LIST,
                    patch_control_points: PCP_ACTUAL,
                    dynamic_stride: false,
                    dynamic_patch_control_points: false,
                    no_vertex_input: false,
                    extra_attribute: false,
                    indirect_bindable: false,
                    construction: params.construction,
                    depth_test: false,
                    rendering: None,
                },
            )?);
        }

        // Generate reference image.
        cmd_buffer = ref_cmd_buffer.get();
        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer_ref,
            make_rect_2d(0, 0, fb_extent.0, fb_extent.1),
            clear_value,
        );
        unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]) };
        for (i, draw_offset) in draw_offsets.iter().enumerate() {
            let pipeline_idx = if i >= ref_pipelines.len() { 0 } else { i };
            unsafe {
                device.cmd_bind_pipeline(
                    cmd_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    *ref_pipelines[pipeline_idx],
                );
                let bytes: Vec<u8> = draw_offset.iter().flat_map(|value| value.to_ne_bytes()).collect();
                device.cmd_push_constants(cmd_buffer, *pipeline_layout, vk::ShaderStageFlags::VERTEX, 0, &bytes);
                device.cmd_draw(cmd_buffer, vertex_count, 1, 0, 0);
            }
        }
        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer_ref.image.get(),
            color_buffer_ref.buffer.get(),
            fb_extent.0,
            fb_extent.1,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify color output: no tolerance.
        let reference = color_buffer_ref.read_bytes(device)?;
        let result = color_buffer_res.read_bytes(device)?;
        if reference != result {
            let mismatches = reference.iter().zip(result).filter(|(a, b)| a != b).count();
            log::error!("{mismatches} bytes of the result differ from the reference image");
            return Ok(TestStatus::fail(
                "Unexpected color in result buffer; check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `dynamic_states` cases of `createDGCGraphicsTessStateTestsExt` (monolithic and `fast_lib`).
pub fn create_dgc_graphics_tess_state_dynamic_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (construction, construction_name) in [
        (Construction::Monolithic, "monolithic"),
        (Construction::FastLinked, "fast_lib"),
    ] {
        for use_ies in [false, true] {
            for use_preprocess in [false, true] {
                let name = format!(
                    "pcp{}{}",
                    if use_ies { "_ies" } else { "" },
                    if use_preprocess { "_preprocess" } else { "" }
                );
                cases.push((
                    format!("ext.graphics.tess_state.dynamic_states.{construction_name}.{name}"),
                    Box::new(DynamicPcpCase {
                        name,
                        params: DynamicPcpParams {
                            construction,
                            use_ies,
                            use_preprocess,
                        },
                    }) as Box<dyn TestCase>,
                ));
            }
        }
    }
    cases
}
