// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkBuilderUtil.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::ref_util::Unique;

/// `vk::DescriptorSetLayoutBuilder`
#[derive(Default)]
pub struct DescriptorSetLayoutBuilder {
    bindings: Vec<vk::DescriptorSetLayoutBinding>,
    /// Immutable samplers are referenced by pointer from the bindings, so the builder
    /// has to own them until `build`. Upstream keeps the same list for the same reason.
    immutable_samplers: Vec<Vec<vk::Sampler>>,
}

impl DescriptorSetLayoutBuilder {
    pub fn new() -> Self {
        Self::default()
    }

    /// `DescriptorSetLayoutBuilder::addSingleBinding`
    pub fn add_single_binding(mut self, descriptor_type: vk::DescriptorType, stage_flags: vk::ShaderStageFlags) -> Self {
        self.bindings.push(vk::DescriptorSetLayoutBinding {
            binding: self.bindings.len() as u32,
            descriptor_type,
            descriptor_count: 1,
            stage_flags,
            immutable_samplers: std::ptr::null(),
        });
        self
    }

    /// `DescriptorSetLayoutBuilder::addSingleIndexedBinding` / `addArrayBinding` -
    /// the binding number is given rather than taken from the position, which is what
    /// a layout with gaps or with an arbitrary binding index needs.
    pub fn add_indexed_binding(mut self, descriptor_type: vk::DescriptorType, stage_flags: vk::ShaderStageFlags, binding: u32, descriptor_count: u32) -> Self {
        self.bindings.push(vk::DescriptorSetLayoutBinding {
            binding,
            descriptor_type,
            descriptor_count,
            stage_flags,
            immutable_samplers: std::ptr::null(),
        });
        self
    }

    /// `DescriptorSetLayoutBuilder::addSingleIndexedSamplerBinding` /
    /// `addArraySamplerBinding` - the immutable-sampler forms, where the sampler is
    /// baked into the layout rather than written into the descriptor.
    pub fn add_indexed_sampler_binding(mut self, descriptor_type: vk::DescriptorType, stage_flags: vk::ShaderStageFlags, binding: u32, samplers: &[vk::Sampler]) -> Self {
        self.immutable_samplers.push(samplers.to_vec());
        let owned = self.immutable_samplers.last().expect("just pushed");
        self.bindings.push(vk::DescriptorSetLayoutBinding {
            binding,
            descriptor_type,
            descriptor_count: owned.len() as u32,
            stage_flags,
            immutable_samplers: owned.as_ptr(),
        });
        self
    }

    pub fn build(self, device: &Device) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        let info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&self.bindings);
        let layout = unsafe { device.create_descriptor_set_layout(&info, None) }.vk_check("vkCreateDescriptorSetLayout")?;
        Ok(Unique::new(device, layout))
    }
}

/// `vk::DescriptorPoolBuilder`
#[derive(Default)]
pub struct DescriptorPoolBuilder {
    counts: Vec<u32>,
}

impl DescriptorPoolBuilder {
    pub fn new() -> Self {
        Self {
            counts: vec![0; vk::DescriptorType::INPUT_ATTACHMENT.as_raw() as usize + 1],
        }
    }

    /// `DescriptorPoolBuilder::addType`
    pub fn add_type(mut self, descriptor_type: vk::DescriptorType, num_descriptors: u32) -> Self {
        if num_descriptors == 0 {
            return self;
        }
        let idx = descriptor_type.as_raw() as usize;
        if idx >= self.counts.len() {
            self.counts.resize(idx + 1, 0);
        }
        self.counts[idx] += num_descriptors;
        self
    }

    pub fn build(self, device: &Device, flags: vk::DescriptorPoolCreateFlags, max_sets: u32) -> Result<Unique<'_, vk::DescriptorPool>, TestError> {
        let sizes: Vec<vk::DescriptorPoolSize> = self
            .counts
            .iter()
            .enumerate()
            .filter(|&(_, &n)| n > 0)
            .map(|(i, &n)| vk::DescriptorPoolSize {
                type_: vk::DescriptorType::from_raw(i as i32),
                descriptor_count: n,
            })
            .collect();

        let info = vk::DescriptorPoolCreateInfo::builder().flags(flags).max_sets(max_sets).pool_sizes(&sizes);
        let pool = unsafe { device.create_descriptor_pool(&info, None) }.vk_check("vkCreateDescriptorPool")?;
        Ok(Unique::new(device, pool))
    }
}

/// `vk::DescriptorSetUpdateBuilder::Location`
#[derive(Debug, Clone, Copy)]
pub struct Location {
    pub binding: u32,
    pub array_element: u32,
}

impl Location {
    pub fn binding(binding: u32) -> Self {
        Self { binding, array_element: 0 }
    }

    pub fn binding_array_element(binding: u32, array_element: u32) -> Self {
        Self { binding, array_element }
    }
}

/// `vk::DescriptorSetUpdateBuilder`
///
/// The buffer infos are owned by the builder so the pointers written into
/// `VkWriteDescriptorSet` stay valid until `update` runs - upstream relies on the
/// caller keeping them alive, which is exactly the kind of dangling-pointer footgun
/// there is no reason to reproduce.
#[derive(Default)]
pub struct DescriptorSetUpdateBuilder {
    writes: Vec<PendingWrite>,
}

struct PendingWrite {
    destination_set: vk::DescriptorSet,
    location: Location,
    descriptor_type: vk::DescriptorType,
    buffer_info: vk::DescriptorBufferInfo,
}

impl DescriptorSetUpdateBuilder {
    pub fn new() -> Self {
        Self::default()
    }

    /// `DescriptorSetUpdateBuilder::writeSingle` for buffer descriptors.
    pub fn write_single(mut self, destination_set: vk::DescriptorSet, location: Location, descriptor_type: vk::DescriptorType, buffer_info: &vk::DescriptorBufferInfo) -> Self {
        self.writes.push(PendingWrite {
            destination_set,
            location,
            descriptor_type,
            buffer_info: *buffer_info,
        });
        self
    }

    pub fn update(self, device: &Device) {
        let writes: Vec<vk::WriteDescriptorSet> = self
            .writes
            .iter()
            .map(|w| vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: w.destination_set,
                dst_binding: w.location.binding,
                dst_array_element: w.location.array_element,
                descriptor_count: 1,
                descriptor_type: w.descriptor_type,
                image_info: std::ptr::null(),
                buffer_info: &w.buffer_info,
                texel_buffer_view: std::ptr::null(),
            })
            .collect();

        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
    }
}
