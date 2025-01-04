// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image_processing/vktImageProcessingTestsUtil.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 Qualcomm Technologies, Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only what the ported groups use is here so far.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::vkt::Context;

/// `ImageProcOp` (without `IMAGE_PROC_OP_LAST`)
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum ImageProcOp {
    SampleWeighted,
    BoxFilter,
    BlockMatchSad,
    BlockMatchSsd,
}

/// `Context::getImageProcessingFeaturesQCOM`, queried on demand since the context does not carry the structure.
pub fn query_image_processing_features(context: &Context<'_>) -> vk::PhysicalDeviceImageProcessingFeaturesQCOM {
    let mut features = vk::PhysicalDeviceImageProcessingFeaturesQCOM::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}
