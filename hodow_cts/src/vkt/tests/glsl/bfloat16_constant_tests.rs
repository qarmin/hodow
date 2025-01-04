// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderBFloat16ConstantTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are written by `scripts/gen_bfloat16_constant_manifest.py`
// (`shaders/manifest/shader_bfloat16_constant.toml`). The compute cases run through the compute case of the assembly groups, which takes the specialization constants
// as data of any size and verifies with a function pointer per float type; the vertex and fragment cases draw a triangle fan of seven corners with the constants
// as the specialization of the stage that has them. `tcu::BrainFloat16`, `tcu::FloatE5M2` and `tcu::FloatE4M3` are `fconvert_tests::StorageFloat`. Upstream aligns the
// data of each constant to its type; the compute case packs them, the draw cases align them.

use vulkanalia::prelude::v1_0::*;

use super::fconvert_tests::{StorageFloat, shader_float8_supported};
use crate::generated::shaders::shader_bfloat16_constant::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::spirv_assembly::compute_shader_case::{
    ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SEED: u32 = 13;
const WIDTH: u32 = 64;
const HEIGHT: u32 = 64;
const FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;
const IO_COUNT: usize = 1024;
/// The corners of the fan, counter clockwise, as x and y.
const CORNERS: [[f32; 2]; 7] = [
    [1.0, 1.0],
    [1.0, -1.0],
    [-1.0, -1.0],
    [-1.0, -0.5],
    [-1.0, 0.0],
    [-1.0, 0.5],
    [-1.0, 1.0],
];
/// The constants that are `float` in the shaders; the others have the float type of the case.
const FLOAT32_CONSTANTS: [usize; 5] = [0, 2, 4, 7, 11];

fn read_bits(bytes: &[u8]) -> u64 {
    let mut word = [0u8; 8];
    word[..bytes.len()].copy_from_slice(bytes);
    u64::from_le_bytes(word)
}

/// `BFloat16ComputeInstance::prepareReferenceSet`: the storage bits of 20 values of `float`.
fn reference_set(float: StorageFloat) -> [u64; 20] {
    let mut rnd = Random::new(SEED);
    std::array::from_fn(|_| float.from_f32(((rnd.get_uint32() % 15) as i32 - 7) as f32 / 2.0))
}

/// `asLocalSize`
fn as_local_size(float: StorageFloat, bits: u64) -> u32 {
    (float.to_f32(bits).abs() + 1.0) as u32
}

fn float_of(id: u8) -> StorageFloat {
    match id {
        0 => StorageFloat::Bf16,
        1 => StorageFloat::E5m2,
        _ => StorageFloat::E4m3,
    }
}

/// `BFloat16ComputeInstance::verifyResult`
fn verify_compute<const FLOAT: u8>(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    let float = float_of(FLOAT);
    let reference = reference_set(float);
    let value = |i: usize| float.to_f32(reference[i]);
    let local = |i: usize| float.to_f32(float.from_f32(as_local_size(float, reference[i]) as f32));
    let expected = [
        local(0),
        value(1),
        local(2),
        value(3),
        local(4),
        value(5),
        value(6),
        value(7),
        value(8),
        value(9),
        value(10),
        value(11),
    ];
    let size = float.bytes();
    expected.iter().enumerate().all(|(k, &want)| {
        let bits = read_bits(&outputs[0][k * size..(k + 1) * size]);
        float.to_f32(bits) == want
    })
}

fn compute_spec(float: StorageFloat) -> ComputeShaderSpec {
    let reference = reference_set(float);
    let value = |i: usize| float.to_f32(reference[i]);
    let local = |i: usize| as_local_size(float, reference[i]).to_le_bytes().to_vec();
    let element = |i: usize| reference[i].to_le_bytes()[..float.bytes()].to_vec();
    let io_bytes = IO_COUNT * 4 * float.bytes();

    let mut spec = ComputeShaderSpec {
        num_work_groups: [1, 1, 1],
        verify_io: Some(match float {
            StorageFloat::Bf16 => verify_compute::<0>,
            StorageFloat::E5m2 => verify_compute::<1>,
            StorageFloat::E4m3 => verify_compute::<2>,
        }),
        ..Default::default()
    };
    spec.spec_constants = vec![
        local(0),
        element(1),
        local(2),
        element(3),
        local(4),
        element(5),
        element(6),
        value(7).to_le_bytes().to_vec(),
        element(8),
        element(9),
        element(10),
        value(11).to_le_bytes().to_vec(),
    ];
    spec.inputs = vec![vec![0u8; io_bytes]; 2];
    spec.outputs = vec![vec![0u8; io_bytes]];
    spec
}

/// `BFloat16VertexInstance` and `BFloat16FragmentInstance`: the 14 constants are the coordinates of the corners; the shader writes them to the buffer and the vertex
/// shader draws the fan from what it wrote, while the fragment shader colours every triangle by its primitive id.
fn graphics_pass(context: &Context<'_>, float: StorageFloat, fragment: bool) -> TestOutcome {
    let device = context.get_device();
    let bytes = float.bytes();
    let stage = if fragment {
        vk::ShaderStageFlags::FRAGMENT
    } else {
        vk::ShaderStageFlags::VERTEX
    };

    let vertex_bits: Vec<u64> = CORNERS.iter().flatten().map(|&v| float.from_f32(v)).collect();
    let vertex_values: Vec<f32> = vertex_bits.iter().map(|&bits| float.to_f32(bits)).collect();
    let vertex_count = vertex_values.len() / 2;

    let io_size = (IO_COUNT * 4 * bytes) as vk::DeviceSize;
    let io_usage =
        vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
    let make_io_buffer = || {
        BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(io_size, io_usage),
            MemoryRequirement::HOST_VISIBLE,
        )
    };
    let in_buffer_x = make_io_buffer()?;
    let in_buffer_y = make_io_buffer()?;
    let out_buffer_z = make_io_buffer()?;

    let vertex_data: Vec<[f32; 4]> = if fragment {
        (0..vertex_count)
            .map(|i| [vertex_values[2 * i], vertex_values[2 * i + 1], 0.0, 1.0])
            .collect()
    } else {
        vec![[0.0; 4]; vertex_count]
    };
    let vertex_buffer = create_host_buffer(context, &vertex_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    let desc_type = vk::DescriptorType::STORAGE_BUFFER;
    let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 3).build(
        device,
        vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
        1,
    )?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(desc_type, stage)
        .add_single_binding(desc_type, stage)
        .add_single_binding(desc_type, stage)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
    let info_x = make_descriptor_buffer_info(in_buffer_x.get(), 0, io_size);
    let info_y = make_descriptor_buffer_info(in_buffer_y.get(), 0, io_size);
    let info_z = make_descriptor_buffer_info(out_buffer_z.get(), 0, io_size);
    DescriptorSetUpdateBuilder::new()
        .write_single(descriptor_set.get(), Location::binding(0), desc_type, &info_x)
        .write_single(descriptor_set.get(), Location::binding(1), desc_type, &info_y)
        .write_single(descriptor_set.get(), Location::binding(2), desc_type, &info_z)
        .update(device);

    let attachment = ImageWithBuffer::new(
        context,
        WIDTH,
        HEIGHT,
        FORMAT,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        16,
    )?;
    let render_pass = make_color_render_pass(
        device,
        FORMAT,
        vk::AttachmentLoadOp::CLEAR,
        vk::AttachmentStoreOp::STORE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*attachment.view], WIDTH, HEIGHT, 1)?;

    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let mut entries = Vec::new();
    let mut data: Vec<u8> = Vec::new();
    for (id, &bits) in vertex_bits.iter().enumerate() {
        let (element, size) = if FLOAT32_CONSTANTS.contains(&id) {
            (vertex_values[id].to_le_bytes().to_vec(), 4)
        } else {
            (bits.to_le_bytes()[..bytes].to_vec(), bytes)
        };
        while data.len() % size != 0 {
            data.push(0);
        }
        entries.push(vk::SpecializationMapEntry {
            constant_id: id as u32,
            offset: data.len() as u32,
            size,
        });
        data.extend(element);
    }

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_FAN).with_full_viewport(WIDTH, HEIGHT);
    if fragment {
        state = state.with_position_input();
    }
    state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .line_width(1.0)
        .build();
    state.specialization = Some((entries, data));
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_shader),
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
        .render_area(rect_2d(WIDTH, HEIGHT))
        .clear_values(&clear_values);
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_draw(cmd, vertex_count as u32, 1, 0, 0);
        device.cmd_end_render_pass(cmd);
    }
    copy_image_to_buffer(
        device,
        cmd,
        attachment.image.get(),
        attachment.buffer.get(),
        WIDTH,
        HEIGHT,
    );
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, out_buffer_z.get_allocation())?;
    let z_bytes = unsafe { std::slice::from_raw_parts(out_buffer_z.get_allocation().get_host_ptr(), io_size as usize) };
    let pixels = attachment.read_bytes(device)?;

    let barycentrum_color = |a: [f32; 2], b: [f32; 2], c: [f32; 2]| -> [f32; 4] {
        let fx = (a[0] + b[0] + c[0]) / 3.0;
        let fy = (a[1] + b[1] + c[1]) / 3.0;
        let ix = (((fx + 1.0) / 2.0) * WIDTH as f32) as usize;
        let iy = (((fy + 1.0) / 2.0) * HEIGHT as f32) as usize;
        let offset = (iy * WIDTH as usize + ix) * 16;
        std::array::from_fn(|k| {
            f32::from_le_bytes([
                pixels[offset + k * 4],
                pixels[offset + k * 4 + 1],
                pixels[offset + k * 4 + 2],
                pixels[offset + k * 4 + 3],
            ])
        })
    };

    let mut triangles = 0u32;
    for i in 0..vertex_values.len() {
        let reference = vertex_values[i];
        let out = float.to_f32(read_bits(&z_bytes[(i * 4 + 1) * bytes..(i * 4 + 2) * bytes]));
        if reference != out {
            return Ok(TestStatus::fail(format!(
                "Constant {i} was {out} in the output buffer, expected {reference}"
            )));
        }

        if i >= 5 && i % 2 == 1 {
            triangles += 1;
            let a = [vertex_values[0], vertex_values[1]];
            let b = [vertex_values[i - 1], vertex_values[i]];
            let c = [vertex_values[i - 3], vertex_values[i - 2]];
            let expected = if fragment {
                let d = triangles as f32;
                [d, d, d, 1.0]
            } else {
                [1.0; 4]
            };
            let color = barycentrum_color(a, b, c);
            if color != expected {
                return Ok(TestStatus::fail(format!(
                    "Triangle {triangles} is {color:?} at its barycentrum, expected {expected:?}"
                )));
            }
        }
    }

    if vertex_count as u32 - 2 == triangles {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Unexpected number of triangles"))
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Stage {
    Compute,
    Vertex,
    Fragment,
}

struct ConstantCase {
    name: String,
    stage: Stage,
    float: StorageFloat,
}

impl TestCase for ConstantCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `BFloat16ConstantCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let mut spec = ComputeShaderSpec::default();
        spec.features.push(RequiredFeature::StorageBuffer16BitAccess);
        if self.float == StorageFloat::Bf16 {
            spec.features.push(RequiredFeature::BFloat16Type);
        }
        let features_case = SpvAsmComputeShaderCase {
            name: self.name.clone(),
            spec,
            programs: BinaryCollection::new(&[]),
        };
        features_case.check_support(context)?;
        if self.float != StorageFloat::Bf16 && !shader_float8_supported(context) {
            return Err(TestError::NotSupported(
                "shaderFloat8 not supported by device".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == self.name)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConstantInstance {
            context,
            stage: self.stage,
            float: self.float,
            programs: self.programs(),
        })
    }
}

struct ConstantInstance<'a> {
    context: &'a Context<'a>,
    stage: Stage,
    float: StorageFloat,
    programs: BinaryCollection,
}

impl TestInstance for ConstantInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.stage {
            Stage::Compute => {
                let case = SpvAsmComputeShaderCase {
                    name: String::new(),
                    spec: compute_spec(self.float),
                    programs: self.programs,
                };
                case.create_instance(self.context).iterate()
            }
            Stage::Vertex => graphics_pass(self.context, self.float, false),
            Stage::Fragment => graphics_pass(self.context, self.float, true),
        }
    }
}

/// `createBFloat16ConstantTests`
pub fn create_bfloat16_constant_tests() -> TestCaseGroup {
    let mut constant = TestCaseGroup::new("constant");
    for (suffix, float) in [
        ("bf16", StorageFloat::Bf16),
        ("fe5m2", StorageFloat::E5m2),
        ("fe4m3", StorageFloat::E4m3),
    ] {
        for (prefix, stage) in [
            ("compute", Stage::Compute),
            ("vertex", Stage::Vertex),
            ("fragment", Stage::Fragment),
        ] {
            constant.add_child(Box::new(ConstantCase {
                name: format!("{prefix}{suffix}"),
                stage,
                float,
            }) as Box<dyn TestCase>);
        }
    }
    constant
}
