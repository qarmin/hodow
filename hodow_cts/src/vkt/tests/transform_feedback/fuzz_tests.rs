// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackFuzzLayoutCase.cpp (InterfaceBlockCaseInstance)
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackFuzzLayoutTests.cpp (createTransformFeedbackFuzzLayoutTests)
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackRandomLayoutCase.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The interface blocks, the random generator of the `random_*` groups, `computeXfbLayout`, the reference values and the
// shaders (which `InterfaceBlockCase::delayedInit` builds at run time) are produced by scripts/gen_xfb_fuzz_cases.py and listed in `fuzz_cases.rs`: the buffer
// bindings, the components `validateValues` compares and the programs. This file only draws one point and compares what was captured.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1};

use super::fuzz_cases::FUZZ_CASES;
use super::simple_pipeline::{XfbPipelineOptions, XfbStages, make_xfb_pipeline};
use super::simple_tests::{make_attachmentless_render_pass, zero_clear_value};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 256;

const KIND_FLOAT: u8 = 0;
const KIND_DOUBLE: u8 = 1;
const KIND_INT: u8 = 2;

/// One case of `fuzz_cases.rs`.
pub struct FuzzCaseDef {
    /// the dotted path below `fuzz`
    pub name: &'static str,
    pub geometry: bool,
    pub locations_required: u32,
    pub uses_float64: bool,
    pub tf_offsets: &'static [u64],
    pub tf_sizes: &'static [u64],
    pub data_size: u32,
    /// (byte offset in the buffer, kind, expected value)
    pub checks: &'static [(u32, u8, i32)],
    pub programs: &'static SharedProgram,
}

struct FuzzCase {
    name: &'static str,
    def: &'static FuzzCaseDef,
}

impl TestCase for FuzzCase {
    fn name(&self) -> &str {
        self.name
    }

    /// The constructor checks of `InterfaceBlockCaseInstance`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let def = self.def;
        let not_supported = |message: String| Err(TestError::NotSupported(message));

        context.require_device_functionality("VK_EXT_transform_feedback")?;

        let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut xfb_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if xfb_features.transform_feedback == vk::FALSE {
            return not_supported("transformFeedback feature is not supported".to_string());
        }

        let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };

        if (xfb_properties.max_transform_feedback_buffers as usize) < def.tf_sizes.len() {
            return not_supported(format!(
                "maxTransformFeedbackBuffers={} is less than required ({})",
                xfb_properties.max_transform_feedback_buffers,
                def.tf_sizes.len()
            ));
        }
        if (xfb_properties.max_transform_feedback_buffer_data_size as u64) < def.data_size as u64 {
            return not_supported(format!(
                "maxTransformFeedbackBufferDataSize={} is less than required ({})",
                xfb_properties.max_transform_feedback_buffer_data_size, def.data_size
            ));
        }

        let components_per_location = 4u32;
        let components_required = def.locations_required * components_per_location + 7; // 7 for the built-in components
        let limits = &context.get_device_properties().limits;
        if !def.geometry && limits.max_vertex_output_components < components_required {
            return not_supported(format!(
                "maxVertexOutputComponents={} is less than required ({components_required})",
                limits.max_vertex_output_components
            ));
        }
        if def.geometry {
            if context.get_device_features().geometry_shader == vk::FALSE {
                return not_supported("Missing feature: geometryShader".to_string());
            }
            if limits.max_geometry_output_components < components_required {
                return not_supported(format!(
                    "maxGeometryOutputComponents={} is less than required ({components_required})",
                    limits.max_geometry_output_components
                ));
            }
        }

        if def.uses_float64 && context.get_device_features().shader_float64 == vk::FALSE {
            return not_supported("shaderFloat64 feature is not supported".to_string());
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.def.programs.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FuzzInstance { context, def: self.def })
    }
}

/// `InterfaceBlockCaseInstance`
struct FuzzInstance<'a> {
    context: &'a Context<'a>,
    def: &'static FuzzCaseDef,
}

impl TestInstance for FuzzInstance<'_> {
    /// `InterfaceBlockCaseInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let def = self.def;
        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(vk, binaries.get("vert")?)?;
        let geom_module = if def.geometry {
            Some(create_shader_module(vk, binaries.get("geom")?)?)
        } else {
            None
        };
        let render_pass = make_attachmentless_render_pass(vk)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk, &[])?;
        let stages = XfbStages {
            vert: *vert_module,
            geom: geom_module.as_ref().map(|module| **module),
            ..XfbStages::default()
        };
        let pipeline = make_xfb_pipeline(
            vk,
            *pipeline_layout,
            *render_pass,
            &stages,
            (RENDER_SIZE, RENDER_SIZE),
            0,
            &XfbPipelineOptions::default(),
        )?;
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();

        let data_size = def.data_size as usize;
        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                data_size as u64,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let binding_count = def.tf_offsets.len();
        let tf_buf_bindings = vec![tf_buf.get(); binding_count];

        unsafe { std::ptr::write_bytes(tf_buf.get_allocation().get_host_ptr(), 0, data_size) };
        flush_alloc(vk, tf_buf.get_allocation())?;

        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );

        begin_command_buffer(vk, cmd)?;
        {
            begin_render_pass(
                vk,
                cmd,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, RENDER_SIZE, RENDER_SIZE),
                zero_clear_value(),
            );
            unsafe {
                vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                vk.cmd_bind_transform_feedback_buffers_ext(cmd, 0, &tf_buf_bindings, def.tf_offsets, def.tf_sizes);

                (vk.commands().cmd_begin_transform_feedback_ext)(cmd, 0, 0, std::ptr::null(), std::ptr::null());
                vk.cmd_draw(cmd, 1, 1, 0, 0);
                (vk.commands().cmd_end_transform_feedback_ext)(cmd, 0, 0, std::ptr::null(), std::ptr::null());
            }
            end_render_pass(vk, cmd);

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[tf_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(vk, cmd)?;
        submit_commands_and_wait(vk, queue, cmd)?;

        invalidate_alloc(vk, tf_buf.get_allocation())?;
        let received =
            unsafe { std::slice::from_raw_parts(tf_buf.get_allocation().get_host_ptr().cast_const(), data_size) };

        match validate_values(def, received) {
            Some(message) => Err(TestError::Fail(message)),
            None => Ok(TestStatus::pass("Pass")),
        }
    }
}

/// `InterfaceBlockCaseInstance::validateValues`, with the per-entry loops flattened into `checks`
fn validate_values(def: &FuzzCaseDef, received: &[u8]) -> Option<String> {
    for &(offset, kind, expected) in def.checks {
        let offset = offset as usize;
        let mismatch = match kind {
            KIND_DOUBLE => {
                let value = f64::from_ne_bytes(received[offset..offset + 8].try_into().expect("8 bytes"));
                ((value - expected as f64).abs() > 0.05).then(|| value.to_string())
            }
            KIND_FLOAT => {
                let value = f32::from_ne_bytes(received[offset..offset + 4].try_into().expect("4 bytes"));
                ((value - expected as f32).abs() > 0.05).then(|| value.to_string())
            }
            KIND_INT => {
                let value = i32::from_ne_bytes(received[offset..offset + 4].try_into().expect("4 bytes"));
                (value != expected).then(|| value.to_string())
            }
            _ => {
                let value = u32::from_ne_bytes(received[offset..offset + 4].try_into().expect("4 bytes"));
                (value != expected as u32).then(|| value.to_string())
            }
        };
        if let Some(value) = mismatch {
            log::info!("Mismatch at offset {offset} expected {expected} received {value}");
            return Some(format!(
                "Mismatch at offset {offset} expected {expected} received {value}"
            ));
        }
    }
    None
}

/// A group under construction. Cases only sit in the innermost group, as upstream's `vertex`/`geometry` ones do.
struct Node {
    name: String,
    groups: Vec<Node>,
    cases: Vec<FuzzCase>,
}

impl Node {
    fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),
            groups: Vec::new(),
            cases: Vec::new(),
        }
    }

    /// Adds a case below `path`, reusing the last group when it has the name: upstream registers every group's cases back to back.
    fn insert(&mut self, path: &[&'static str], case: FuzzCase) {
        let Some((first, rest)) = path.split_first() else {
            self.cases.push(case);
            return;
        };
        if self.groups.last().is_none_or(|g| g.name != *first) {
            self.groups.push(Node::new(first));
        }
        self.groups.last_mut().expect("just pushed").insert(rest, case);
    }

    fn into_group(self) -> TestCaseGroup {
        let mut group = TestCaseGroup::new(self.name);
        for child in self.groups {
            group.add_child(child.into_group());
        }
        for case in self.cases {
            group.add_child(Box::new(case) as Box<dyn TestCase>);
        }
        group
    }
}

/// `createTransformFeedbackFuzzLayoutTests` - the `fuzz` group.
pub fn create_transform_feedback_fuzz_layout_tests() -> TestCaseGroup {
    let mut root = Node::new("fuzz");
    for def in FUZZ_CASES {
        let mut path: Vec<&'static str> = def.name.split('.').collect();
        let name = path.pop().expect("a case has a name");
        root.insert(&path, FuzzCase { name, def });
    }
    root.into_group()
}
