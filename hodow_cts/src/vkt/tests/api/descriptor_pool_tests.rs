// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiDescriptorPoolTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Not ported: the Vulkan SC branches (`noResetDescriptorPoolTest`, the SC
// `recycleDescriptorSetMemory` support check), which this port does not build.

use vulkanalia::prelude::v1_0::*;

use super::case_util::add_case;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `VK_DESCRIPTOR_TYPE_LAST` is `VK_DESCRIPTOR_TYPE_INPUT_ATTACHMENT + 1`.
const VK_DESCRIPTOR_TYPE_LAST: i32 = 11;

/// `ResetDescriptorPoolTestParams`
#[derive(Clone, Copy)]
struct ResetDescriptorPoolTestParams {
    num_iterations: u32,
    free_descriptor_sets: bool,
}

/// `resetDescriptorPoolTest`
fn reset_descriptor_pool_test(context: &Context<'_>, params: ResetDescriptorPoolTestParams) -> TestOutcome {
    let num_descriptor_sets_per_iter: u32 = 2048;
    let vkd = context.get_device();

    let descriptor_pool_size = [vk::DescriptorPoolSize {
        type_: vk::DescriptorType::SAMPLER,
        descriptor_count: num_descriptor_sets_per_iter,
    }];

    let descriptor_pool_info = vk::DescriptorPoolCreateInfo::builder()
        .flags(if params.free_descriptor_sets {
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET
        } else {
            vk::DescriptorPoolCreateFlags::empty()
        })
        .max_sets(num_descriptor_sets_per_iter)
        .pool_sizes(&descriptor_pool_size);

    {
        let descriptor_pool = Unique::new(
            vkd,
            unsafe { vkd.create_descriptor_pool(&descriptor_pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );

        let descriptor_set_layout_bindings = [vk::DescriptorSetLayoutBinding::builder()
            .binding(0)
            .descriptor_type(vk::DescriptorType::SAMPLER)
            .descriptor_count(1)
            .stage_flags(vk::ShaderStageFlags::ALL)
            .build()];

        let descriptor_set_layout_info =
            vk::DescriptorSetLayoutCreateInfo::builder().bindings(&descriptor_set_layout_bindings);

        {
            let mut descriptor_set_layouts: Vec<Unique<'_, vk::DescriptorSetLayout>> =
                Vec::with_capacity(num_descriptor_sets_per_iter as usize);

            for _ in 0..num_descriptor_sets_per_iter {
                descriptor_set_layouts.push(Unique::new(
                    vkd,
                    unsafe { vkd.create_descriptor_set_layout(&descriptor_set_layout_info, None) }
                        .vk_check("vkCreateDescriptorSetLayout")?,
                ));
            }

            let descriptor_set_layouts_raw: Vec<vk::DescriptorSetLayout> =
                descriptor_set_layouts.iter().map(|layout| layout.get()).collect();

            let descriptor_set_info = vk::DescriptorSetAllocateInfo::builder()
                .descriptor_pool(*descriptor_pool)
                .set_layouts(&descriptor_set_layouts_raw);

            for _ in 0..params.num_iterations {
                // The test should crash in this loop at some point if there is a memory leak
                let test_sets = unsafe { vkd.allocate_descriptor_sets(&descriptor_set_info) }
                    .vk_check("vkAllocateDescriptorSets")?;
                if params.free_descriptor_sets {
                    unsafe { vkd.free_descriptor_sets(*descriptor_pool, &test_sets[..1]) }
                        .vk_check("vkFreeDescriptorSets")?;
                }
                unsafe { vkd.reset_descriptor_pool(*descriptor_pool, vk::DescriptorPoolResetFlags::empty()) }
                    .vk_check("vkResetDescriptorPool")?;
            }
        }
    }

    // If it didn't crash, pass
    Ok(TestStatus::pass("Pass"))
}

/// `outOfPoolMemoryTest`'s `FailureCase`
struct FailureCase {
    /// total number of descriptors (of a given type) in the descriptor pool
    pool_descriptor_count: u32,
    /// max number of descriptor sets that can be allocated from the pool
    pool_max_sets: u32,
    /// number of bindings per descriptor set layout
    binding_count: u32,
    /// number of descriptors in a binding (array size) (in all bindings)
    binding_descriptor_count: u32,
    /// number of descriptor sets to allocate
    descriptor_set_count: u32,
    /// the log message for this failure condition
    description: &'static str,
}

/// `outOfPoolMemoryTest`
fn out_of_pool_memory_test(context: &Context<'_>) -> TestOutcome {
    let vkd = context.get_device();
    let expect_out_of_pool_memory_error = context.is_device_functionality_supported("VK_KHR_maintenance1");
    let mut num_errors_returned: u32 = 0;

    let failure_cases = [
        //  pool            pool        binding     binding        alloc set
        //  descr. count    max sets    count       array size     count
        FailureCase {
            pool_descriptor_count: 4,
            pool_max_sets: 2,
            binding_count: 1,
            binding_descriptor_count: 1,
            descriptor_set_count: 3,
            description: "Out of descriptor sets",
        },
        FailureCase {
            pool_descriptor_count: 3,
            pool_max_sets: 4,
            binding_count: 1,
            binding_descriptor_count: 1,
            descriptor_set_count: 4,
            description: "Out of descriptors (due to the number of sets)",
        },
        FailureCase {
            pool_descriptor_count: 2,
            pool_max_sets: 1,
            binding_count: 3,
            binding_descriptor_count: 1,
            descriptor_set_count: 1,
            description: "Out of descriptors (due to the number of bindings)",
        },
        FailureCase {
            pool_descriptor_count: 3,
            pool_max_sets: 2,
            binding_count: 1,
            binding_descriptor_count: 2,
            descriptor_set_count: 2,
            description: "Out of descriptors (due to descriptor array size)",
        },
        FailureCase {
            pool_descriptor_count: 5,
            pool_max_sets: 1,
            binding_count: 2,
            binding_descriptor_count: 3,
            descriptor_set_count: 1,
            description: "Out of descriptors (due to descriptor array size in all bindings)",
        },
    ];

    log::info!("Creating a descriptor pool with insufficient resources. Descriptor set allocation is likely to fail.");

    for params in &failure_cases {
        log::info!("Checking: {}", params.description);

        for raw_descriptor_type in vk::DescriptorType::SAMPLER.as_raw()..VK_DESCRIPTOR_TYPE_LAST {
            let descriptor_type = vk::DescriptorType::from_raw(raw_descriptor_type);
            log::info!("- {descriptor_type:?}");

            let descriptor_pool_size = [vk::DescriptorPoolSize {
                type_: descriptor_type,
                descriptor_count: params.pool_descriptor_count,
            }];

            let descriptor_pool_create_info = vk::DescriptorPoolCreateInfo::builder()
                .flags(vk::DescriptorPoolCreateFlags::empty())
                .max_sets(params.pool_max_sets)
                .pool_sizes(&descriptor_pool_size);

            let descriptor_pool = Unique::new(
                vkd,
                unsafe { vkd.create_descriptor_pool(&descriptor_pool_create_info, None) }
                    .vk_check("vkCreateDescriptorPool")?,
            );

            let stage_flags = if descriptor_type != vk::DescriptorType::INPUT_ATTACHMENT {
                vk::ShaderStageFlags::ALL
            } else {
                vk::ShaderStageFlags::FRAGMENT
            };

            let mut descriptor_set_layout_bindings = vec![
                vk::DescriptorSetLayoutBinding::builder()
                    .binding(0)
                    .descriptor_type(descriptor_type)
                    .descriptor_count(params.binding_descriptor_count)
                    .stage_flags(stage_flags)
                    .build();
                params.binding_count as usize
            ];

            for (binding, layout_binding) in descriptor_set_layout_bindings.iter_mut().enumerate() {
                layout_binding.binding = binding as u32;
            }

            let descriptor_set_layout_info =
                vk::DescriptorSetLayoutCreateInfo::builder().bindings(&descriptor_set_layout_bindings);

            let descriptor_set_layout = Unique::new(
                vkd,
                unsafe { vkd.create_descriptor_set_layout(&descriptor_set_layout_info, None) }
                    .vk_check("vkCreateDescriptorSetLayout")?,
            );
            let raw_set_layouts = vec![descriptor_set_layout.get(); params.descriptor_set_count as usize];

            let descriptor_set_allocate_info = vk::DescriptorSetAllocateInfo::builder()
                .descriptor_pool(*descriptor_pool)
                .set_layouts(&raw_set_layouts);

            match unsafe { vkd.allocate_descriptor_sets(&descriptor_set_allocate_info) } {
                Err(result) => {
                    num_errors_returned += 1;

                    if expect_out_of_pool_memory_error && result != vk::ErrorCode::OUT_OF_POOL_MEMORY {
                        return Ok(TestStatus::fail(format!(
                            "Expected VK_ERROR_OUT_OF_POOL_MEMORY but got {result:?} instead"
                        )));
                    }
                }
                Ok(_) => log::info!("  Allocation was successful anyway"),
            }
        }
    }

    if num_errors_returned == 0 {
        Ok(TestStatus::pass("Not validated"))
    } else {
        Ok(TestStatus::pass("Pass"))
    }
}

/// `zeroPoolSizeCount`
fn zero_pool_size_count(context: &Context<'_>) -> TestOutcome {
    let vkd = context.get_device();

    let descriptor_pool_create_info = vk::DescriptorPoolCreateInfo::builder()
        .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
        .max_sets(1)
        .pool_sizes(&[] as &[vk::DescriptorPoolSize]);

    // Test a pool can be created for empty descriptor sets.
    let descriptor_pool = Unique::new(
        vkd,
        unsafe { vkd.create_descriptor_pool(&descriptor_pool_create_info, None) }.vk_check("vkCreateDescriptorPool")?,
    );

    let descriptor_set_layout_info =
        vk::DescriptorSetLayoutCreateInfo::builder().bindings(&[] as &[vk::DescriptorSetLayoutBinding]);

    let descriptor_set_layout = Unique::new(
        vkd,
        unsafe { vkd.create_descriptor_set_layout(&descriptor_set_layout_info, None) }
            .vk_check("vkCreateDescriptorSetLayout")?,
    );

    let set_layouts = [descriptor_set_layout.get()];
    let descriptor_set_allocate_info = vk::DescriptorSetAllocateInfo::builder()
        .descriptor_pool(*descriptor_pool)
        .set_layouts(&set_layouts);

    // Create an empty descriptor set from the pool.
    let descriptor_sets = match unsafe { vkd.allocate_descriptor_sets(&descriptor_set_allocate_info) } {
        Ok(sets) => sets,
        Err(result) => {
            return Ok(TestStatus::fail(format!(
                "Expected vkAllocateDescriptorSets to return VK_SUCCESS but got {result:?} instead"
            )));
        }
    };

    // Free the empty descriptor set back to the pool.
    if let Err(result) = unsafe { vkd.free_descriptor_sets(*descriptor_pool, &descriptor_sets) } {
        return Ok(TestStatus::fail(format!(
            "Expected vkFreeDescriptorSets to return VK_SUCCESS but got {result:?} instead"
        )));
    }

    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy)]
enum TestType {
    Reset(ResetDescriptorPoolTestParams),
    OutOfPoolMemory,
    ZeroPoolSizeCount,
}

struct DescriptorPoolCase {
    name: &'static str,
    test_type: TestType,
}

impl TestCase for DescriptorPoolCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DescriptorPoolInstance {
            context,
            test_type: self.test_type,
        })
    }
}

struct DescriptorPoolInstance<'a> {
    context: &'a Context<'a>,
    test_type: TestType,
}

impl TestInstance for DescriptorPoolInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.test_type {
            TestType::Reset(params) => reset_descriptor_pool_test(self.context, params),
            TestType::OutOfPoolMemory => out_of_pool_memory_test(self.context),
            TestType::ZeroPoolSizeCount => zero_pool_size_count(self.context),
        }
    }
}

/// `createDescriptorPoolTests`
pub fn create_descriptor_pool_tests() -> TestCaseGroup {
    let num_iterations_high: u32 = 4096;

    let mut descriptor_pool_tests = TestCaseGroup::new("descriptor_pool");

    let cases: [(&'static str, TestType); 6] = [
        // Test 2 cycles of vkAllocateDescriptorSets and vkResetDescriptorPool (should pass)
        (
            "repeated_reset_short",
            TestType::Reset(ResetDescriptorPoolTestParams {
                num_iterations: 2,
                free_descriptor_sets: false,
            }),
        ),
        // Test many cycles of vkAllocateDescriptorSets and vkResetDescriptorPool
        (
            "repeated_reset_long",
            TestType::Reset(ResetDescriptorPoolTestParams {
                num_iterations: num_iterations_high,
                free_descriptor_sets: false,
            }),
        ),
        // Test 2 cycles of vkAllocateDescriptorSets, vkFreeDescriptorSets and vkResetDescriptorPool (should pass)
        (
            "repeated_free_reset_short",
            TestType::Reset(ResetDescriptorPoolTestParams {
                num_iterations: 2,
                free_descriptor_sets: true,
            }),
        ),
        // Test many cycles of vkAllocateDescriptorSets, vkFreeDescriptorSets and vkResetDescriptorPool
        (
            "repeated_free_reset_long",
            TestType::Reset(ResetDescriptorPoolTestParams {
                num_iterations: num_iterations_high,
                free_descriptor_sets: true,
            }),
        ),
        // Test that when we run out of descriptors a correct error code is returned
        ("out_of_pool_memory", TestType::OutOfPoolMemory),
        // Test a descriptor pool object can be created with zero pools without error or crash
        ("zero_pool_size_count", TestType::ZeroPoolSizeCount),
    ];
    for (name, test_type) in cases {
        add_case(&mut descriptor_pool_tests, DescriptorPoolCase { name, test_type });
    }

    descriptor_pool_tests
}
