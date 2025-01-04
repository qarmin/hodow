// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineInterfaceMatchingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the monolithic pipeline construction type exists, and the `shader_layout_component_matching`
// group lives in component_decorated_tests.rs. The shaders `initPrograms` builds per case are written
// out by scripts/gen_interface_matching_manifest.py, and a case finds them in the manifest by its own name.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_interface_matching::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::component_decorated_tests;
use crate::vkt::tests::pipeline::shader_object_draw::{
    begin_draw, end_draw, make_shader_objects, make_shader_objects_stages,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `VecType`
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum VecType {
    Vec2,
    Vec3,
    Vec4,
    Ivec2,
    Ivec3,
    Ivec4,
    Uvec2,
    Uvec3,
    Uvec4,
}

impl VecType {
    fn glsl_type(self) -> &'static str {
        match self {
            VecType::Vec2 => "vec2",
            VecType::Vec3 => "vec3",
            VecType::Vec4 => "vec4",
            VecType::Ivec2 => "ivec2",
            VecType::Ivec3 => "ivec3",
            VecType::Ivec4 => "ivec4",
            VecType::Uvec2 => "uvec2",
            VecType::Uvec3 => "uvec3",
            VecType::Uvec4 => "uvec4",
        }
    }
}

/// `DecorationType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DecorationType {
    None,
    Flat,
    NoPerspective,
    Component0,
}

impl DecorationType {
    fn name_part(self) -> &'static str {
        match self {
            DecorationType::None => "none",
            DecorationType::Flat => "flat",
            DecorationType::NoPerspective => "noperspective",
            DecorationType::Component0 => "component0",
        }
    }
}

/// `PipelineType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum PipelineType {
    VertOutFragIn,
    VertOutTescInTeseFrag,
    VertTescTeseOutFragIn,
    VertTescOutTeseInFrag,
    VertOutGeomInFrag,
    VertGeomOutFragIn,
    VertOutTescInTeseGeomFrag,
    VertTescTeseOutGeomInFrag,
    VertTescTeseGeomOutFragIn,
}

impl PipelineType {
    fn name(self) -> &'static str {
        match self {
            PipelineType::VertOutFragIn => "vert_out_frag_in",
            PipelineType::VertOutTescInTeseFrag => "vert_out_tesc_in_tese_frag",
            PipelineType::VertTescTeseOutFragIn => "vert_tesc_tese_out_frag_in",
            PipelineType::VertTescOutTeseInFrag => "vert_tesc_out_tese_in_frag",
            PipelineType::VertOutGeomInFrag => "vert_out_geom_in_frag",
            PipelineType::VertGeomOutFragIn => "vert_geom_out_frag_in",
            PipelineType::VertOutTescInTeseGeomFrag => "vert_out_tesc_in_tese_geom_frag",
            PipelineType::VertTescTeseOutGeomInFrag => "vert_tesc_tese_out_geom_in_frag",
            PipelineType::VertTescTeseGeomOutFragIn => "vert_tesc_tese_geom_out_frag_in",
        }
    }

    fn uses_tessellation(self) -> bool {
        matches!(
            self,
            PipelineType::VertOutTescInTeseFrag
                | PipelineType::VertTescTeseOutFragIn
                | PipelineType::VertTescOutTeseInFrag
                | PipelineType::VertOutTescInTeseGeomFrag
                | PipelineType::VertTescTeseOutGeomInFrag
                | PipelineType::VertTescTeseGeomOutFragIn
        )
    }

    fn uses_geometry(self) -> bool {
        matches!(
            self,
            PipelineType::VertOutGeomInFrag
                | PipelineType::VertGeomOutFragIn
                | PipelineType::VertOutTescInTeseGeomFrag
                | PipelineType::VertTescTeseOutGeomInFrag
                | PipelineType::VertTescTeseGeomOutFragIn
        )
    }
}

const PIPELINE_TYPES: [PipelineType; 9] = [
    PipelineType::VertOutFragIn,
    PipelineType::VertOutTescInTeseFrag,
    PipelineType::VertTescTeseOutFragIn,
    PipelineType::VertTescOutTeseInFrag,
    PipelineType::VertOutGeomInFrag,
    PipelineType::VertGeomOutFragIn,
    PipelineType::VertOutTescInTeseGeomFrag,
    PipelineType::VertTescTeseOutGeomInFrag,
    PipelineType::VertTescTeseGeomOutFragIn,
];

/// `DefinitionType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DefinitionType {
    LooseVariable,
    MemberOfBlock,
    MemberOfStructure,
    MemberOfArrayOfStructures,
    MemberOfStructureInBlock,
    MemberOfArrayOfStructuresInBlock,
}

impl DefinitionType {
    fn name(self) -> &'static str {
        match self {
            DefinitionType::LooseVariable => "loose_variable",
            DefinitionType::MemberOfBlock => "member_of_block",
            DefinitionType::MemberOfStructure => "member_of_structure",
            DefinitionType::MemberOfArrayOfStructures => "member_of_array_of_structures",
            DefinitionType::MemberOfStructureInBlock => "member_of_structure_in_block",
            DefinitionType::MemberOfArrayOfStructuresInBlock => "member_of_array_of_structures_in_block",
        }
    }
}

const DEFINITION_TYPES: [DefinitionType; 6] = [
    DefinitionType::LooseVariable,
    DefinitionType::MemberOfBlock,
    DefinitionType::MemberOfStructure,
    DefinitionType::MemberOfArrayOfStructures,
    DefinitionType::MemberOfStructureInBlock,
    DefinitionType::MemberOfArrayOfStructuresInBlock,
];

#[derive(Clone, Copy)]
enum Kind {
    /// `TestType::VECTOR_LENGTH`
    VectorLength { out_vec: VecType, in_vec: VecType },
    /// `TestType::DECORATION_MISMATCH`
    #[allow(dead_code)]
    DecorationMismatch {
        out_decoration: DecorationType,
        in_decoration: DecorationType,
    },
    /// `TestType::SKIP_OUTPUT_VARIABLE`
    SkipOutputVariable,
}

struct InterfaceMatchingCase {
    name: String,
    kind: Kind,
    pipeline_type: PipelineType,
    #[allow(dead_code)]
    definition_type: DefinitionType,
}

impl TestCase for InterfaceMatchingCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if let Kind::SkipOutputVariable = self.kind {
            return Ok(());
        }

        // Outputs of an earlier stage matched with smaller inputs in a later one need VK_KHR_maintenance4.
        if let Kind::VectorLength { out_vec, in_vec } = self.kind
            && out_vec != in_vec
        {
            context.require_device_functionality("VK_KHR_maintenance4")?;
        }

        let features = context.get_device_features();

        if self.pipeline_type.uses_tessellation() && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }

        if self.pipeline_type.uses_geometry() && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.name)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {}", self.name))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InterfaceMatchingInstance {
            context,
            kind: self.kind,
            pipeline_type: self.pipeline_type,
        })
    }
}

struct InterfaceMatchingInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
    pipeline_type: PipelineType,
}

impl TestInstance for InterfaceMatchingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::SkipOutputVariable => run_misc(self.context),
            _ => run_interface_matching(self.context, self.pipeline_type),
        }
    }
}

/// `InterfaceMatchingTestInstance::iterate`: one triangle whose shaders verify the interface and write the verdict into the red channel.
fn run_interface_matching(context: &Context<'_>, pipeline_type: PipelineType) -> TestOutcome {
    let device = context.get_device();
    const RENDER_SIZE: u32 = 16;

    let color_buffer = ImageWithBuffer::new(
        context,
        RENDER_SIZE,
        RENDER_SIZE,
        COLOR_FORMAT,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        4,
    )?;
    let render_pass = make_render_pass(device, COLOR_FORMAT)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], RENDER_SIZE, RENDER_SIZE, 1)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let use_tess = pipeline_type.uses_tessellation();
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let tesc_module = if use_tess {
        Some(create_shader_module(device, binaries.get("tesc")?)?)
    } else {
        None
    };
    let tese_module = if use_tess {
        Some(create_shader_module(device, binaries.get("tese")?)?)
    } else {
        None
    };
    let geom_module = if pipeline_type.uses_geometry() {
        Some(create_shader_module(device, binaries.get("geom")?)?)
    } else {
        None
    };

    let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
    if let (Some(tesc), Some(tese)) = (&tesc_module, &tese_module) {
        stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tesc));
        stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tese));
    }
    if let Some(geom) = &geom_module {
        stages.push((vk::ShaderStageFlags::GEOMETRY, **geom));
    }
    stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));

    let topology = if use_tess {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::TRIANGLE_STRIP
    };
    let mut state = DrawPipelineState::new(topology)
        .with_position_input()
        .with_full_viewport(RENDER_SIZE, RENDER_SIZE);
    if use_tess {
        state.patch_control_points = Some(1);
    }
    let mut shader_object_stages = vec![(vk::ShaderStageFlags::VERTEX, "vert")];
    if use_tess {
        shader_object_stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"));
        shader_object_stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"));
    }
    if pipeline_type.uses_geometry() {
        shader_object_stages.push((vk::ShaderStageFlags::GEOMETRY, "geom"));
    }
    shader_object_stages.push((vk::ShaderStageFlags::FRAGMENT, "frag"));
    let shader_objects = make_shader_objects_stages(context, &shader_object_stages, &[], &[])?;
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

    let vertices: [[f32; 4]; 3] = [[1.0, -1.0, 0.0, 1.0], [-1.0, 1.0, 0.0, 1.0], [-1.0, -1.0, 0.0, 1.0]];
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    let attachment_layout_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        color_buffer.image.get(),
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );
    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[attachment_layout_barrier],
        );
    }
    begin_draw(
        device,
        cmd,
        shader_objects.as_ref(),
        &state,
        pipeline.as_ref().map(|pipeline| **pipeline),
        *render_pass,
        *framebuffer,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        &clear_values,
        &[(color_buffer.image.get(), *color_buffer.view)],
    );
    unsafe {
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
    }
    end_draw(device, cmd, shader_objects.is_some());
    copy_image_to_buffer(
        device,
        cmd,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        RENDER_SIZE,
        RENDER_SIZE,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    // The verification is done in GLSL: two texels are enough, the red channel is 255 when the test passed.
    let result = color_buffer.read_bytes(device)?;
    if result[0] > 254 && result[(RENDER_SIZE * 4 + 8) as usize] > 254 {
        return Ok(TestStatus::pass("Pass"));
    }

    Ok(TestStatus::fail("Fail"))
}

/// `MiscInterfaceMatchingTestInstance::iterate`: a vertex output nobody reads, between two that are read.
fn run_misc(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    const RENDER_SIZE: u32 = 8;

    let color_buffer = ImageWithBuffer::new(
        context,
        RENDER_SIZE,
        RENDER_SIZE,
        COLOR_FORMAT,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        4,
    )?;
    let render_pass = make_render_pass(device, COLOR_FORMAT)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], RENDER_SIZE, RENDER_SIZE, 1)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
    let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &[])?;
    let pipeline = if shader_objects.is_some() {
        None
    } else {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?)
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    let attachment_layout_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        color_buffer.image.get(),
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );
    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[attachment_layout_barrier],
        );
    }
    begin_draw(
        device,
        cmd,
        shader_objects.as_ref(),
        &state,
        pipeline.as_ref().map(|pipeline| **pipeline),
        *render_pass,
        *framebuffer,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        &clear_values,
        &[(color_buffer.image.get(), *color_buffer.view)],
    );
    unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };
    end_draw(device, cmd, shader_objects.is_some());
    copy_image_to_buffer(
        device,
        cmd,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        RENDER_SIZE,
        RENDER_SIZE,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    let result = color_buffer.read_bytes(device)?;
    let wrong_fragments = result
        .chunks_exact(4)
        .filter(|pixel| pixel[0] > 2 || pixel[1] < 253 || pixel[2] < 253 || pixel[3] < 253)
        .count();
    if wrong_fragments == 0 {
        return Ok(TestStatus::pass("Pass"));
    }

    Ok(TestStatus::fail("Fail"))
}

/// `createInterfaceMatchingTests`
pub fn create_interface_matching_tests() -> TestCaseGroup {
    let vec_type_list = [
        [VecType::Vec4, VecType::Vec3, VecType::Vec2],
        [VecType::Ivec4, VecType::Ivec3, VecType::Ivec2],
        [VecType::Uvec4, VecType::Uvec3, VecType::Uvec2],
    ];

    let mut test_group = TestCaseGroup::new("interface_matching");

    let mut vector_matching = TestCaseGroup::new("vector_length");
    for pipeline_type in PIPELINE_TYPES {
        for definition_type in DEFINITION_TYPES {
            // iterate over vector type - float, int or uint
            for vec_type in &vec_type_list {
                // iterate over all out/in length combinations
                for &out_vec in vec_type {
                    for &in_vec in vec_type {
                        if out_vec < in_vec {
                            continue;
                        }

                        let name = format!(
                            "out_{}_in_{}_{}_{}",
                            out_vec.glsl_type(),
                            in_vec.glsl_type(),
                            definition_type.name(),
                            pipeline_type.name()
                        );
                        let case: Box<dyn TestCase> = Box::new(InterfaceMatchingCase {
                            name,
                            kind: Kind::VectorLength { out_vec, in_vec },
                            pipeline_type,
                            definition_type,
                        });
                        vector_matching.add_child(case);
                    }
                }
            }
        }
    }
    test_group.add_child(vector_matching);

    let decoration_pairs = [
        (DecorationType::None, DecorationType::NoPerspective),
        (DecorationType::None, DecorationType::Flat),
        (DecorationType::Flat, DecorationType::NoPerspective),
        (DecorationType::Flat, DecorationType::None),
        (DecorationType::NoPerspective, DecorationType::Flat),
        (DecorationType::NoPerspective, DecorationType::None),
        (DecorationType::Component0, DecorationType::None),
        (DecorationType::None, DecorationType::Component0),
    ];

    let mut decoration_mismatching = TestCaseGroup::new("decoration_mismatch");
    for pipeline_type in PIPELINE_TYPES {
        for definition_type in DEFINITION_TYPES {
            for (out_decoration, in_decoration) in decoration_pairs {
                // tests component = 0 only for loose variables or member of block
                if (out_decoration == DecorationType::Component0 || in_decoration == DecorationType::Component0)
                    && definition_type != DefinitionType::LooseVariable
                    && definition_type != DefinitionType::MemberOfBlock
                {
                    continue;
                }

                let name = format!(
                    "out_{}_in_{}_{}_{}",
                    out_decoration.name_part(),
                    in_decoration.name_part(),
                    definition_type.name(),
                    pipeline_type.name()
                );
                let case: Box<dyn TestCase> = Box::new(InterfaceMatchingCase {
                    name,
                    kind: Kind::DecorationMismatch {
                        out_decoration,
                        in_decoration,
                    },
                    pipeline_type,
                    definition_type,
                });
                decoration_mismatching.add_child(case);
            }
        }
    }
    test_group.add_child(decoration_mismatching);

    test_group.add_child(component_decorated_tests::create_shader_comp_decor_layout_matching_tests());

    // miscellaneous tests
    let mut misc_tests = TestCaseGroup::new("misc");
    let case: Box<dyn TestCase> = Box::new(InterfaceMatchingCase {
        name: "skip_output_variable".to_string(),
        kind: Kind::SkipOutputVariable,
        pipeline_type: PipelineType::VertOutFragIn,
        definition_type: DefinitionType::LooseVariable,
    });
    misc_tests.add_child(case);
    test_group.add_child(misc_tests);

    test_group
}
