// SPDX-License-Identifier: Apache-2.0
//
// Port of the parts of VK-GL-CTS `external/vulkancts/framework/vulkan` that the
// ported tests use, on demand.
//
// One structural difference from upstream runs through this whole module: upstream
// threads a `DeviceInterface&` (the dispatch table) and a `VkDevice` (the handle)
// separately, because its bindings keep them apart. `vulkanalia::Device` carries
// both, so every helper here takes a single `&Device` where upstream takes two
// arguments. Call sites read `makeCommandPool(vk, queueFamilyIndex)` instead of
// `makeCommandPool(vk, device, queueFamilyIndex)`.

pub mod alloc_callback_util;
pub mod builder_util;
pub mod cmd_util;
pub mod compressed_formats;
pub mod compute_pipeline;
pub mod image_util;
pub mod mem_util;
pub mod obj_util;
pub mod platform;
pub mod programs;
pub mod ref_util;

pub use image_util::ImageWithMemory;
pub use mem_util::{Allocation, MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
pub use ref_util::{DeviceObject, Unique, UniqueCommandBuffer, UniqueDescriptorSet};

use crate::tcu::TestError;

/// Maps a failed Vulkan call onto the verdict upstream's `VK_CHECK` would produce.
///
/// The split matters: `VK_ERROR_OUT_OF_*_MEMORY` is a ResourceError (the
/// implementation ran out of something, which is not a conformance failure) and
/// `VK_ERROR_DEVICE_LOST` gets its own verdict because it poisons the device for
/// every subsequent test in the batch, which the runner has to react to.
pub trait VkResultExt<T> {
    fn vk_check(self, what: &str) -> Result<T, TestError>;
}

impl<T> VkResultExt<T> for Result<T, vulkanalia::vk::ErrorCode> {
    fn vk_check(self, what: &str) -> Result<T, TestError> {
        use vulkanalia::vk::ErrorCode;

        self.map_err(|code| {
            let msg = format!("{what} returned {code:?}");
            match code {
                // Host-memory exhaustion is its own variant because the alloc-callback
                // tests induce it deliberately and have to tell it from any other
                // out-of-memory; both still report as ResourceError.
                ErrorCode::OUT_OF_HOST_MEMORY => TestError::OutOfHostMemory(msg),
                ErrorCode::OUT_OF_DEVICE_MEMORY | ErrorCode::OUT_OF_POOL_MEMORY => TestError::ResourceError(msg),
                ErrorCode::DEVICE_LOST => TestError::DeviceLost(msg),
                ErrorCode::FEATURE_NOT_PRESENT | ErrorCode::EXTENSION_NOT_PRESENT | ErrorCode::FORMAT_NOT_SUPPORTED => TestError::NotSupported(msg),
                _ => TestError::InternalError(msg),
            }
        })
    }
}
