// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleTests.cpp (`createMultisampleTests(.., useFragmentShadingRate)`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream builds the `multisample` groups a second time as `multisample_with_fragment_shading_rate`: the same cases, each of whose
// graphics pipelines also chains a 2x2 `VkPipelineFragmentShadingRateStateCreateInfoKHR` (combiners KEEP) and whose `checkSupport` additionally
// requires pipelineFragmentShadingRate and a 2x2 rate for the sample count in use. The cases here are written once, so the flag is ambient while
// a case runs (like the construction type): `with_fragment_shading_rate` makes it so, `draw::util::create_draw_pipeline` chains the state and
// refuses, as `checkFragmentShadingRateRequirements` does, a sample count that has no 2x2 rate.

use std::cell::RefCell;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// A supported fragment shading rate: its size and the sample counts it works with.
type Rate = (vk::Extent2D, vk::SampleCountFlags);

thread_local! {
    static AMBIENT_RATES: RefCell<Option<Vec<Rate>>> = const { RefCell::new(None) };
}

/// The running case builds its pipelines with fragment shading rate state.
pub fn ambient_fragment_shading_rate() -> bool {
    AMBIENT_RATES.with(|rates| rates.borrow().is_some())
}

fn has_2x2_rate(rates: &[Rate], samples: vk::SampleCountFlags) -> bool {
    rates
        .iter()
        .any(|(size, counts)| size.width == 2 && size.height == 2 && counts.intersects(samples))
}

/// `checkFragmentShadingRateRequirements` for the ambient rates: a 2x2 rate that works with `samples`.
pub fn ambient_rates_support(samples: vk::SampleCountFlags) -> bool {
    AMBIENT_RATES.with(|rates| rates.borrow().as_ref().is_none_or(|rates| has_2x2_rate(rates, samples)))
}

/// `vkGetPhysicalDeviceFragmentShadingRatesKHR`: the count query followed by the query of that many.
fn query_rates(context: &Context<'_>) -> Vec<Rate> {
    let get_rates = context
        .get_instance()
        .commands()
        .get_physical_device_fragment_shading_rates_khr;
    let mut count = 0u32;
    unsafe { get_rates(context.get_physical_device(), &mut count, std::ptr::null_mut()) };
    let mut rates = vec![vk::PhysicalDeviceFragmentShadingRateKHR::default(); count as usize];
    unsafe { get_rates(context.get_physical_device(), &mut count, rates.as_mut_ptr()) };
    rates
        .iter()
        .map(|rate| (rate.fragment_size, rate.sample_counts))
        .collect()
}

fn pipeline_fragment_shading_rate(context: &Context<'_>) -> bool {
    let mut features = vk::PhysicalDeviceFragmentShadingRateFeaturesKHR::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    features.pipeline_fragment_shading_rate != vk::FALSE
}

/// A case of the `multisample_with_fragment_shading_rate` groups.
struct FragmentShadingRateCase {
    inner: Box<dyn TestCase>,
}

impl TestCase for FragmentShadingRateCase {
    fn name(&self) -> &str {
        self.inner.name()
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.inner.check_support(context)?;
        context.require_device_functionality("VK_KHR_fragment_shading_rate")?;
        if !pipeline_fragment_shading_rate(context) {
            return Err(TestError::NotSupported(
                "pipelineFragmentShadingRate not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.inner.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FragmentShadingRateInstance {
            inner: self.inner.create_instance(context),
            rates: query_rates(context),
        })
    }

    fn is_stub(&self) -> bool {
        self.inner.is_stub()
    }
}

struct FragmentShadingRateInstance<'a> {
    inner: Box<dyn TestInstance + 'a>,
    rates: Vec<Rate>,
}

impl TestInstance for FragmentShadingRateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let previous = AMBIENT_RATES.with(|rates| rates.replace(Some(self.rates.clone())));
        let outcome = self.inner.iterate();
        AMBIENT_RATES.with(|rates| rates.replace(previous));
        outcome
    }
}

/// Every case of `group` run with fragment shading rate state on its pipelines.
pub fn with_fragment_shading_rate(group: TestCaseGroup) -> TestCaseGroup {
    group.map_cases(&mut |case| Box::new(FragmentShadingRateCase { inner: case }) as Box<dyn TestCase>)
}
