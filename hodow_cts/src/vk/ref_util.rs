// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkRef.hpp / vkRefUtil.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `Move<T>`/`Unique<T>`
// pair exists because C++ needs an explicit ownership-transfer type; in Rust the
// move is the default, so only `Unique<T>` is needed. This is one of the few places
// the port deliberately drops upstream structure: keeping a hand-rolled `Move<T>`
// would add a type that does nothing here and would still not prevent leaks the way
// `Drop` does.

use std::ops::Deref;

use vulkanalia::prelude::v1_0::*;

/// A Vulkan object that is destroyed through the device.
pub trait DeviceObject: Copy {
    /// Destroys the handle.
    ///
    /// # Safety
    /// Must be called at most once per handle, and only while `device` is still
    /// alive and no queue still has work referencing the object. `allocator` must be
    /// the one the object was created with, or `None` if it was created with none.
    unsafe fn destroy(self, device: &Device, allocator: Option<&vk::AllocationCallbacks>);
}

/// `vk::Unique<T>` - destroys the wrapped handle when it goes out of scope.
pub struct Unique<'a, T: DeviceObject> {
    device: &'a Device,
    handle: T,
    /// `Deleter<T>::m_allocator` - an object created with allocation callbacks has to
    /// be destroyed with a compatible allocator, so the pair travels together.
    allocator: Option<&'a vk::AllocationCallbacks>,
}

impl<'a, T: DeviceObject> Unique<'a, T> {
    pub fn new(device: &'a Device, handle: T) -> Self {
        Self { device, handle, allocator: None }
    }

    pub fn with_allocator(device: &'a Device, handle: T, allocator: Option<&'a vk::AllocationCallbacks>) -> Self {
        Self { device, handle, allocator }
    }

    pub fn get(&self) -> T {
        self.handle
    }
}

impl<T: DeviceObject> Deref for Unique<'_, T> {
    type Target = T;

    fn deref(&self) -> &T {
        &self.handle
    }
}

impl<T: DeviceObject> Drop for Unique<'_, T> {
    fn drop(&mut self) {
        unsafe { self.handle.destroy(self.device, self.allocator) };
    }
}

macro_rules! impl_device_object {
    ($ty:ty, $destroy:ident) => {
        impl DeviceObject for $ty {
            unsafe fn destroy(self, device: &Device, allocator: Option<&vk::AllocationCallbacks>) {
                unsafe { device.$destroy(self, allocator) };
            }
        }
    };
}

impl_device_object!(vk::Buffer, destroy_buffer);
impl_device_object!(vk::BufferView, destroy_buffer_view);
impl_device_object!(vk::CommandPool, destroy_command_pool);
impl_device_object!(vk::DescriptorPool, destroy_descriptor_pool);
impl_device_object!(vk::DescriptorSetLayout, destroy_descriptor_set_layout);
impl_device_object!(vk::DeviceMemory, free_memory);
impl_device_object!(vk::Fence, destroy_fence);
impl_device_object!(vk::Framebuffer, destroy_framebuffer);
impl_device_object!(vk::Image, destroy_image);
impl_device_object!(vk::ImageView, destroy_image_view);
impl_device_object!(vk::Pipeline, destroy_pipeline);
impl_device_object!(vk::PipelineLayout, destroy_pipeline_layout);
impl_device_object!(vk::PipelineCache, destroy_pipeline_cache);
impl_device_object!(vk::QueryPool, destroy_query_pool);
impl_device_object!(vk::RenderPass, destroy_render_pass);
impl_device_object!(vk::Sampler, destroy_sampler);
impl_device_object!(vk::Semaphore, destroy_semaphore);
impl_device_object!(vk::ShaderModule, destroy_shader_module);
impl_device_object!(vk::Event, destroy_event);

/// The private-data slot's destroy entry point comes from `VK_EXT_private_data` (or
/// core 1.3), so it needs the extension trait in scope rather than the blanket macro.
impl DeviceObject for vk::PrivateDataSlot {
    unsafe fn destroy(self, device: &Device, allocator: Option<&vk::AllocationCallbacks>) {
        use vulkanalia::vk::ExtPrivateDataExtensionDeviceCommands;
        unsafe { device.destroy_private_data_slot_ext(self, allocator) };
    }
}

/// A descriptor set needs its pool to be freed, so it cannot use the blanket
/// `DeviceObject` impl. Upstream wraps it in `Unique<VkDescriptorSet>` with a
/// deleter that carries the pool; this carries it in the struct instead.
pub struct UniqueDescriptorSet<'a> {
    device: &'a Device,
    pool: vk::DescriptorPool,
    handle: vk::DescriptorSet,
}

impl<'a> UniqueDescriptorSet<'a> {
    pub fn new(device: &'a Device, pool: vk::DescriptorPool, handle: vk::DescriptorSet) -> Self {
        Self { device, pool, handle }
    }

    pub fn get(&self) -> vk::DescriptorSet {
        self.handle
    }
}

impl Deref for UniqueDescriptorSet<'_> {
    type Target = vk::DescriptorSet;

    fn deref(&self) -> &vk::DescriptorSet {
        &self.handle
    }
}

impl Drop for UniqueDescriptorSet<'_> {
    fn drop(&mut self) {
        unsafe { self.device.free_descriptor_sets(self.pool, &[self.handle]) }.ok();
    }
}

/// Command buffers are freed back to their pool. Upstream's `Unique<VkCommandBuffer>`
/// does the same through a pool-carrying deleter.
pub struct UniqueCommandBuffer<'a> {
    device: &'a Device,
    pool: vk::CommandPool,
    handle: vk::CommandBuffer,
}

impl<'a> UniqueCommandBuffer<'a> {
    pub fn new(device: &'a Device, pool: vk::CommandPool, handle: vk::CommandBuffer) -> Self {
        Self { device, pool, handle }
    }

    pub fn get(&self) -> vk::CommandBuffer {
        self.handle
    }
}

impl Deref for UniqueCommandBuffer<'_> {
    type Target = vk::CommandBuffer;

    fn deref(&self) -> &vk::CommandBuffer {
        &self.handle
    }
}

impl Drop for UniqueCommandBuffer<'_> {
    fn drop(&mut self) {
        unsafe { self.device.free_command_buffers(self.pool, &[self.handle]) };
    }
}
