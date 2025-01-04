// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image_processing/vktImageProcessingApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 Qualcomm Technologies, Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::test_util::{ImageProcOp, query_image_processing_features};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct ImageProcessingApiTest {
    name: &'static str,
    operation: ImageProcOp,
}

impl TestCase for ImageProcessingApiTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.api_version() < (1, 3, 0) {
            context.require_device_functionality("VK_KHR_format_feature_flags2")?;
        }

        context.require_device_functionality("VK_QCOM_image_processing")?;

        let features = query_image_processing_features(context);

        match self.operation {
            ImageProcOp::BlockMatchSad | ImageProcOp::BlockMatchSsd => {
                if features.texture_block_match == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Feature textureBlockMatch not supported".to_string(),
                    ));
                }
            }
            ImageProcOp::SampleWeighted => {
                if features.texture_sample_weighted == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Feature textureSampleWeighted not supported".to_string(),
                    ));
                }
            }
            ImageProcOp::BoxFilter => {
                if features.texture_box_filter == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Feature textureBoxFilter not supported".to_string(),
                    ));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageProcessingApiTestInstance {
            context,
            operation: self.operation,
            rnd: Random::new(1234),
        })
    }
}

struct ImageProcessingApiTestInstance<'a> {
    context: &'a Context<'a>,
    operation: ImageProcOp,
    rnd: Random,
}

impl TestInstance for ImageProcessingApiTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let instance = self.context.get_instance();

        let test_iterations = self.rnd.get_int(1, 20) as u32;

        for _ in 0..test_iterations {
            let mut img_proc_properties = vk::PhysicalDeviceImageProcessingPropertiesQCOM::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut img_proc_properties);
            unsafe { instance.get_physical_device_properties2(self.context.get_physical_device(), &mut properties2) };

            match self.operation {
                ImageProcOp::BlockMatchSad | ImageProcOp::BlockMatchSsd => {
                    if img_proc_properties.max_block_match_region.width < 64
                        || img_proc_properties.max_block_match_region.height < 64
                    {
                        return Ok(TestStatus::fail(
                            "Property maxBlockMatchRegion is less than the minimum limit",
                        ));
                    }
                }
                ImageProcOp::SampleWeighted => {
                    if img_proc_properties.max_weight_filter_phases < 1024 {
                        return Ok(TestStatus::fail(
                            "Property maxWeightFilterPhases is less than the minimum limit",
                        ));
                    }
                    if img_proc_properties.max_weight_filter_dimension.width < 64
                        || img_proc_properties.max_weight_filter_dimension.height < 64
                    {
                        return Ok(TestStatus::fail(
                            "Property maxWeightFilterDimension is less than the minimum limit",
                        ));
                    }
                }
                ImageProcOp::BoxFilter => {
                    if img_proc_properties.max_box_filter_block_size.width < 64
                        || img_proc_properties.max_box_filter_block_size.height < 64
                    {
                        return Ok(TestStatus::fail(
                            "Property maxBoxFilterBlockSize is less than the minimum limit",
                        ));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createImageProcessingApiTests`
pub fn create_image_processing_api_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("api");
    let cases = [
        ("properties_block_matching_sad", ImageProcOp::BlockMatchSad),
        ("properties_block_matching_ssd", ImageProcOp::BlockMatchSsd),
        ("properties_weight_sampling", ImageProcOp::SampleWeighted),
        ("properties_box_filtering", ImageProcOp::BoxFilter),
    ];
    for (name, operation) in cases {
        group.add_child(Box::new(ImageProcessingApiTest { name, operation }) as Box<dyn TestCase>);
    }
    group
}
