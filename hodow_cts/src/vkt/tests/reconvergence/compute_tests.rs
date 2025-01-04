// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/reconvergence/vktReconvergenceTests.cpp
//   (`RandomProgram::execute`, `ComputeRandomProgram`, `ReconvergenceTestComputeInstance::iterate`, `calculateAndLogResult`, `checkSupport`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The random program is not generated here: `scripts/gen_reconvergence_maximal_compute.py` replays
// `RandomProgram::generateRandomProgram` and `printCode` and writes the shaders and the op list of every case (`compute_cases.rs`). What the
// stride of the device decides upstream (`rnd % invocationStride` of the local index comparisons) is a specialization constant here, computed from
// the raw draw the table holds; the retries of the uniform control flow programs depend on the stride too, so a case holds one program per
// stride the device can end up with (the strides that give the same program share it).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::compute_cases::COMPUTE_CASES;
use crate::generated::shaders::reconvergence_compute::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE_X: u32 = 7;
const SIZE_Y: u32 = 13;
const LOCAL_INDEX_CONSTANT_BASE: u32 = 10;
const STATE_STACK_SIZE: usize = 32;
const BALLOT_BITS: u32 = 128;

const OP_BALLOT: u32 = 0;
const OP_STORE: u32 = 1;
const OP_IF_MASK: u32 = 2;
const OP_ELSE_MASK: u32 = 3;
const OP_ENDIF: u32 = 4;
const OP_IF_LOOPCOUNT: u32 = 5;
const OP_ELSE_LOOPCOUNT: u32 = 6;
const OP_IF_LOCAL_INVOCATION_INDEX: u32 = 7;
const OP_ELSE_LOCAL_INVOCATION_INDEX: u32 = 8;
const OP_BREAK: u32 = 9;
const OP_CONTINUE: u32 = 10;
const OP_ELECT: u32 = 11;
const OP_BEGIN_FOR_UNIF: u32 = 12;
const OP_END_FOR_UNIF: u32 = 13;
const OP_BEGIN_FOR_VAR: u32 = 14;
const OP_END_FOR_VAR: u32 = 15;
const OP_BEGIN_FOR_INF: u32 = 16;
const OP_END_FOR_INF: u32 = 17;
const OP_BEGIN_DO_WHILE_UNIF: u32 = 18;
const OP_END_DO_WHILE_UNIF: u32 = 19;
const OP_BEGIN_DO_WHILE_INF: u32 = 20;
const OP_END_DO_WHILE_INF: u32 = 21;
const OP_RETURN: u32 = 22;
const OP_CALL_BEGIN: u32 = 23;
const OP_CALL_END: u32 = 24;
const OP_SWITCH_UNIF_BEGIN: u32 = 25;
const OP_SWITCH_VAR_BEGIN: u32 = 26;
const OP_SWITCH_LOOP_COUNT_BEGIN: u32 = 27;
const OP_CASE_MASK_BEGIN: u32 = 28;
const OP_CASE_LOOP_COUNT_BEGIN: u32 = 29;
const OP_SWITCH_END: u32 = 30;
const OP_CASE_END: u32 = 31;
const OP_NOISE: u32 = 32;

/// One program of a case, for the invocation strides in `strides` (empty: any)
pub struct ReconvergenceVariant {
    pub strides: &'static [u32],
    /// The body of main has no letter in its first 20 characters, upstream's `NotSupportedError`
    pub empty_main: bool,
    pub ops: &'static str,
}

/// One case of `reconvergence.{maximal,subgroup_uniform_control_flow_*,workgroup_uniform_control_flow_*}.compute`
pub struct ReconvergenceCase {
    pub group: &'static str,
    pub name: &'static str,
    pub nesting: u32,
    pub seed_group: u32,
    pub masks: [u128; 5],
    pub variants: &'static [ReconvergenceVariant],
}

impl ReconvergenceCase {
    fn is_maximal(&self) -> bool {
        self.group == "maximal"
    }

    fn is_subgroup_uniform(&self) -> bool {
        self.group.starts_with("subgroup_uniform")
    }

    fn is_workgroup_uniform(&self) -> bool {
        self.group.starts_with("workgroup_uniform")
    }

    fn is_elect(&self) -> bool {
        self.group.ends_with("elect")
    }

    /// The key of the shader program set of the case in the generated shaders
    fn key(&self) -> String {
        let short = match self.group {
            "maximal" => "maximal",
            "subgroup_uniform_control_flow_elect" => "sucf_elect",
            "subgroup_uniform_control_flow_ballot" => "sucf_ballot",
            "workgroup_uniform_control_flow_elect" => "wucf_elect",
            _ => "wucf_ballot",
        };
        format!(
            "reconvergence_compute_{short}_n{}_s{}_{}",
            self.nesting, self.seed_group, self.name
        )
    }

    /// The variant for the invocation stride the device ends up with, and its position (the name of its program is `test` or `test_v<position>`)
    fn variant_for(&self, stride: u32) -> Option<(usize, &'static ReconvergenceVariant)> {
        self.variants
            .iter()
            .enumerate()
            .find(|(_, variant)| variant.strides.is_empty() || variant.strides.contains(&stride))
    }
}

/// `OP`: `value` is the number the op carries (the raw draw of a local index comparison), `bvalue` the ballot of a mask or case op.
#[derive(Clone, Copy)]
struct Op {
    kind: u32,
    value: u64,
    bvalue: u128,
}

fn parse_ops(case: &ReconvergenceCase, variant: &ReconvergenceVariant) -> Vec<Op> {
    variant
        .ops
        .split(' ')
        .map(|token| {
            let (kind, arg) = match token.split_once(':') {
                Some((kind, arg)) => (kind, Some(arg)),
                None => (token, None),
            };
            let kind: u32 = kind.parse().expect("op type");
            let mut op = Op {
                kind,
                value: 0,
                bvalue: 0,
            };
            match (kind, arg) {
                (OP_IF_MASK, Some("u")) => op.bvalue = !0,
                (OP_IF_MASK, Some(index)) => {
                    op.bvalue = case.masks[index[1..].parse::<usize>().expect("mask index")];
                }
                (OP_CASE_MASK_BEGIN | OP_CASE_LOOP_COUNT_BEGIN, Some(ballot)) => {
                    op.bvalue = u128::from_str_radix(ballot, 16).expect("case ballot");
                }
                (_, Some(value)) => op.value = u64::from_str_radix(value, 16).expect("op value"),
                (_, None) => {}
            }
            op
        })
        .collect()
}

/// `bitsetToBallot(0x12345678, ...)`: the value a ballot that is not uniform is expected to have, so that it is not validated
const MAGIC_BALLOT: u128 = 0x12345678;

/// `Ballots`: one 128 bit ballot per subgroup, bit `n` being the invocation `n` of that subgroup.
type Ballots = Vec<u128>;

/// `subgroupSizeToMask(subgroupSize, subgroupCount)`
fn subgroup_size_to_mask(subgroup_size: u32) -> u128 {
    if subgroup_size >= BALLOT_BITS {
        !0
    } else {
        (1u128 << subgroup_size) - 1
    }
}

/// `ballotsFromBallot`
fn ballots_from_ballot(ballot: u128, subgroup_size: u32, subgroup_count: usize) -> Ballots {
    vec![ballot & subgroup_size_to_mask(subgroup_size); subgroup_count]
}

fn ballots_any(ballots: &[u128]) -> bool {
    ballots.iter().any(|&ballot| ballot != 0)
}

fn ballots_and(a: &[u128], b: &[u128]) -> Ballots {
    a.iter().zip(b).map(|(&x, &y)| x & y).collect()
}

fn ballots_not(a: &[u128]) -> Ballots {
    a.iter().map(|&x| !x).collect()
}

/// `Ballots::findBit`
fn find_bit(id: u32, subgroup_size: u32) -> (usize, u32) {
    ((id / subgroup_size) as usize, id % subgroup_size)
}

fn ballots_test(ballots: &[u128], id: u32, subgroup_size: u32) -> bool {
    let (group, bit) = find_bit(id, subgroup_size);
    (ballots[group] >> bit) & 1 != 0
}

/// `bitsetElect(Ballots)`
fn ballots_elect(ballots: &[u128]) -> Ballots {
    ballots
        .iter()
        .map(|&ballot| {
            if ballot == 0 {
                0
            } else {
                1u128 << ballot.trailing_zeros()
            }
        })
        .collect()
}

/// `SubgroupState2`
#[derive(Clone)]
struct SubgroupState {
    active_mask: Ballots,
    continue_mask: Ballots,
    header: usize,
    trip_count: u32,
    is_loop: bool,
    is_call: bool,
    is_switch: bool,
}

/// The outputs of `execute`: the ballots and stores every invocation wrote, `ref[location * stride + id]`.
struct Reference {
    entries: Vec<u128>,
}

/// `RandomProgram::execute` of the compute flavour: the simulation of the program for `subgroup_size` and `invocation_stride` invocations. With `reference`
/// the expected output is written there, without only the number of locations is counted. Returns the largest number of locations of one invocation.
fn execute(
    ops: &[Op],
    subgroup_size: u32,
    invocation_stride: u32,
    mut reference: Option<&mut Reference>,
) -> Result<u32, TestError> {
    let stride = invocation_stride as usize;
    let subgroup_count = invocation_stride.div_ceil(subgroup_size) as usize;
    let mut state_stack = vec![
        SubgroupState {
            active_mask: vec![0; subgroup_count],
            continue_mask: vec![0; subgroup_count],
            header: 0,
            trip_count: 0,
            is_loop: false,
            is_call: false,
            is_switch: false,
        };
        STATE_STACK_SIZE
    ];
    let mut out_loc = vec![0u32; stride];
    for id in 0..invocation_stride {
        let (group, bit) = find_bit(id, subgroup_size);
        state_stack[0].active_mask[group] |= 1u128 << bit;
    }

    let mut simulate = |active_mask: &[u128], out_loc: &mut Vec<u32>, value: Option<u128>| -> Result<(), TestError> {
        for id in 0..invocation_stride {
            if !ballots_test(active_mask, id, subgroup_size) {
                continue;
            }
            if let Some(reference) = reference.as_deref_mut() {
                let entry = match value {
                    Some(value) => value,
                    None => active_mask[find_bit(id, subgroup_size).0] & subgroup_size_to_mask(subgroup_size),
                };
                let index = out_loc[id as usize] as usize * stride + id as usize;
                *reference
                    .entries
                    .get_mut(index)
                    .ok_or_else(|| TestError::Fail("reference location out of range".to_string()))? = entry;
            }
            out_loc[id as usize] += 1;
        }
        Ok(())
    };

    let mut nesting = 0usize;
    let mut loop_nesting = 0u32;
    let mut i = 0usize;

    while i < ops.len() {
        let op = ops[i];
        match op.kind {
            OP_BALLOT => {
                let active = state_stack[nesting].active_mask.clone();
                // Emit a magic value to indicate that we shouldn't validate this ballot
                let value = (op.value != 0).then(|| MAGIC_BALLOT & subgroup_size_to_mask(subgroup_size));
                simulate(&active, &mut out_loc, value)?;
            }
            OP_STORE => {
                let active = state_stack[nesting].active_mask.clone();
                simulate(&active, &mut out_loc, Some(u128::from(op.value & 0xFFFF_FFFF)))?;
            }
            OP_IF_MASK => {
                nesting += 1;
                state_stack[nesting].active_mask = ballots_and(
                    &state_stack[nesting - 1].active_mask,
                    &ballots_from_ballot(op.bvalue, subgroup_size, subgroup_count),
                );
                state_stack[nesting].header = i;
                state_stack[nesting].is_loop = false;
                state_stack[nesting].is_switch = false;
            }
            OP_ELSE_MASK => {
                let header = state_stack[nesting].header;
                state_stack[nesting].active_mask = ballots_and(
                    &state_stack[nesting - 1].active_mask,
                    &ballots_not(&ballots_from_ballot(ops[header].bvalue, subgroup_size, subgroup_count)),
                );
            }
            OP_IF_LOOPCOUNT => {
                let mut n = nesting;
                while !state_stack[n].is_loop {
                    n -= 1;
                }
                let trip_ballot = 1u128 << state_stack[n].trip_count;

                nesting += 1;
                state_stack[nesting].active_mask = ballots_and(
                    &state_stack[nesting - 1].active_mask,
                    &ballots_from_ballot(trip_ballot, subgroup_size, subgroup_count),
                );
                state_stack[nesting].header = i;
                state_stack[nesting].is_loop = false;
                state_stack[nesting].is_switch = false;
            }
            OP_ELSE_LOOPCOUNT => {
                let mut n = nesting;
                while !state_stack[n].is_loop {
                    n -= 1;
                }
                let trip_ballot = 1u128 << state_stack[n].trip_count;

                state_stack[nesting].active_mask = ballots_and(
                    &state_stack[nesting - 1].active_mask,
                    &ballots_not(&ballots_from_ballot(trip_ballot, subgroup_size, subgroup_count)),
                );
            }
            OP_IF_LOCAL_INVOCATION_INDEX => {
                let first = (op.value % u64::from(invocation_stride)) as u32;
                let mut mask = vec![0u128; subgroup_count];
                for id in first..subgroup_count as u32 * subgroup_size {
                    let (group, bit) = find_bit(id, subgroup_size);
                    mask[group] |= 1u128 << bit;
                }

                nesting += 1;
                state_stack[nesting].active_mask = ballots_and(&state_stack[nesting - 1].active_mask, &mask);
                state_stack[nesting].header = i;
                state_stack[nesting].is_loop = false;
                state_stack[nesting].is_switch = false;
            }
            OP_ELSE_LOCAL_INVOCATION_INDEX => {
                let end = ((op.value % u64::from(invocation_stride)) as u32).min(subgroup_count as u32 * subgroup_size);
                let mut mask = vec![0u128; subgroup_count];
                for id in 0..end {
                    let (group, bit) = find_bit(id, subgroup_size);
                    mask[group] |= 1u128 << bit;
                }

                state_stack[nesting].active_mask = ballots_and(&state_stack[nesting - 1].active_mask, &mask);
            }
            OP_ENDIF => nesting -= 1,
            OP_BEGIN_FOR_UNIF | OP_BEGIN_FOR_VAR | OP_BEGIN_FOR_INF | OP_BEGIN_DO_WHILE_INF => {
                nesting += 1;
                loop_nesting += 1;
                state_stack[nesting].active_mask = state_stack[nesting - 1].active_mask.clone();
                state_stack[nesting].header = i;
                state_stack[nesting].trip_count = 0;
                state_stack[nesting].is_loop = true;
                state_stack[nesting].is_switch = false;
                state_stack[nesting].continue_mask = vec![0; subgroup_count];
            }
            OP_BEGIN_DO_WHILE_UNIF => {
                nesting += 1;
                loop_nesting += 1;
                state_stack[nesting].active_mask = state_stack[nesting - 1].active_mask.clone();
                state_stack[nesting].header = i;
                state_stack[nesting].trip_count = 1;
                state_stack[nesting].is_loop = true;
                state_stack[nesting].is_switch = false;
                state_stack[nesting].continue_mask = vec![0; subgroup_count];
            }
            OP_END_FOR_UNIF => {
                let state = &mut state_stack[nesting];
                state.trip_count += 1;
                let continue_mask = std::mem::replace(&mut state.continue_mask, vec![0; subgroup_count]);
                for (active, cont) in state.active_mask.iter_mut().zip(&continue_mask) {
                    *active |= cont;
                }
                if u64::from(state.trip_count) < ops[state.header].value && ballots_any(&state.active_mask) {
                    i = state.header + 1;
                    continue;
                }
                loop_nesting -= 1;
                nesting -= 1;
            }
            OP_END_DO_WHILE_UNIF => {
                let state = &mut state_stack[nesting];
                let continue_mask = std::mem::replace(&mut state.continue_mask, vec![0; subgroup_count]);
                for (active, cont) in state.active_mask.iter_mut().zip(&continue_mask) {
                    *active |= cont;
                }
                if u64::from(state.trip_count) < ops[state.header].value && ballots_any(&state.active_mask) {
                    i = state.header + 1;
                    state.trip_count += 1;
                    continue;
                }
                loop_nesting -= 1;
                nesting -= 1;
            }
            OP_END_FOR_VAR => {
                let state = &mut state_stack[nesting];
                state.trip_count += 1;
                let continue_mask = std::mem::replace(&mut state.continue_mask, vec![0; subgroup_count]);
                for (active, cont) in state.active_mask.iter_mut().zip(&continue_mask) {
                    *active |= cont;
                }
                let mut trip_ballot = 0u128;
                if subgroup_size != state.trip_count {
                    for bit in state.trip_count..BALLOT_BITS {
                        trip_ballot |= 1u128 << bit;
                    }
                }
                let filter = ballots_from_ballot(trip_ballot, subgroup_size, subgroup_count);
                state.active_mask = ballots_and(&state.active_mask, &filter);

                if ballots_any(&state.active_mask) {
                    i = state.header + 1;
                    continue;
                }
                loop_nesting -= 1;
                nesting -= 1;
            }
            OP_END_FOR_INF | OP_END_DO_WHILE_INF => {
                let state = &mut state_stack[nesting];
                state.trip_count += 1;
                let continue_mask = std::mem::replace(&mut state.continue_mask, vec![0; subgroup_count]);
                for (active, cont) in state.active_mask.iter_mut().zip(&continue_mask) {
                    *active |= cont;
                }
                if ballots_any(&state.active_mask) {
                    if op.kind == OP_END_FOR_INF {
                        // output expected OP_BALLOT values
                        let active = state.active_mask.clone();
                        simulate(&active, &mut out_loc, None)?;
                    }
                    i = state_stack[nesting].header + 1;
                    continue;
                }
                loop_nesting -= 1;
                nesting -= 1;
            }
            OP_BREAK => {
                let mut n = nesting;
                let mask = state_stack[nesting].active_mask.clone();
                loop {
                    let cleared = ballots_and(&state_stack[n].active_mask, &ballots_not(&mask));
                    state_stack[n].active_mask = cleared;
                    if state_stack[n].is_loop || state_stack[n].is_switch {
                        break;
                    }
                    n -= 1;
                }
            }
            OP_CONTINUE => {
                let mut n = nesting;
                let mask = state_stack[nesting].active_mask.clone();
                loop {
                    let cleared = ballots_and(&state_stack[n].active_mask, &ballots_not(&mask));
                    state_stack[n].active_mask = cleared;
                    if state_stack[n].is_loop {
                        for (cont, bits) in state_stack[n].continue_mask.iter_mut().zip(&mask) {
                            *cont |= bits;
                        }
                        break;
                    }
                    n -= 1;
                }
            }
            OP_ELECT => {
                nesting += 1;
                state_stack[nesting].active_mask = ballots_elect(&state_stack[nesting - 1].active_mask);
                state_stack[nesting].header = i;
                state_stack[nesting].is_loop = false;
                state_stack[nesting].is_switch = false;
            }
            OP_RETURN => {
                let mask = state_stack[nesting].active_mask.clone();
                for n in (0..=nesting).rev() {
                    let cleared = ballots_and(&state_stack[n].active_mask, &ballots_not(&mask));
                    state_stack[n].active_mask = cleared;
                    if state_stack[n].is_call {
                        break;
                    }
                }
            }
            OP_CALL_BEGIN => {
                nesting += 1;
                state_stack[nesting].active_mask = state_stack[nesting - 1].active_mask.clone();
                state_stack[nesting].is_loop = false;
                state_stack[nesting].is_switch = false;
                state_stack[nesting].is_call = true;
            }
            OP_CALL_END => {
                state_stack[nesting].is_call = false;
                nesting -= 1;
            }
            OP_NOISE => {}
            OP_SWITCH_UNIF_BEGIN | OP_SWITCH_VAR_BEGIN | OP_SWITCH_LOOP_COUNT_BEGIN => {
                nesting += 1;
                state_stack[nesting].active_mask = state_stack[nesting - 1].active_mask.clone();
                state_stack[nesting].header = i;
                state_stack[nesting].is_loop = false;
                state_stack[nesting].is_switch = true;
            }
            OP_SWITCH_END => nesting -= 1,
            OP_CASE_MASK_BEGIN => {
                state_stack[nesting].active_mask = ballots_and(
                    &state_stack[nesting - 1].active_mask,
                    &ballots_from_ballot(op.bvalue, subgroup_size, subgroup_count),
                );
            }
            OP_CASE_LOOP_COUNT_BEGIN => {
                let mut n = nesting;
                let mut l = loop_nesting;

                loop {
                    if state_stack[n].is_loop {
                        l = l.wrapping_sub(1);
                        if u64::from(l) == ops[state_stack[nesting].header].value {
                            break;
                        }
                    }
                    n -= 1;
                }

                if (1u128 << state_stack[n].trip_count) & op.bvalue != 0 {
                    state_stack[nesting].active_mask = state_stack[nesting - 1].active_mask.clone();
                } else {
                    state_stack[nesting].active_mask = vec![0; subgroup_count];
                }
            }
            OP_CASE_END => {}
            other => return Err(TestError::Fail(format!("unknown op {other}"))),
        }
        i += 1;
    }

    Ok(out_loc.iter().copied().max().unwrap_or(0))
}

struct ReconvergenceTestCase {
    data: &'static ReconvergenceCase,
}

impl TestCase for ReconvergenceTestCase {
    fn name(&self) -> &str {
        self.data.name
    }

    /// `ReconvergenceTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.api_version() < (1, 1, 0) {
            return Err(TestError::NotSupported("Vulkan 1.1 not supported".to_string()));
        }
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
        let limits = context.get_device_properties().limits;

        if self.data.is_elect() {
            if !subgroup_properties
                .supported_operations
                .contains(vk::SubgroupFeatureFlags::BASIC)
            {
                return Err(TestError::NotSupported(
                    "VK_SUBGROUP_FEATURE_BASIC_BIT not supported".to_string(),
                ));
            }
        } else if !subgroup_properties
            .supported_operations
            .contains(vk::SubgroupFeatureFlags::BALLOT)
        {
            return Err(TestError::NotSupported(
                "VK_SUBGROUP_FEATURE_BALLOT_BIT not supported".to_string(),
            ));
        }

        let (size_x, size_y) = validated_size(context);
        if size_x > limits.max_compute_work_group_size[0]
            || size_y > limits.max_compute_work_group_size[1]
            || size_x * size_y > limits.max_compute_work_group_invocations
        {
            return Err(TestError::NotSupported(
                "compute workgroup count exceeds device limit".to_string(),
            ));
        }

        if !subgroup_properties
            .supported_stages
            .contains(vk::ShaderStageFlags::COMPUTE)
        {
            return Err(TestError::NotSupported(
                "VK_SHADER_STAGE_COMPUTE_BIT does not support subgroup operations".to_string(),
            ));
        }

        // Both subgroup- AND workgroup-uniform tests are enabled by shaderSubgroupUniformControlFlow.
        if self.data.is_subgroup_uniform() || self.data.is_workgroup_uniform() {
            context.require_device_functionality("VK_KHR_shader_subgroup_uniform_control_flow")?;
            let mut uniform = vk::PhysicalDeviceShaderSubgroupUniformControlFlowFeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut uniform);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if uniform.shader_subgroup_uniform_control_flow == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderSubgroupUniformControlFlow not supported".to_string(),
                ));
            }
        }

        if self.data.is_maximal() {
            context.require_device_functionality("VK_KHR_shader_maximal_reconvergence")?;
            let mut maximal = vk::PhysicalDeviceShaderMaximalReconvergenceFeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut maximal);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if maximal.shader_maximal_reconvergence == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderMaximalReconvergence not supported".to_string(),
                ));
            }
        }

        let (size_x, size_y) = validated_size(context);
        match self.data.variant_for(size_x * size_y) {
            None => Err(TestError::NotPorted(format!(
                "no program was generated for the workgroup of {} invocations (the generator's simulation of nested infinite loops is too slow, or the subgroup size is unusual)",
                size_x * size_y
            ))),
            Some((_, variant)) if variant.empty_main => Err(TestError::NotSupported(
                "The body of main shader function must not be empty".to_string(),
            )),
            Some(_) => Ok(()),
        }
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.data.key();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ReconvergenceInstance {
            context,
            data: self.data,
        })
    }
}

fn device_subgroup_size(context: &Context<'_>) -> u32 {
    let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    subgroup_properties.subgroup_size
}

fn compute_full_subgroups(context: &Context<'_>) -> bool {
    let mut size_control = vk::PhysicalDeviceSubgroupSizeControlFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut size_control);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    size_control.compute_full_subgroups != vk::FALSE
}

/// `validateCaseDef`: the workgroup is a full subgroup wide when the device can run full subgroups.
fn validated_size(context: &Context<'_>) -> (u32, u32) {
    if context.is_device_functionality_supported("VK_EXT_subgroup_size_control") && compute_full_subgroups(context) {
        let subgroup_size = device_subgroup_size(context);
        (subgroup_size, (SIZE_X * SIZE_Y).div_ceil(subgroup_size))
    } else {
        (SIZE_X, SIZE_Y)
    }
}

struct ReconvergenceInstance<'a> {
    context: &'a Context<'a>,
    data: &'static ReconvergenceCase,
}

/// `ReconvergenceTestInstance::createComputePipeline`: the workgroup size and the local index comparisons are specialized.
fn create_compute_pipeline<'a>(
    context: &'a Context<'a>,
    pipeline_layout: vk::PipelineLayout,
    shader: vk::ShaderModule,
    spec_data: &[u32],
    subgroup_size: u32,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let device = context.get_device();
    let entries: Vec<vk::SpecializationMapEntry> = (0..spec_data.len() as u32)
        .map(|index| vk::SpecializationMapEntry {
            constant_id: if index < 2 {
                index
            } else {
                LOCAL_INDEX_CONSTANT_BASE + index - 2
            },
            offset: index * 4,
            size: 4,
        })
        .collect();
    let spec_info = vk::SpecializationInfo {
        map_entry_count: entries.len() as u32,
        map_entries: entries.as_ptr(),
        data_size: std::mem::size_of_val(spec_data),
        data: spec_data.as_ptr().cast(),
    };
    let subgroup_size_info = vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo {
        s_type: vk::StructureType::PIPELINE_SHADER_STAGE_REQUIRED_SUBGROUP_SIZE_CREATE_INFO,
        next: std::ptr::null(),
        required_subgroup_size: subgroup_size,
    };
    let full_subgroups = subgroup_size <= 64
        && context.is_device_functionality_supported("VK_EXT_subgroup_size_control")
        && compute_full_subgroups(context);
    let stage = vk::PipelineShaderStageCreateInfo {
        s_type: vk::StructureType::PIPELINE_SHADER_STAGE_CREATE_INFO,
        next: if full_subgroups {
            (&subgroup_size_info as *const vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo).cast()
        } else {
            std::ptr::null()
        },
        flags: if full_subgroups {
            vk::PipelineShaderStageCreateFlags::REQUIRE_FULL_SUBGROUPS
        } else {
            vk::PipelineShaderStageCreateFlags::empty()
        },
        stage: vk::ShaderStageFlags::COMPUTE,
        module: shader,
        name: c"main".as_ptr().cast(),
        specialization_info: &spec_info,
    };
    let create_info = vk::ComputePipelineCreateInfo {
        s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::PipelineCreateFlags::empty(),
        stage,
        layout: pipeline_layout,
        base_pipeline_handle: vk::Pipeline::null(),
        base_pipeline_index: 0,
    };
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `PushConstant`, as the words the shader block holds.
type PushConstant = [u32; 6];

fn host_buffer<'a>(context: &'a Context<'a>, size: u64) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(
            size,
            vk::BufferUsageFlags::STORAGE_BUFFER
                | vk::BufferUsageFlags::TRANSFER_DST
                | vk::BufferUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED,
    )
}

impl TestInstance for ReconvergenceInstance<'_> {
    /// `ReconvergenceTestComputeInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let vk = context.get_device();
        let limits = context.get_device_properties().limits;

        let (size_x, size_y) = validated_size(context);
        let invocation_stride = size_x * size_y;
        let subgroup_size = device_subgroup_size(context);
        let (variant_index, variant) = self
            .data
            .variant_for(invocation_stride)
            .ok_or_else(|| TestError::NotPorted("no program was generated for this workgroup size".to_string()))?;
        let ops = parse_ops(self.data, variant);

        let mut max_loc = execute(&ops, subgroup_size, invocation_stride, None)?;

        // maxLoc is per-invocation. Add one (to make sure no additional writes are done) and multiply by the number of invocations
        max_loc += 1;
        max_loc *= invocation_stride;

        // buffer[0] is an input filled with a[i] == i, buffer[1] is the output, buffer[2] is the location counts
        let mut sizes = [
            u64::from(invocation_stride) * 4,
            u64::from(max_loc) * 16,
            u64::from(invocation_stride) * 4,
        ];
        for size in sizes {
            if size > u64::from(limits.max_storage_buffer_range) {
                return Err(TestError::NotSupported(
                    "Storage buffer size larger than device limits".to_string(),
                ));
            }
        }

        let mut buffers = Vec::with_capacity(3);
        for size in sizes {
            match host_buffer(context, size) {
                Ok(buffer) => buffers.push(buffer),
                Err(_) => {
                    return Ok(TestStatus::new(
                        TestResult::QualityWarning,
                        format!("Failed device memory allocation {size} bytes"),
                    ));
                }
            }
        }

        let host_ptr = |buffer: &BufferWithMemory<'_>| buffer.get_allocation().get_host_ptr();
        // SAFETY: buffer 0 holds `invocation_stride` words and is mapped in full.
        unsafe {
            let input = std::slice::from_raw_parts_mut(host_ptr(&buffers[0]).cast::<u32>(), invocation_stride as usize);
            for (i, word) in input.iter_mut().enumerate() {
                *word = i as u32;
            }
            std::ptr::write_bytes(host_ptr(&buffers[1]), 0, sizes[1] as usize);
            std::ptr::write_bytes(host_ptr(&buffers[2]), 0, sizes[2] as usize);
        }

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 3)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let push_constant_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            offset: 0,
            size: std::mem::size_of::<PushConstant>() as u32,
        };
        let pipeline_layout =
            make_pipeline_layout_with_push_constants(vk, &[*descriptor_set_layout], &[push_constant_range])?;

        for buffer in &buffers {
            flush_alloc(vk, buffer.get_allocation())?;
        }

        let binaries = context.get_binary_collection();
        let program_name = if variant_index == 0 {
            "test".to_string()
        } else {
            format!("test_v{variant_index}")
        };
        let shader = create_shader_module(vk, binaries.get(&program_name)?)?;
        let mut spec_data = vec![size_x, size_y];
        spec_data.extend(
            ops.iter()
                .filter(|op| op.kind == OP_IF_LOCAL_INVOCATION_INDEX)
                .map(|op| (op.value % u64::from(invocation_stride)) as u32),
        );
        let pipeline = create_compute_pipeline(context, *pipeline_layout, *shader, &spec_data, subgroup_size)?;
        let queue = context.get_universal_queue();
        let cmd_pool = make_command_pool(vk, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let write_descriptors = |buffers: &[BufferWithMemory<'_>], sizes: &[u64; 3]| {
            let infos: Vec<vk::DescriptorBufferInfo> = buffers
                .iter()
                .zip(sizes)
                .map(|(buffer, &size)| make_descriptor_buffer_info(buffer.get(), 0, size))
                .collect();
            let mut builder = DescriptorSetUpdateBuilder::new();
            for (binding, info) in infos.iter().enumerate() {
                builder = builder.write_single(
                    *descriptor_set,
                    Location::binding(binding as u32),
                    vk::DescriptorType::STORAGE_BUFFER,
                    info,
                );
            }
            builder.update(vk);
        };
        write_descriptors(&buffers, &sizes);

        let dispatch = |push_constant: PushConstant| -> Result<(), TestError> {
            begin_command_buffer(vk, cmd_buffer)?;
            let compute_finish_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            let bytes: Vec<u8> = push_constant.iter().flat_map(|word| word.to_ne_bytes()).collect();
            unsafe {
                vk.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[],
                );
                vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
                vk.cmd_push_constants(cmd_buffer, *pipeline_layout, vk::ShaderStageFlags::COMPUTE, 0, &bytes);
                vk.cmd_dispatch(cmd_buffer, 1, 1, 1);
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[compute_finish_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(vk, cmd_buffer)?;
            submit_commands_and_wait(vk, queue, cmd_buffer)
        };

        // compute "maxLoc", the maximum number of locations written
        dispatch([0; 6])?;

        invalidate_alloc(vk, buffers[1].get_allocation())?;
        invalidate_alloc(vk, buffers[2].get_allocation())?;

        // Take the max over all invocations. Add one (to make sure no additional writes are done) and multiply by the number of invocations
        // SAFETY: buffer 2 holds `invocation_stride` location counts and is mapped in full.
        let counts = unsafe {
            std::slice::from_raw_parts(
                host_ptr(&buffers[2]).cast_const().cast::<u32>(),
                invocation_stride as usize,
            )
        };
        let mut new_max_loc = counts.iter().copied().max().unwrap_or(0);
        new_max_loc += 1;
        new_max_loc *= invocation_stride;

        // If we need more space, reallocate buffers[1]
        if new_max_loc > max_loc {
            max_loc = new_max_loc;
            sizes[1] = u64::from(max_loc) * 16;

            if sizes[1] > u64::from(limits.max_storage_buffer_range) {
                return Err(TestError::NotSupported(
                    "Storage buffer size larger than device limits".to_string(),
                ));
            }

            match host_buffer(context, sizes[1]) {
                Ok(buffer) => buffers[1] = buffer,
                Err(_) => {
                    return Ok(TestStatus::new(
                        TestResult::QualityWarning,
                        format!("Failed device memory allocation {} bytes", sizes[1]),
                    ));
                }
            }
            write_descriptors(&buffers, &sizes);
        }

        // Clear any writes to buffer[1] and buffer[2] during the counting pass
        // SAFETY: both buffers are mapped in full.
        unsafe {
            std::ptr::write_bytes(host_ptr(&buffers[1]), 0, sizes[1] as usize);
            std::ptr::write_bytes(host_ptr(&buffers[2]), 0, sizes[2] as usize);
        }
        flush_alloc(vk, buffers[1].get_allocation())?;
        flush_alloc(vk, buffers[2].get_allocation())?;

        // run the actual shader, with the invocationStride of the shader set
        dispatch([invocation_stride, 0, 0, 0, 0, 0])?;

        invalidate_alloc(vk, buffers[1].get_allocation())?;

        // Simulate execution on the CPU, and compare against the GPU result
        let mut reference = Reference {
            entries: vec![0; max_loc as usize],
        };
        execute(&ops, subgroup_size, invocation_stride, Some(&mut reference))?;

        // SAFETY: buffer 1 holds `max_loc` ballots and is mapped in full.
        let result = unsafe {
            std::slice::from_raw_parts(host_ptr(&buffers[1]).cast_const().cast::<u32>(), max_loc as usize * 4)
        };

        let result: Vec<u128> = result
            .chunks_exact(4)
            .map(|words| {
                u128::from(words[0])
                    | (u128::from(words[1]) << 32)
                    | (u128::from(words[2]) << 64)
                    | (u128::from(words[3]) << 96)
            })
            .collect();

        if self.data.is_maximal() {
            // With maximal reconvergence, we should expect the output to exactly match the reference.
            let mut mismatches = 0u32;
            for (index, (got, expected)) in result.iter().zip(&reference.entries).enumerate() {
                if got != expected {
                    if mismatches < 5 {
                        log::error!("Mismatch at {index}: expected {expected:032x}, got {got:032x}");
                    }
                    mismatches += 1;
                }
            }
            if mismatches > 0 {
                return Ok(TestStatus::fail("Fail"));
            }
            return Ok(TestStatus::pass("Pass"));
        }

        // For subgroup_uniform_control_flow, we expect any fully converged outputs in the reference to have a corresponding fully converged output
        // in the result. So walk through each lane's results, and for each reference value of fullMask, find a corresponding result value of
        // fullMask where the previous value (OP_STORE) matches. That means these came from the same source location.
        let full_mask = subgroup_size_to_mask(subgroup_size);
        let stride = invocation_stride as usize;
        let max_loc = reference.entries.len();
        let mut failed = false;
        for lane in 0..stride {
            let mut res_loc = lane + stride;
            let mut ref_loc = lane + stride;
            while ref_loc < max_loc {
                while ref_loc < max_loc && reference.entries[ref_loc] != full_mask {
                    ref_loc += stride;
                }
                if ref_loc >= max_loc {
                    break;
                }

                // For elect, when the reference result has a full mask we expect lane 0 of the subgroup to be elected (a value of 2) and all other
                // lanes to be not elected (a value of 1). For ballot, we expect a full mask.
                let expected_result = if self.data.is_elect() {
                    if lane % subgroup_size as usize == 0 { 2 } else { 1 }
                } else {
                    full_mask
                };

                while res_loc < max_loc
                    && !(result[res_loc] == expected_result
                        && result[res_loc - stride] == reference.entries[ref_loc - stride])
                {
                    res_loc += stride;
                }

                // If we didn't find this output in the result, flag it as an error.
                if res_loc >= max_loc {
                    log::error!("lane {lane} first mismatch at {ref_loc}");
                    failed = true;
                    break;
                }
                ref_loc += stride;
                res_loc += stride;
            }
        }
        if failed {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `compute` groups of the random program cases, with the name of the group of `reconvergence` each belongs to:
/// `<group>/compute/nesting<n>/<seed group>/<case>`
pub fn create_compute_tests() -> Vec<(&'static str, TestCaseGroup)> {
    let mut groups: Vec<(&'static str, TestCaseGroup)> = Vec::new();
    for data in COMPUTE_CASES {
        let position = match groups.iter().position(|(name, _)| *name == data.group) {
            Some(position) => position,
            None => {
                groups.push((data.group, TestCaseGroup::new("compute")));
                groups.len() - 1
            }
        };
        let compute = &mut groups[position].1;

        let nesting_name = format!("nesting{}", data.nesting);
        if compute.group_mut(&nesting_name).is_none() {
            compute.add_child(TestCaseGroup::new(nesting_name.clone()));
        }
        let nesting = compute.group_mut(&nesting_name).expect("the group was just added");

        let seed_name = data.seed_group.to_string();
        if nesting.group_mut(&seed_name).is_none() {
            nesting.add_child(TestCaseGroup::new(seed_name.clone()));
        }
        nesting
            .group_mut(&seed_name)
            .expect("the group was just added")
            .add_child(Box::new(ReconvergenceTestCase { data }) as Box<dyn TestCase>);
    }
    groups
}
