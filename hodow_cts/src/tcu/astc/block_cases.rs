// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuAstcUtil.cpp (generateBlockCaseTestData, BlockTestType and its
//   name/colour helpers, generateDefaultVoidExtentBlocks, generateDefaultNormalBlocks)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. 2D block sizes only (the `isAstc3D`
// branches are folded to their false arm), matching what `astc.rs` itself covers. A child
// module of `astc` because the block builders it drives are private there.

use super::*;

/// `tcu::astc::BlockTestType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum BlockTestType {
    VoidExtentLdr,
    VoidExtentHdr,
    WeightGrid,
    WeightIse,
    Cems,
    PartitionSeed,
    EndpointValueLdr,
    EndpointValueHdrNo15,
    EndpointValueHdr15,
    EndpointIse,
    Ccs,
    Random,
}

impl BlockTestType {
    /// Every value, in upstream's enum order (`BLOCK_TEST_TYPE_LAST` is the length).
    pub const ALL: [BlockTestType; 12] = [
        BlockTestType::VoidExtentLdr,
        BlockTestType::VoidExtentHdr,
        BlockTestType::WeightGrid,
        BlockTestType::WeightIse,
        BlockTestType::Cems,
        BlockTestType::PartitionSeed,
        BlockTestType::EndpointValueLdr,
        BlockTestType::EndpointValueHdrNo15,
        BlockTestType::EndpointValueHdr15,
        BlockTestType::EndpointIse,
        BlockTestType::Ccs,
        BlockTestType::Random,
    ];

    /// `getBlockTestTypeName`
    pub fn name(self) -> &'static str {
        match self {
            BlockTestType::VoidExtentLdr => "void_extent_ldr",
            BlockTestType::VoidExtentHdr => "void_extent_hdr",
            BlockTestType::WeightGrid => "weight_grid",
            BlockTestType::WeightIse => "weight_ise",
            BlockTestType::Cems => "color_endpoint_modes",
            BlockTestType::PartitionSeed => "partition_pattern_index",
            BlockTestType::EndpointValueLdr => "endpoint_value_ldr",
            BlockTestType::EndpointValueHdrNo15 => "endpoint_value_hdr_cem_not_15",
            BlockTestType::EndpointValueHdr15 => "endpoint_value_hdr_cem_15",
            BlockTestType::EndpointIse => "endpoint_ise",
            BlockTestType::Ccs => "color_component_selector",
            BlockTestType::Random => "random",
        }
    }

    /// `isBlockTestTypeHDROnly`
    pub fn is_hdr_only(self) -> bool {
        matches!(
            self,
            BlockTestType::VoidExtentHdr | BlockTestType::EndpointValueHdrNo15 | BlockTestType::EndpointValueHdr15
        )
    }

    /// `getBlockTestTypeColorScale`
    pub fn color_scale(self) -> [f32; 4] {
        match self {
            BlockTestType::VoidExtentHdr => [0.5 / 65504.0; 4],
            BlockTestType::EndpointValueHdrNo15 => [1.0 / 65504.0, 1.0 / 65504.0, 1.0 / 65504.0, 1.0],
            BlockTestType::EndpointValueHdr15 => [1.0 / 65504.0; 4],
            _ => [1.0; 4],
        }
    }

    /// `getBlockTestTypeColorBias`
    pub fn color_bias(self) -> [f32; 4] {
        match self {
            BlockTestType::VoidExtentHdr => [0.5; 4],
            _ => [0.0; 4],
        }
    }
}

fn push_block(dst: &mut Vec<u8>, block: AssignBlock128) {
    let mut bytes = [0u8; BLOCK_SIZE_BYTES];
    block.assign_to_memory(&mut bytes);
    dst.extend_from_slice(&bytes);
}

/// `generateDefaultISEInputs`
fn generate_default_ise_inputs(block_params: &NormalBlockParams) -> NormalBlockIseInputs {
    let mut result = NormalBlockIseInputs::default();

    {
        result.weight.is_given_in_block_form = false;

        let num_weights = compute_num_weights_params(block_params);
        let weight_range_max = compute_ise_range_max(&block_params.weight_ise_params) as i32;

        if block_params.is_dual_plane {
            for i in (0..num_weights).step_by(2) {
                result.weight.plain[i as usize] =
                    ((i * weight_range_max + (num_weights - 1) / 2) / (num_weights - 1)) as u32;
            }
            for i in (1..num_weights).step_by(2) {
                result.weight.plain[i as usize] =
                    (weight_range_max - (i * weight_range_max + (num_weights - 1) / 2) / (num_weights - 1)) as u32;
            }
        } else {
            for i in 0..num_weights {
                result.weight.plain[i as usize] =
                    ((i * weight_range_max + (num_weights - 1) / 2) / (num_weights - 1)) as u32;
            }
        }
    }

    {
        result.endpoint.is_given_in_block_form = false;

        let num_color_endpoint_values = compute_num_color_endpoint_values_params(
            &block_params.color_endpoint_modes,
            block_params.num_partitions,
            block_params.is_multi_part_single_cem_mode,
        );
        let num_bits_for_color_endpoints = compute_num_bits_for_color_endpoints(block_params);
        let color_endpoint_ise_params =
            compute_maximum_range_ise_params(num_bits_for_color_endpoints, num_color_endpoint_values);
        let color_endpoint_range_max = compute_ise_range_max(&color_endpoint_ise_params) as i32;

        for i in 0..num_color_endpoint_values {
            result.endpoint.plain[i as usize] = ((i * color_endpoint_range_max + (num_color_endpoint_values - 1) / 2)
                / (num_color_endpoint_values - 1)) as u32;
        }
    }

    result
}

fn num_values_in_ise_block(ise_params: &IseParams) -> i32 {
    match ise_params.mode {
        IseMode::Trit => 5,
        IseMode::Quint => 3,
        _ => 1,
    }
}

/// `generateDefaultVoidExtentBlocks`
pub fn generate_default_void_extent_blocks(dst: &mut [u8], num_blocks: usize) {
    let block = generate_void_extent_block(&VoidExtentParams {
        is_hdr: false,
        r: 0,
        g: 0,
        b: 0,
        a: 0,
    });
    for ndx in 0..num_blocks {
        block.assign_to_memory(&mut dst[ndx * BLOCK_SIZE_BYTES..(ndx + 1) * BLOCK_SIZE_BYTES]);
    }
}

/// `generateDefaultNormalBlocks` (2D)
#[allow(clippy::field_reassign_with_default)]
pub fn generate_default_normal_blocks(dst: &mut [u8], num_blocks: usize) {
    let mut block_params = NormalBlockParams::default();

    block_params.weight_grid_width = 3;
    block_params.weight_grid_height = 3;
    block_params.weight_grid_depth = 1;
    block_params.weight_ise_params = IseParams::new(IseMode::PlainBit, 5);
    block_params.is_dual_plane = false;
    block_params.num_partitions = 1;
    block_params.color_endpoint_modes[0] = 8;

    let mut ise_inputs = generate_default_ise_inputs(&block_params);
    ise_inputs.weight.is_given_in_block_form = false;

    let num_weights = compute_num_weights_params(&block_params) as usize;
    let weight_range_max = compute_ise_range_max(&block_params.weight_ise_params) as usize;

    for block_ndx in 0..num_blocks {
        for weight_ndx in 0..num_weights {
            ise_inputs.weight.plain[weight_ndx] =
                ((block_ndx * num_weights + weight_ndx) * weight_range_max / (num_blocks * num_weights - 1)) as u32;
        }

        generate_normal_block(&block_params, &ise_inputs)
            .assign_to_memory(&mut dst[block_ndx * BLOCK_SIZE_BYTES..(block_ndx + 1) * BLOCK_SIZE_BYTES]);
    }
}

/// `generateBlockCaseTestData` for a 2D block size.
#[allow(clippy::field_reassign_with_default)]
pub fn generate_block_case_test_data(block_width: i32, block_height: i32, test_type: BlockTestType) -> Vec<u8> {
    let (bw, bh) = (block_width, block_height);
    let mut dst: Vec<u8> = Vec::new();

    match test_type {
        BlockTestType::VoidExtentLdr => {
            // Generate a gradient-like set of LDR void-extent blocks.
            let num_blocks = 1i32 << 13;
            let num_values = 1u32 << 16;
            dst.reserve(num_blocks as usize * BLOCK_SIZE_BYTES);

            for block_ndx in 0..num_blocks {
                let base_value = block_ndx as u32 * (num_values - 1) / (num_blocks as u32 - 1);
                let r = (base_value % num_values) as u16;
                let g = ((base_value + num_values / 4) % num_values) as u16;
                let b = ((base_value + num_values * 2 / 4) % num_values) as u16;
                let a = ((base_value + num_values * 3 / 4) % num_values) as u16;

                push_block(
                    &mut dst,
                    generate_void_extent_block(&VoidExtentParams {
                        is_hdr: false,
                        r,
                        g,
                        b,
                        a,
                    }),
                );
            }
        }

        BlockTestType::VoidExtentHdr => {
            // Generate a gradient-like set of HDR void-extent blocks, with values ranging from the largest finite negative to largest finite positive of fp16.
            let min_value = -65504.0f32;
            let max_value = 65504.0f32;
            let num_blocks = 1i32 << 13;
            dst.reserve(num_blocks as usize * BLOCK_SIZE_BYTES);

            let to_f16 = |ndx: i32| {
                crate::tcu::pixel::f32_to_f16_bits(
                    min_value + ndx as f32 * (max_value - min_value) / (num_blocks - 1) as f32,
                )
            };

            for block_ndx in 0..num_blocks {
                let r_ndx = block_ndx % num_blocks;
                let g_ndx = (block_ndx + num_blocks / 4) % num_blocks;
                let b_ndx = (block_ndx + num_blocks * 2 / 4) % num_blocks;
                let a_ndx = (block_ndx + num_blocks * 3 / 4) % num_blocks;

                push_block(
                    &mut dst,
                    generate_void_extent_block(&VoidExtentParams {
                        is_hdr: true,
                        r: to_f16(r_ndx),
                        g: to_f16(g_ndx),
                        b: to_f16(b_ndx),
                        a: to_f16(a_ndx),
                    }),
                );
            }
        }

        BlockTestType::WeightGrid => {
            // Generate different combinations of plane count, weight ISE params, and grid size.
            for is_dual_plane in 0..=1 {
                for ise_params_ndx in 0..WEIGHT_ISE_PARAMS_CANDIDATES.len() {
                    for weight_grid_width in 2..=12 {
                        for weight_grid_height in 2..=12 {
                            let mut block_params = NormalBlockParams::default();

                            block_params.weight_grid_width = weight_grid_width;
                            block_params.weight_grid_height = weight_grid_height;
                            block_params.weight_grid_depth = 1;
                            block_params.is_dual_plane = is_dual_plane != 0;
                            block_params.weight_ise_params = WEIGHT_ISE_PARAMS_CANDIDATES[ise_params_ndx];
                            block_params.ccs = 0;
                            block_params.num_partitions = 1;
                            block_params.color_endpoint_modes[0] = 0;

                            if is_valid_block_params(&block_params, bw, bh, 1) {
                                push_block(
                                    &mut dst,
                                    generate_normal_block(&block_params, &generate_default_ise_inputs(&block_params)),
                                );
                            }
                        }
                    }
                }
            }
        }

        BlockTestType::WeightIse => {
            // For each weight ISE param set, generate blocks that cover:
            // - each single value of the ISE's range, at each position inside an ISE block
            // - for trit and quint ISEs, each single T or Q value of an ISE block
            for ise_params_ndx in 0..WEIGHT_ISE_PARAMS_CANDIDATES.len() {
                let ise_params = WEIGHT_ISE_PARAMS_CANDIDATES[ise_params_ndx];
                let mut block_params = NormalBlockParams::default();

                block_params.weight_grid_width = 4;
                block_params.weight_grid_height = 4;
                block_params.weight_grid_depth = 1;
                block_params.weight_ise_params = ise_params;
                block_params.num_partitions = 1;
                block_params.is_dual_plane = block_params.weight_grid_width * block_params.weight_grid_height < 24;
                block_params.ccs = 0;
                block_params.color_endpoint_modes[0] = 0;

                while !is_valid_block_params(&block_params, bw, bh, 1) {
                    block_params.weight_grid_width -= 1;
                    block_params.weight_grid_height -= 1;
                }

                let num_values_in_ise_block = num_values_in_ise_block(&ise_params);
                let num_weights = compute_num_weights_params(&block_params);

                {
                    let num_weight_values = compute_ise_range_max(&ise_params) as i32 + 1;
                    let num_blocks = div_round_up(num_weight_values, num_weights);
                    let mut ise_inputs = generate_default_ise_inputs(&block_params);
                    ise_inputs.weight.is_given_in_block_form = false;

                    for offset in 0..num_values_in_ise_block {
                        for block_ndx in 0..num_blocks {
                            for weight_ndx in 0..num_weights {
                                ise_inputs.weight.plain[weight_ndx as usize] =
                                    ((block_ndx * num_weights + weight_ndx + offset) % num_weight_values) as u32;
                            }

                            push_block(&mut dst, generate_normal_block(&block_params, &ise_inputs));
                        }
                    }
                }

                if ise_params.mode == IseMode::Trit || ise_params.mode == IseMode::Quint {
                    let mut ise_inputs = generate_default_ise_inputs(&block_params);
                    ise_inputs.weight.is_given_in_block_form = true;

                    let num_tq_values = 1i32 << (if ise_params.mode == IseMode::Trit { 8 } else { 7 });
                    let num_ise_blocks_per_block = div_round_up(num_weights, num_values_in_ise_block);
                    let num_blocks = div_round_up(num_tq_values, num_ise_blocks_per_block);

                    for offset in 0..num_values_in_ise_block {
                        for block_ndx in 0..num_blocks {
                            for ise_block_ndx in 0..num_ise_blocks_per_block {
                                for i in 0..num_values_in_ise_block {
                                    ise_inputs.weight.block[ise_block_ndx as usize].bit_values[i as usize] = 0;
                                }
                                ise_inputs.weight.block[ise_block_ndx as usize].t_or_q_value =
                                    ((block_ndx * num_ise_blocks_per_block + ise_block_ndx + offset) % num_tq_values)
                                        as u32;
                            }

                            push_block(&mut dst, generate_normal_block(&block_params, &ise_inputs));
                        }
                    }
                }
            }
        }

        BlockTestType::Cems => {
            // For each plane count & partition count combination, generate all color endpoint mode combinations.
            for is_dual_plane in 0..=1 {
                for num_partitions in 1..=(if is_dual_plane != 0 { 3 } else { 4 }) {
                    // Multi-partition, single-CEM mode.
                    if num_partitions > 1 {
                        for single_cem in 0..16u32 {
                            let mut block_params = NormalBlockParams::default();
                            block_params.weight_grid_width = 4;
                            block_params.weight_grid_height = 4;
                            block_params.weight_grid_depth = 1;
                            block_params.is_dual_plane = is_dual_plane != 0;
                            block_params.ccs = 0;
                            block_params.num_partitions = num_partitions;
                            block_params.is_multi_part_single_cem_mode = true;
                            block_params.color_endpoint_modes[0] = single_cem;
                            block_params.partition_seed = 634;

                            for ise_params_ndx in 0..WEIGHT_ISE_PARAMS_CANDIDATES.len() {
                                block_params.weight_ise_params = WEIGHT_ISE_PARAMS_CANDIDATES[ise_params_ndx];
                                if is_valid_block_params(&block_params, bw, bh, 1) {
                                    push_block(
                                        &mut dst,
                                        generate_normal_block(
                                            &block_params,
                                            &generate_default_ise_inputs(&block_params),
                                        ),
                                    );
                                    break;
                                }
                            }
                        }
                    }

                    // Separate-CEM mode.
                    for cem0 in 0..16u32 {
                        for cem1 in 0..(if num_partitions >= 2 { 16u32 } else { 1 }) {
                            for cem2 in 0..(if num_partitions >= 3 { 16u32 } else { 1 }) {
                                for cem3 in 0..(if num_partitions >= 4 { 16u32 } else { 1 }) {
                                    let mut block_params = NormalBlockParams::default();
                                    block_params.weight_grid_width = 4;
                                    block_params.weight_grid_height = 4;
                                    block_params.weight_grid_depth = 1;
                                    block_params.is_dual_plane = is_dual_plane != 0;
                                    block_params.ccs = 0;
                                    block_params.num_partitions = num_partitions;
                                    block_params.is_multi_part_single_cem_mode = false;
                                    block_params.color_endpoint_modes = [cem0, cem1, cem2, cem3];
                                    block_params.partition_seed = 634;

                                    {
                                        let modes = &block_params.color_endpoint_modes[..num_partitions as usize];
                                        let min_cem = *modes.iter().min().unwrap();
                                        let max_cem = *modes.iter().max().unwrap();
                                        let min_cem_class = min_cem / 4;
                                        let max_cem_class = max_cem / 4;

                                        if max_cem_class - min_cem_class > 1 {
                                            continue;
                                        }
                                    }

                                    for ise_params_ndx in 0..WEIGHT_ISE_PARAMS_CANDIDATES.len() {
                                        block_params.weight_ise_params = WEIGHT_ISE_PARAMS_CANDIDATES[ise_params_ndx];
                                        if is_valid_block_params(&block_params, bw, bh, 1) {
                                            push_block(
                                                &mut dst,
                                                generate_normal_block(
                                                    &block_params,
                                                    &generate_default_ise_inputs(&block_params),
                                                ),
                                            );
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        BlockTestType::PartitionSeed => {
            // Test all partition seeds ("partition pattern indices").
            for num_partitions in 2..=4 {
                for partition_seed in 0..(1u32 << 10) {
                    let mut block_params = NormalBlockParams::default();
                    block_params.weight_grid_width = 4;
                    block_params.weight_grid_height = 4;
                    block_params.weight_grid_depth = 1;
                    block_params.weight_ise_params = IseParams::new(IseMode::PlainBit, 2);
                    block_params.is_dual_plane = false;
                    block_params.num_partitions = num_partitions;
                    block_params.is_multi_part_single_cem_mode = true;
                    block_params.color_endpoint_modes[0] = 0;
                    block_params.partition_seed = partition_seed;

                    push_block(
                        &mut dst,
                        generate_normal_block(&block_params, &generate_default_ise_inputs(&block_params)),
                    );
                }
            }
        }

        BlockTestType::EndpointValueLdr | BlockTestType::EndpointValueHdrNo15 | BlockTestType::EndpointValueHdr15 => {
            // For each endpoint mode, for each pair of components in the endpoint value, test 10x10 combinations of values for that pair.
            // Separate modes for HDR and mode 15 due to different color scales and biases.
            for cem in 0..16u32 {
                let is_hdr_cem = cem == 2 || cem == 3 || cem == 7 || cem == 11 || cem == 14 || cem == 15;

                if (test_type == BlockTestType::EndpointValueLdr && is_hdr_cem)
                    || (test_type == BlockTestType::EndpointValueHdrNo15 && (!is_hdr_cem || cem == 15))
                    || (test_type == BlockTestType::EndpointValueHdr15 && cem != 15)
                {
                    continue;
                }

                let mut block_params = NormalBlockParams::default();
                block_params.weight_grid_width = 3;
                block_params.weight_grid_height = 4;
                block_params.weight_grid_depth = 1;
                block_params.weight_ise_params = IseParams::new(IseMode::PlainBit, 2);
                block_params.is_dual_plane = false;
                block_params.num_partitions = 1;
                block_params.color_endpoint_modes[0] = cem;

                let num_bits_for_endpoints = compute_num_bits_for_color_endpoints(&block_params);
                let num_endpoint_parts = compute_num_color_endpoint_values_for_mode(cem);
                let endpoint_ise = compute_maximum_range_ise_params(num_bits_for_endpoints, num_endpoint_parts);
                let endpoint_ise_range_max = compute_ise_range_max(&endpoint_ise) as i32;

                for endpoint_part_ndx0 in 0..num_endpoint_parts {
                    for endpoint_part_ndx1 in (endpoint_part_ndx0 + 1)..num_endpoint_parts {
                        let mut ise_inputs = generate_default_ise_inputs(&block_params);
                        let num_endpoint_values = 10.min(endpoint_ise_range_max + 1);

                        for endpoint_value_ndx0 in 0..num_endpoint_values {
                            for endpoint_value_ndx1 in 0..num_endpoint_values {
                                let endpoint_value0 =
                                    endpoint_value_ndx0 * endpoint_ise_range_max / (num_endpoint_values - 1);
                                let endpoint_value1 =
                                    endpoint_value_ndx1 * endpoint_ise_range_max / (num_endpoint_values - 1);

                                ise_inputs.endpoint.plain[endpoint_part_ndx0 as usize] = endpoint_value0 as u32;
                                ise_inputs.endpoint.plain[endpoint_part_ndx1 as usize] = endpoint_value1 as u32;

                                push_block(&mut dst, generate_normal_block(&block_params, &ise_inputs));
                            }
                        }
                    }
                }
            }
        }

        BlockTestType::EndpointIse => {
            // Similar to BlockTestType::WeightIse, see above.
            const ENDPOINT_RANGE_MAXIMUMS: [u32; 11] = [5, 9, 11, 19, 23, 39, 47, 79, 95, 159, 191];

            for &endpoint_range_max in &ENDPOINT_RANGE_MAXIMUMS {
                let mut valid_case_generated = false;

                'search: for num_partitions in 1..=4 {
                    for is_dual in 0..=1 {
                        for weight_ise_params_ndx in 0..WEIGHT_ISE_PARAMS_CANDIDATES.len() {
                            for weight_grid_width in 2..=12 {
                                for weight_grid_height in 2..=12 {
                                    let mut block_params = NormalBlockParams::default();
                                    block_params.weight_grid_width = weight_grid_width;
                                    block_params.weight_grid_height = weight_grid_height;
                                    block_params.weight_grid_depth = 1;
                                    block_params.weight_ise_params =
                                        WEIGHT_ISE_PARAMS_CANDIDATES[weight_ise_params_ndx];
                                    block_params.is_dual_plane = is_dual != 0;
                                    block_params.ccs = 0;
                                    block_params.num_partitions = num_partitions;
                                    block_params.is_multi_part_single_cem_mode = true;
                                    block_params.color_endpoint_modes[0] = 12;
                                    block_params.partition_seed = 634;

                                    if !is_valid_block_params(&block_params, bw, bh, 1) {
                                        continue;
                                    }

                                    let endpoint_ise_params = compute_maximum_range_ise_params(
                                        compute_num_bits_for_color_endpoints(&block_params),
                                        compute_num_color_endpoint_values_params(
                                            &block_params.color_endpoint_modes,
                                            num_partitions,
                                            true,
                                        ),
                                    );

                                    if compute_ise_range_max(&endpoint_ise_params) != endpoint_range_max {
                                        continue;
                                    }

                                    valid_case_generated = true;

                                    let num_color_endpoints = compute_num_color_endpoint_values_params(
                                        &block_params.color_endpoint_modes,
                                        num_partitions,
                                        block_params.is_multi_part_single_cem_mode,
                                    );
                                    let num_values_in_ise_block = num_values_in_ise_block(&endpoint_ise_params);

                                    {
                                        let num_color_endpoint_values =
                                            compute_ise_range_max(&endpoint_ise_params) as i32 + 1;
                                        let num_blocks = div_round_up(num_color_endpoint_values, num_color_endpoints);
                                        let mut ise_inputs = generate_default_ise_inputs(&block_params);
                                        ise_inputs.endpoint.is_given_in_block_form = false;

                                        for offset in 0..num_values_in_ise_block {
                                            for block_ndx in 0..num_blocks {
                                                for endpoint_ndx in 0..num_color_endpoints {
                                                    ise_inputs.endpoint.plain[endpoint_ndx as usize] =
                                                        ((block_ndx * num_color_endpoints + endpoint_ndx + offset)
                                                            % num_color_endpoint_values)
                                                            as u32;
                                                }

                                                push_block(&mut dst, generate_normal_block(&block_params, &ise_inputs));
                                            }
                                        }
                                    }

                                    if endpoint_ise_params.mode == IseMode::Trit
                                        || endpoint_ise_params.mode == IseMode::Quint
                                    {
                                        let mut ise_inputs = generate_default_ise_inputs(&block_params);
                                        ise_inputs.endpoint.is_given_in_block_form = true;

                                        let num_tq_values = 1i32
                                            << (if endpoint_ise_params.mode == IseMode::Trit {
                                                8
                                            } else {
                                                7
                                            });
                                        let num_ise_blocks_per_block =
                                            div_round_up(num_color_endpoints, num_values_in_ise_block);
                                        let num_blocks = div_round_up(num_tq_values, num_ise_blocks_per_block);

                                        for offset in 0..num_values_in_ise_block {
                                            for block_ndx in 0..num_blocks {
                                                for ise_block_ndx in 0..num_ise_blocks_per_block {
                                                    for i in 0..num_values_in_ise_block {
                                                        ise_inputs.endpoint.block[ise_block_ndx as usize].bit_values
                                                            [i as usize] = 0;
                                                    }
                                                    ise_inputs.endpoint.block[ise_block_ndx as usize].t_or_q_value =
                                                        ((block_ndx * num_ise_blocks_per_block
                                                            + ise_block_ndx
                                                            + offset)
                                                            % num_tq_values)
                                                            as u32;
                                                }

                                                push_block(&mut dst, generate_normal_block(&block_params, &ise_inputs));
                                            }
                                        }
                                    }

                                    break 'search;
                                }
                            }
                        }
                    }
                }

                debug_assert!(valid_case_generated);
            }
        }

        BlockTestType::Ccs => {
            // For all partition counts, test all values of the CCS (color component selector).
            for num_partitions in 1..=3 {
                for ccs in 0..4u32 {
                    let mut block_params = NormalBlockParams::default();
                    block_params.weight_grid_width = 3;
                    block_params.weight_grid_height = 3;
                    block_params.weight_grid_depth = 1;
                    block_params.weight_ise_params = IseParams::new(IseMode::PlainBit, 2);
                    block_params.is_dual_plane = true;
                    block_params.ccs = ccs;
                    block_params.num_partitions = num_partitions;
                    block_params.is_multi_part_single_cem_mode = true;
                    block_params.color_endpoint_modes[0] = 8;
                    block_params.partition_seed = 634;

                    push_block(
                        &mut dst,
                        generate_normal_block(&block_params, &generate_default_ise_inputs(&block_params)),
                    );
                }
            }
        }

        BlockTestType::Random => {
            // Generate a number of random (including invalid) blocks.
            let num_blocks = 16384usize;
            let seed = 1u32;

            dst.resize(num_blocks * BLOCK_SIZE_BYTES, 0);

            // `generateRandomBlocks`
            let mut rnd = Random::new(seed);
            for block_ndx in 0..num_blocks {
                generate_random_block(
                    &mut dst[block_ndx * BLOCK_SIZE_BYTES..(block_ndx + 1) * BLOCK_SIZE_BYTES],
                    [bw, bh, 1],
                    &mut rnd,
                );
            }
        }
    }

    dst
}
