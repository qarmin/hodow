// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeCooperativeMatrixTests.cpp (CooperativeMatrixTestInstance::queuePass and the data helpers)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 NVIDIA Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The instance runs every case `scripts/gen_cooperative_matrix_manifest.py` writes a shader for (three
// manifests: the base feature set, the VK_NV_cooperative_matrix2 / VK_EXT_cooperative_matrix_maintenance1 shaders at subgroup scope with linear addressing,
// and workgroup scope / tensor addressing), on the universal queue. The sizes come from the classic property queries and the flexible dimension
// properties; the sizes upstream adds through VK_EXT_cooperative_matrix_maintenance1 properties2 are not tested (the bindings lack the query), so a device that
// has only those ends in NotSupported here. `matrixmuladd_cross` (SPIR-V assembly upstream) and the base-feature transposes (the shader needs an extension
// upstream does not enable) are not ported.

use std::collections::BTreeSet;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1, NvCooperativeMatrix2ExtensionInstanceCommands};

use super::cooperative_matrix_float::{
    BFLOAT16, FLOAT_E4M3, FLOAT_E5M2, FLOAT16, RoundingDirection, SmallFloat, calc_b16_threshold,
};
use super::cooperative_matrix_tests::{
    AddrMethod, CaseDef, Ct, MatrixProps, StorageClass, SubgroupSizeMode, TestType, UseType,
    cooperative_matrix_properties_converted, cooperative_matrix2_features, has_varying_effective_subgroup_size,
    is_clamp_test, is_convert_op, is_matrix_mul_add_op, is_reduce_2x2, is_reduce_change_dim, is_reduce_col,
    is_reduce_op, is_reduce_row, is_reduce_row_col, is_reduce_sum, is_saturated_convert_op, is_split_barrier_test,
    is_tensor_layout_clip_test, is_tensor_layout_test, is_transpose_test, reduce_m_scale, reduce_n_scale,
    subgroup_size_control_properties, subgroup_size_from_mode,
};
use crate::generated::shaders::compute_cooperative_matrix::ALL_SHARED_PROGRAM;
use crate::generated::shaders::compute_cooperative_matrix_cm2::ALL_SHARED_PROGRAM as ALL_SHARED_PROGRAM_CM2;
use crate::generated::shaders::compute_cooperative_matrix_ext::ALL_SHARED_PROGRAM as ALL_SHARED_PROGRAM_EXT;
use crate::tcu::float::Float16;
use crate::tcu::{Random, TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
use crate::vkt::{Context, TestInstance};

/// Index into a buffer of `Ct` elements, the typed accessors of upstream's `void *` helpers
#[derive(Clone, Copy)]
struct Mem(*mut u8);

fn is_float_type(t: Ct) -> bool {
    t.is_float()
}

fn is_uint_type(t: Ct) -> bool {
    matches!(t, Ct::U8 | Ct::U16 | Ct::U32 | Ct::U64)
}

fn is_sint_type(t: Ct) -> bool {
    t.is_sint()
}

fn is_signed(t: Ct) -> bool {
    t.is_float() || t.is_sint()
}

/// The small float format of a float component type other than float32
fn small_float(dt: Ct) -> Option<SmallFloat> {
    match dt {
        Ct::F16 => Some(FLOAT16),
        Ct::Bf16 => Some(BFLOAT16),
        Ct::E5m2 => Some(FLOAT_E5M2),
        Ct::E4m3 => Some(FLOAT_E4M3),
        _ => None,
    }
}

/// `setDataFloat`
fn set_data_float(base: Mem, dt: Ct, i: u32, value: f32) -> Result<(), TestError> {
    let i = i as usize;
    if dt == Ct::F32 {
        unsafe { base.0.cast::<f32>().add(i).write_unaligned(value) };
        return Ok(());
    }
    let format = small_float(dt).ok_or_else(|| TestError::InternalError("not a float type".to_string()))?;
    let bits = format.from_f32(value, RoundingDirection::ToEven);
    unsafe {
        match dt.bits() {
            8 => base.0.add(i).write(bits as u8),
            _ => base.0.cast::<u16>().add(i).write_unaligned(bits as u16),
        }
    }
    Ok(())
}

/// `getDataFloat`
fn get_data_float(base: Mem, dt: Ct, i: u32) -> Result<f32, TestError> {
    let i = i as usize;
    if dt == Ct::F32 {
        return Ok(unsafe { base.0.cast::<f32>().add(i).read_unaligned() });
    }
    let format = small_float(dt).ok_or_else(|| TestError::InternalError("not a float type".to_string()))?;
    let bits = unsafe {
        match dt.bits() {
            8 => u32::from(base.0.add(i).read()),
            _ => u32::from(base.0.cast::<u16>().add(i).read_unaligned()),
        }
    };
    Ok(format.to_f32(bits))
}

/// `setDataInt`
fn set_data_int(base: Mem, dt: Ct, i: u32, value: u32) -> Result<(), TestError> {
    let i = i as usize;
    unsafe {
        match dt {
            Ct::U8 | Ct::S8 => base.0.add(i).write(value as u8),
            Ct::U16 | Ct::S16 => base.0.cast::<u16>().add(i).write_unaligned(value as u16),
            Ct::U32 | Ct::S32 => base.0.cast::<u32>().add(i).write_unaligned(value),
            _ => return Err(TestError::InternalError("Unsupported type".to_string())),
        }
    }
    Ok(())
}

/// `getDataInt`: signed types are sign extended
fn get_data_int(base: Mem, dt: Ct, i: u32) -> Result<u32, TestError> {
    let i = i as usize;
    unsafe {
        Ok(match dt {
            Ct::U8 => u32::from(base.0.add(i).read()),
            Ct::U16 => u32::from(base.0.cast::<u16>().add(i).read_unaligned()),
            Ct::U32 => base.0.cast::<u32>().add(i).read_unaligned(),
            Ct::S8 => base.0.add(i).cast::<i8>().read() as i32 as u32,
            Ct::S16 => base.0.cast::<i16>().add(i).read_unaligned() as i32 as u32,
            Ct::S32 => base.0.cast::<i32>().add(i).read_unaligned() as u32,
            _ => return Err(TestError::InternalError("Unsupported type".to_string())),
        })
    }
}

/// The value of an element as `getDataConvertedToT<T>` converts it (`T` is `dst`), widened to double
fn get_data_converted_to(base: Mem, src: Ct, i: u32, dst: Ct) -> Result<f64, TestError> {
    let wrap = |v: i64| -> f64 {
        match dst {
            Ct::U8 => f64::from(v as u8),
            Ct::U16 => f64::from(v as u16),
            Ct::U32 => f64::from(v as u32),
            Ct::S8 => f64::from(v as i8),
            Ct::S16 => f64::from(v as i16),
            _ => f64::from(v as i32),
        }
    };
    if is_float_type(src) {
        let mut temp = get_data_float(base, src, i)?;
        if is_uint_type(dst) {
            temp = temp.max(0.0);
        }
        if is_float_type(dst) {
            return Ok(f64::from(temp));
        }
        Ok(wrap(temp as i64))
    } else {
        let raw = get_data_int(base, src, i)?;
        let value = if is_sint_type(src) {
            i64::from(raw as i32)
        } else {
            i64::from(raw)
        };
        if is_float_type(dst) {
            return Ok(value as f32 as f64);
        }
        Ok(wrap(value))
    }
}

/// `satAddData`
fn sat_add_data(dt: Ct, a: u32, b: u32) -> Result<u32, TestError> {
    fn sat_add_signed(a: i64, b: i64, min: i64, max: i64) -> i64 {
        (a + b).clamp(min, max)
    }
    Ok(match dt {
        Ct::U8 => (a + b).min(u32::from(u8::MAX)),
        Ct::U16 => (a + b).min(u32::from(u16::MAX)),
        Ct::U32 => a.saturating_add(b),
        Ct::S8 => sat_add_signed(
            i64::from(a as i8),
            i64::from(b as i8),
            i64::from(i8::MIN),
            i64::from(i8::MAX),
        ) as u32,
        Ct::S16 => sat_add_signed(
            i64::from(a as i16),
            i64::from(b as i16),
            i64::from(i16::MIN),
            i64::from(i16::MAX),
        ) as u32,
        Ct::S32 => sat_add_signed(
            i64::from(a as i32),
            i64::from(b as i32),
            i64::from(i32::MIN),
            i64::from(i32::MAX),
        ) as u32,
        _ => return Err(TestError::InternalError("Unsupported type".to_string())),
    })
}

/// `getLimit`
fn get_limit(dt: Ct, positive: bool) -> Result<u32, TestError> {
    Ok(match (dt, positive) {
        (Ct::U8, true) => u32::from(u8::MAX),
        (Ct::U16, true) => u32::from(u16::MAX),
        (Ct::U32, true) => u32::MAX,
        (Ct::U8 | Ct::U16 | Ct::U32, false) => 0,
        (Ct::S8, true) => i8::MAX as u32,
        (Ct::S16, true) => i16::MAX as u32,
        (Ct::S32, true) => i32::MAX as u32,
        (Ct::S8, false) => i8::MIN as i32 as u32,
        (Ct::S16, false) => i16::MIN as i32 as u32,
        (Ct::S32, false) => i32::MIN as u32,
        _ => return Err(TestError::InternalError("Unsupported type".to_string())),
    })
}

/// `setSingleElementInt`
fn set_single_element_int(
    data: Mem,
    dt: Ct,
    start: u32,
    count: u32,
    step: u32,
    at: u32,
    val: u32,
) -> Result<(), TestError> {
    for i in 0..count {
        set_data_int(data, dt, start + i * step, if i == at { val } else { 0 })?;
    }
    Ok(())
}

/// `getSplitBarrierReservedSharedMemory`
fn split_barrier_reserved_shared_memory(context: &Context<'_>) -> u32 {
    if !context.is_device_functionality_supported("VK_EXT_shader_split_barrier") {
        return 0;
    }
    let mut words = vec![0u64; 3];
    let base = words.as_mut_ptr();
    unsafe { base.cast::<i32>().write(1000305001) };
    let mut properties2 = vk::PhysicalDeviceProperties2::default();
    properties2.next = base.cast();
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    unsafe { base.cast::<u32>().add(4).read() }
}

/// `blockSize`
const BLOCK_SIZE: [u32; 2] = [2, 4];

/// One `tensorLayout<N>d*` table: matrix size, tensor dimensions, spans, load and store offsets (`GetTensorLayout*`)
struct TensorLayoutTable {
    matrix_sizes: &'static [[i32; 2]],
    dim: [i32; 5],
    span: &'static [[i32; 5]],
    load_offsets: &'static [[i32; 5]],
    store_offsets: &'static [[i32; 5]],
}

fn tensor_layout_table(dim: u32) -> TensorLayoutTable {
    match dim {
        1 => TensorLayoutTable {
            matrix_sizes: &[[32, 32], [64, 64]],
            dim: [65536, 1, 1, 1, 1],
            span: &[[1024, 0, 0, 0, 0], [4096, 0, 0, 0, 0]],
            load_offsets: &[[10000, 0, 0, 0, 0], [-1, 0, 0, 0, 0]],
            store_offsets: &[[-1, 0, 0, 0, 0], [4321, 0, 0, 0, 0]],
        },
        2 => TensorLayoutTable {
            matrix_sizes: &[[32, 32], [64, 64]],
            dim: [512, 512, 1, 1, 1],
            span: &[[32, 32, 0, 0, 0], [64, 64, 0, 0, 0]],
            load_offsets: &[[7, 13, 0, 0, 0], [128, 128, 0, 0, 0]],
            store_offsets: &[[13, 7, 0, 0, 0], [148, 0, 0, 0, 0]],
        },
        3 => TensorLayoutTable {
            matrix_sizes: &[[64, 32], [32, 32]],
            dim: [33, 44, 55, 1, 1],
            span: &[[16, 16, 8, 0, 0], [8, 4, 32, 0, 0]],
            load_offsets: &[[1, 1, 1, 0, 0], [-1, -1, -1, 0, 0]],
            store_offsets: &[[2, 2, 2, 0, 0], [23, 2, 1, 0, 0]],
        },
        4 => TensorLayoutTable {
            matrix_sizes: &[[64, 64]],
            dim: [20, 25, 40, 10, 1],
            span: &[[16, 8, 8, 4, 0]],
            load_offsets: &[[-1, -1, -1, -1, 0]],
            store_offsets: &[[1, 2, 1, 2, 0]],
        },
        _ => TensorLayoutTable {
            matrix_sizes: &[[32, 32]],
            dim: [4, 4, 32, 16, 8],
            span: &[[1, 4, 8, 4, 8]],
            load_offsets: &[[-1, -1, -1, -1, -1]],
            store_offsets: &[[1, 2, 1, 0, 1]],
        },
    }
}

fn tensor_layout_dim_of(test_type: TestType) -> u32 {
    use TestType::*;
    match test_type {
        TensorLayout1d | TensorLayout1dClip => 1,
        TensorLayout2d | TensorLayout2dClip => 2,
        TensorLayout3d | TensorLayout3dClip => 3,
        TensorLayout4d | TensorLayout4dClip => 4,
        _ => 5,
    }
}

/// `setSubgroup..`: how one element's granularity is folded into M and N for a use type (`SetGranularity` of `queuePass`)
fn set_granularity(
    d: &CaseDef,
    p: &vk::CooperativeMatrixFlexibleDimensionsPropertiesNV,
    ty: vk::ComponentTypeKHR,
    use_type: UseType,
    m_granularity: &mut u32,
    n_granularity: &mut u32,
) -> Result<bool, TestError> {
    let transpose = is_transpose_test(d.test_type);
    Ok(match use_type {
        UseType::Nv => false,
        UseType::KhrA if p.a_type == ty => {
            let (m, n) = if transpose {
                (p.k_granularity, p.m_granularity)
            } else {
                (p.m_granularity, p.k_granularity)
            };
            *m_granularity = (*m_granularity).max(m);
            *n_granularity = (*n_granularity).max(n);
            true
        }
        UseType::KhrB if p.b_type == ty => {
            let (m, n) = if transpose {
                (p.n_granularity, p.k_granularity)
            } else {
                (p.k_granularity, p.n_granularity)
            };
            *m_granularity = (*m_granularity).max(m);
            *n_granularity = (*n_granularity).max(n);
            true
        }
        UseType::KhrResult if p.result_type == ty => {
            *m_granularity = (*m_granularity).max(p.m_granularity);
            *n_granularity = (*n_granularity).max(p.n_granularity);
            true
        }
        UseType::KhrC => return Err(TestError::InternalError("Unsupported use type".to_string())),
        _ => false,
    })
}

fn is_addressing_test(d: &CaseDef) -> bool {
    d.test_type == TestType::SpaceToDepth
        || is_tensor_layout_test(d.test_type)
        || is_clamp_test(d.test_type)
        || (matches!(d.addr_method, AddrMethod::BlockSize | AddrMethod::Decode)
            && d.test_type != TestType::MatrixMulAddDequant)
}

/// `TestTuple`, ordered by workgroup size, then M, N, K
type TestTuple = (u32, u32, u32, u32);

#[derive(Clone, Copy, Default)]
struct Dims {
    rows: u32,
    cols: u32,
}

/// `CooperativeMatrixTestInstance`
pub struct CooperativeMatrixInstance<'a> {
    context: &'a Context<'a>,
    data: CaseDef,
    key: String,
}

impl<'a> CooperativeMatrixInstance<'a> {
    pub fn new(context: &'a Context<'a>, data: CaseDef, key: &str) -> Self {
        Self {
            context,
            data,
            key: key.to_string(),
        }
    }

    /// The sizes the classic (non flexible, non properties2) property queries yield for this case
    fn test_sizes(&self, properties: &[MatrixProps]) -> BTreeSet<TestTuple> {
        let d = &self.data;
        let mut test_sizes = BTreeSet::new();
        if is_reduce_change_dim(d.test_type) || is_tensor_layout_test(d.test_type) {
            return test_sizes;
        }
        if is_matrix_mul_add_op(d.test_type) {
            for p in properties {
                if p.a_type == d.input_type.vk()
                    && p.b_type == d.input_type.vk()
                    && p.c_type == d.output_type.vk()
                    && p.result_type == d.output_type.vk()
                    && p.scope == d.scope
                {
                    test_sizes.insert((0, p.m_size, p.n_size, p.k_size));
                }
            }
        } else {
            let mut type_sizes: [BTreeSet<TestTuple>; 2] = [BTreeSet::new(), BTreeSet::new()];
            let types = [d.input_type.vk(), d.output_type.vk()];
            let uses = [d.use_type, d.use_type2];
            for p in properties {
                if p.scope != d.scope {
                    continue;
                }
                for j in 0..2 {
                    if matches!(uses[j], UseType::KhrA | UseType::Nv) && p.a_type == types[j] {
                        type_sizes[j].insert(if is_transpose_test(d.test_type) {
                            (0, p.k_size, p.m_size, 0)
                        } else {
                            (0, p.m_size, p.k_size, 0)
                        });
                    }
                    if matches!(uses[j], UseType::KhrB | UseType::Nv) && p.b_type == types[j] {
                        type_sizes[j].insert(if is_transpose_test(d.test_type) {
                            (0, p.n_size, p.k_size, 0)
                        } else {
                            (0, p.k_size, p.n_size, 0)
                        });
                    }
                    if matches!(uses[j], UseType::KhrResult | UseType::Nv)
                        && (p.c_type == types[j] || p.result_type == types[j])
                    {
                        type_sizes[j].insert((0, p.m_size, p.n_size, 0));
                    }
                }
            }
            test_sizes = type_sizes[0].intersection(&type_sizes[1]).copied().collect();
        }
        test_sizes
    }

    /// The sizes of the `VK_NV_cooperative_matrix2` flexible dimension properties, which the tensor layout tests and the workgroup scope depend on
    fn flexible_sizes(&self) -> Result<BTreeSet<TestTuple>, TestError> {
        let d = &self.data;
        let context = self.context;
        let mut test_sizes = BTreeSet::new();
        if d.use_type == UseType::Nv
            || cooperative_matrix2_features(context).cooperative_matrix_flexible_dimensions == vk::FALSE
        {
            return Ok(test_sizes);
        }
        let flexible_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_cooperative_matrix_flexible_dimensions_properties_nv(context.get_physical_device())
        }
        .vk_check("vkGetPhysicalDeviceCooperativeMatrixFlexibleDimensionsPropertiesNV")?;

        if is_tensor_layout_test(d.test_type) {
            for p in &flexible_properties {
                if p.scope == d.scope {
                    test_sizes.insert((p.workgroup_invocations, 32, 32, 32));
                }
            }
            return Ok(test_sizes);
        }

        let wg_scope = d.scope == vk::ScopeKHR::WORKGROUP;
        let max_shared_memory = context.get_device_properties().limits.max_compute_shared_memory_size as i64;
        let reserved = if context.is_device_functionality_supported("VK_NV_cooperative_matrix2") && wg_scope {
            let mut properties = vk::PhysicalDeviceCooperativeMatrix2PropertiesNV::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            i64::from(properties.cooperative_matrix_workgroup_scope_reserved_shared_memory)
        } else {
            0
        };
        let shmem_ok = |m: u32, n: u32, k: u32| -> bool {
            let mut max_matrix_elements = (m * n).max((m * k).max(k * n));
            if is_reduce_2x2(d.test_type) {
                max_matrix_elements *= 4;
            }
            if is_reduce_change_dim(d.test_type) {
                max_matrix_elements *= reduce_m_scale(d.test_type) * reduce_n_scale(d.test_type);
            }
            if !wg_scope {
                max_matrix_elements *= d.subgroups_per_workgroup_x * d.subgroups_per_workgroup_y;
            }
            let max_shared = max_shared_memory - reserved;
            if matches!(
                d.storage_class,
                StorageClass::Workgroup | StorageClass::WorkgroupVariablePointers
            ) {
                return i64::from(
                    max_matrix_elements
                        * 2
                        * (d.input_type.bits() * d.input_component_count
                            + d.output_type.bits() * d.output_component_count)
                        / 8,
                ) <= max_shared;
            }
            true
        };

        let is_mma = is_matrix_mul_add_op(d.test_type);
        let is_mma_sat = d.test_type == TestType::MatrixMulAddSaturated;
        let types = [d.input_type.vk(), d.output_type.vk()];
        let uses = [d.use_type, d.use_type2];
        let mut sizes: Vec<TestTuple> = Vec::new();
        for p in &flexible_properties {
            let (mut m_g, mut n_g, mut k_g) = (0u32, 0u32, 0u32);
            let mut ok = false;
            if p.scope != d.scope {
                continue;
            }
            if is_mma && is_mma_sat != (p.saturating_accumulation != vk::FALSE) {
                continue;
            }
            if is_mma {
                if p.a_type == d.input_type.vk()
                    && p.b_type == d.input_type.vk()
                    && p.c_type == d.output_type.vk()
                    && p.result_type == d.output_type.vk()
                {
                    ok = true;
                    m_g = p.m_granularity;
                    n_g = p.n_granularity;
                    k_g = p.k_granularity;
                }
            } else {
                ok = set_granularity(d, p, types[0], uses[0], &mut m_g, &mut n_g)?;
                if !ok {
                    continue;
                }
                for p2 in &flexible_properties {
                    if p2.scope != d.scope || p2.workgroup_invocations != p.workgroup_invocations {
                        continue;
                    }
                    ok = set_granularity(d, p2, types[1], uses[1], &mut m_g, &mut n_g)?;
                    if ok {
                        break;
                    }
                }
            }
            if ok {
                let w = p.workgroup_invocations;
                sizes.push((w, m_g, n_g, k_g));
                if !matches!(
                    d.storage_class,
                    StorageClass::Workgroup | StorageClass::WorkgroupVariablePointers
                ) {
                    sizes.push((w, 3 * m_g, n_g, k_g));
                    sizes.push((w, m_g, 3 * n_g, k_g));
                    if is_mma {
                        sizes.push((w, 2 * m_g, 2 * n_g, 3 * k_g));
                        sizes.push((w, m_g, n_g, 3 * k_g));
                    }
                }
            }
        }
        for (w, m, n, k) in sizes {
            if shmem_ok(m, n, k) {
                test_sizes.insert((w, m, n, k));
            }
        }
        Ok(test_sizes)
    }

    fn dims_for(&self, m: u32, n: u32, k: u32) -> [Dims; 4] {
        if is_matrix_mul_add_op(self.data.test_type) {
            [
                Dims { rows: m, cols: k },
                Dims { rows: k, cols: n },
                Dims { rows: m, cols: n },
                Dims { rows: m, cols: n },
            ]
        } else {
            let t = self.data.test_type;
            let mut dims = [Dims { rows: m, cols: n }; 4];
            if is_reduce_2x2(t) {
                dims[0] = Dims {
                    rows: m * 2,
                    cols: n * 2,
                };
            }
            if is_reduce_change_dim(t) {
                dims[3] = Dims {
                    rows: m * reduce_m_scale(t),
                    cols: n * reduce_n_scale(t),
                };
            } else if is_transpose_test(t) {
                dims[2] = Dims { rows: n, cols: m };
                dims[3] = Dims { rows: n, cols: m };
            }
            dims
        }
    }

    /// `CooperativeMatrixTestInstance::queuePass`
    fn queue_pass(&self) -> TestOutcome {
        let d = &self.data;
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let memory_device_address = if d.storage_class == StorageClass::PhysicalStorageBuffer
            && context.is_device_functionality_supported("VK_KHR_buffer_device_address")
        {
            MemoryRequirement::DEVICE_ADDRESS
        } else {
            MemoryRequirement::ANY
        };
        let mut final_res = TestResult::NotSupported;
        let saturated = d.test_type == TestType::MatrixMulAddSaturated;
        let subgroup_size = subgroup_size_from_mode(context, d.subgroup_size_mode);
        let varying_effective_subgroup_size =
            has_varying_effective_subgroup_size(context, d.subgroup_size_mode, d.test_type);
        let local_size_x_subgroup_size = if varying_effective_subgroup_size {
            subgroup_size_control_properties(context).max_subgroup_size
        } else {
            subgroup_size
        };
        let epsilon = 1.0f32 / (1u64 << 17) as f32;
        let max_shared_memory = context.get_device_properties().limits.max_compute_shared_memory_size;

        let mut rnd = Random::new(1234);

        let properties = cooperative_matrix_properties_converted(context, d.use_type != UseType::Nv)?;
        let mut test_sizes = self.flexible_sizes()?;
        test_sizes.extend(self.test_sizes(&properties));
        if test_sizes.is_empty()
            && is_reduce_change_dim(d.test_type)
            && cooperative_matrix2_features(context).cooperative_matrix_flexible_dimensions == vk::FALSE
        {
            return Err(TestError::NotPorted(
                "changed dimension reductions take their sizes from the flexible dimension or properties2 queries"
                    .to_string(),
            ));
        }
        let wg_scope = d.scope == vk::ScopeKHR::WORKGROUP;
        let sg_x = if wg_scope { 1 } else { d.subgroups_per_workgroup_x };

        for &(workgroup_size, m, n, k) in &test_sizes {
            let dims = self.dims_for(m, n, k);

            let mut data_types = [d.input_type; 4];
            let mut element_size = [0usize; 4];
            let mut buffer_sizes = [0u64; 5];
            let mut strides = [0u32; 4];
            let mut load_strides = [0u32; 4];
            let mut total_elements = [0u32; 4];
            let mut total_shared_memory_usage = 0usize;
            let mut split_barrier_reserved_shared_memory_bytes = 0u32;

            if is_split_barrier_test(d.test_type) {
                split_barrier_reserved_shared_memory_bytes = split_barrier_reserved_shared_memory(context);
                if d.test_type == TestType::MatrixMulAddSplitBarrierSkew {
                    split_barrier_reserved_shared_memory_bytes += 4;
                }
            }

            let workgroup_storage = matches!(
                d.storage_class,
                StorageClass::Workgroup | StorageClass::WorkgroupVariablePointers
            );
            for i in 0..4usize {
                data_types[i] = if i < 2 { d.input_type } else { d.output_type };
                element_size[i] = (data_types[i].bits() / 8) as usize;

                strides[i] = (if d.col_major { dims[i].rows } else { dims[i].cols }) * d.workgroups_x * sg_x;
                load_strides[i] = strides[i];
                total_elements[i] =
                    strides[i] * (if d.col_major { dims[i].cols } else { dims[i].rows }) * d.workgroups_y;
                let shared_memory_usage = dims[i].cols as usize
                    * dims[i].rows as usize
                    * d.subgroups_per_workgroup_x as usize
                    * d.subgroups_per_workgroup_y as usize
                    * element_size[i]
                    * (if i < 2 {
                        d.input_component_count
                    } else {
                        d.output_component_count
                    }) as usize;

                if d.use_type != UseType::Nv && workgroup_storage {
                    total_shared_memory_usage += shared_memory_usage;
                    if total_shared_memory_usage as u64
                        > u64::from(max_shared_memory.saturating_sub(split_barrier_reserved_shared_memory_bytes))
                    {
                        return Err(TestError::NotSupported(
                            "Not enough shared memory supported.".to_string(),
                        ));
                    }
                }

                if d.test_type == TestType::MatrixMulAddDequant && i < 2 {
                    total_elements[i] /= (data_types[i].bits() / 8) * 2;
                }

                if !wg_scope {
                    total_elements[i] *= d.subgroups_per_workgroup_y;
                }

                if is_tensor_layout_test(d.test_type) {
                    total_elements[i] = 512 * 512;
                }
                buffer_sizes[i] = u64::from(total_elements[i]) * element_size[i] as u64;
            }
            buffer_sizes[4] = 8 * 4;

            let usage = vk::BufferUsageFlags::STORAGE_BUFFER
                | vk::BufferUsageFlags::TRANSFER_DST
                | vk::BufferUsageFlags::TRANSFER_SRC
                | if memory_device_address.contains(MemoryRequirement::DEVICE_ADDRESS) {
                    vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
                } else {
                    vk::BufferUsageFlags::empty()
                };
            let mut buffers: Vec<BufferWithMemory<'_>> = Vec::with_capacity(5);
            for &size in &buffer_sizes {
                let cached = BufferWithMemory::new(
                    device,
                    allocator,
                    make_buffer_create_info(size, usage),
                    MemoryRequirement::HOST_VISIBLE
                        | MemoryRequirement::CACHED
                        | MemoryRequirement::COHERENT
                        | memory_device_address,
                );
                buffers.push(match cached {
                    Ok(buffer) => buffer,
                    Err(TestError::NotSupported(_)) => BufferWithMemory::new(
                        device,
                        allocator,
                        make_buffer_create_info(size, usage),
                        MemoryRequirement::HOST_VISIBLE | memory_device_address,
                    )?,
                    Err(e) => return Err(e),
                });
            }
            let buffer_descriptors: Vec<vk::DescriptorBufferInfo> = buffers
                .iter()
                .zip(buffer_sizes)
                .map(|(buffer, size)| make_descriptor_buffer_info(buffer.get(), 0, size))
                .collect();

            if d.test_type == TestType::MatrixMulAddStride0 {
                load_strides = [0; 4];
            }

            let ptrs: Vec<Mem> = buffers.iter().map(|b| Mem(b.get_allocation().get_host_ptr())).collect();

            let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .build(device)?;
            let descriptor_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 5)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

            let mut update_builder = DescriptorSetUpdateBuilder::new();
            if d.storage_class == StorageClass::PhysicalStorageBuffer {
                for (i, buffer) in buffers.iter().take(4).enumerate() {
                    let info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get());
                    let address = unsafe { device.get_buffer_device_address(&info) };
                    unsafe { ptrs[4].0.cast::<u64>().add(i).write_unaligned(address) };
                }
                update_builder = update_builder.write_single(
                    *descriptor_set,
                    Location::binding(4),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &buffer_descriptors[4],
                );
            } else {
                for binding in 0..4u32 {
                    update_builder = update_builder.write_single(
                        *descriptor_set,
                        Location::binding(binding),
                        vk::DescriptorType::STORAGE_BUFFER,
                        &buffer_descriptors[binding as usize],
                    );
                }
            }
            update_builder.update(device);

            let spec_data: [u32; 9] = [
                if wg_scope {
                    workgroup_size
                } else {
                    local_size_x_subgroup_size * d.subgroups_per_workgroup_x
                },
                if wg_scope { 1 } else { d.subgroups_per_workgroup_y },
                strides[0],
                strides[1],
                strides[2],
                strides[3],
                m,
                n,
                k,
            ];
            let spec_entries: Vec<vk::SpecializationMapEntry> = (0..9u32)
                .map(|id| vk::SpecializationMapEntry {
                    constant_id: id,
                    offset: id * 4,
                    size: 4,
                })
                .collect();
            let spec_bytes: Vec<u8> = spec_data.iter().flat_map(|v| v.to_ne_bytes()).collect();

            let special_floats: Vec<f32> = [-1.0f32, 1.0]
                .iter()
                .flat_map(|&sign| {
                    [
                        f32::INFINITY,
                        f32::MAX,
                        65504.0,
                        f32::from_bits(0x7f7f_0000),
                        57344.0,
                        448.0,
                        57344.0 * 2.0,
                        448.0 * 2.0,
                        57344.0 * 0.75,
                        448.0 * 0.75,
                        65504.0 * 2.0,
                        65504.0 * 0.75,
                    ]
                    .map(|v| v * sign)
                })
                .collect();

            for i in 0..4usize {
                for j in 0..total_elements[i] {
                    if is_float_type(data_types[i]) {
                        if (is_tensor_layout_test(d.test_type) || is_clamp_test(d.test_type)) && i == 3 {
                            set_data_float(ptrs[i], data_types[i], j, 14.0)?;
                        } else if is_convert_op(d.test_type) && is_float_type(data_types[3]) {
                            if (j as usize) < special_floats.len() {
                                set_data_float(ptrs[i], data_types[i], j, special_floats[j as usize])?;
                            } else {
                                set_data_float(
                                    ptrs[i],
                                    data_types[i],
                                    j,
                                    ((rnd.get_uint32() & 0xff) as f32 - 64.0) / 2.0,
                                )?;
                            }
                        } else if is_convert_op(d.test_type) && is_uint_type(d.output_type) {
                            set_data_float(ptrs[i], data_types[i], j, (rnd.get_uint32() & 0xff) as f32 / 4.0)?;
                        } else if !is_matrix_mul_add_op(d.test_type) && !is_reduce_sum(d.test_type) {
                            set_data_float(
                                ptrs[i],
                                data_types[i],
                                j,
                                ((rnd.get_uint32() & 0xff) as f32 - 64.0) / 2.0,
                            )?;
                        } else if d.test_type == TestType::MatrixMulAddDequant && i < 2 {
                            if data_types[i].bits() == 16 {
                                set_data_int(ptrs[i], Ct::U16, j, rnd.get_uint32() & 0xffff)?;
                            } else {
                                set_data_int(ptrs[i], Ct::U8, j, rnd.get_uint32() & 0xff)?;
                            }
                        } else if d.output_type == Ct::Bf16 {
                            set_data_float(ptrs[i], data_types[i], j, ((rnd.get_uint32() & 0x7) as f32 - 3.0) / 2.0)?;
                        } else {
                            set_data_float(ptrs[i], data_types[i], j, ((rnd.get_uint32() & 0xf) as f32 - 4.0) / 2.0)?;
                        }
                    } else if d.test_type == TestType::MatrixMulAddWrapping {
                        let bits = data_types[i].bits();
                        let value = if i == 2 {
                            let mut value = (rnd.get_uint32() & 0xff).wrapping_sub(128);
                            if is_signed(data_types[i]) {
                                value = value.wrapping_add(1u32 << (bits - 1));
                            }
                            value
                        } else {
                            let mask = if bits == 32 { 0xFFFF_FFFF } else { (1u32 << bits) - 1 };
                            rnd.get_uint32() & mask
                        };
                        set_data_int(ptrs[i], data_types[i], j, value)?;
                    } else if d.test_type == TestType::MatrixMulAddSaturated {
                        set_data_int(ptrs[i], data_types[i], j, 0)?;
                    } else if (is_tensor_layout_test(d.test_type) || is_clamp_test(d.test_type)) && i == 3 {
                        set_data_int(ptrs[i], data_types[i], j, 123)?;
                    } else if d.test_type == TestType::Div {
                        let mut value = (rnd.get_uint32() & 0xff).wrapping_sub(128);
                        if is_sint_type(data_types[3]) && i == 1 {
                            if value == 0 {
                                value = 1;
                            } else {
                                let bits = data_types[i].bits();
                                let mask = if bits == 32 { !0u32 } else { (1u32 << bits) - 1 };
                                let mat_a_val = get_data_int(ptrs[0], data_types[0], j)?;
                                let all_ones = if bits == 32 { 0 } else { (1u32 << bits) - 1 };
                                if (value & mask) == all_ones && (mat_a_val & mask) == 1u32.wrapping_shl(bits - 1) {
                                    value = 1;
                                }
                            }
                        }
                        set_data_int(ptrs[i], data_types[i], j, value)?;
                    } else {
                        let value = (rnd.get_uint32() & 0xff).wrapping_sub(128);
                        set_data_int(ptrs[i], data_types[i], j, value)?;
                    }
                }
            }

            if saturated {
                let col = d.col_major;
                set_single_element_int(
                    ptrs[0],
                    data_types[0],
                    0,
                    dims[0].cols,
                    if col { strides[0] } else { 1 },
                    0,
                    1,
                )?;
                set_single_element_int(
                    ptrs[1],
                    data_types[1],
                    0,
                    dims[1].rows,
                    if col { 1 } else { strides[1] },
                    0,
                    1,
                )?;
                set_data_int(ptrs[2], data_types[2], 0, get_limit(data_types[2], true)?)?;

                if is_sint_type(data_types[1]) && is_sint_type(data_types[2]) && is_sint_type(data_types[3]) {
                    set_single_element_int(
                        ptrs[0],
                        data_types[0],
                        if col { 1 } else { strides[0] },
                        dims[0].cols,
                        if col { strides[0] } else { 1 },
                        1,
                        1,
                    )?;
                    set_single_element_int(
                        ptrs[1],
                        data_types[1],
                        if col { strides[1] } else { 1 },
                        dims[1].rows,
                        if col { 1 } else { strides[1] },
                        1,
                        (-1i32) as u32,
                    )?;
                    set_data_int(ptrs[2], data_types[2], strides[2] + 1, get_limit(data_types[2], false)?)?;
                }
            }

            for buffer in buffers.iter().take(4) {
                flush_alloc(device, buffer.get_allocation())?;
            }

            let program = ALL_SHARED_PROGRAM
                .iter()
                .chain(ALL_SHARED_PROGRAM_EXT.iter())
                .chain(ALL_SHARED_PROGRAM_CM2.iter())
                .find(|program| program.name == self.key)
                .ok_or_else(|| TestError::InternalError(format!("no shader {}", self.key)))?;
            let mut pipeline = ComputePipelineWrapper::new(
                device,
                ComputePipelineConstructionType::Pipeline,
                program.programs.get("test")?,
            );
            pipeline.set_descriptor_set_layout(*descriptor_set_layout);
            if d.test_type == TestType::MatrixMulAddPushConstants {
                pipeline.add_push_constant_range(vk::PushConstantRange {
                    stage_flags: vk::ShaderStageFlags::COMPUTE,
                    offset: 0,
                    size: (strides.len() * std::mem::size_of::<u32>()) as u32,
                });
            }
            pipeline.set_specialization_info(spec_entries, spec_bytes);
            pipeline.set_subgroup_size(if d.subgroup_size_mode == SubgroupSizeMode::None {
                0
            } else {
                subgroup_size_from_mode(context, d.subgroup_size_mode)
            });
            pipeline.build_pipeline()?;

            let cmd_pool = make_command_pool(device, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, *cmd_buffer)?;

            unsafe {
                device.cmd_bind_descriptor_sets(
                    *cmd_buffer,
                    vk::PipelineBindPoint::COMPUTE,
                    pipeline.get_pipeline_layout(),
                    0,
                    &[*descriptor_set],
                    &[],
                );
                if d.test_type == TestType::MatrixMulAddPushConstants {
                    let bytes: Vec<u8> = strides.iter().flat_map(|v| v.to_ne_bytes()).collect();
                    device.cmd_push_constants(
                        *cmd_buffer,
                        pipeline.get_pipeline_layout(),
                        vk::ShaderStageFlags::COMPUTE,
                        0,
                        &bytes,
                    );
                }
            }

            pipeline.bind(*cmd_buffer);

            let barrier = vk::MemoryBarrier {
                s_type: vk::StructureType::MEMORY_BARRIER,
                next: std::ptr::null(),
                src_access_mask: vk::AccessFlags::SHADER_WRITE,
                dst_access_mask: vk::AccessFlags::HOST_READ,
            };
            unsafe {
                let (dispatch_x, dispatch_y) = if is_tensor_layout_test(d.test_type) {
                    (1, 1)
                } else {
                    (d.workgroups_x, d.workgroups_y)
                };
                device.cmd_dispatch(*cmd_buffer, dispatch_x, dispatch_y, 1);
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(device, *cmd_buffer)?;
            submit_commands_and_wait(device, queue, *cmd_buffer)?;
            invalidate_alloc(device, buffers[3].get_allocation())?;

            let res = self.verify(
                &dims,
                &data_types,
                &ptrs,
                &strides,
                &load_strides,
                &total_elements,
                (m, n, k),
                saturated,
                epsilon,
                subgroup_size,
                varying_effective_subgroup_size,
            )?;

            if res != TestResult::Pass {
                final_res = res;
                log::info!("failed with M = {m}, N = {n}, K = {k}, WG = {workgroup_size}");
            } else if final_res == TestResult::NotSupported {
                final_res = res;
            }
        }

        Ok(TestStatus::new(final_res, final_res.as_str()))
    }

    /// The tensor layout, space to depth, clamp, block size and decode checks of `queuePass`, for float and integer elements alike
    fn verify_addressing(
        &self,
        dims: &[Dims; 4],
        data_types: &[Ct; 4],
        ptrs: &[Mem],
        strides: &[u32; 4],
        load_strides: &[u32; 4],
        (m, n): (u32, u32),
        mut res: TestResult,
    ) -> Result<TestResult, TestError> {
        let d = &self.data;
        let col = d.col_major;
        let float = is_float_type(data_types[0]);
        let wg_scope = d.scope == vk::ScopeKHR::WORKGROUP;
        let num_matrix_x = if wg_scope {
            d.workgroups_x
        } else {
            d.subgroups_per_workgroup_x * d.workgroups_x
        };
        let num_matrix_y = if wg_scope {
            d.workgroups_y
        } else {
            d.subgroups_per_workgroup_y * d.workgroups_y
        };
        let result_size = data_types[3].bits();
        let mask: u32 = if result_size == 32 {
            !0
        } else {
            (1u32 << result_size) - 1
        };
        let read = |ptr: Mem, dt: Ct, idx: u32| -> Result<f64, TestError> {
            if float {
                Ok(f64::from(get_data_float(ptr, dt, idx)?))
            } else {
                Ok(f64::from(get_data_int(ptr, dt, idx)?))
            }
        };
        let (store_value, clamp_load_value) = if float { (14.0, 0.5) } else { (123.0, 17.0) };

        if d.test_type == TestType::SpaceToDepth {
            let (h_size, w_size, c_size) = (32u32, 32u32, 16u32);
            for h in 0..h_size {
                for w in 0..w_size {
                    for c in 0..c_size {
                        let input_index = (h * w_size + w) * c_size + c;
                        let output_index =
                            ((h / 2) * w_size / 2 + w / 2) * 4 * c_size + ((h & 1) * 2 + (w & 1)) * c_size + c;
                        if read(ptrs[0], data_types[0], input_index)? != read(ptrs[3], data_types[3], output_index)? {
                            res = TestResult::Fail;
                        }
                    }
                }
            }
        } else if is_tensor_layout_test(d.test_type) {
            let dim = tensor_layout_dim_of(d.test_type);
            let table = tensor_layout_table(dim);
            let k_dim = dim as usize;
            let clip = is_tensor_layout_clip_test(d.test_type);
            for i0 in 0..table.dim[0] {
                for i1 in 0..table.dim[1] {
                    for i2 in 0..table.dim[2] {
                        for i3 in 0..table.dim[3] {
                            for i4 in 0..table.dim[4] {
                                let tensor_coord = [i0, i1, i2, i3, i4];
                                let mut index = 0u32;
                                for k in 0..k_dim {
                                    index = index
                                        .wrapping_mul(table.dim[k] as u32)
                                        .wrapping_add(tensor_coord[k] as u32);
                                }
                                let mut reference = store_value;
                                let output = read(ptrs[3], data_types[3], index)?;
                                for r in 0..table.load_offsets.len() {
                                    let mut in_store_rect = true;
                                    for k in 0..k_dim {
                                        if tensor_coord[k] < table.store_offsets[r][k]
                                            || tensor_coord[k] >= table.store_offsets[r][k] + table.span[r][k]
                                        {
                                            in_store_rect = false;
                                        }
                                    }
                                    if in_store_rect && clip {
                                        let mut span_index = 0i32;
                                        for k in 0..k_dim {
                                            span_index = span_index * table.span[r][k]
                                                + (tensor_coord[k] - table.store_offsets[r][k]);
                                        }
                                        let matrix_coord = [
                                            span_index / table.matrix_sizes[r][1],
                                            span_index % table.matrix_sizes[r][1],
                                        ];
                                        if matrix_coord[0] == table.matrix_sizes[r][0] - 1
                                            || matrix_coord[1] == table.matrix_sizes[r][1] - 1
                                        {
                                            in_store_rect = false;
                                        }
                                    }
                                    if in_store_rect {
                                        let mut load_coord = tensor_coord;
                                        for k in 0..k_dim {
                                            load_coord[k] =
                                                load_coord[k] - table.store_offsets[r][k] + table.load_offsets[r][k];
                                        }
                                        let oob =
                                            (0..k_dim).any(|k| load_coord[k] < 0 || load_coord[k] >= table.dim[k]);
                                        if oob {
                                            reference = 0.0;
                                        } else {
                                            let mut index = 0u32;
                                            for k in 0..k_dim {
                                                index = index
                                                    .wrapping_mul(table.dim[k] as u32)
                                                    .wrapping_add(load_coord[k] as u32);
                                            }
                                            reference = read(ptrs[0], data_types[0], index)?;
                                        }
                                        break;
                                    }
                                }
                                if reference != output {
                                    res = TestResult::Fail;
                                }
                            }
                        }
                    }
                }
            }
        } else if is_clamp_test(d.test_type) {
            let full_dim_x = num_matrix_x * if col { dims[0].rows } else { dims[0].cols };
            let full_dim_y = num_matrix_y * if col { dims[0].cols } else { dims[0].rows };
            let dim_x = full_dim_x - 6;
            let dim_y = full_dim_y - 6;
            let modulo = |n: i32, d: i32| (n + d) % d;
            for m_x in 0..num_matrix_x {
                for m_y in 0..num_matrix_y {
                    for i in 0..m {
                        for j in 0..n {
                            let (mut i2, mut j2, ij, oob_store) = if col {
                                let (i2, j2) = ((m_x * m + i) as i32, (m_y * n + j) as i32);
                                (
                                    i2,
                                    j2,
                                    i2 as u32 + strides[3] * j2 as u32,
                                    i2 == full_dim_x as i32 - 1 || j2 == full_dim_y as i32 - 1,
                                )
                            } else {
                                let (i2, j2) = ((m_y * m + i) as i32, (m_x * n + j) as i32);
                                (
                                    i2,
                                    j2,
                                    j2 as u32 + strides[3] * i2 as u32,
                                    i2 == full_dim_y as i32 - 1 || j2 == full_dim_x as i32 - 1,
                                )
                            };
                            let d_ij = read(ptrs[3], data_types[3], ij)?;
                            i2 -= 3;
                            j2 -= 3;
                            let dim_i = (if col { dim_x } else { dim_y }) as i32;
                            let dim_j = (if col { dim_y } else { dim_x }) as i32;
                            let mut oob_load = false;
                            match d.test_type {
                                TestType::ClampConstant => oob_load = i2 < 0 || j2 < 0 || i2 >= dim_i || j2 >= dim_j,
                                TestType::ClampToEdge => {
                                    i2 = i2.max(0).min(dim_i - 1);
                                    j2 = j2.max(0).min(dim_j - 1);
                                }
                                TestType::ClampRepeat => {
                                    i2 = modulo(i2, dim_i);
                                    j2 = modulo(j2, dim_j);
                                }
                                _ => {
                                    i2 = modulo(i2, 2 * dim_i - 2);
                                    i2 = if i2 >= dim_i { 2 * dim_i - 2 - i2 } else { i2 };
                                    j2 = modulo(j2, 2 * dim_j - 2);
                                    j2 = if j2 >= dim_j { 2 * dim_j - 2 - j2 } else { j2 };
                                }
                            }
                            let load_index = if col {
                                i2 as u32 + strides[0] * j2 as u32
                            } else {
                                j2 as u32 + strides[0] * i2 as u32
                            };
                            let reference = if oob_store {
                                store_value
                            } else if oob_load {
                                clamp_load_value
                            } else {
                                read(ptrs[0], data_types[0], load_index)?
                            };
                            if reference != d_ij {
                                res = TestResult::Fail;
                            }
                        }
                    }
                }
            }
        } else {
            let decode = d.addr_method == AddrMethod::Decode;
            for m_x in 0..num_matrix_x {
                for m_y in 0..num_matrix_y {
                    for i in 0..m {
                        for j in 0..n {
                            let block_coords = if col {
                                [(m_y * n + j) / BLOCK_SIZE[0], (m_x * m + i) / BLOCK_SIZE[1]]
                            } else {
                                [(m_y * m + i) / BLOCK_SIZE[0], (m_x * n + j) / BLOCK_SIZE[1]]
                            };
                            let mut block_ij = block_coords[1] + (strides[0] / BLOCK_SIZE[1]) * block_coords[0];
                            if decode {
                                let (within_row, within_col) = if col {
                                    (j % BLOCK_SIZE[0], i % BLOCK_SIZE[1])
                                } else {
                                    (i % BLOCK_SIZE[0], j % BLOCK_SIZE[1])
                                };
                                block_ij =
                                    block_ij * BLOCK_SIZE[0] * BLOCK_SIZE[1] + within_row * BLOCK_SIZE[1] + within_col;
                            }
                            let ij = if col {
                                m_x * m + i + strides[0] * m_y * n + load_strides[0] * j
                            } else {
                                m_x * n + j + strides[0] * m_y * m + load_strides[0] * i
                            };
                            let mut reference = read(ptrs[0], data_types[0], block_ij)?;
                            if decode {
                                reference += f64::from((2 * block_coords[0] + block_coords[1]) & 3);
                            }
                            let d_ij = read(ptrs[3], data_types[3], ij)?;
                            if float {
                                if -reference != d_ij {
                                    res = TestResult::Fail;
                                }
                            } else if ((-(reference as u32 as i32)) as u32 & mask) != (d_ij as u32 & mask) {
                                res = TestResult::Fail;
                            }
                        }
                    }
                }
            }
        }
        Ok(res)
    }

    /// The reduce checks of `queuePass`, for the float and the integer element types alike (values are carried as double, which holds both exactly)
    fn verify_reduce(
        &self,
        dims: &[Dims; 4],
        data_types: &[Ct; 4],
        ptrs: &[Mem],
        strides: &[u32; 4],
        load_strides: &[u32; 4],
        (m, n): (u32, u32),
        mut res: TestResult,
    ) -> Result<TestResult, TestError> {
        let d = &self.data;
        let col = d.col_major;
        let float = is_float_type(data_types[0]);
        let signed = is_signed(data_types[0]);
        let result_size = data_types[3].bits();
        let mask: i64 = if result_size == 32 {
            0xFFFF_FFFF
        } else {
            (1i64 << result_size) - 1
        };
        let is_b16 = data_types[3] == Ct::Bf16;
        let wg_scope = d.scope == vk::ScopeKHR::WORKGROUP;
        let num_matrix_x = if wg_scope {
            d.workgroups_x
        } else {
            d.subgroups_per_workgroup_x * d.workgroups_x
        };
        let num_matrix_y = if wg_scope {
            d.workgroups_y
        } else {
            d.subgroups_per_workgroup_y * d.workgroups_y
        };
        let output_m = m * reduce_m_scale(d.test_type);
        let output_n = n * reduce_n_scale(d.test_type);

        let read = |ptr: Mem, dt: Ct, ij: u32| -> Result<f64, TestError> {
            if float {
                Ok(f64::from(get_data_float(ptr, dt, ij)?))
            } else {
                let raw = get_data_int(ptr, dt, ij)?;
                Ok(if signed { f64::from(raw as i32) } else { f64::from(raw) })
            }
        };
        let combine = |a: f64, b: f64| -> f64 {
            if is_reduce_sum(d.test_type) {
                if float { f64::from(a as f32 + b as f32) } else { a + b }
            } else if float {
                f64::from((a as f32).min(b as f32))
            } else {
                a.min(b)
            }
        };
        let identity = if is_reduce_sum(d.test_type) {
            0.0
        } else if float {
            f64::from(f32::MAX)
        } else {
            i64::MAX as f64
        };
        let mismatch = |reference: f64, d_ij: f64| -> bool {
            if float {
                let (r, dd) = (reference as f32, d_ij as f32);
                let threshold = if is_b16 { calc_b16_threshold(r) } else { None };
                match threshold {
                    Some(threshold) => (r - dd).abs() > threshold,
                    None => f64::from((r - dd).abs()) / (f64::from(r.abs()) + 0.001) > 3.0 / 1024.0,
                }
            } else {
                (reference as i64 & mask) != (d_ij as i64 & mask)
            }
        };

        for m_x in 0..num_matrix_x {
            for m_y in 0..num_matrix_y {
                let get_a = |i: u32, j: u32| -> Result<f64, TestError> {
                    let ij = if col {
                        m_x * dims[0].rows + i + strides[0] * m_y * dims[0].cols + load_strides[0] * j
                    } else {
                        m_x * dims[0].cols + j + strides[0] * m_y * dims[0].rows + load_strides[0] * i
                    };
                    read(ptrs[0], data_types[0], ij)
                };
                let get_d = |i: u32, j: u32| -> Result<f64, TestError> {
                    let ij = if col {
                        m_x * dims[3].rows + i + strides[3] * (m_y * dims[3].cols + j)
                    } else {
                        m_x * dims[3].cols + j + strides[3] * (m_y * dims[3].rows + i)
                    };
                    read(ptrs[3], data_types[3], ij)
                };

                if is_reduce_row(d.test_type) {
                    for i in 0..m {
                        let mut reference = identity;
                        for j in 0..n {
                            reference = combine(reference, get_a(i, j)?);
                        }
                        for j in 0..output_n {
                            let d_ij = get_d(i, j)?;
                            if mismatch(reference, d_ij) || d_ij != get_d(i, 0)? {
                                res = TestResult::Fail;
                            }
                        }
                    }
                } else if is_reduce_col(d.test_type) {
                    for j in 0..n {
                        let mut reference = identity;
                        for i in 0..m {
                            reference = combine(reference, get_a(i, j)?);
                        }
                        for i in 0..output_m {
                            let d_ij = get_d(i, j)?;
                            if mismatch(reference, d_ij) || d_ij != get_d(0, j)? {
                                res = TestResult::Fail;
                            }
                        }
                    }
                } else if is_reduce_row_col(d.test_type) {
                    let mut reference = identity;
                    for i in 0..m {
                        for j in 0..n {
                            reference = combine(reference, get_a(i, j)?);
                        }
                    }
                    for i in 0..output_m {
                        for j in 0..output_n {
                            let d_ij = get_d(i, j)?;
                            if mismatch(reference, d_ij) || d_ij != get_d(0, 0)? {
                                res = TestResult::Fail;
                            }
                        }
                    }
                } else if is_reduce_2x2(d.test_type) {
                    for j in 0..n {
                        for i in 0..m {
                            let mut reference = identity;
                            for (di, dj) in [(0, 0), (0, 1), (1, 0), (1, 1)] {
                                reference = combine(reference, get_a(i * 2 + di, j * 2 + dj)?);
                            }
                            let d_ij = get_d(i, j)?;
                            let wrong = if float {
                                reference as f32 != d_ij as f32
                            } else {
                                (reference as i64 & mask) != (d_ij as i64 & mask)
                            };
                            if wrong {
                                res = TestResult::Fail;
                            }
                        }
                    }
                } else {
                    return Err(TestError::InternalError("Unimplemented".to_string()));
                }
            }
        }
        Ok(res)
    }

    #[allow(clippy::too_many_arguments)]
    fn verify(
        &self,
        dims: &[Dims; 4],
        data_types: &[Ct; 4],
        ptrs: &[Mem],
        strides: &[u32; 4],
        load_strides: &[u32; 4],
        total_elements: &[u32; 4],
        (m, n, k): (u32, u32, u32),
        saturated: bool,
        epsilon: f32,
        subgroup_size: u32,
        varying_effective_subgroup_size: bool,
    ) -> Result<TestResult, TestError> {
        let d = &self.data;
        let mut res = TestResult::Pass;
        let wg_scope = d.scope == vk::ScopeKHR::WORKGROUP;
        let num_matrix_x = if wg_scope {
            d.workgroups_x
        } else {
            d.subgroups_per_workgroup_x * d.workgroups_x
        };
        let num_matrix_y = if wg_scope {
            d.workgroups_y
        } else {
            d.subgroups_per_workgroup_y * d.workgroups_y
        };
        let col = d.col_major;

        if d.test_type == TestType::GetCoordinate {
            for m_x in 0..num_matrix_x {
                for m_y in 0..num_matrix_y {
                    for i in 0..m {
                        for j in 0..n {
                            let (coord_x, coord_y, ij) = if col {
                                (m_y * m + j, m_x * n + i, m_x * m + i + strides[3] * (m_y * n + j))
                            } else {
                                (m_y * m + i, m_x * n + j, m_x * n + j + strides[3] * (m_y * m + i))
                            };
                            let coord_1d = coord_y * 3 + coord_x;
                            if is_float_type(data_types[3]) {
                                let output = f64::from(get_data_float(ptrs[3], data_types[3], ij)?);
                                let reference = f64::from(coord_1d);
                                let mut converted = [reference; 2];
                                if let Some(format) = small_float(data_types[3]) {
                                    converted[0] = format.round_value(reference, RoundingDirection::Downward);
                                    converted[1] = format.round_value(reference, RoundingDirection::Upward);
                                }
                                if output != converted[0]
                                    && output != converted[1]
                                    && !((converted[0].is_nan() || converted[1].is_nan()) && output.is_nan())
                                {
                                    res = TestResult::Fail;
                                    break;
                                }
                            } else {
                                let bits = data_types[3].bits();
                                let mask = if bits == 32 { 0xFFFF_FFFF } else { (1u32 << bits) - 1 };
                                let output = get_data_int(ptrs[3], data_types[3], ij)? & mask;
                                if output != coord_1d & mask {
                                    res = TestResult::Fail;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        } else if is_convert_op(d.test_type) || is_transpose_test(d.test_type) {
            for m_x in 0..num_matrix_x {
                for m_y in 0..num_matrix_y {
                    for i in 0..m {
                        for j in 0..n {
                            let mut input_converted = [0f64; 2];
                            let mut output = 0f64;
                            for (idx, up) in [false, true].into_iter().enumerate() {
                                let ij = if col {
                                    m_x * m + i + strides[0] * m_y * n + load_strides[0] * j
                                } else {
                                    m_x * n + j + strides[0] * m_y * m + load_strides[0] * i
                                };
                                let input_a = get_data_converted_to(ptrs[0], data_types[0], ij, data_types[3])?;
                                input_converted[idx] = input_a;

                                let ij = if is_transpose_test(d.test_type) {
                                    if col {
                                        m_x * n + j + strides[3] * (m_y * m + i)
                                    } else {
                                        m_x * m + i + strides[3] * (m_y * n + j)
                                    }
                                } else if col {
                                    m_x * m + i + strides[3] * (m_y * n + j)
                                } else {
                                    m_x * n + j + strides[3] * (m_y * m + i)
                                };
                                output = get_data_converted_to(ptrs[3], data_types[3], ij, data_types[3])?;
                                if let Some(format) = small_float(data_types[3]) {
                                    let rd = if up {
                                        RoundingDirection::Upward
                                    } else {
                                        RoundingDirection::Downward
                                    };
                                    input_converted[idx] = format.round_value(input_converted[idx], rd);
                                }
                                if is_saturated_convert_op(d.test_type) {
                                    let limit = match data_types[3] {
                                        Ct::E5m2 => Some(FLOAT_E5M2),
                                        Ct::E4m3 => Some(FLOAT_E4M3),
                                        _ => None,
                                    };
                                    if let Some(format) = limit
                                        && input_a.abs() > f64::from(format.to_f32(format.largest_normal(1)))
                                    {
                                        let sign = if input_a > 0.0 { 1 } else { -1 };
                                        input_converted[idx] = f64::from(format.to_f32(format.largest_normal(sign)));
                                    }
                                }
                            }
                            if input_converted[0] != output
                                && input_converted[1] != output
                                && !((input_converted[0].is_nan() || input_converted[1].is_nan()) && output.is_nan())
                            {
                                res = TestResult::Fail;
                            }
                        }
                    }
                }
            }
        } else if is_float_type(data_types[0]) {
            if is_reduce_op(d.test_type) {
                res = self.verify_reduce(dims, data_types, ptrs, strides, load_strides, (m, n), res)?;
            } else if is_addressing_test(d) {
                res = self.verify_addressing(dims, data_types, ptrs, strides, load_strides, (m, n), res)?;
            } else if d.test_type == TestType::PerElementOpRowCol {
                for m_x in 0..num_matrix_x {
                    for m_y in 0..num_matrix_y {
                        for i in 0..m {
                            for j in 0..n {
                                let ij = if col {
                                    m_x * m + i + strides[0] * m_y * n + load_strides[0] * j
                                } else {
                                    m_x * n + j + strides[0] * m_y * m + load_strides[0] * i
                                };
                                let reference = get_data_float(ptrs[0], data_types[0], ij)?;
                                let d_ij = get_data_float(ptrs[3], data_types[3], ij)?;
                                if reference + (i * 3 + j) as f32 != d_ij {
                                    res = TestResult::Fail;
                                }
                            }
                        }
                    }
                }
            } else if !is_matrix_mul_add_op(d.test_type) {
                for i in 0..total_elements[3] {
                    let input_a = get_data_float(ptrs[0], data_types[0], i)?;
                    let input_b = get_data_float(ptrs[1], data_types[1], i)?;
                    let output = get_data_float(ptrs[3], data_types[3], i)?;
                    match d.test_type {
                        TestType::Length => {
                            if output < 1.0 || output > (n * m) as f32 {
                                res = TestResult::Fail;
                            }
                            if !wg_scope
                                && !varying_effective_subgroup_size
                                && output != (n * m / subgroup_size) as f32
                                && res == TestResult::Pass
                            {
                                res = TestResult::QualityWarning;
                            }
                        }
                        TestType::Constant => {
                            if output != 1.0 {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::Composite | TestType::Add => {
                            if output != input_a + input_b {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::CompositeArray | TestType::CompositeRvalue => {
                            if output != input_a {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::Sub => {
                            if output != input_a - input_b {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::Div => {
                            let mut ulp = if d.input_type == Ct::F16 {
                                1.0 / 1024.0
                            } else {
                                1.0 / (8.0 * 1024.0 * 1024.0)
                            };
                            ulp *= 3.0;
                            if input_b != 0.0 && (output - input_a / input_b).abs() > ulp * (input_a / input_b).abs() {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::Mul => {
                            if data_types[0] == Ct::F16 {
                                let expected32 = input_a * input_b;
                                let expected = Float16::from_bits(Float16::new(expected32).bits()).as_float();
                                if output != expected {
                                    res = TestResult::Fail;
                                }
                            } else if output != input_a * input_b {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::Negate | TestType::Func | TestType::FuncConstIn => {
                            if output != -input_a {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::MatrixTimesScalar => {
                            if f64::from(output) != 6.0 * f64::from(input_a) {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::MulticomponentLoad => {
                            if output != input_a {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::MulticomponentSave => {
                            let mut temp = 0u32;
                            let temp_mem = Mem((&mut temp as *mut u32).cast());
                            set_data_float(temp_mem, data_types[3], 0, input_a)?;
                            let converted_input = get_data_float(temp_mem, data_types[3], 0)?;
                            if output != converted_input {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::PerElementOp | TestType::PerElementOpStruct => {
                            if f64::from(output) != f64::from(input_a) + 2.0 {
                                res = TestResult::Fail;
                            }
                        }
                        TestType::PerElementOpMat => {
                            if output != 3.0 * input_a {
                                res = TestResult::Fail;
                            }
                        }
                        _ => return Err(TestError::InternalError("Unimplemented".to_string())),
                    }
                }
            } else {
                let is_split_barrier_looped = matches!(
                    d.test_type,
                    TestType::MatrixMulAddSplitBarrierLoop | TestType::MatrixMulAddSplitBarrierSkew
                );
                for m_x in 0..num_matrix_x {
                    for m_y in 0..num_matrix_y {
                        for i in 0..m {
                            for j in 0..n {
                                let mut reference = 0f32;
                                for kk in 0..k {
                                    let (mut a_ik, b_kj) = if d.test_type == TestType::MatrixMulAddDequant {
                                        let decode = |ptr: Mem, idx: u32| -> Result<f32, TestError> {
                                            let value = (get_data_int(ptr, Ct::U8, idx / 2)? >> ((idx & 1) * 4)) & 0xF;
                                            Ok(0.5 * ((((value & 7) as i32 - 3) * (1 + (value / 8) as i32)) as f32))
                                        };
                                        let block_ik = ((m_x * k + kk) / BLOCK_SIZE[1])
                                            + (strides[0] / BLOCK_SIZE[1]) * ((m_y * m + i) / BLOCK_SIZE[0]);
                                        let idx_a = block_ik * BLOCK_SIZE[0] * BLOCK_SIZE[1]
                                            + (i % BLOCK_SIZE[0]) * BLOCK_SIZE[1]
                                            + (kk % BLOCK_SIZE[1]);
                                        let block_kj = ((m_x * n + j) / BLOCK_SIZE[1])
                                            + (strides[1] / BLOCK_SIZE[1]) * ((m_y * k + kk) / BLOCK_SIZE[0]);
                                        let idx_b = block_kj * BLOCK_SIZE[0] * BLOCK_SIZE[1]
                                            + (kk % BLOCK_SIZE[0]) * BLOCK_SIZE[1]
                                            + (j % BLOCK_SIZE[1]);
                                        (decode(ptrs[0], idx_a)?, decode(ptrs[1], idx_b)?)
                                    } else {
                                        let ik = if col {
                                            m_x * m + i + strides[0] * m_y * k + load_strides[0] * kk
                                        } else {
                                            m_x * k + kk + strides[0] * m_y * m + load_strides[0] * i
                                        };
                                        let kj = if col {
                                            m_x * k + kk + strides[1] * m_y * n + load_strides[1] * j
                                        } else {
                                            m_x * n + j + strides[1] * m_y * k + load_strides[1] * kk
                                        };
                                        (
                                            get_data_float(ptrs[0], data_types[0], ik)?,
                                            get_data_float(ptrs[1], data_types[1], kj)?,
                                        )
                                    };

                                    reference += a_ik * b_kj;
                                    if is_split_barrier_looped {
                                        let mut temp = 0u32;
                                        let temp_mem = Mem((&mut temp as *mut u32).cast());
                                        set_data_float(temp_mem, data_types[0], 0, a_ik + 1.0)?;
                                        a_ik = get_data_float(temp_mem, data_types[0], 0)?;
                                        reference += a_ik * b_kj;
                                    }
                                }

                                let ij = if col {
                                    m_x * m + i + strides[2] * m_y * n + load_strides[2] * j
                                } else {
                                    m_x * n + j + strides[2] * m_y * m + load_strides[2] * i
                                };
                                let c_ij = get_data_float(ptrs[2], data_types[2], ij)?;

                                reference += c_ij;
                                if data_types[3] == Ct::F16 {
                                    reference = Float16::new(reference).as_float();
                                }
                                if matches!(data_types[3], Ct::E5m2 | Ct::E4m3 | Ct::F16)
                                    && let Some(format) = small_float(data_types[3])
                                {
                                    reference = format.to_f32(format.from_f32(reference, RoundingDirection::ToEven));
                                }

                                let ij = if col {
                                    m_x * m + i + strides[2] * (m_y * n + j)
                                } else {
                                    m_x * n + j + strides[2] * (m_y * m + i)
                                };
                                let d_ij = get_data_float(ptrs[3], data_types[3], ij)?;

                                if (reference - d_ij).abs() > epsilon {
                                    if m.max(n).max(k) >= 48 {
                                        let special_threshold = if data_types[3] == Ct::Bf16 {
                                            calc_b16_threshold(reference)
                                        } else {
                                            None
                                        };
                                        if let Some(threshold) = special_threshold {
                                            if (reference - d_ij).abs() > threshold {
                                                res = TestResult::Fail;
                                            }
                                        } else if f64::from((reference - d_ij).abs())
                                            / (f64::from(reference.abs()) + 0.001)
                                            > 3.0 / 1024.0
                                        {
                                            res = TestResult::Fail;
                                        }
                                    } else {
                                        res = TestResult::Fail;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else if is_reduce_op(d.test_type) {
            res = self.verify_reduce(dims, data_types, ptrs, strides, load_strides, (m, n), res)?;
        } else if is_addressing_test(d) {
            res = self.verify_addressing(dims, data_types, ptrs, strides, load_strides, (m, n), res)?;
        } else if d.test_type == TestType::PerElementOpRowCol {
            let result_size = data_types[3].bits();
            let mask = if result_size == 32 {
                !0u32
            } else {
                (1u32 << result_size) - 1
            };
            for m_x in 0..num_matrix_x {
                for m_y in 0..num_matrix_y {
                    for i in 0..m {
                        for j in 0..n {
                            let ij = if col {
                                m_x * m + i + strides[0] * m_y * n + load_strides[0] * j
                            } else {
                                m_x * n + j + strides[0] * m_y * m + load_strides[0] * i
                            };
                            let reference = get_data_int(ptrs[0], data_types[0], ij)?;
                            let d_ij = get_data_int(ptrs[3], data_types[3], ij)?;
                            if (reference.wrapping_add(i * 3 + j) & mask) != (d_ij & mask) {
                                res = TestResult::Fail;
                            }
                        }
                    }
                }
            }
        } else if !is_matrix_mul_add_op(d.test_type) {
            for i in 0..total_elements[3] {
                let input_a = get_data_int(ptrs[0], data_types[0], i)?;
                let input_b = get_data_int(ptrs[1], data_types[1], i)?;
                let output = get_data_int(ptrs[3], data_types[3], i)?;
                let result_size = data_types[3].bits();
                let mask = if result_size == 32 {
                    !0u32
                } else {
                    (1u32 << result_size) - 1
                };
                match d.test_type {
                    TestType::Length => {
                        if output < 1 || output > n * m {
                            res = TestResult::Fail;
                        }
                        if !wg_scope
                            && !varying_effective_subgroup_size
                            && output != n * m / subgroup_size
                            && res == TestResult::Pass
                        {
                            res = TestResult::QualityWarning;
                        }
                    }
                    TestType::Constant => {
                        if output != 1 {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::Composite | TestType::Add => {
                        if (output & mask) != (input_a.wrapping_add(input_b) & mask) {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::CompositeArray | TestType::CompositeRvalue => {
                        if (output & mask) != (input_a & mask) {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::Sub => {
                        if (output & mask) != (input_a.wrapping_sub(input_b) & mask) {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::Div => {
                        if is_sint_type(data_types[3]) {
                            if input_b == 0 {
                                return Err(TestError::InternalError(
                                    "division by zero in the reference".to_string(),
                                ));
                            }
                            let quotient = (input_a as i32).wrapping_div(input_b as i32);
                            if ((output as i32) as u32 & mask) != (quotient as u32 & mask) {
                                res = TestResult::Fail;
                            }
                        } else if input_b != 0 && output != input_a / input_b {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::Mul => {
                        if ((output as i32) as u32 & mask)
                            != ((input_a as i32).wrapping_mul(input_b as i32) as u32 & mask)
                        {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::Negate | TestType::Func | TestType::FuncConstIn => {
                        if (output & mask) != ((input_a as i32).wrapping_neg() as u32 & mask) {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::MatrixTimesScalar => {
                        if (output & mask) != (6u32.wrapping_mul(input_a) & mask) {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::MulticomponentLoad => {
                        if output != input_a {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::MulticomponentSave => {
                        if (output & mask) != (input_a & mask) {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::PerElementOp | TestType::PerElementOpStruct => {
                        if (output & mask) != (input_a.wrapping_add(2) & mask) {
                            res = TestResult::Fail;
                        }
                    }
                    TestType::PerElementOpMat => {
                        if (output & mask) != (input_a.wrapping_mul(3) & mask) {
                            res = TestResult::Fail;
                        }
                    }
                    _ => return Err(TestError::InternalError("Unimplemented".to_string())),
                }
            }
        } else {
            let is_split_barrier_looped = matches!(
                d.test_type,
                TestType::MatrixMulAddSplitBarrierLoop | TestType::MatrixMulAddSplitBarrierSkew
            );
            for m_x in 0..num_matrix_x {
                for m_y in 0..num_matrix_y {
                    for i in 0..m {
                        for j in 0..n {
                            let mut reference = 0u32;
                            for kk in 0..k {
                                let ik = if col {
                                    m_x * m + i + strides[0] * m_y * k + load_strides[0] * kk
                                } else {
                                    m_x * k + kk + strides[0] * m_y * m + load_strides[0] * i
                                };
                                let mut a_ik = get_data_int(ptrs[0], data_types[0], ik)?;
                                let kj = if col {
                                    m_x * k + kk + strides[1] * m_y * n + load_strides[1] * j
                                } else {
                                    m_x * n + j + strides[1] * m_y * k + load_strides[1] * kk
                                };
                                let b_kj = get_data_int(ptrs[1], data_types[1], kj)?;

                                reference = reference.wrapping_add(a_ik.wrapping_mul(b_kj));
                                if is_split_barrier_looped {
                                    let mut temp = 0u32;
                                    let temp_mem = Mem((&mut temp as *mut u32).cast());
                                    set_data_int(temp_mem, data_types[0], 0, a_ik.wrapping_add(1))?;
                                    a_ik = get_data_int(temp_mem, data_types[0], 0)?;
                                    reference = reference.wrapping_add(a_ik.wrapping_mul(b_kj));
                                }
                            }

                            let ij = if col {
                                m_x * m + i + strides[2] * m_y * n + load_strides[2] * j
                            } else {
                                m_x * n + j + strides[2] * m_y * m + load_strides[2] * i
                            };
                            let c_ij = get_data_int(ptrs[2], data_types[2], ij)?;

                            if saturated {
                                reference = sat_add_data(data_types[2], reference, c_ij)?;
                            } else {
                                reference = reference.wrapping_add(c_ij);
                                let bits = data_types[3].bits();
                                let mask = if bits == 32 { 0xFFFF_FFFF } else { (1u32 << bits) - 1 };
                                reference &= mask;
                            }

                            let ij = if col {
                                m_x * m + i + strides[2] * (m_y * n + j)
                            } else {
                                m_x * n + j + strides[2] * (m_y * m + i)
                            };
                            let d_ij = get_data_int(ptrs[3], data_types[3], ij)?;
                            if reference != d_ij {
                                res = TestResult::Fail;
                            }
                        }
                    }
                }
            }
        }
        Ok(res)
    }
}

impl TestInstance for CooperativeMatrixInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.queue_pass()
    }
}
