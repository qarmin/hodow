// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationMaxIOTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `max_in_out` writes its GLSL out of the device limits it finds at run time, which cannot be
// committed ahead of time: the programs are pre-expanded for the default limits (128 / 120 / 128 components, what the constructor of
// `MaxIOTest` already uses for its mock programs) in `shaders/manifest/tessellation_max_io.toml` (`scripts/gen_tess_max_io_manifest.py`), and a
// device whose limits cut the interface variables to a different length reports NotPorted. The programs of `level_io` are pre-expanded in
// `shaders/manifest/tessellation_level_io.toml` (`scripts/gen_tess_level_io_manifest.py`).
//
// A control shader writes the tessellation levels (all ones, or zeros) and a per-patch colour, an evaluation shader outputs that colour,
// possibly multiplied by the levels it reads, and two nested quads are checked in an 8x8 target: a patch whose outer level is zero is
// discarded and must leave the clear colour behind.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::tessellation_level_io::*;
use crate::generated::shaders::tessellation_max_io::ALL_SHARED_PROGRAM as MAX_IO_PROGRAMS;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_set, make_framebuffer, make_pipeline_layout,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d, viewport,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 8;
const NUM_VERTICES: u32 = 4;
const NUM_PATCHES: u32 = 2;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `TessReadLevel`; the order is part of the test, as the shaders and the expectation compare against it.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum TessReadLevel {
    ReadsOuter,
    ReadsInner,
    ReadsOuterInner,
    Writes0Inner1,
    Writes0InnerAll,
    Writes0Outer1,
    Writes0OuterAll,
    Writes0OuterInner,
}

/// `LevelIOTest`
struct LevelIoCase {
    name: &'static str,
    tess_read_level: TessReadLevel,
    programs: BinaryCollection,
}

impl TestCase for LevelIoCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if features.multi_viewport == vk::FALSE {
            return Err(TestError::NotSupported("Multiple viewports not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LevelIoInstance {
            context,
            tess_read_level: self.tess_read_level,
        })
    }
}

struct LevelIoInstance<'a> {
    context: &'a Context<'a>,
    tess_read_level: TessReadLevel,
}

/// `commonGenerateReferenceLevel`: `outer` everywhere and `inner` in the middle half of the target.
fn reference_level(outer: [u8; 4], inner: [u8; 4]) -> Vec<u8> {
    let size = RENDER_SIZE as usize;
    let inner_size = size / 2;
    let dist = (size - inner_size) / 2;
    let mut pixels = Vec::with_capacity(size * size * 4);
    for y in 0..size {
        for x in 0..size {
            let in_middle = (dist..dist + inner_size).contains(&x) && (dist..dist + inner_size).contains(&y);
            pixels.extend_from_slice(if in_middle { &inner } else { &outer });
        }
    }
    pixels
}

impl TestInstance for LevelIoInstance<'_> {
    /// `LevelIOTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let color = ImageWithBuffer::new(context, RENDER_SIZE, RENDER_SIZE, COLOR_FORMAT, usage, 4)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let tesc_shader = create_shader_module(device, binaries.get("tesc")?)?;
        let tese_shader = create_shader_module(device, binaries.get("tese")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color.view], RENDER_SIZE, RENDER_SIZE, 1)?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST);
        state.patch_control_points = Some(NUM_VERTICES);
        state.viewports = vec![
            viewport(0.0, 0.0, RENDER_SIZE as f32, RENDER_SIZE as f32, 0.0, 1.0),
            viewport(0.0, 0.0, RENDER_SIZE as f32, (RENDER_SIZE / 2) as f32, 0.0, 1.0),
        ];
        state.scissors = vec![rect_2d(RENDER_SIZE, RENDER_SIZE); 2];
        state.viewport_count = 2;
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0)
            .build();
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader),
                (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_shader),
                (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(cmd, NUM_PATCHES * NUM_VERTICES, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            color.image.get(),
            color.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // default expected color is blue in patch 0 and yellow in patch 1
        let (mut outer, mut inner) = ([0u8, 0, 255, 255], [255u8, 255, 0, 255]);
        // If any of the outer tessellation levels are 0, or all tessellation levels are 0, no output shall be produced which means no color should be expected
        if (TessReadLevel::Writes0Outer1..=TessReadLevel::Writes0OuterInner).contains(&self.tess_read_level) {
            outer = [0; 4];
            inner = [0; 4];
        }
        let reference = reference_level(outer, inner);

        // 1/256 < 0.005 < 2/256
        let result = color.read_bytes(device)?;
        if result.len() != reference.len()
            || result
                .iter()
                .zip(&reference)
                .any(|(&got, &want)| got.abs_diff(want) > 1)
        {
            return Ok(TestStatus::fail("Result does not match reference"));
        }
        Ok(TestStatus::pass("Passed"))
    }
}

const VARS_PER_TYPE: u32 = 10;
const SLOT_SIZE: u32 = 4;
const DEFAULT_LIMITS: TessDeviceLimits = TessDeviceLimits {
    max_tessellation_control_per_vertex_output_components: 128,
    max_tessellation_control_per_patch_output_components: 120,
    max_tessellation_evaluation_per_vertex_input_components: 128,
};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Owner {
    Vertex,
    Patch,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DataType {
    Integer,
    Float,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Interpolation {
    Normal,
    Flat,
}

/// Limits for tessellation control outputs and evaluation shader inputs
#[derive(Clone, Copy)]
struct TessDeviceLimits {
    max_tessellation_control_per_vertex_output_components: u32,
    max_tessellation_control_per_patch_output_components: u32,
    max_tessellation_evaluation_per_vertex_input_components: u32,
}

/// `IfaceVar`: the data side only, the GLSL of a variable is in `shaders/manifest/tessellation_max_io.toml`.
#[derive(Clone, Copy)]
struct IfaceVar {
    owner: Owner,
    data_type: DataType,
    bit_width: u32,
    data_dim: u32,
}

impl IfaceVar {
    fn location_size(&self) -> u32 {
        if self.bit_width == 64 && self.data_dim >= 3 {
            2
        } else {
            1
        }
    }

    fn array_size(&self) -> u32 {
        if self.owner == Owner::Patch {
            NUM_PATCHES
        } else {
            NUM_VERTICES
        }
    }

    fn binding_comp_size(&self) -> u32 {
        let bits = if self.bit_width == 16 || self.bit_width == 64 {
            32
        } else {
            self.bit_width
        };
        bits / 8
    }

    fn element_alignment(&self) -> u32 {
        (if self.data_dim == 3 { 4 } else { self.data_dim }) * self.binding_comp_size()
    }

    fn get_binding_size(&self, owner_type: Owner, size: &mut u32) {
        if self.owner != owner_type {
            return;
        }
        let element_alignment = self.element_alignment();
        let comp_size = self.binding_comp_size();
        for _ in 0..self.array_size() {
            while !(*size).is_multiple_of(element_alignment) {
                *size += 1;
            }
            for _ in 1..=self.data_dim {
                *size += comp_size;
            }
        }
        while !(*size).is_multiple_of(element_alignment) {
            *size += 1;
        }
    }

    fn init_binding(&self, owner_type: Owner, data: &mut [u8], offset: &mut u32, start_value: u32) {
        if self.owner != owner_type {
            return;
        }
        let element_alignment = self.element_alignment();
        let comp_size = self.binding_comp_size() as usize;
        let float_suffixes = [0.25f32, 0.50, 0.875, 0.0];
        for _ in 0..self.array_size() {
            while !(*offset).is_multiple_of(element_alignment) {
                *offset += 1;
            }
            for dim_idx in 1..=self.data_dim {
                let fvalue = start_value as f32 + float_suffixes[(dim_idx - 1) as usize];
                // TES is changing float values when assigning in shader so using integer
                let f16value = start_value as f32;
                let bytes = match (self.data_type, self.bit_width) {
                    (DataType::Integer, _) => start_value.to_le_bytes(),
                    (DataType::Float, 16) => f16value.to_le_bytes(),
                    (DataType::Float, _) => fvalue.to_le_bytes(),
                };
                let dest = *offset as usize;
                data[dest..dest + comp_size].copy_from_slice(&bytes[..comp_size]);
                *offset += comp_size as u32;
            }
        }
        while !(*offset).is_multiple_of(element_alignment) {
            *offset += 1;
        }
    }
}

/// `MaxIOTestParams`
struct MaxIoParams {
    tcs_reads: bool,
    tes_reads: bool,
    use_int64: bool,
    use_float64: bool,
    use_int16: bool,
    use_float16: bool,
    iface_vars: Vec<IfaceVar>,
}

/// `getMaxLocations`
fn get_max_locations(limits: &TessDeviceLimits, params: &MaxIoParams, owner: Owner) -> u32 {
    let used_per_vertex_builtin_locations = 2; // Position, TessCoord
    let used_per_patch_builtin_locations = 3; // TessOuter, TessInner and PrimitiveID
    let used_out_color_locations = u32::from(params.tcs_reads);

    let per_vertex_locations = (if params.tes_reads {
        limits.max_tessellation_evaluation_per_vertex_input_components
    } else {
        limits.max_tessellation_control_per_vertex_output_components
    }) / SLOT_SIZE
        - (used_per_vertex_builtin_locations + used_out_color_locations);
    let per_patch_locations =
        limits.max_tessellation_control_per_patch_output_components / SLOT_SIZE - used_per_patch_builtin_locations;

    if owner == Owner::Vertex {
        per_vertex_locations
    } else {
        per_patch_locations
    }
}

/// `getUsableLocations`: the length the vector is cut to (upstream resizes to the index of the last variable that fit).
fn get_usable_locations(limits: &TessDeviceLimits, params: &MaxIoParams) -> usize {
    let mut available_per_vert_locations = get_max_locations(limits, params, Owner::Vertex) as i32;
    let mut available_per_patch_locations = get_max_locations(limits, params, Owner::Patch) as i32;

    let mut vec_end = 0;
    for (i, var) in params.iface_vars.iter().enumerate() {
        let var_size = var.location_size() as i32;
        let available = if var.owner == Owner::Vertex {
            &mut available_per_vert_locations
        } else {
            &mut available_per_patch_locations
        };
        if *available <= 0 || *available - var_size < 0 {
            break;
        }
        *available -= var_size;
        vec_end = i;
    }
    vec_end
}

/// `MaxIOTest`
struct MaxIoCase {
    name: &'static str,
    key: String,
    params: MaxIoParams,
    /// What `getUsableLocations` leaves of the variables with the default limits: the length the shaders were written for.
    default_len: usize,
}

impl TestCase for MaxIoCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if features.multi_viewport == vk::FALSE {
            return Err(TestError::NotSupported("Multiple viewports not supported".to_string()));
        }
        for (required, supported, feature) in [
            (self.params.use_float64, features.shader_float64, "shaderFloat64"),
            (self.params.use_int64, features.shader_int64, "shaderInt64"),
            (self.params.use_int16, features.shader_int16, "shaderInt16"),
        ] {
            if required && supported == vk::FALSE {
                return Err(TestError::NotSupported(format!("{feature} not supported")));
            }
        }

        if self.params.use_float16 || self.params.use_int16 {
            let mut float16_int8 = vk::PhysicalDeviceShaderFloat16Int8Features::default();
            let mut storage16 = vk::PhysicalDevice16BitStorageFeatures::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                    .push_next(&mut float16_int8)
                    .push_next(&mut storage16);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if self.params.use_float16 && float16_int8.shader_float16 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderFloat16 feature not supported".to_string(),
                ));
            }
            if storage16.storage_input_output16 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "storageInputOutput16 feature not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        MAX_IO_PROGRAMS
            .iter()
            .find(|program| program.name == self.key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MaxIoInstance {
            context,
            params: &self.params,
            default_len: self.default_len,
        })
    }
}

struct MaxIoInstance<'a> {
    context: &'a Context<'a>,
    params: &'a MaxIoParams,
    default_len: usize,
}

impl MaxIoInstance<'_> {
    fn find_data_size(vars: &[IfaceVar], owner_type: Owner) -> u32 {
        let mut size = 0;
        for var in vars {
            var.get_binding_size(owner_type, &mut size);
        }
        size
    }

    fn init_data(vars: &[IfaceVar], data: &mut [u8], owner_type: Owner) {
        let mut offset = 0u32;
        let mut rnd = Random::new(1636723398);
        for var in vars {
            let start_value = rnd.get_int(1000, 1231) as u32;
            var.init_binding(owner_type, data, &mut offset, start_value);
        }
    }
}

impl TestInstance for MaxIoInstance<'_> {
    /// `MaxIOTestInstance::iterate` (the constructor's limits and variable cut included)
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        let limits = &context.get_device_properties().limits;
        let real_dev_limits = TessDeviceLimits {
            max_tessellation_control_per_vertex_output_components: limits
                .max_tessellation_control_per_vertex_output_components,
            max_tessellation_control_per_patch_output_components: limits
                .max_tessellation_control_per_patch_output_components,
            max_tessellation_evaluation_per_vertex_input_components: limits
                .max_tessellation_evaluation_input_components,
        };
        let usable = get_usable_locations(&real_dev_limits, self.params);
        if usable != self.default_len {
            return Err(TestError::NotPorted(
                "the device limits leave a different number of interface variables than the 128/120/128 components the shaders were written for"
                    .to_string(),
            ));
        }
        let vars = &self.params.iface_vars[..usable];

        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let color = ImageWithBuffer::new(context, RENDER_SIZE, RENDER_SIZE, COLOR_FORMAT, usage, 4)?;

        let buf_stages = vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION;
        let mut buffers = Vec::new();
        for owner_type in [Owner::Vertex, Owner::Patch] {
            let data_size = Self::find_data_size(vars, owner_type);
            if data_size != 0 {
                let mut data = vec![0u8; data_size as usize];
                Self::init_data(vars, &mut data, owner_type);
                let buffer = create_host_buffer(context, &data, vk::BufferUsageFlags::STORAGE_BUFFER)?;
                buffers.push((buffer, vk::DeviceSize::from(data_size)));
            }
        }

        let mut set_layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in &buffers {
            set_layout_builder = set_layout_builder.add_single_binding(vk::DescriptorType::STORAGE_BUFFER, buf_stages);
        }
        let set_layout = set_layout_builder.build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, buffers.len() as u32)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let mut update_builder = DescriptorSetUpdateBuilder::new();
        for (binding_idx, (buffer, data_size)) in buffers.iter().enumerate() {
            let buffer_info = vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: *data_size,
            };
            update_builder = update_builder.write_single(
                descriptor_set.get(),
                Location::binding(binding_idx as u32),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer_info,
            );
        }
        update_builder.update(device);

        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

        let binaries = context.get_binary_collection();
        let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
        let tesc_shader = create_shader_module(device, binaries.get("tesc")?)?;
        let tese_shader = create_shader_module(device, binaries.get("tese")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color.view], RENDER_SIZE, RENDER_SIZE, 1)?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST);
        state.patch_control_points = Some(NUM_VERTICES);
        state.viewports = vec![
            viewport(0.0, 0.0, RENDER_SIZE as f32, RENDER_SIZE as f32, 0.0, 1.0),
            viewport(0.0, 0.0, RENDER_SIZE as f32, (RENDER_SIZE / 2) as f32, 0.0, 1.0),
        ];
        state.scissors = vec![rect_2d(RENDER_SIZE, RENDER_SIZE); 2];
        state.viewport_count = 2;
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0)
            .build();
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_shader),
                (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_shader),
                (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, NUM_PATCHES * NUM_VERTICES, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
        copy_image_to_buffer(
            device,
            cmd,
            color.image.get(),
            color.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // default expected color is blue in patch 0 and yellow in patch 1
        let reference = reference_level([0, 0, 255, 255], [255, 255, 0, 255]);

        // 1/256 < 0.005 < 2/256
        let result = color.read_bytes(device)?;
        if result.len() != reference.len()
            || result
                .iter()
                .zip(&reference)
                .any(|(&got, &want)| got.abs_diff(want) > 1)
        {
            return Ok(TestStatus::fail(
                "Result does not match reference; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `max_in_out` group of `createTessIOTests`.
fn create_max_in_out_tests() -> TestCaseGroup {
    // i64, f64, i16, f16, name
    let required_features = [
        (false, false, false, false, "32_bits_only"),
        (true, false, false, false, "with_i64"),
        (false, true, false, false, "with_f64"),
        (true, true, false, false, "all_but_16_bits"),
        (false, false, true, false, "with_i16"),
        (false, false, false, true, "with_f16"),
        (true, true, true, true, "all_types"),
    ];
    // tcs_reads, tes_reads, var type, name
    let tess_types = [
        (false, true, Owner::Vertex, "tcs_vert_writes_tes_reads"),
        (true, true, Owner::Vertex, "tcs_vert_writes_reads_tes_reads"),
        (false, false, Owner::Vertex, "tcs_vert_writes_tes_na"),
        (true, false, Owner::Vertex, "tcs_vert_writes_reads_tes_na"),
        (false, true, Owner::Patch, "tcs_patch_writes_tes_reads"),
        (true, true, Owner::Patch, "tcs_patch_writes_reads_tes_reads"),
        (false, false, Owner::Patch, "tcs_patch_writes_tes_na"),
        (true, false, Owner::Patch, "tcs_patch_writes_reads_tes_na"),
    ];
    const PERMUTATIONS: u32 = 10;

    let mut rnd = Random::new(1636723398);
    let mut in_out_tests = TestCaseGroup::new("max_in_out");
    for (i64, f64, i16, f16, reqs_name) in required_features {
        let mut reqs_group = TestCaseGroup::new(reqs_name);

        // Generate the variable list according to the group requirements
        let mut vert_vars = Vec::new();
        let mut patch_vars = Vec::new();
        for owner_case in [Owner::Vertex, Owner::Patch] {
            for data_type_case in [DataType::Float, DataType::Integer] {
                for bit_width_case in [64u32, 32, 16] {
                    for data_dim_case in [1u32, 2, 3, 4] {
                        for interpolation_case in [Interpolation::Normal, Interpolation::Flat] {
                            if data_type_case == DataType::Float {
                                if bit_width_case == 64 && !f64 {
                                    continue;
                                }
                                if bit_width_case == 16 && !f16 {
                                    continue;
                                }
                            } else {
                                if bit_width_case == 64 && !i64 {
                                    continue;
                                }
                                if bit_width_case == 16 && !i16 {
                                    continue;
                                }
                            }
                            if data_type_case == DataType::Integer && interpolation_case == Interpolation::Normal {
                                continue;
                            }
                            if owner_case == Owner::Patch && interpolation_case == Interpolation::Flat {
                                continue;
                            }
                            if data_type_case == DataType::Float
                                && bit_width_case == 64
                                && interpolation_case == Interpolation::Normal
                            {
                                continue;
                            }
                            for _ in 0..VARS_PER_TYPE {
                                let var = IfaceVar {
                                    owner: owner_case,
                                    data_type: data_type_case,
                                    bit_width: bit_width_case,
                                    data_dim: data_dim_case,
                                };
                                if owner_case == Owner::Vertex {
                                    vert_vars.push(var);
                                } else {
                                    patch_vars.push(var);
                                }
                            }
                        }
                    }
                }
            }
        }

        // Generating all permutations of the variables above would mean millions of tests, so some pseudorandom permutations.
        for comb_idx in 0..PERMUTATIONS {
            let mut rnd_group = TestCaseGroup::new(format!("permutation_{comb_idx}"));

            let mut permut_vert_vec = vert_vars.clone();
            rnd.shuffle(&mut permut_vert_vec);
            let mut permut_patch_vec = patch_vars.clone();
            rnd.shuffle(&mut permut_patch_vec);

            for (tcs_reads, tes_reads, tess_var_type, name) in tess_types {
                let params = MaxIoParams {
                    tcs_reads,
                    tes_reads,
                    use_int64: i64,
                    use_float64: f64,
                    use_int16: i16,
                    use_float16: f16,
                    iface_vars: if tess_var_type == Owner::Vertex {
                        permut_vert_vec.clone()
                    } else {
                        permut_patch_vec.clone()
                    },
                };
                let default_len = get_usable_locations(&DEFAULT_LIMITS, &params);
                rnd_group.add_child(Box::new(MaxIoCase {
                    name,
                    key: format!("{reqs_name}_p{comb_idx}_{name}"),
                    params,
                    default_len,
                }) as Box<dyn TestCase>);
            }
            reqs_group.add_child(rnd_group);
        }
        in_out_tests.add_child(reqs_group);
    }
    in_out_tests
}

/// `createTessIOTests`
pub fn create_tess_io_tests() -> TestCaseGroup {
    let mut tess_io_group = TestCaseGroup::new("tess_io");
    tess_io_group.add_child(create_max_in_out_tests());
    let mut level_io_group = TestCaseGroup::new("level_io");

    // test reading of tessellation outer and inner variables from TES
    for (tess_read_level, name, programs) in [
        (
            TessReadLevel::ReadsInner,
            "tes_reads_inner",
            LEVEL_IO_TES_READS_INNER.programs,
        ),
        (
            TessReadLevel::ReadsOuter,
            "tes_reads_outer",
            LEVEL_IO_TES_READS_OUTER.programs,
        ),
        (
            TessReadLevel::ReadsOuterInner,
            "tes_reads_both",
            LEVEL_IO_TES_READS_BOTH.programs,
        ),
    ] {
        level_io_group.add_child(Box::new(LevelIoCase {
            name,
            tess_read_level,
            programs,
        }) as Box<dyn TestCase>);
    }

    // test writing of tessellation outer and inner variables as 0 from TCS
    for (tess_read_level, name, programs) in [
        (
            TessReadLevel::Writes0Outer1,
            "tcs_writes0_outer_1",
            LEVEL_IO_TCS_WRITES0_OUTER_1.programs,
        ),
        (
            TessReadLevel::Writes0OuterAll,
            "tcs_writes0_outer_all",
            LEVEL_IO_TCS_WRITES0_OUTER_ALL.programs,
        ),
        (
            TessReadLevel::Writes0Inner1,
            "tcs_writes0_inner_1",
            LEVEL_IO_TCS_WRITES0_INNER_1.programs,
        ),
        (
            TessReadLevel::Writes0InnerAll,
            "tcs_writes0_inner_all",
            LEVEL_IO_TCS_WRITES0_INNER_ALL.programs,
        ),
        (
            TessReadLevel::Writes0OuterInner,
            "tcs_writes0_outer_inner",
            LEVEL_IO_TCS_WRITES0_OUTER_INNER.programs,
        ),
    ] {
        level_io_group.add_child(Box::new(LevelIoCase {
            name,
            tess_read_level,
            programs,
        }) as Box<dyn TestCase>);
    }

    tess_io_group.add_child(level_io_group);
    tess_io_group
}
