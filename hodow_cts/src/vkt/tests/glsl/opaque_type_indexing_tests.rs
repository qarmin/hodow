// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktOpaqueTypeIndexingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The block array (`ubo`, `ssbo`, `ssbo_storage_buffer_decoration`) and `atomic_counter` groups
// are here, over the ShaderExecutor with its extra resources set; the shaders are written by `scripts/gen_shader_executor_programs.py`
// (`opaque_type_indexing_specs`, `opaque_sampler_specs`), whose own `de::Random` gives them the same lookup indices as the ones in `OpaqueCase::new`
// and `SamplerCase::new`. The `sampler` group runs on the vertex, fragment and compute executors, over images of one texel. Upstream runs the
// instance on every queue of the kind; this runs it on the universal queue.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::random::{Random, de_int32_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::shaderexecutor::{
    ScalarKind, ShaderSpec, ShaderType, Symbol, check_support_shader, execute, executor_programs,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NUM_INVOCATIONS: usize = 32;
const NUM_INSTANCES: usize = 4;
const NUM_READS: usize = 4;
const NUM_COUNTERS: usize = 4;
const NUM_OPS: usize = 4;

/// `IndexExprType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum IndexExprType {
    ConstLiteral,
    ConstExpression,
    Uniform,
    DynamicUniform,
}

const INDEXING_TYPES: [(IndexExprType, &str); 4] = [
    (IndexExprType::ConstLiteral, "const_literal"),
    (IndexExprType::ConstExpression, "const_expression"),
    (IndexExprType::Uniform, "uniform"),
    (IndexExprType::DynamicUniform, "dynamically_uniform"),
];

/// The shader types in `glu::ShaderType` order, as `deInt32Hash(m_shaderType)` sees them, with the names of the case and of the executor.
const SHADER_TYPES: [(ShaderType, &str); 6] = [
    (ShaderType::Vertex, "vertex"),
    (ShaderType::Fragment, "fragment"),
    (ShaderType::Geometry, "geometry"),
    (ShaderType::TessellationControl, "tess_ctrl"),
    (ShaderType::TessellationEvaluation, "tess_eval"),
    (ShaderType::Compute, "compute"),
];

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum CaseKind {
    Ubo,
    Ssbo,
    SsboStorageBufferDecoration,
    AtomicCounter,
}

impl CaseKind {
    /// `BlockType`: BLOCKTYPE_UNIFORM is 0, BLOCKTYPE_BUFFER 1.
    fn block_type(self) -> i32 {
        if self == Self::Ubo { 0 } else { 1 }
    }

    fn group_key(self) -> &'static str {
        match self {
            Self::Ubo => "ubo",
            Self::Ssbo => "ssbo",
            Self::SsboStorageBufferDecoration => "ssbo_storage_buffer_decoration",
            Self::AtomicCounter => "atomic_counter",
        }
    }
}

fn index_expr_ndx(index_expr_type: IndexExprType) -> i32 {
    INDEXING_TYPES
        .iter()
        .position(|(kind, _)| *kind == index_expr_type)
        .expect("an index expression type") as i32
}

fn shader_type_ndx(shader_type: ShaderType) -> i32 {
    SHADER_TYPES
        .iter()
        .position(|(kind, _)| *kind == shader_type)
        .expect("a shader type of the group") as i32
}

struct OpaqueCase {
    name: String,
    kind: CaseKind,
    index_expr_type: IndexExprType,
    shader_type: ShaderType,
    spec: ShaderSpec,
    key: String,
    /// `m_readIndices` or `m_opIndices`
    indices: Vec<i32>,
    /// `m_inValues`, the block cases only
    in_values: Vec<u32>,
}

impl OpaqueCase {
    /// `BlockArrayIndexingCase::createShaderSpec` and `AtomicCounterIndexingCase::createShaderSpec`: the random read indices and values.
    fn new(
        name: String,
        kind: CaseKind,
        index_expr_type: IndexExprType,
        shader_type: ShaderType,
        case_name: &str,
    ) -> Self {
        let index_hash = de_int32_hash(index_expr_ndx(index_expr_type));
        let shader_hash = de_int32_hash(shader_type_ndx(shader_type));
        let (indices, in_values) = if kind == CaseKind::AtomicCounter {
            let mut rnd = Random::new(shader_hash ^ index_hash);
            (
                (0..NUM_OPS).map(|_| rnd.get_int(0, NUM_OPS as i32 - 1)).collect(),
                Vec::new(),
            )
        } else {
            let mut rnd = Random::new(shader_hash ^ de_int32_hash(kind.block_type()) ^ index_hash);
            let indices = (0..NUM_READS)
                .map(|_| rnd.get_int(0, NUM_INSTANCES as i32 - 1))
                .collect();
            let in_values = (0..NUM_INSTANCES).map(|_| rnd.get_uint32()).collect();
            (indices, in_values)
        };

        let count = if kind == CaseKind::AtomicCounter {
            NUM_OPS
        } else {
            NUM_READS
        };
        let inputs: Vec<Symbol> = if index_expr_type == IndexExprType::DynamicUniform {
            (0..count)
                .map(|ndx| Symbol::new(Box::leak(format!("index{ndx}").into_boxed_str()), ScalarKind::Int, 1))
                .collect()
        } else {
            Vec::new()
        };
        let outputs: Vec<Symbol> = (0..count)
            .map(|ndx| Symbol::new(Box::leak(format!("result{ndx}").into_boxed_str()), ScalarKind::Uint, 1))
            .collect();
        let spec = ShaderSpec {
            inputs: inputs.leak(),
            outputs: outputs.leak(),
        };

        Self {
            name,
            kind,
            index_expr_type,
            shader_type,
            spec,
            key: format!("opaque_{}_{case_name}", kind.group_key()),
            indices,
            in_values,
        }
    }
}

impl TestCase for OpaqueCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `OpaqueTypeIndexingCase::checkSupport` and `BlockArrayIndexingCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_shader(context, self.shader_type)?;

        if self.kind != CaseKind::AtomicCounter {
            let mut max_descriptor_storage_buffers = self.in_values.len() as u32;
            if self.shader_type == ShaderType::Compute {
                // From ComputeShaderExecutor class
                max_descriptor_storage_buffers += 2;
            }
            if max_descriptor_storage_buffers
                > context
                    .get_device_properties()
                    .limits
                    .max_per_stage_descriptor_storage_buffers
            {
                return Err(TestError::NotSupported(
                    "Driver supports less maxPerStageDescriptorStorageBuffers than the ones required".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(&self.key, self.shader_type)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OpaqueInstance { context, case: self })
    }
}

struct OpaqueInstance<'a> {
    context: &'a Context<'a>,
    case: &'a OpaqueCase,
}

fn host_buffer<'a>(
    context: &'a Context<'_>,
    size: usize,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size as vk::DeviceSize, usage),
        MemoryRequirement::HOST_VISIBLE,
    )
}

fn write_u32s(context: &Context<'_>, buffer: &BufferWithMemory<'_>, values: &[u32]) -> Result<(), TestError> {
    let bytes: Vec<u8> = values.iter().flat_map(|value| value.to_ne_bytes()).collect();
    unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
    flush_alloc(context.get_device(), buffer.get_allocation())
}

fn to_bytes(values: &[i32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

impl OpaqueInstance<'_> {
    /// `OpaqueTypeIndexingTestInstance::checkSupported`
    fn check_supported(&self, descriptor_type: vk::DescriptorType) -> Result<(), TestError> {
        let features = self.context.get_device_features();
        if !matches!(
            self.case.index_expr_type,
            IndexExprType::ConstLiteral | IndexExprType::ConstExpression
        ) {
            let (supported, what) = match descriptor_type {
                vk::DescriptorType::UNIFORM_BUFFER => {
                    (features.shader_uniform_buffer_array_dynamic_indexing, "uniform buffer")
                }
                vk::DescriptorType::STORAGE_BUFFER => {
                    (features.shader_storage_buffer_array_dynamic_indexing, "storage buffer")
                }
                _ => (vk::TRUE, ""),
            };
            if supported == vk::FALSE {
                return Err(TestError::NotSupported(format!(
                    "Dynamic indexing of {what} arrays is not supported"
                )));
            }
        }
        Ok(())
    }
}

impl TestInstance for OpaqueInstance<'_> {
    /// `BlockArrayIndexingCaseInstance::queuePass` and `AtomicCounterIndexingCaseInstance::queuePass`
    fn iterate(&mut self) -> TestOutcome {
        let case = self.case;
        let context = self.context;
        let device = context.get_device();
        let is_counter = case.kind == CaseKind::AtomicCounter;
        let count = if is_counter { NUM_OPS } else { NUM_READS };
        let descriptor_type = match case.kind {
            CaseKind::Ubo => vk::DescriptorType::UNIFORM_BUFFER,
            _ => vk::DescriptorType::STORAGE_BUFFER,
        };
        let buffer_usage = if descriptor_type == vk::DescriptorType::UNIFORM_BUFFER {
            vk::BufferUsageFlags::UNIFORM_BUFFER
        } else {
            vk::BufferUsageFlags::STORAGE_BUFFER
        };
        let num_bindings = if is_counter { 1 } else { case.in_values.len() };

        if is_counter {
            // Stores and atomic operation support.
            let features = context.get_device_features();
            match case.shader_type {
                ShaderType::Vertex
                | ShaderType::TessellationControl
                | ShaderType::TessellationEvaluation
                | ShaderType::Geometry => {
                    if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
                        return Err(TestError::NotSupported("Stores and atomic operations are not supported in Vertex, Tessellation, and Geometry shader.".to_string()));
                    }
                }
                ShaderType::Fragment if features.fragment_stores_and_atomics == vk::FALSE => {
                    return Err(TestError::NotSupported(
                        "Stores and atomic operations are not supported in fragment shader.".to_string(),
                    ));
                }
                _ => {}
            }
        }
        self.check_supported(descriptor_type)?;
        if case.kind == CaseKind::SsboStorageBufferDecoration
            && !context.is_device_functionality_supported("VK_KHR_storage_buffer_storage_class")
        {
            return Err(TestError::NotSupported(
                "VK_KHR_storage_buffer_storage_class is not supported".to_string(),
            ));
        }

        // \note Using separate buffer per element - might want to test offsets & single buffer in the future.
        let mut buffers = Vec::new();
        if is_counter {
            let buffer = host_buffer(context, std::mem::size_of::<u32>() * NUM_COUNTERS, buffer_usage)?;
            write_u32s(context, &buffer, &[0; NUM_COUNTERS])?;
            buffers.push(buffer);
        } else {
            for &value in &case.in_values {
                let buffer = host_buffer(context, std::mem::size_of::<u32>(), buffer_usage)?;
                write_u32s(context, &buffer, &[value])?;
                buffers.push(buffer);
            }
        }

        let index_binding = num_bindings as u32;
        let index_buffer = if case.index_expr_type == IndexExprType::Uniform {
            let buffer = host_buffer(
                context,
                std::mem::size_of::<i32>() * count,
                vk::BufferUsageFlags::UNIFORM_BUFFER,
            )?;
            let indices: Vec<u32> = case.indices.iter().map(|&index| index as u32).collect();
            write_u32s(context, &buffer, &indices)?;
            Some(buffer)
        } else {
            None
        };

        let extra_resources_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(descriptor_type, vk::ShaderStageFlags::ALL, 0, num_bindings as u32)
            .add_indexed_binding(
                vk::DescriptorType::UNIFORM_BUFFER,
                vk::ShaderStageFlags::ALL,
                index_binding,
                1,
            )
            .build(device)?;
        let extra_resources_set_pool = DescriptorPoolBuilder::new()
            .add_type(descriptor_type, num_bindings as u32)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let extra_resources_set = make_descriptor_set(device, *extra_resources_set_pool, *extra_resources_layout)?;

        {
            let buffer_infos: Vec<vk::DescriptorBufferInfo> = buffers
                .iter()
                .map(|buffer| vk::DescriptorBufferInfo {
                    buffer: buffer.get(),
                    offset: 0,
                    range: vk::WHOLE_SIZE,
                })
                .collect();
            let descriptor_write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: extra_resources_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: buffer_infos.len() as u32,
                descriptor_type,
                image_info: std::ptr::null(),
                buffer_info: buffer_infos.as_ptr(),
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { device.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };
        }
        if let Some(index_buffer) = &index_buffer {
            let buffer_info = vk::DescriptorBufferInfo {
                buffer: index_buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            };
            let descriptor_write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: extra_resources_set.get(),
                dst_binding: index_binding,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::UNIFORM_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: &buffer_info,
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { device.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };
        }

        // The dynamically uniform index of every read, repeated for every invocation, is the input of the shader.
        let input_bytes: Vec<Vec<u8>> = if case.index_expr_type == IndexExprType::DynamicUniform {
            case.indices
                .iter()
                .map(|&index| to_bytes(&[index; NUM_INVOCATIONS]))
                .collect()
        } else {
            Vec::new()
        };
        let input_refs: Vec<&[u8]> = input_bytes.iter().map(|bytes| bytes.as_slice()).collect();
        let mut output_bytes: Vec<Vec<u8>> = (0..count).map(|_| vec![0u8; NUM_INVOCATIONS * 4]).collect();
        {
            let mut output_refs: Vec<&mut [u8]> = output_bytes.iter_mut().map(|bytes| bytes.as_mut_slice()).collect();
            execute(
                context,
                case.shader_type,
                &case.spec,
                Some(*extra_resources_layout),
                NUM_INVOCATIONS,
                &input_refs,
                &mut output_refs,
                Some(extra_resources_set.get()),
            )?;
        }
        let out_values: Vec<u32> = output_bytes
            .iter()
            .flat_map(|bytes| {
                bytes
                    .chunks_exact(4)
                    .map(|chunk| u32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]))
            })
            .collect();

        let mut test_result = TestStatus::pass("Pass");

        if !is_counter {
            for invocation_ndx in 0..NUM_INVOCATIONS {
                for read_ndx in 0..NUM_READS {
                    let ref_value = case.in_values[case.indices[read_ndx] as usize];
                    let res_value = out_values[read_ndx * NUM_INVOCATIONS + invocation_ndx];
                    if ref_value != res_value {
                        log::error!(
                            "ERROR: at invocation {invocation_ndx}, read {read_ndx}: expected {ref_value:#x}, got {res_value:#x}"
                        );
                        if !test_result.is_fail() {
                            test_result = TestStatus::fail("Invalid result value");
                        }
                    }
                }
            }
            return Ok(test_result);
        }

        let mut num_hits = [0usize; NUM_COUNTERS]; // Number of hits per counter.
        let mut result_value_hit_count_maps: Vec<std::collections::BTreeMap<u32, usize>> =
            vec![Default::default(); NUM_COUNTERS];
        for &op_index in &case.indices {
            num_hits[op_index as usize] += 1;
        }

        // Read counter values
        invalidate_alloc(device, buffers[0].get_allocation())?;
        let counter_values: Vec<u32> = (0..NUM_COUNTERS)
            .map(|ndx| unsafe {
                std::ptr::read_unaligned(
                    buffers[0]
                        .get_allocation()
                        .get_host_ptr()
                        .cast_const()
                        .cast::<u32>()
                        .add(ndx),
                )
            })
            .collect();

        // Verify counter values
        for counter_ndx in 0..NUM_COUNTERS {
            let ref_count = (num_hits[counter_ndx] * NUM_INVOCATIONS) as u32;
            let res_count = counter_values[counter_ndx];
            let mut found_invalid_ctr_value = false;

            if res_count < ref_count {
                log::error!(
                    "ERROR: atomic counter {counter_ndx} has value {res_count}, expected value greater than or equal to {ref_count}"
                );
                found_invalid_ctr_value = true;
            } else if ref_count == 0 && res_count != 0 {
                log::error!("ERROR: atomic counter {counter_ndx} has value {res_count}, expected {ref_count}");
                found_invalid_ctr_value = true;
            }

            if found_invalid_ctr_value && !test_result.is_fail() {
                test_result = TestStatus::fail("Invalid atomic counter value");
            }
        }

        // Verify result values from shaders
        for invocation_ndx in 0..NUM_INVOCATIONS {
            for op_ndx in 0..NUM_OPS {
                let counter_ndx = case.indices[op_ndx] as usize;
                let res_value = out_values[op_ndx * NUM_INVOCATIONS + invocation_ndx];
                let range_ok = res_value <= counter_values[counter_ndx];

                *result_value_hit_count_maps[counter_ndx].entry(res_value).or_insert(0) += 1;

                if !range_ok {
                    log::error!(
                        "ERROR: at invocation {invocation_ndx}, op {op_ndx}: got invalid result value {res_value}"
                    );
                    if !test_result.is_fail() {
                        test_result = TestStatus::fail("Invalid result value");
                    }
                }
            }
        }

        for (ctr_idx, hit_count_map) in result_value_hit_count_maps.iter().enumerate() {
            for (value, hits) in hit_count_map {
                if *hits > 1 {
                    log::error!(
                        "ERROR: Duplicate result value from counter {ctr_idx}. Value {value} found {hits} times."
                    );
                    if !test_result.is_fail() {
                        test_result = TestStatus::fail("Invalid result value");
                    }
                }
            }
        }

        Ok(test_result)
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum TextureType {
    Tex1D,
    Tex1DArray,
    Tex2D,
    TexCube,
    Tex2DArray,
    Tex3D,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum ResultKind {
    Float,
    Shadow,
    Int,
    Uint,
}

/// One of the `samplerTypes`: the GLSL name, its index in `glu::DataType` (the hash seeds read it), the texture it samples and the type of a lookup.
#[derive(Clone, Copy)]
struct SamplerType {
    glsl: &'static str,
    type_ndx: i32,
    texture: TextureType,
    result: ResultKind,
}

const fn sampler(glsl: &'static str, type_ndx: i32, texture: TextureType, result: ResultKind) -> SamplerType {
    SamplerType {
        glsl,
        type_ndx,
        texture,
        result,
    }
}

static SAMPLER_TYPES: [SamplerType; 23] = [
    sampler("sampler1D", 44, TextureType::Tex1D, ResultKind::Float),
    sampler("sampler1DArray", 47, TextureType::Tex1DArray, ResultKind::Float),
    sampler("sampler1DArrayShadow", 54, TextureType::Tex1DArray, ResultKind::Shadow),
    sampler("sampler2D", 45, TextureType::Tex2D, ResultKind::Float),
    sampler("samplerCube", 46, TextureType::TexCube, ResultKind::Float),
    sampler("sampler2DArray", 48, TextureType::Tex2DArray, ResultKind::Float),
    sampler("sampler3D", 49, TextureType::Tex3D, ResultKind::Float),
    sampler("sampler1DShadow", 51, TextureType::Tex1D, ResultKind::Shadow),
    sampler("sampler2DShadow", 52, TextureType::Tex2D, ResultKind::Shadow),
    sampler("samplerCubeShadow", 53, TextureType::TexCube, ResultKind::Shadow),
    sampler("sampler2DArrayShadow", 55, TextureType::Tex2DArray, ResultKind::Shadow),
    sampler("isampler1D", 57, TextureType::Tex1D, ResultKind::Int),
    sampler("isampler1DArray", 60, TextureType::Tex1DArray, ResultKind::Int),
    sampler("isampler2D", 58, TextureType::Tex2D, ResultKind::Int),
    sampler("isamplerCube", 59, TextureType::TexCube, ResultKind::Int),
    sampler("isampler2DArray", 61, TextureType::Tex2DArray, ResultKind::Int),
    sampler("isampler3D", 62, TextureType::Tex3D, ResultKind::Int),
    sampler("usampler1D", 64, TextureType::Tex1D, ResultKind::Uint),
    sampler("usampler1DArray", 67, TextureType::Tex1DArray, ResultKind::Uint),
    sampler("usampler2D", 65, TextureType::Tex2D, ResultKind::Uint),
    sampler("usamplerCube", 66, TextureType::TexCube, ResultKind::Uint),
    sampler("usampler2DArray", 68, TextureType::Tex2DArray, ResultKind::Uint),
    sampler("usampler3D", 69, TextureType::Tex3D, ResultKind::Uint),
];

const SAMPLER_NUM_INVOCATIONS: usize = 64;
const NUM_SAMPLERS: usize = 8;
const NUM_LOOKUPS: usize = 4;

impl SamplerType {
    fn is_shadow(&self) -> bool {
        self.result == ResultKind::Shadow
    }

    /// `getSamplerCoordType`, the number of components
    fn coord_count(&self) -> usize {
        let count = match self.texture {
            TextureType::Tex1D => 1,
            TextureType::Tex1DArray | TextureType::Tex2D => 2,
            _ => 3,
        };
        if self.glsl == "sampler1DShadow" {
            3
        } else if self.is_shadow() {
            count + 1
        } else {
            count
        }
    }

    /// `getSamplerOutputType`: the kind and the number of components of a lookup
    fn output(&self) -> (ScalarKind, u32) {
        match self.result {
            ResultKind::Float => (ScalarKind::Float, 4),
            ResultKind::Shadow => (ScalarKind::Float, 1),
            ResultKind::Int => (ScalarKind::Int, 4),
            ResultKind::Uint => (ScalarKind::Uint, 4),
        }
    }

    /// `getSamplerTextureFormat`, with the size of a texel in bytes
    fn texture_format(&self) -> (vk::Format, usize) {
        match self.result {
            ResultKind::Float => (vk::Format::R8G8B8A8_UNORM, 4),
            ResultKind::Shadow => (vk::Format::D16_UNORM, 2),
            ResultKind::Int => (vk::Format::R8G8B8A8_SINT, 4),
            ResultKind::Uint => (vk::Format::R8G8B8A8_UINT, 4),
        }
    }

    fn layers(&self) -> u32 {
        if self.texture == TextureType::TexCube { 6 } else { 1 }
    }
}

struct SamplerCase {
    name: String,
    sampler: SamplerType,
    index_expr_type: IndexExprType,
    shader_type: ShaderType,
    spec: ShaderSpec,
    key: String,
    lookup_indices: Vec<i32>,
}

impl SamplerCase {
    /// `SamplerIndexingCase::createShaderSpec`
    fn new(
        name: String,
        sampler: SamplerType,
        index_expr_type: IndexExprType,
        shader_type: ShaderType,
        shader_name: &str,
        index_expr_name: &str,
    ) -> Self {
        let mut rnd = Random::new(
            de_int32_hash(sampler.type_ndx)
                ^ de_int32_hash(shader_type_ndx(shader_type))
                ^ de_int32_hash(index_expr_ndx(index_expr_type)),
        );
        let lookup_indices = (0..NUM_LOOKUPS)
            .map(|_| rnd.get_int(0, NUM_SAMPLERS as i32 - 1))
            .collect();

        let mut inputs = vec![Symbol::new("coords", ScalarKind::Float, sampler.coord_count() as u32)];
        if index_expr_type == IndexExprType::DynamicUniform {
            inputs.extend(
                (0..NUM_LOOKUPS)
                    .map(|ndx| Symbol::new(Box::leak(format!("index{ndx}").into_boxed_str()), ScalarKind::Int, 1)),
            );
        }
        let (out_kind, out_size) = sampler.output();
        let outputs: Vec<Symbol> = (0..NUM_LOOKUPS)
            .map(|ndx| Symbol::new(Box::leak(format!("result{ndx}").into_boxed_str()), out_kind, out_size))
            .collect();
        let spec = ShaderSpec {
            inputs: inputs.leak(),
            outputs: outputs.leak(),
        };

        let key = format!(
            "opaque_sampler_{index_expr_name}_{shader_name}_{}",
            sampler.glsl.to_lowercase()
        );
        Self {
            name,
            sampler,
            index_expr_type,
            shader_type,
            spec,
            key,
            lookup_indices,
        }
    }
}

impl TestCase for SamplerCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `OpaqueTypeIndexingCase::checkSupport` and `SamplerIndexingCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_shader(context, self.shader_type)?;

        // VUID-VkImageCreateInfo-imageCreateMaxMipLevels-02251
        if matches!(self.sampler.glsl, "sampler1DShadow" | "sampler1DArrayShadow") {
            let result = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    vk::Format::D16_UNORM,
                    vk::ImageType::_1D,
                    vk::ImageTiling::OPTIMAL,
                    vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if result == Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
                return Err(TestError::NotSupported(
                    "VK_FORMAT_D16_UNORM with VK_IMAGE_TYPE_1D not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(&self.key, self.shader_type)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SamplerInstance { context, case: self })
    }
}

struct SamplerInstance<'a> {
    context: &'a Context<'a>,
    case: &'a SamplerCase,
}

/// `TestImage`: an image of one texel and no mipmaps, filled with one colour in every layer
struct TestImage<'a> {
    view: Unique<'a, vk::ImageView>,
    _image: ImageWithMemory<'a>,
}

impl<'a> TestImage<'a> {
    fn new(context: &'a Context<'a>, sampler: &SamplerType, color: &[u8]) -> Result<Self, TestError> {
        let device = context.get_device();
        let (format, pixel_size) = sampler.texture_format();
        let layers = sampler.layers();
        let is_depth = sampler.is_shadow();
        let aspect = if is_depth {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::COLOR
        };

        let (image_type, view_type) = match sampler.texture {
            TextureType::Tex1D => (vk::ImageType::_1D, vk::ImageViewType::_1D),
            TextureType::Tex1DArray => (vk::ImageType::_1D, vk::ImageViewType::_1D_ARRAY),
            TextureType::Tex2D => (vk::ImageType::_2D, vk::ImageViewType::_2D),
            TextureType::Tex2DArray => (vk::ImageType::_2D, vk::ImageViewType::_2D_ARRAY),
            TextureType::TexCube => (vk::ImageType::_2D, vk::ImageViewType::CUBE),
            TextureType::Tex3D => (vk::ImageType::_3D, vk::ImageViewType::_3D),
        };
        let image_info = vk::ImageCreateInfo::builder()
            .flags(if sampler.texture == TextureType::TexCube {
                vk::ImageCreateFlags::CUBE_COMPATIBLE
            } else {
                vk::ImageCreateFlags::empty()
            })
            .image_type(image_type)
            .format(format)
            .extent(vk::Extent3D {
                width: 1,
                height: 1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        let range = make_image_subresource_range(aspect, 0, 1, 0, layers);
        let view_info = vk::ImageViewCreateInfo::builder()
            .image(image.get())
            .view_type(view_type)
            .format(format)
            .components(vk::ComponentMapping {
                r: vk::ComponentSwizzle::IDENTITY,
                g: vk::ComponentSwizzle::IDENTITY,
                b: vk::ComponentSwizzle::IDENTITY,
                a: vk::ComponentSwizzle::IDENTITY,
            })
            .subresource_range(range);
        let view = Unique::new(
            device,
            unsafe { device.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
        );

        // The staging buffer holds the colour once per layer.
        let staging_size = pixel_size * layers as usize;
        let staging = host_buffer(context, staging_size, vk::BufferUsageFlags::TRANSFER_SRC)?;
        let bytes: Vec<u8> = (0..layers).flat_map(|_| color.iter().copied()).collect();
        unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), staging.get_allocation().get_host_ptr(), bytes.len()) };
        flush_alloc(device, staging.get_allocation())?;

        let queue_family_index = context.get_universal_queue_family_index();
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            let pre = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image.get(),
                range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre],
            );
            let copy = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 1,
                buffer_image_height: 1,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: aspect,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: layers,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: 1,
                    height: 1,
                    depth: 1,
                },
            };
            device.cmd_copy_buffer_to_image(
                cmd,
                staging.get(),
                image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[copy],
            );
            let post = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                image.get(),
                range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        Ok(Self { view, _image: image })
    }
}

impl TestInstance for SamplerInstance<'_> {
    /// `SamplerIndexingCaseInstance::queuePass`
    fn iterate(&mut self) -> TestOutcome {
        let case = self.case;
        let context = self.context;
        let device = context.get_device();
        let sampler_type = &case.sampler;
        let shadow = sampler_type.is_shadow();
        let num_coord_comps = sampler_type.coord_count();
        let (out_kind, out_size) = sampler_type.output();
        let (_, pixel_size) = sampler_type.texture_format();
        let out_lookup_stride = SAMPLER_NUM_INVOCATIONS * out_size as usize;
        let mut rnd = Random::new(
            de_int32_hash(sampler_type.type_ndx)
                ^ de_int32_hash(shader_type_ndx(case.shader_type))
                ^ de_int32_hash(index_expr_ndx(case.index_expr_type)),
        );
        let is_integer = matches!(sampler_type.result, ResultKind::Int | ResultKind::Uint);

        // checkSupported
        if !matches!(
            case.index_expr_type,
            IndexExprType::ConstLiteral | IndexExprType::ConstExpression
        ) && context
            .get_device_features()
            .shader_sampled_image_array_dynamic_indexing
            == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Dynamic indexing of sampler arrays is not supported".to_string(),
            ));
        }

        let mut coords = vec![0f32; SAMPLER_NUM_INVOCATIONS * num_coord_comps];
        if sampler_type.texture == TextureType::TexCube {
            let comps = if shadow { 4 } else { 3 };
            for texel in coords.chunks_mut(comps) {
                texel[0] = 1.0;
            }
        }
        if shadow {
            // Use different comparison value per invocation. \note Texture uses odd values, comparison even values.
            let cmp_values = [0.0f32, 0.2, 0.4, 0.6, 0.8, 1.0];
            for invocation_ndx in 0..SAMPLER_NUM_INVOCATIONS {
                coords[invocation_ndx * num_coord_comps + (num_coord_comps - 1)] = *rnd.choose(&cmp_values);
            }
        }

        // fillTextureData
        let mut tex_data = vec![0u8; NUM_SAMPLERS * pixel_size];
        if shadow {
            // \note Texture uses odd values, lookup even values to avoid precision issues.
            let values = [0.1f32, 0.3, 0.5, 0.7, 0.9];
            for ndx in 0..NUM_SAMPLERS {
                let value = *rnd.choose(&values);
                let unorm = (value * 65535.0 + 0.5).floor() as u16;
                tex_data[ndx * 2..ndx * 2 + 2].copy_from_slice(&unorm.to_le_bytes());
            }
        } else {
            for ndx in 0..NUM_SAMPLERS {
                tex_data[ndx * 4..ndx * 4 + 4].copy_from_slice(&rnd.get_uint32().to_ne_bytes());
            }
        }

        let filter = if shadow || is_integer {
            vk::Filter::NEAREST
        } else {
            vk::Filter::LINEAR
        };
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(filter)
            .min_filter(filter)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(shadow)
            .compare_op(if shadow {
                vk::CompareOp::LESS
            } else {
                vk::CompareOp::ALWAYS
            })
            .min_lod(0.0)
            .max_lod(0.25)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);

        let mut images = Vec::new();
        let mut samplers = Vec::new();
        for ndx in 0..NUM_SAMPLERS {
            images.push(TestImage::new(
                context,
                sampler_type,
                &tex_data[ndx * pixel_size..(ndx + 1) * pixel_size],
            )?);
            samplers.push(Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
            ));
        }

        let index_buffer = if case.index_expr_type == IndexExprType::Uniform {
            let buffer = host_buffer(
                context,
                std::mem::size_of::<i32>() * NUM_LOOKUPS,
                vk::BufferUsageFlags::UNIFORM_BUFFER,
            )?;
            let indices: Vec<u32> = case.lookup_indices.iter().map(|&index| index as u32).collect();
            write_u32s(context, &buffer, &indices)?;
            Some(buffer)
        } else {
            None
        };

        let extra_resources_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::ALL,
                0,
                NUM_SAMPLERS as u32,
            )
            .add_indexed_binding(
                vk::DescriptorType::UNIFORM_BUFFER,
                vk::ShaderStageFlags::ALL,
                NUM_SAMPLERS as u32,
                1,
            )
            .build(device)?;
        let extra_resources_set_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, NUM_SAMPLERS as u32)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let extra_resources_set = make_descriptor_set(device, *extra_resources_set_pool, *extra_resources_layout)?;
        {
            let image_infos: Vec<vk::DescriptorImageInfo> = images
                .iter()
                .zip(&samplers)
                .map(|(image, sampler)| vk::DescriptorImageInfo {
                    sampler: **sampler,
                    image_view: *image.view,
                    image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                })
                .collect();
            let descriptor_write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: extra_resources_set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: NUM_SAMPLERS as u32,
                descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                image_info: image_infos.as_ptr(),
                buffer_info: std::ptr::null(),
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { device.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };
        }
        if let Some(index_buffer) = &index_buffer {
            let buffer_info = vk::DescriptorBufferInfo {
                buffer: index_buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            };
            let descriptor_write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: extra_resources_set.get(),
                dst_binding: NUM_SAMPLERS as u32,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::UNIFORM_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: &buffer_info,
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { device.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };
        }

        let coord_bytes: Vec<u8> = coords.iter().flat_map(|value| value.to_ne_bytes()).collect();
        let mut input_bytes = vec![coord_bytes];
        if case.index_expr_type == IndexExprType::DynamicUniform {
            input_bytes.extend(
                case.lookup_indices
                    .iter()
                    .map(|&index| to_bytes(&vec![index; SAMPLER_NUM_INVOCATIONS])),
            );
        }
        let input_refs: Vec<&[u8]> = input_bytes.iter().map(|bytes| bytes.as_slice()).collect();
        let mut output_bytes: Vec<Vec<u8>> = (0..NUM_LOOKUPS).map(|_| vec![0u8; out_lookup_stride * 4]).collect();
        {
            let mut output_refs: Vec<&mut [u8]> = output_bytes.iter_mut().map(|bytes| bytes.as_mut_slice()).collect();
            execute(
                context,
                case.shader_type,
                &case.spec,
                Some(*extra_resources_layout),
                SAMPLER_NUM_INVOCATIONS,
                &input_refs,
                &mut output_refs,
                Some(extra_resources_set.get()),
            )?;
        }
        let out_data: Vec<Vec<u32>> = output_bytes
            .iter()
            .map(|bytes| {
                bytes
                    .chunks_exact(4)
                    .map(|chunk| u32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]))
                    .collect()
            })
            .collect();

        let mut test_result = TestStatus::pass("Pass");

        if shadow {
            // Each invocation may have different results.
            for invocation_ndx in 0..SAMPLER_NUM_INVOCATIONS {
                let coord = coords[invocation_ndx * num_coord_comps + (num_coord_comps - 1)];
                for lookup_ndx in 0..NUM_LOOKUPS {
                    let tex_ndx = case.lookup_indices[lookup_ndx] as usize;
                    let result = f32::from_bits(out_data[lookup_ndx][invocation_ndx]);
                    let depth =
                        f32::from(u16::from_le_bytes([tex_data[tex_ndx * 2], tex_data[tex_ndx * 2 + 1]])) / 65535.0;
                    let reference = if coord < depth { 1.0f32 } else { 0.0 };
                    if (result - reference).abs() > 0.005 {
                        log::error!(
                            "ERROR: at invocation {invocation_ndx}, lookup {lookup_ndx}: expected {reference}, got {result}"
                        );
                        if !test_result.is_fail() {
                            test_result = TestStatus::fail("Got invalid lookup result");
                        }
                    }
                }
            }
        } else {
            // Validate results from first invocation
            for lookup_ndx in 0..NUM_LOOKUPS {
                let tex_ndx = case.lookup_indices[lookup_ndx] as usize;
                let texel = &tex_data[tex_ndx * 4..tex_ndx * 4 + 4];
                let result = &out_data[lookup_ndx][..4];
                let is_ok = if out_kind == ScalarKind::Float {
                    let threshold = 1.0f32 / 256.0;
                    let ok =
                        (0..4).all(|c| (f32::from(texel[c]) / 255.0 - f32::from_bits(result[c])).abs() <= threshold);
                    if !ok {
                        log::error!(
                            "ERROR: at lookup {lookup_ndx}: got {:?}",
                            result.iter().map(|&bits| f32::from_bits(bits)).collect::<Vec<_>>()
                        );
                    }
                    ok
                } else {
                    let signed = sampler_type.result == ResultKind::Int;
                    let ok = (0..4).all(|c| {
                        result[c]
                            == if signed {
                                texel[c] as i8 as i32 as u32
                            } else {
                                u32::from(texel[c])
                            }
                    });
                    if !ok {
                        log::error!("ERROR: at lookup {lookup_ndx}: got {result:x?}");
                    }
                    ok
                };
                if !is_ok && !test_result.is_fail() {
                    test_result = TestStatus::fail("Got invalid lookup result");
                }
            }

            // Check results of other invocations against first one
            for invocation_ndx in 1..SAMPLER_NUM_INVOCATIONS {
                for lookup_ndx in 0..NUM_LOOKUPS {
                    let ref_values = &out_data[lookup_ndx][..4];
                    let res_values = &out_data[lookup_ndx][invocation_ndx * 4..invocation_ndx * 4 + 4];
                    if ref_values != res_values {
                        log::error!(
                            "ERROR: invocation {invocation_ndx} result {res_values:x?} for lookup {lookup_ndx} doesn't match result from first invocation {ref_values:x?}"
                        );
                        if !test_result.is_fail() {
                            test_result = TestStatus::fail("Inconsistent lookup results");
                        }
                    }
                }
            }
        }

        Ok(test_result)
    }
}

/// `OpaqueTypeIndexingTests::init`
pub fn create_opaque_type_indexing_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("opaque_type_indexing");

    // .sampler
    let mut sampler_group = TestCaseGroup::new("sampler");
    for (index_expr_type, index_expr_name) in INDEXING_TYPES {
        let mut index_group = TestCaseGroup::new(index_expr_name);
        for (shader_type, shader_name) in SHADER_TYPES {
            let mut shader_group = TestCaseGroup::new(shader_name);
            // \note [pyry] In Vulkan CTS 1.0.2 sampler groups should not cover tess/geom stages
            if matches!(
                shader_type,
                ShaderType::Vertex | ShaderType::Fragment | ShaderType::Compute
            ) {
                for sampler_type in SAMPLER_TYPES {
                    let case_name = sampler_type.glsl.to_lowercase();
                    shader_group.add_child(Box::new(SamplerCase::new(
                        case_name,
                        sampler_type,
                        index_expr_type,
                        shader_type,
                        shader_name,
                        index_expr_name,
                    )) as Box<dyn TestCase>);
                }
            }
            index_group.add_child(shader_group);
        }
        sampler_group.add_child(index_group);
    }
    group.add_child(sampler_group);

    let kinds = [
        CaseKind::Ubo,
        CaseKind::Ssbo,
        CaseKind::SsboStorageBufferDecoration,
        CaseKind::AtomicCounter,
    ];
    let mut groups: Vec<TestCaseGroup> = kinds.iter().map(|kind| TestCaseGroup::new(kind.group_key())).collect();

    for (index_expr_type, index_expr_name) in INDEXING_TYPES {
        for (shader_type, shader_name) in SHADER_TYPES {
            let name = format!("{index_expr_name}_{shader_name}");
            for (kind, kind_group) in kinds.iter().zip(groups.iter_mut()) {
                kind_group.add_child(Box::new(OpaqueCase::new(
                    name.clone(),
                    *kind,
                    index_expr_type,
                    shader_type,
                    &name,
                )) as Box<dyn TestCase>);
            }
        }
    }

    for kind_group in groups {
        group.add_child(kind_group);
    }
    group
}
