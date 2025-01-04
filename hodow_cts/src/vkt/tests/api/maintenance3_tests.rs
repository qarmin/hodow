// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiMaintenance3Check.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `std::set<VkDescriptorType>` and `std::map<VkDescriptorType, ..>` iterate in the numeric
// order of the enum, and the descriptor distribution depends on that order, so they are
// `BTreeSet<i32>` / `BTreeMap<i32, ..>` keyed on the raw enum value here.

use std::collections::{BTreeMap, BTreeSet};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1};

use super::case_util::{add_case, add_function_case};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

// These variables are equal to minimal values for maxMemoryAllocationSize and maxPerSetDescriptors
const MAX_MEMORY_ALLOCATION_SIZE: u32 = 1_073_741_824;
const MAX_DESCRIPTORS_IN_SET: u32 = 1024;
const MAX_REASONABLE_INLINE_UNIFORM_BLOCKS: u32 = 64;

type TypeSet = BTreeSet<i32>;

fn raw(descriptor_type: vk::DescriptorType) -> i32 {
    descriptor_type.as_raw()
}

fn type_set(types: &[vk::DescriptorType]) -> TypeSet {
    types.iter().map(|&t| raw(t)).collect()
}

/// Structure representing an implementation limit, like maxPerStageDescriptorSamplers. It has a maximum value
/// obtained at runtime and a remaining number of descriptors, which starts with the same count and decreases
/// as we assign descriptor counts to the different types. A limit is affected by (or itself affects) one or more
/// descriptor types. Note a type may be involved in several limits, and a limit may affect several types.
struct Limit {
    #[allow(dead_code)]
    name: &'static str,
    #[allow(dead_code)]
    max_value: u32,
    remaining: u32,
    affected_types: TypeSet,
}

impl Limit {
    fn new(name: &'static str, max_value: u32, affected_types: &TypeSet) -> Self {
        Self {
            name,
            max_value,
            remaining: max_value,
            affected_types: affected_types.clone(),
        }
    }
}

/// Structure representing how many descriptors have been assigned to the given type. The type is "alive" during
/// descriptor count assignment if more descriptors can be added to the type without hitting any limit affected
/// by the type. Once at least one of the limits is reached, no more descriptors can be assigned to the type and
/// the type is no longer considered "alive".
struct TypeState {
    alive: bool,
    count: u32,
}

type TypeCounts = BTreeMap<i32, TypeState>;
type LimitsVector = Vec<Limit>;

/// Get the subset of alive types from the given map.
fn get_alive_types(type_counts: &TypeCounts) -> TypeSet {
    type_counts
        .iter()
        .filter(|(_, state)| state.alive)
        .map(|(&t, _)| t)
        .collect()
}

/// Get the subset of alive types for a specific limit, among the set of types affected by the limit.
fn get_alive_types_for_limit(limit: &Limit, alive_types: &TypeSet) -> TypeSet {
    limit
        .affected_types
        .iter()
        .filter(|t| alive_types.contains(t))
        .copied()
        .collect()
}

/// Distribute descriptor counts as evenly as possible among the given set of types, taking into account the
/// given limits.
fn distribute_counts(limits: &mut LimitsVector, type_counts: &mut TypeCounts) {
    loop {
        let alive_types = get_alive_types(type_counts);
        if alive_types.is_empty() {
            break;
        }

        // Calculate the maximum increment per alive descriptor type. This involves iterating over the limits and
        // finding out how many more descriptors can be distributed among the affected types that are still alive
        // for the limit. For each type, remember the lowest possible increment.
        let mut increments: BTreeMap<i32, u32> = BTreeMap::new();
        for &t in &alive_types {
            increments.insert(t, u32::MAX);
        }

        for limit in limits.iter() {
            if limit.remaining == 0 {
                continue;
            }

            let alive_types_for_limit = get_alive_types_for_limit(limit, &alive_types);
            if alive_types_for_limit.is_empty() {
                continue;
            }

            // Distribute remaining count evenly among alive types.
            let max_increment = limit.remaining / alive_types_for_limit.len() as u32;
            if max_increment == 0 {
                // More types than remaining descriptors. Assign 1 to the first affected types and 0 to the rest.
                let mut remaining = limit.remaining;
                for t in &alive_types_for_limit {
                    let increment = increments.entry(*t).or_insert(0);
                    if remaining > 0 && *increment > 0 {
                        *increment = 1;
                        remaining -= 1;
                    } else {
                        *increment = 0;
                    }
                }
            } else {
                // Find the lowest possible increment taking into account all limits.
                for t in &alive_types_for_limit {
                    let increment = increments.entry(*t).or_insert(0);
                    if *increment > max_increment {
                        *increment = max_increment;
                    }
                }
            }
        }

        // Apply the calculated increments per descriptor type, decreasing the remaining descriptors for each
        // limit affected by the type, and switching types to the not-alive state when a limit is hit.
        for (&t, &increment) in &increments {
            // Increase type count.
            let state = type_counts.get_mut(&t).expect("every incremented type is in the map");
            state.count += increment;

            for limit in limits.iter_mut() {
                // Decrease remaining descriptors for affected limits.
                if limit.affected_types.contains(&t) {
                    assert!(increment <= limit.remaining);
                    limit.remaining -= increment;
                }
                if limit.remaining == 0 {
                    // Limit hit, switch affected types to not-alive.
                    for affected_type in &limit.affected_types {
                        if let Some(tc) = type_counts.get_mut(affected_type) {
                            tc.alive = false;
                        }
                    }
                }
            }
        }
    }
}

/// Create a limits vector based on runtime limit information for the device.
fn build_limits_vector(
    prop1: &vk::PhysicalDeviceProperties,
    iub_prop: &vk::PhysicalDeviceInlineUniformBlockProperties,
    maint_prop3: &vk::PhysicalDeviceMaintenance3Properties,
) -> LimitsVector {
    use vk::DescriptorType as T;

    let sampler_types = type_set(&[T::COMBINED_IMAGE_SAMPLER, T::SAMPLER]);
    let sampled_image_types = type_set(&[T::COMBINED_IMAGE_SAMPLER, T::SAMPLED_IMAGE, T::UNIFORM_TEXEL_BUFFER]);
    let uniform_buffer_types = type_set(&[T::UNIFORM_BUFFER, T::UNIFORM_BUFFER_DYNAMIC]);
    let storage_buffer_types = type_set(&[T::STORAGE_BUFFER, T::STORAGE_BUFFER_DYNAMIC]);
    let storage_image_types = type_set(&[T::STORAGE_IMAGE, T::STORAGE_TEXEL_BUFFER]);
    let input_attachment_types = type_set(&[T::INPUT_ATTACHMENT]);
    let inline_uniform_block_types = type_set(&[T::INLINE_UNIFORM_BLOCK]);
    let dynamic_uniform_buffer = type_set(&[T::UNIFORM_BUFFER_DYNAMIC]);
    let dynamic_storage_buffer = type_set(&[T::STORAGE_BUFFER_DYNAMIC]);
    let all_types_but_iub = type_set(&[
        T::COMBINED_IMAGE_SAMPLER,
        T::SAMPLED_IMAGE,
        T::STORAGE_IMAGE,
        T::UNIFORM_TEXEL_BUFFER,
        T::STORAGE_TEXEL_BUFFER,
        T::UNIFORM_BUFFER,
        T::STORAGE_BUFFER,
        T::UNIFORM_BUFFER_DYNAMIC,
        T::STORAGE_BUFFER_DYNAMIC,
        T::INPUT_ATTACHMENT,
    ]);
    let all_types = type_set(&[
        T::COMBINED_IMAGE_SAMPLER,
        T::SAMPLER,
        T::UNIFORM_BUFFER,
        T::UNIFORM_BUFFER_DYNAMIC,
        T::STORAGE_BUFFER,
        T::STORAGE_BUFFER_DYNAMIC,
        T::SAMPLED_IMAGE,
        T::UNIFORM_TEXEL_BUFFER,
        T::STORAGE_IMAGE,
        T::STORAGE_TEXEL_BUFFER,
        T::INPUT_ATTACHMENT,
        T::INLINE_UNIFORM_BLOCK,
    ]);

    let l = &prop1.limits;
    vec![
        Limit::new(
            "maxPerStageDescriptorSamplers",
            l.max_per_stage_descriptor_samplers,
            &sampler_types,
        ),
        Limit::new(
            "maxDescriptorSetSamplers",
            l.max_descriptor_set_samplers,
            &sampler_types,
        ),
        Limit::new(
            "maxPerStageDescriptorSampledImages",
            l.max_per_stage_descriptor_sampled_images,
            &sampled_image_types,
        ),
        Limit::new(
            "maxDescriptorSetSampledImages",
            l.max_descriptor_set_sampled_images,
            &sampled_image_types,
        ),
        Limit::new(
            "maxPerStageDescriptorUniformBuffers",
            l.max_per_stage_descriptor_uniform_buffers,
            &uniform_buffer_types,
        ),
        Limit::new(
            "maxDescriptorSetUniformBuffers",
            l.max_descriptor_set_uniform_buffers,
            &uniform_buffer_types,
        ),
        Limit::new(
            "maxPerStageDescriptorStorageBuffers",
            l.max_per_stage_descriptor_storage_buffers,
            &storage_buffer_types,
        ),
        Limit::new(
            "maxDescriptorSetStorageBuffers",
            l.max_descriptor_set_storage_buffers,
            &storage_buffer_types,
        ),
        Limit::new(
            "maxPerStageDescriptorStorageImages",
            l.max_per_stage_descriptor_storage_images,
            &storage_image_types,
        ),
        Limit::new(
            "maxDescriptorSetStorageImages",
            l.max_descriptor_set_storage_images,
            &storage_image_types,
        ),
        Limit::new(
            "maxPerStageDescriptorInputAttachments",
            l.max_per_stage_descriptor_input_attachments,
            &input_attachment_types,
        ),
        Limit::new(
            "maxDescriptorSetInputAttachments",
            l.max_descriptor_set_input_attachments,
            &input_attachment_types,
        ),
        Limit::new(
            "maxDescriptorSetUniformBuffersDynamic",
            l.max_descriptor_set_uniform_buffers_dynamic,
            &dynamic_uniform_buffer,
        ),
        Limit::new(
            "maxDescriptorSetStorageBuffersDynamic",
            l.max_descriptor_set_storage_buffers_dynamic,
            &dynamic_storage_buffer,
        ),
        Limit::new(
            "maxPerStageDescriptorInlineUniformBlocks",
            iub_prop.max_per_stage_descriptor_inline_uniform_blocks,
            &inline_uniform_block_types,
        ),
        Limit::new(
            "maxDescriptorSetInlineUniformBlocks",
            iub_prop.max_descriptor_set_inline_uniform_blocks,
            &inline_uniform_block_types,
        ),
        Limit::new("maxPerStageResources", l.max_per_stage_resources, &all_types_but_iub),
        Limit::new("maxPerSetDescriptors", maint_prop3.max_per_set_descriptors, &all_types),
    ]
}

/// Create a vector of bindings by constructing the system limits and distributing descriptor counts.
fn calculate_bindings(
    prop1: &vk::PhysicalDeviceProperties,
    iub_prop: &vk::PhysicalDeviceInlineUniformBlockProperties,
    maint_prop3: &vk::PhysicalDeviceMaintenance3Properties,
    types: &[vk::DescriptorType],
) -> Vec<vk::DescriptorSetLayoutBinding> {
    let mut limits = build_limits_vector(prop1, iub_prop, maint_prop3);

    let mut type_counts = TypeCounts::new();
    for &t in types {
        type_counts.entry(raw(t)).or_insert(TypeState { alive: true, count: 0 });
    }

    distribute_counts(&mut limits, &mut type_counts);

    let mut binding_number: u32 = 0;
    let mut bindings: Vec<vk::DescriptorSetLayoutBinding> = Vec::new();
    for (&type_raw, state) in &type_counts {
        let descriptor_type = vk::DescriptorType::from_raw(type_raw);
        if descriptor_type != vk::DescriptorType::INLINE_UNIFORM_BLOCK {
            bindings.push(
                vk::DescriptorSetLayoutBinding::builder()
                    .binding(binding_number)
                    .descriptor_count(state.count)
                    .descriptor_type(descriptor_type)
                    .stage_flags(if descriptor_type == vk::DescriptorType::INPUT_ATTACHMENT {
                        vk::ShaderStageFlags::FRAGMENT
                    } else {
                        vk::ShaderStageFlags::ALL
                    })
                    .build(),
            );
        } else {
            // Inline uniform blocks are special because descriptorCount represents the size of that block.
            // The only way of creating several blocks is by adding more structures to the list instead of creating an array.
            for i in 0..state.count {
                bindings.push(
                    vk::DescriptorSetLayoutBinding::builder()
                        .binding(binding_number + i)
                        // For inline uniform blocks, this must be a multiple of 4 according to the spec.
                        .descriptor_count(4)
                        .descriptor_type(descriptor_type)
                        .stage_flags(vk::ShaderStageFlags::ALL)
                        .build(),
                );
            }
        }
        binding_number += state.count;
    }

    bindings
}

/// Get a textual description with descriptor counts per type.
fn get_bindings_description(bindings: &[vk::DescriptorSetLayoutBinding]) -> String {
    let mut type_count: BTreeMap<i32, u32> = BTreeMap::new();
    let mut total_count: u32 = 0;
    for b in bindings {
        let count = if b.descriptor_type == vk::DescriptorType::INLINE_UNIFORM_BLOCK {
            1
        } else {
            b.descriptor_count
        };
        *type_count.entry(raw(b.descriptor_type)).or_insert(0) += count;
        total_count += count;
    }

    let mut comb_str = format!("{{ Descriptors: {total_count}, [");
    for (i, (t, count)) in type_count.iter().enumerate() {
        comb_str.push_str(if i != 0 { ", " } else { " " });
        comb_str.push_str(&format!("{t}: {count}"));
    }
    comb_str.push_str(" ] }");
    comb_str
}

fn check_support_maintenance3(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_maintenance3")
}

/// `Maintenance3StructTestInstance::iterate`
fn maintenance3_struct(context: &Context<'_>) -> TestOutcome {
    // set values to be a bit smaller than required minimum values
    let mut maint_prop3 = vk::PhysicalDeviceMaintenance3Properties {
        max_per_set_descriptors: MAX_DESCRIPTORS_IN_SET - 1,
        max_memory_allocation_size: (MAX_MEMORY_ALLOCATION_SIZE - 1) as vk::DeviceSize,
        ..Default::default()
    };

    {
        let mut prop2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maint_prop3);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut prop2)
        };
    }

    if maint_prop3.max_memory_allocation_size < MAX_MEMORY_ALLOCATION_SIZE as vk::DeviceSize {
        return Ok(TestStatus::fail("Fail"));
    }

    if maint_prop3.max_per_set_descriptors < MAX_DESCRIPTORS_IN_SET {
        return Ok(TestStatus::fail("Fail"));
    }

    log::info!("maxMemoryAllocationSize: {}", maint_prop3.max_memory_allocation_size);
    log::info!("maxPerSetDescriptors: {}", maint_prop3.max_per_set_descriptors);
    Ok(TestStatus::pass("Pass"))
}

/// `std::prev_permutation` for a `vector<bool>` (false < true).
fn prev_permutation(v: &mut [bool]) -> bool {
    let n = v.len();
    if n < 2 {
        return false;
    }

    let mut i = n - 1;
    while i > 0 && v[i - 1] <= v[i] {
        i -= 1;
    }
    if i == 0 {
        v.reverse();
        return false;
    }

    let mut j = n - 1;
    while v[j] >= v[i - 1] {
        j -= 1;
    }
    v.swap(i - 1, j);
    v[i..].reverse();
    true
}

/// `Maintenance3DescriptorTestInstance::iterate`
fn maintenance3_descriptor(context: &Context<'_>) -> TestOutcome {
    let vki = context.get_instance();
    let vkd = context.get_device();
    let physical_device = context.get_physical_device();

    let mut iub_supported = false;

    if context.is_device_functionality_supported("VK_EXT_inline_uniform_block") {
        let mut iub_features = vk::PhysicalDeviceInlineUniformBlockFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut iub_features);
            unsafe { vki.get_physical_device_features2(physical_device, &mut features2) };
        }
        iub_supported = iub_features.inline_uniform_block == vk::TRUE;
    }

    let mut dev_iub_prop = vk::PhysicalDeviceInlineUniformBlockProperties::default();
    let mut maint_prop3 = vk::PhysicalDeviceMaintenance3Properties {
        max_per_set_descriptors: MAX_DESCRIPTORS_IN_SET,
        max_memory_allocation_size: MAX_MEMORY_ALLOCATION_SIZE as vk::DeviceSize,
        ..Default::default()
    };

    let mut prop2 = vk::PhysicalDeviceProperties2::default();
    if iub_supported {
        maint_prop3.next = (&raw mut dev_iub_prop).cast();
    }
    prop2.next = (&raw mut maint_prop3).cast();
    unsafe { vki.get_physical_device_properties2(physical_device, &mut prop2) };

    use vk::DescriptorType as T;
    let mut descriptor_types = vec![
        T::SAMPLER,
        T::COMBINED_IMAGE_SAMPLER,
        T::SAMPLED_IMAGE,
        T::STORAGE_IMAGE,
        T::UNIFORM_TEXEL_BUFFER,
        T::STORAGE_TEXEL_BUFFER,
        T::UNIFORM_BUFFER,
        T::STORAGE_BUFFER,
        T::UNIFORM_BUFFER_DYNAMIC,
        T::STORAGE_BUFFER_DYNAMIC,
        T::INPUT_ATTACHMENT,
    ];
    if iub_supported {
        descriptor_types.push(T::INLINE_UNIFORM_BLOCK);
    }

    // Check every combination maximizing descriptor counts.
    for comb_size in 1..=descriptor_types.len() {
        // Create a vector of selectors with combSize elements set to true.
        let mut selectors = vec![false; descriptor_types.len()];
        for selector in selectors.iter_mut().take(comb_size) {
            *selector = true;
        }

        // Iterate over every permutation of selectors for that combination size.
        loop {
            let types: Vec<vk::DescriptorType> = selectors
                .iter()
                .zip(descriptor_types.iter())
                .filter(|(selected, _)| **selected)
                .map(|(_, &t)| t)
                .collect();

            // Due to inline uniform blocks being unable to form arrays and each one of them needing its own
            // VkDescriptorSetLayoutBinding structure, we will limit when to test them.
            let skip = types.contains(&T::INLINE_UNIFORM_BLOCK)
                && dev_iub_prop.max_per_stage_descriptor_inline_uniform_blocks > MAX_REASONABLE_INLINE_UNIFORM_BLOCKS
                && comb_size > 1
                && comb_size < descriptor_types.len();

            if !skip {
                let bindings = calculate_bindings(&prop2.properties, &dev_iub_prop, &maint_prop3, &types);
                let description = get_bindings_description(&bindings);
                log::info!("Testing combination: {description}");

                let create_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
                let mut support = vk::DescriptorSetLayoutSupport::default();

                unsafe { vkd.get_descriptor_set_layout_support(&create_info, &mut support) };
                if support.supported == vk::FALSE {
                    return Ok(TestStatus::fail(format!(
                        "Failed to use the following descriptor type counts: {description}"
                    )));
                }
            }

            if !prev_permutation(&mut selectors) {
                break;
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `CountLayoutSupportParams`
#[derive(Clone, Copy)]
struct CountLayoutSupportParams {
    descriptor_type: vk::DescriptorType,
    /// Apply an offset to each binding number.
    binding_offset: u32,
    extra_bindings: bool,
    use_variable_size: bool,
    /// Actually attempt to create the layout.
    create_layout: bool,
}

/// `checkSupportCountLayoutSupport`
fn check_support_count_layout_support(
    context: &Context<'_>,
    params: CountLayoutSupportParams,
) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_maintenance3")?;
    context.require_device_functionality("VK_EXT_descriptor_indexing")?;

    if params.use_variable_size {
        let mut indexing_features = vk::PhysicalDeviceDescriptorIndexingFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut indexing_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if indexing_features.descriptor_binding_variable_descriptor_count == vk::FALSE {
            return Err(TestError::NotSupported(
                "descriptorBindingVariableDescriptorCount not supported".to_string(),
            ));
        }
    }

    if params.descriptor_type == vk::DescriptorType::INLINE_UNIFORM_BLOCK {
        context.require_device_functionality("VK_EXT_inline_uniform_block")?;
    }
    Ok(())
}

/// `SetLayoutSupportAndCount`
struct SetLayoutSupportAndCount {
    supported: bool,
    max_variable_descriptor_count: u32,
}

/// `getSetLayoutSupportAndCount`
fn get_set_layout_support_and_count(
    context: &Context<'_>,
    set_layout_create_info: &vk::DescriptorSetLayoutCreateInfo,
) -> SetLayoutSupportAndCount {
    // Set a garbage value in the maxVariableDescriptorCount member, to verify it's not simply left untouched by the implementation.
    let mut count_layout_support = vk::DescriptorSetVariableDescriptorCountLayoutSupport {
        max_variable_descriptor_count: u32::MAX,
        ..Default::default()
    };
    let mut set_layout_support = vk::DescriptorSetLayoutSupport::default();
    set_layout_support.next = (&raw mut count_layout_support).cast();
    unsafe {
        context
            .get_device()
            .get_descriptor_set_layout_support(set_layout_create_info, &mut set_layout_support)
    };
    SetLayoutSupportAndCount {
        supported: set_layout_support.supported == vk::TRUE,
        max_variable_descriptor_count: count_layout_support.max_variable_descriptor_count,
    }
}

/// `testCountLayoutSupport`
fn test_count_layout_support(context: &Context<'_>, params: CountLayoutSupportParams) -> TestOutcome {
    use vk::DescriptorType as T;

    // The shader stages are probably not very relevant. This is an attempt at setting some varied but plausible stages anyway.
    let stages = match params.descriptor_type {
        T::STORAGE_IMAGE | T::STORAGE_TEXEL_BUFFER | T::STORAGE_BUFFER | T::STORAGE_BUFFER_DYNAMIC => {
            vk::ShaderStageFlags::COMPUTE
        }
        T::SAMPLER | T::COMBINED_IMAGE_SAMPLER | T::SAMPLED_IMAGE | T::INPUT_ATTACHMENT => {
            vk::ShaderStageFlags::FRAGMENT
        }
        T::UNIFORM_BUFFER | T::UNIFORM_BUFFER_DYNAMIC | T::UNIFORM_TEXEL_BUFFER | T::INLINE_UNIFORM_BLOCK => {
            vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT
        }
        _ => return Err(TestError::InternalError("unexpected descriptor type".to_string())),
    };

    let mut bindings: Vec<vk::DescriptorSetLayoutBinding> = Vec::new();
    let mut binding_flags: Vec<vk::DescriptorBindingFlags> = Vec::new();

    let offset = params.binding_offset;

    if params.extra_bindings {
        // Add a few uniform buffers to the mix.
        let extra_binding_count = 3u32;

        for _ in 0..extra_binding_count {
            bindings.push(
                vk::DescriptorSetLayoutBinding::builder()
                    .binding(bindings.len() as u32 + offset)
                    .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                    .descriptor_count(1)
                    .stage_flags(stages)
                    .build(),
            );
            binding_flags.push(vk::DescriptorBindingFlags::empty());
        }
    }

    let mut max_inline_uniform_block_size: u32 = 256;
    if params.descriptor_type == vk::DescriptorType::INLINE_UNIFORM_BLOCK {
        let mut inline_uniform_props = vk::PhysicalDeviceInlineUniformBlockProperties::default();
        {
            let mut props2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut inline_uniform_props);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut props2)
            };
        }
        max_inline_uniform_block_size = inline_uniform_props.max_inline_uniform_block_size;
    }

    // VUID-VkDescriptorSetLayoutBinding-descriptorType-02209 mandates descriptorCount to be a multiple of 4 when using inline
    // uniform blocks.
    // VUID-VkDescriptorSetLayoutBinding-descriptorType-08004 descriptorCount must be less than or equal
    // to VkPhysicalDeviceInlineUniformBlockProperties::maxInlineUniformBlockSize
    let descriptor_count = if params.descriptor_type == vk::DescriptorType::INLINE_UNIFORM_BLOCK {
        4u32.min(max_inline_uniform_block_size)
    } else {
        1
    };

    bindings.push(
        vk::DescriptorSetLayoutBinding::builder()
            .binding(bindings.len() as u32 + offset)
            .descriptor_type(params.descriptor_type)
            .descriptor_count(descriptor_count)
            .stage_flags(stages)
            .build(),
    );
    binding_flags.push(if params.use_variable_size {
        vk::DescriptorBindingFlags::VARIABLE_DESCRIPTOR_COUNT
    } else {
        vk::DescriptorBindingFlags::empty()
    });

    let binding_flags_info = vk::DescriptorSetLayoutBindingFlagsCreateInfo::builder()
        .binding_flags(&binding_flags)
        .build();

    // Check the layout is supported.
    let layout_create_info = make_create_info(&bindings, &binding_flags_info);
    let normal_values = get_set_layout_support_and_count(context, &layout_create_info);
    if !normal_values.supported {
        return Err(TestError::NotSupported("Set layout not supported".to_string()));
    }

    if !params.use_variable_size {
        if normal_values.max_variable_descriptor_count != 0 {
            return Ok(TestStatus::fail(
                "Nonzero maxVariableDescriptorCount when using no variable descriptor counts",
            ));
        }
    } else {
        // Check that the reported number makes sense.
        if params.descriptor_type == vk::DescriptorType::INLINE_UNIFORM_BLOCK {
            let mut iub_properties = vk::PhysicalDeviceInlineUniformBlockProperties::default();
            {
                let mut props2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut iub_properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut props2)
                };
            }
            if normal_values.max_variable_descriptor_count > iub_properties.max_inline_uniform_block_size {
                return Ok(TestStatus::fail(
                    "Implementation supports a max IUB size larger than maxInlineUniformBlockSize",
                ));
            }

            // The number needs to make sense for VUID-VkDescriptorSetLayoutBinding-descriptorType-02209 too.
            if !normal_values.max_variable_descriptor_count.is_multiple_of(4) {
                return Ok(TestStatus::fail(
                    "Implementation reports a max IUB size that is not a multiple of 4",
                ));
            }
        }

        // Verify if we switch from one to zero descriptors we get the same reply back.
        bindings.last_mut().expect("at least one binding").descriptor_count = 0;
        let layout_create_info = make_create_info(&bindings, &binding_flags_info);
        let zero_descriptor_values = get_set_layout_support_and_count(context, &layout_create_info);

        if !zero_descriptor_values.supported {
            return Ok(TestStatus::fail(
                "Implementation reports support with one descriptor and no support with zero descriptors",
            ));
        }

        if zero_descriptor_values.max_variable_descriptor_count != normal_values.max_variable_descriptor_count {
            return Ok(TestStatus::fail(
                "Mismatch in maxVariableDescriptorCount when using zero and one as descriptor counts",
            ));
        }

        // Verify we can create a descriptor set with the promised amount of descriptors.
        bindings.last_mut().expect("at least one binding").descriptor_count =
            normal_values.max_variable_descriptor_count;
        let layout_create_info = make_create_info(&bindings, &binding_flags_info);
        let max_descriptor_values = get_set_layout_support_and_count(context, &layout_create_info);

        if !max_descriptor_values.supported {
            return Ok(TestStatus::fail(
                "Implementation reports no support when using the maximum allowed size",
            ));
        }

        if max_descriptor_values.max_variable_descriptor_count != normal_values.max_variable_descriptor_count {
            return Ok(TestStatus::fail(
                "Mismatch in maxVariableDescriptorCount when using one and the maximum descriptor counts",
            ));
        }
    }

    if params.create_layout {
        let device = context.get_device();
        let layout_create_info = make_create_info(&bindings, &binding_flags_info);

        // This should work.
        let set_layout = unsafe { device.create_descriptor_set_layout(&layout_create_info, None) }
            .vk_check("vkCreateDescriptorSetLayout")?;
        if set_layout != vk::DescriptorSetLayout::null() {
            unsafe { device.destroy_descriptor_set_layout(set_layout, None) };
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// The create info is rebuilt for each query because the last binding's count is edited between them.
fn make_create_info(
    bindings: &[vk::DescriptorSetLayoutBinding],
    flags_info: &vk::DescriptorSetLayoutBindingFlagsCreateInfo,
) -> vk::DescriptorSetLayoutCreateInfo {
    vk::DescriptorSetLayoutCreateInfo {
        next: (flags_info as *const vk::DescriptorSetLayoutBindingFlagsCreateInfo).cast::<std::ffi::c_void>(),
        flags: vk::DescriptorSetLayoutCreateFlags::empty(),
        binding_count: bindings.len() as u32,
        bindings: bindings.as_ptr(),
        ..Default::default()
    }
}

/// `getDescriptorTypeShortName`: `de::toLower(getDescriptorTypeName(type).substr(strlen("VK_DESCRIPTOR_TYPE_")))`
fn get_descriptor_type_short_name(descriptor_type: vk::DescriptorType) -> &'static str {
    use vk::DescriptorType as T;
    match descriptor_type {
        T::SAMPLER => "sampler",
        T::COMBINED_IMAGE_SAMPLER => "combined_image_sampler",
        T::SAMPLED_IMAGE => "sampled_image",
        T::STORAGE_IMAGE => "storage_image",
        T::UNIFORM_TEXEL_BUFFER => "uniform_texel_buffer",
        T::STORAGE_TEXEL_BUFFER => "storage_texel_buffer",
        T::UNIFORM_BUFFER => "uniform_buffer",
        T::STORAGE_BUFFER => "storage_buffer",
        T::UNIFORM_BUFFER_DYNAMIC => "uniform_buffer_dynamic",
        T::STORAGE_BUFFER_DYNAMIC => "storage_buffer_dynamic",
        T::INPUT_ATTACHMENT => "input_attachment",
        T::INLINE_UNIFORM_BLOCK => "inline_uniform_block",
        _ => "unknown",
    }
}

struct CountLayoutSupportCase {
    name: String,
    params: CountLayoutSupportParams,
}

impl TestCase for CountLayoutSupportCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_count_layout_support(context, self.params)
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CountLayoutSupportInstance {
            context,
            params: self.params,
        })
    }
}

struct CountLayoutSupportInstance<'a> {
    context: &'a Context<'a>,
    params: CountLayoutSupportParams,
}

impl TestInstance for CountLayoutSupportInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        test_count_layout_support(self.context, self.params)
    }
}

/// `createMaintenance3Tests`
pub fn create_maintenance3_tests() -> TestCaseGroup {
    let mut main3_tests = TestCaseGroup::new("maintenance3_check");
    add_function_case(
        &mut main3_tests,
        "maintenance3_properties",
        check_support_maintenance3,
        maintenance3_struct,
    );
    add_function_case(
        &mut main3_tests,
        "descriptor_set",
        check_support_maintenance3,
        maintenance3_descriptor,
    );

    {
        use vk::DescriptorType as T;
        let descriptor_types = [
            T::SAMPLER,
            T::COMBINED_IMAGE_SAMPLER,
            T::SAMPLED_IMAGE,
            T::STORAGE_IMAGE,
            T::UNIFORM_TEXEL_BUFFER,
            T::STORAGE_TEXEL_BUFFER,
            T::UNIFORM_BUFFER,
            T::STORAGE_BUFFER,
            T::UNIFORM_BUFFER_DYNAMIC,
            T::STORAGE_BUFFER_DYNAMIC,
            T::INPUT_ATTACHMENT,
            T::INLINE_UNIFORM_BLOCK,
        ];

        for descriptor_type in descriptor_types {
            for extra_bindings in [false, true] {
                for use_variable_size in [false, true] {
                    for binding_offset in [0u32, 1u32] {
                        for create_layout in [false, true] {
                            if use_variable_size
                                && (descriptor_type == T::UNIFORM_BUFFER_DYNAMIC
                                    || descriptor_type == T::STORAGE_BUFFER_DYNAMIC)
                            {
                                continue;
                            }

                            let extra_bindings_suffix = if extra_bindings { "_extra_bindings" } else { "" };
                            let variable_size_suffix = if use_variable_size { "" } else { "_no_variable_size" };
                            let offset_suffix = if binding_offset != 0 {
                                "_nonzero_binding_offset"
                            } else {
                                ""
                            };
                            let creation_suffix = if create_layout { "_create_layout" } else { "" };
                            let case_name = format!(
                                "support_count_{}{extra_bindings_suffix}{variable_size_suffix}{offset_suffix}{creation_suffix}",
                                get_descriptor_type_short_name(descriptor_type)
                            );
                            let params = CountLayoutSupportParams {
                                descriptor_type,
                                binding_offset,
                                extra_bindings,
                                use_variable_size,
                                create_layout,
                            };

                            add_case(
                                &mut main3_tests,
                                CountLayoutSupportCase {
                                    name: case_name,
                                    params,
                                },
                            );
                        }
                    }
                }
            }
        }
    }

    main3_tests
}
