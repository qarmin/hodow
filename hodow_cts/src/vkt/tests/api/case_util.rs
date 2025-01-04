// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/vktTestCaseUtil.hpp (FunctionInstance0 / addFunctionCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `addFunctionCase(group, name, checkSupport, testFunc)` for the api groups whose cases are
// a plain function of the Context and use no shader.

use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

pub type CheckSupportFn = fn(&Context<'_>) -> Result<(), TestError>;
pub type TestFn = fn(&Context<'_>) -> TestOutcome;

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `FunctionInstance0` + `FunctionSupport0` bound to one case.
pub struct FunctionCase {
    name: String,
    check_support: Option<CheckSupportFn>,
    test: TestFn,
}

impl TestCase for FunctionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.check_support {
            Some(check) => check(context),
            None => Ok(()),
        }
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FunctionInstance {
            context,
            test: self.test,
        })
    }
}

struct FunctionInstance<'a> {
    context: &'a Context<'a>,
    test: TestFn,
}

impl TestInstance for FunctionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test)(self.context)
    }
}

/// `addFunctionCase` with a support check.
pub fn add_function_case(group: &mut TestCaseGroup, name: &str, check_support: CheckSupportFn, test: TestFn) {
    group.add_child(Box::new(FunctionCase {
        name: name.to_string(),
        check_support: Some(check_support),
        test,
    }) as Box<dyn TestCase>);
}

/// `addFunctionCase` without one.
pub fn add_function_case_no_support(group: &mut TestCaseGroup, name: &str, test: TestFn) {
    group.add_child(Box::new(FunctionCase {
        name: name.to_string(),
        check_support: None,
        test,
    }) as Box<dyn TestCase>);
}

/// Adds any case to a group.
pub fn add_case(group: &mut TestCaseGroup, case: impl TestCase + 'static) {
    group.add_child(Box::new(case) as Box<dyn TestCase>);
}

/// `findQueueFamilyIndexWithCaps`: the first family with every `required` flag and none of
/// the `excluded` ones. Throws NotSupported upstream when there is none, as here.
pub fn find_queue_family_index_with_caps(
    instance: &vulkanalia::Instance,
    physical_device: vulkanalia::vk::PhysicalDevice,
    required: vulkanalia::vk::QueueFlags,
    excluded: vulkanalia::vk::QueueFlags,
) -> Result<u32, TestError> {
    use vulkanalia::prelude::v1_0::*;

    let queue_props = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
    queue_props
        .iter()
        .position(|p| p.queue_flags.contains(required) && (p.queue_flags & excluded).is_empty())
        .map(|i| i as u32)
        .ok_or_else(|| TestError::NotSupported("No matching queue found".to_string()))
}

/// `Context::requireInstanceFunctionality`, answered from the loader's instance extension list.
pub fn is_instance_extension_available(context: &Context<'_>, extension: &str) -> bool {
    use vulkanalia::prelude::v1_0::*;

    match unsafe {
        context
            .get_platform()
            .entry
            .enumerate_instance_extension_properties(None)
    } {
        Ok(props) => props.iter().any(|p| p.extension_name.to_string_lossy() == extension),
        Err(_) => false,
    }
}

/// An instance the test created for itself, destroyed on drop, and the physical device in it
/// that is the context's.
pub struct CustomInstance {
    pub instance: vulkanalia::Instance,
    pub physical_device: vulkanalia::vk::PhysicalDevice,
}

impl Drop for CustomInstance {
    fn drop(&mut self) {
        use vulkanalia::prelude::v1_0::*;

        unsafe { self.instance.destroy_instance(None) };
    }
}

/// `createCustomInstanceWithExtension`: an instance of the run's API version with exactly one
/// extra instance extension enabled.
pub fn create_custom_instance_with_extension(
    context: &Context<'_>,
    extension: &str,
) -> Result<CustomInstance, TestError> {
    if !is_instance_extension_available(context, extension) {
        return Err(TestError::NotSupported(format!(
            "{extension} is not supported by this implementation"
        )));
    }
    create_custom_instance(context, &[extension])
}

/// `createCustomInstanceFromContext` with an explicit extension list (empty for none).
pub fn create_custom_instance(context: &Context<'_>, extensions: &[&str]) -> Result<CustomInstance, TestError> {
    use std::ffi::CString;

    use vulkanalia::prelude::v1_0::*;

    use crate::vk::VkResultExt;

    let platform = context.get_platform();
    let extension_names = extensions
        .iter()
        .map(|extension| CString::new(*extension).map_err(|e| TestError::InternalError(e.to_string())))
        .collect::<Result<Vec<_>, _>>()?;
    let extension_ptrs: Vec<*const std::ffi::c_char> = extension_names.iter().map(|name| name.as_ptr()).collect();
    let app_info = vk::ApplicationInfo::builder()
        .application_name(b"hodow_cts\0")
        .application_version(vk::make_version(0, 1, 0))
        .engine_name(b"hodow_cts\0")
        .engine_version(vk::make_version(0, 1, 0))
        .api_version(platform.api_version);
    let info = vk::InstanceCreateInfo::builder()
        .application_info(&app_info)
        .enabled_extension_names(&extension_ptrs);

    let instance = unsafe { platform.entry.create_instance(&info, None) }.vk_check("vkCreateInstance")?;

    let reference = context.get_device_properties();
    let physical_devices = match unsafe { instance.enumerate_physical_devices() }.vk_check("vkEnumeratePhysicalDevices")
    {
        Ok(devices) => devices,
        Err(e) => {
            unsafe { instance.destroy_instance(None) };
            return Err(e);
        }
    };
    let chosen = physical_devices
        .iter()
        .copied()
        .find(|&pd| {
            let props = unsafe { instance.get_physical_device_properties(pd) };
            props.vendor_id == reference.vendor_id
                && props.device_id == reference.device_id
                && props.pipeline_cache_uuid == reference.pipeline_cache_uuid
        })
        .or_else(|| physical_devices.first().copied());

    match chosen {
        Some(physical_device) => Ok(CustomInstance {
            instance,
            physical_device,
        }),
        None => {
            unsafe { instance.destroy_instance(None) };
            Err(TestError::NotSupported(
                "no physical device in the custom instance".to_string(),
            ))
        }
    }
}

/// A case that is registered so the case tree matches upstream but whose body is not
/// ported. It reports itself through `is_stub`, so `cts-coverage` does not count it, and
/// running it yields NotPorted rather than a verdict.
pub struct StubCase {
    name: &'static str,
    what: &'static str,
}

impl StubCase {
    pub fn new(name: &'static str, what: &'static str) -> Self {
        Self { name, what }
    }
}

impl TestCase for StubCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StubInstance { what: self.what })
    }

    fn is_stub(&self) -> bool {
        true
    }
}

struct StubInstance {
    what: &'static str,
}

impl TestInstance for StubInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(self.what.to_string()))
    }
}
