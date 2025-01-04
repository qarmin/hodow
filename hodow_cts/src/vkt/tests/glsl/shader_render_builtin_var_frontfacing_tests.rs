// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderBuiltinVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `gl_FrontFacing` cases of `builtin_var` (`frontfacing`): a VulkanDrawContext draw compared with the
// software rasterizer's picture. The two shader sets are in `shaders/manifest/shader_render_builtin_var.toml` (`frontfacing_simple`, `frontfacing_ubo`).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::shader_render_builtin_var::ALL_SHARED_PROGRAM;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::render_state::FaceType;
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::vector::{UVec4, Vec4};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, make_buffer_create_info, make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::util::draw_util::{
    DrawCallData, FrameBufferState, PipelineState, ReferenceDrawObject, VulkanDrawContext, VulkanProgram, VulkanShader,
    get_primitive_topology_short_name, reference_draw,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FRONTFACE_RENDERWIDTH: u32 = 16;
const FRONTFACE_RENDERHEIGHT: u32 = 16;

/// `FrontFacingVertexShader`
struct FrontFacingVertexShader {
    inputs: [VertexInputInfo; 1],
}

impl VertexShader for FrontFacingVertexShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        &self.inputs
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        &[]
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            // SAFETY: the attribute points at the vertices the test keeps alive across the draw.
            unsafe { read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0) };
            packet.position = position;
        }
    }
}

/// `FrontFacingFragmentShader`
struct FrontFacingFragmentShader {
    outputs: [FragmentOutputInfo; 1],
    ubo_load: bool,
}

impl FragmentShader for FrontFacingFragmentShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        &[]
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        &self.outputs
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        let front = context.visible_face == FaceType::Front;
        let color = match (self.ubo_load, front) {
            (true, true) => Vec4::new(2.0, 2.0, 2.0, 2.0),
            (true, false) => Vec4::new(0.0, 0.0, 0.0, 0.0),
            (false, true) => Vec4::new(1.0, 0.0, 0.0, 1.0),
            (false, false) => Vec4::new(0.0, 1.0, 0.0, 1.0),
        };
        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe {
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(color),
                    )
                };
            }
        }
    }
}

/// `BuiltinGlFrontFacingCase`
struct FrontFacingCase {
    name: &'static str,
    topology: vk::PrimitiveTopology,
    add_ubo_load: bool,
    cull_mode: vk::CullModeFlags,
}

impl TestCase for FrontFacingCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.topology == vk::PrimitiveTopology::TRIANGLE_FAN
            && context.is_device_functionality_supported("VK_KHR_portability_subset")
        {
            let mut features = vk::PhysicalDevicePortabilitySubsetFeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.triangle_fans == vk::FALSE {
                return Err(TestError::NotSupported(
                    "VK_KHR_portability_subset: Triangle fans are not supported by this implementation".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = if self.add_ubo_load {
            "sr_builtin_var_frontfacing_ubo"
        } else {
            "sr_builtin_var_frontfacing_simple"
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FrontFacingInstance {
            context,
            topology: self.topology,
            add_ubo_load: self.add_ubo_load,
            cull_mode: self.cull_mode,
        })
    }
}

/// `BuiltinGlFrontFacingCaseInstance`
struct FrontFacingInstance<'a> {
    context: &'a Context<'a>,
    topology: vk::PrimitiveTopology,
    add_ubo_load: bool,
    cull_mode: vk::CullModeFlags,
}

impl TestInstance for FrontFacingInstance<'_> {
    /// `BuiltinGlFrontFacingCaseInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let vertices = [
            Vec4::new(-0.75, -0.75, 0.0, 1.0),
            Vec4::new(0.0, -0.75, 0.0, 1.0),
            Vec4::new(-0.37, 0.75, 0.0, 1.0),
            Vec4::new(0.37, 0.75, 0.0, 1.0),
            Vec4::new(0.75, -0.75, 0.0, 1.0),
            Vec4::new(0.0, -0.75, 0.0, 1.0),
        ];
        let mut test_desc = format!("gl_FrontFacing {} ", get_primitive_topology_short_name(self.topology));

        let binaries = context.get_binary_collection();
        let shaders = vec![
            VulkanShader {
                stage: vk::ShaderStageFlags::VERTEX,
                binary: binaries.get("vert")?,
            },
            VulkanShader {
                stage: vk::ShaderStageFlags::FRAGMENT,
                binary: binaries.get("frag")?,
            },
        ];

        let uniform_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                std::mem::size_of::<f32>() as vk::DeviceSize,
                vk::BufferUsageFlags::UNIFORM_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { uniform_buffer.get_allocation().get_host_ptr().cast::<f32>().write(1.0) };
        flush_alloc(device, uniform_buffer.get_allocation())?;

        let mut descriptor_set_layout = None;
        let mut descriptor_pool = None;
        let mut descriptor_set = None;
        if self.add_ubo_load {
            let layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT)
                .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
                .build(device)?;
            let pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
                .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let set = make_descriptor_set(device, *pool, *layout)?;
            let buffer_info = make_descriptor_buffer_info(uniform_buffer.get(), 0, vk::WHOLE_SIZE);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    set.get(),
                    Location::binding(0),
                    vk::DescriptorType::UNIFORM_BUFFER,
                    &buffer_info,
                )
                .update(device);
            descriptor_set_layout = Some(layout);
            descriptor_pool = Some(pool);
            descriptor_set = Some(set);
        }

        let framebuffer_state = FrameBufferState::new(FRONTFACE_RENDERWIDTH, FRONTFACE_RENDERHEIGHT);
        let mut pipeline_state =
            PipelineState::new(context.get_device_properties().limits.sub_pixel_precision_bits as i32);
        let draw_call_data = DrawCallData {
            topology: self.topology,
            vertices: &vertices,
        };
        let mut vulkan_program = VulkanProgram::new(shaders);
        if self.add_ubo_load {
            pipeline_state.cull_mode = self.cull_mode;
            vulkan_program.descriptor_set_layout = **descriptor_set_layout.as_ref().expect("made above");
            vulkan_program.descriptor_set = descriptor_set.as_ref().expect("made above").get();
        }
        let mut draw_context = VulkanDrawContext::new(context, &framebuffer_state)?;
        draw_context.register_draw_object(&pipeline_state, &vulkan_program, &draw_call_data)?;
        draw_context.draw()?;
        let _keep_alive = (&descriptor_pool, &uniform_buffer);

        let vertex_shader = FrontFacingVertexShader {
            inputs: [VertexInputInfo {
                type_: Some(GenericVecType::Float),
            }],
        };
        let fragment_shader = FrontFacingFragmentShader {
            outputs: [FragmentOutputInfo {
                type_: Some(GenericVecType::Float),
            }],
            ubo_load: self.add_ubo_load,
        };
        let reference = reference_draw(
            &framebuffer_state,
            &[ReferenceDrawObject {
                pipeline_state: pipeline_state.clone(),
                vertex_shader: &vertex_shader,
                fragment_shader: &fragment_shader,
                draw_call_data,
            }],
        )?;
        let result = draw_context.get_color_pixels()?;

        if int_threshold_position_deviation_compare(
            &reference.get_const_access(),
            &result.get_const_access(),
            UVec4::new(0, 0, 0, 0),
            [1, 1, 0],
            false,
        ) {
            test_desc += "passed";
            Ok(TestStatus::pass(&test_desc))
        } else {
            test_desc += "failed";
            Ok(TestStatus::fail(&test_desc))
        }
    }
}

/// The `frontfacing` group of `createBuiltinVarTests`
pub fn create_front_facing_tests() -> TestCaseGroup {
    const PRIMITIVES: [(&str, vk::PrimitiveTopology); 5] = [
        ("point_list", vk::PrimitiveTopology::POINT_LIST),
        ("line_list", vk::PrimitiveTopology::LINE_LIST),
        ("triangle_list", vk::PrimitiveTopology::TRIANGLE_LIST),
        ("triangle_strip", vk::PrimitiveTopology::TRIANGLE_STRIP),
        ("triangle_fan", vk::PrimitiveTopology::TRIANGLE_FAN),
    ];
    const CULL_MODES: [(&str, vk::CullModeFlags); 4] = [
        ("none", vk::CullModeFlags::NONE),
        ("front", vk::CullModeFlags::FRONT),
        ("back", vk::CullModeFlags::BACK),
        ("front_and_back", vk::CullModeFlags::FRONT_AND_BACK),
    ];

    let mut front_facing_group = TestCaseGroup::new("frontfacing");
    for add_ubo_load in [false, true] {
        let mut type_group = TestCaseGroup::new(if add_ubo_load { "add_ubo_load" } else { "none" });
        for (primitive_name, topology) in PRIMITIVES {
            let mut primitive_group = TestCaseGroup::new(primitive_name);
            if !add_ubo_load {
                primitive_group.add_child(Box::new(FrontFacingCase {
                    name: "simple",
                    topology,
                    add_ubo_load: false,
                    cull_mode: vk::CullModeFlags::NONE,
                }) as Box<dyn TestCase>);
            } else {
                for (cull_name, cull_mode) in CULL_MODES {
                    primitive_group.add_child(Box::new(FrontFacingCase {
                        name: cull_name,
                        topology,
                        add_ubo_load: true,
                        cull_mode,
                    }) as Box<dyn TestCase>);
                }
            }
            type_group.add_child(primitive_group);
        }
        front_facing_group.add_child(type_group);
    }
    front_facing_group
}
