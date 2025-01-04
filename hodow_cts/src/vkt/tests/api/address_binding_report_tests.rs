// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryAddressBindingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. As with `device_memory_report_tests`, the objects are created through
// `object_management_tests`' `Resources` and `create_object`, over the same table of cases (`create_destroy_object_cases`), on a device
// of a custom instance that has a debug messenger for `VK_DEBUG_UTILS_MESSAGE_TYPE_DEVICE_ADDRESS_BINDING_BIT_EXT`. Registered under
// `memory` (see `memory::create_tests`).

use std::ffi::c_void;
use std::sync::Mutex;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDebugUtilsExtensionInstanceCommands, InstanceV1_1};

use super::device_memory_report_tests::create_destroy_object_cases;
use super::object_management_tests::{Environment, ObjectParams, Resources, create_object};
use crate::generated::shaders::api_object_management::OBJECT_MANAGEMENT;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `BindingData`
#[derive(Clone, Copy)]
struct BindingData {
    binding_address: vk::DeviceAddress,
    size: vk::DeviceSize,
    binding_type: vk::DeviceAddressBindingTypeEXT,
    object_handle: u64,
}

impl BindingData {
    /// `BindingData::operator==`, which leaves the binding type out.
    fn matches(&self, rhs: &BindingData) -> bool {
        self.binding_address == rhs.binding_address && self.size == rhs.size && self.object_handle == rhs.object_handle
    }
}

/// `BindingCallbackRecorder`
struct BindingCallbackRecorder {
    records: Mutex<Vec<BindingData>>,
}

impl BindingCallbackRecorder {
    fn new() -> Self {
        Self {
            records: Mutex::new(Vec::new()),
        }
    }

    fn records(&self) -> Vec<BindingData> {
        self.records.lock().expect("recorder lock").clone()
    }

    fn callback_internal(&self, callback_data: &vk::DebugUtilsMessengerCallbackDataEXT) {
        let binding_callback_data = unsafe { &*(callback_data.next as *const vk::DeviceAddressBindingCallbackDataEXT) };
        let object = unsafe { &*callback_data.objects };

        let binding_data = BindingData {
            binding_address: binding_callback_data.base_address,
            size: binding_callback_data.size,
            binding_type: binding_callback_data.binding_type,
            object_handle: object.object_handle,
        };

        self.records.lock().expect("recorder lock").push(binding_data);
    }
}

/// `BindingCallbackRecorder::callback`
unsafe extern "system" fn binding_callback(
    _message_severity: vk::DebugUtilsMessageSeverityFlagsEXT,
    message_type: vk::DebugUtilsMessageTypeFlagsEXT,
    callback_data: *const vk::DebugUtilsMessengerCallbackDataEXT,
    user_data: *mut c_void,
) -> vk::Bool32 {
    if message_type == vk::DebugUtilsMessageTypeFlagsEXT::DEVICE_ADDRESS_BINDING {
        let recorder = unsafe { &*(user_data as *const BindingCallbackRecorder) };
        recorder.callback_internal(unsafe { &*callback_data });
    }
    vk::FALSE
}

/// A device that is destroyed with the scope, like `DeviceWrapper`.
struct BoundDevice {
    device: Device,
}

impl Drop for BoundDevice {
    fn drop(&mut self) {
        unsafe { self.device.destroy_device(None) };
    }
}

/// An instance that is destroyed with the scope, like `InstanceWrapper`.
struct CustomInstance {
    instance: Instance,
}

impl Drop for CustomInstance {
    fn drop(&mut self) {
        unsafe { self.instance.destroy_instance(None) };
    }
}

/// `createDeviceWithAddressBindingReport`
fn create_device_with_address_binding_report(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    queue_family_index: u32,
) -> Result<BoundDevice, TestError> {
    let queue_priorities = [1.0f32];
    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&queue_priorities)
        .build()];
    let enabled_extensions = [c"VK_EXT_device_address_binding_report".as_ptr()];
    let features = unsafe { instance.get_physical_device_features(physical_device) };

    let mut device_address_binding_report_features =
        vk::PhysicalDeviceAddressBindingReportFeaturesEXT::builder().report_address_binding(true);
    let mut enabled_features2 = vk::PhysicalDeviceFeatures2::builder()
        .features(features)
        .push_next(&mut device_address_binding_report_features);
    let device_create_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&enabled_extensions)
        .push_next(&mut enabled_features2);

    let device =
        unsafe { instance.create_device(physical_device, &device_create_info, None) }.vk_check("vkCreateDevice")?;
    Ok(BoundDevice { device })
}

/// `checkSupport<Parameters>`
fn check_support_address_binding_report(context: &Context<'_>) -> Result<(), TestError> {
    if !context.is_device_functionality_supported("VK_EXT_device_address_binding_report") {
        return Err(TestError::NotSupported(
            "VK_EXT_device_address_binding_report not supported".to_string(),
        ));
    }

    let mut device_address_binding_report_features = vk::PhysicalDeviceAddressBindingReportFeaturesEXT::default();
    let mut device_features2 =
        vk::PhysicalDeviceFeatures2::builder().push_next(&mut device_address_binding_report_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut device_features2)
    };

    if device_address_binding_report_features.report_address_binding == vk::FALSE {
        return Err(TestError::NotSupported(
            "reportAddressBinding is not supported".to_string(),
        ));
    }
    Ok(())
}

/// `validateCallbackRecords`
fn validate_callback_records(recorder: &BindingCallbackRecorder) -> bool {
    let records = recorder.records();

    for (bind_ndx, bind_record) in records.iter().enumerate() {
        if bind_record.binding_type == vk::DeviceAddressBindingTypeEXT::BIND {
            let matched_bound_unbound = records[bind_ndx..].iter().any(|pair_record| {
                pair_record.binding_type == vk::DeviceAddressBindingTypeEXT::UNBIND && bind_record.matches(pair_record)
            });

            if matched_bound_unbound {
                log::info!("Bind/Unbind base adress:{}", bind_record.binding_address);
                log::info!("Bind/Unbind size:{}", bind_record.size);
                log::info!("Bind/Unbind object handle:{}", bind_record.object_handle);
            } else {
                log::info!("Lonely bind base adress:{}", bind_record.binding_address);
                log::info!("Lonely bind size:{}", bind_record.size);
                log::info!("Lonely bind object handle:{}", bind_record.object_handle);

                return false;
            }
        } else if bind_record.binding_type == vk::DeviceAddressBindingTypeEXT::UNBIND {
            let matched_bound_unbound = records[..bind_ndx].iter().any(|pair_record| {
                pair_record.binding_type == vk::DeviceAddressBindingTypeEXT::BIND && bind_record.matches(pair_record)
            });

            if !matched_bound_unbound {
                log::info!("Lonely unbind base adress:{}", bind_record.binding_address);
                log::info!("Lonely unbind size:{}", bind_record.size);
                log::info!("Lonely unbind object handle:{}", bind_record.object_handle);

                return false;
            }
        }
    }

    true
}

/// `createCustomInstanceWithExtensions` with `getInstanceExtensions`: only `VK_EXT_debug_utils` is not core.
fn create_instance_with_debug_utils(context: &Context<'_>) -> Result<CustomInstance, TestError> {
    let platform = context.get_platform();
    let extensions = [vk::EXT_DEBUG_UTILS_EXTENSION.name.as_ptr()];
    let app_info = vk::ApplicationInfo::builder().api_version(platform.api_version);
    let info = vk::InstanceCreateInfo::builder()
        .application_info(&app_info)
        .enabled_extension_names(&extensions);
    let instance = unsafe { platform.entry.create_instance(&info, None) }.vk_check("vkCreateInstance")?;
    Ok(CustomInstance { instance })
}

/// `InstanceWrapper::getPhysicalDevice` of the custom instance: the device the context runs on.
fn find_physical_device(context: &Context<'_>, instance: &Instance) -> Result<vk::PhysicalDevice, TestError> {
    let wanted = context.get_device_properties();
    let physical_devices = unsafe { instance.enumerate_physical_devices() }.vk_check("vkEnumeratePhysicalDevices")?;
    physical_devices
        .iter()
        .copied()
        .find(|&physical_device| {
            let properties = unsafe { instance.get_physical_device_properties(physical_device) };
            properties.vendor_id == wanted.vendor_id
                && properties.device_id == wanted.device_id
                && properties.device_name == wanted.device_name
        })
        .or_else(|| physical_devices.first().copied())
        .ok_or_else(|| TestError::NotSupported("No physical device on the custom instance".to_string()))
}

/// `createDestroyObjectTest<Object>`
fn create_destroy_object_test(context: &Context<'_>, params: Option<&ObjectParams>) -> TestOutcome {
    let recorder = BindingCallbackRecorder::new();
    let custom_instance = create_instance_with_debug_utils(context)?;
    let instance = &custom_instance.instance;
    let physical_device = find_physical_device(context, instance)?;
    let mut queue_family_index = 0u32;

    let queue_props = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
    for (queue_ndx, props) in queue_props.iter().enumerate() {
        if props.queue_flags.contains(vk::QueueFlags::GRAPHICS) {
            queue_family_index = queue_ndx as u32;
            break;
        }
    }

    let debug_utils_messenger_create_info = vk::DebugUtilsMessengerCreateInfoEXT::builder()
        .message_severity(vk::DebugUtilsMessageSeverityFlagsEXT::INFO)
        .message_type(vk::DebugUtilsMessageTypeFlagsEXT::DEVICE_ADDRESS_BINDING)
        .user_callback(Some(binding_callback))
        .user_data(unsafe {
            &mut *(&recorder as *const BindingCallbackRecorder)
                .cast_mut()
                .cast::<c_void>()
        });

    let messenger = unsafe { instance.create_debug_utils_messenger_ext(&debug_utils_messenger_create_info, None) }
        .vk_check("vkCreateDebugUtilsMessengerEXT")?;

    let result = (|| -> Result<(), TestError> {
        let device = create_device_with_address_binding_report(instance, physical_device, queue_family_index)?;

        match params {
            // `Device::create`: the device itself is the object.
            None => {
                let _object = create_device_with_address_binding_report(instance, physical_device, queue_family_index)?;
            }
            Some(params) => {
                let platform = context.get_platform();
                let env = Environment {
                    entry: &platform.entry,
                    api_version: platform.api_version,
                    device: &device.device,
                    queue_family_index,
                    programs: OBJECT_MANAGEMENT.programs,
                    allocation_callbacks: None,
                    max_resource_consumers: 1,
                };
                let res = Resources::new(&env, params)?;
                let _object = create_object(&env, &res, params)?;
            }
        }
        Ok(())
    })();

    unsafe { instance.destroy_debug_utils_messenger_ext(messenger, None) };
    result?;

    if !validate_callback_records(&recorder) {
        return Ok(TestStatus::fail("Invalid address binding report callback"));
    }

    Ok(TestStatus::pass("Ok"))
}

struct AddressBindingReportCase {
    name: &'static str,
    params: Option<ObjectParams>,
}

impl TestCase for AddressBindingReportCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_address_binding_report(context)
    }

    fn programs(&self) -> BinaryCollection {
        match &self.params {
            Some(
                ObjectParams::ShaderModule { .. } | ObjectParams::GraphicsPipeline | ObjectParams::ComputePipeline,
            ) => OBJECT_MANAGEMENT.programs,
            _ => BinaryCollection::new(&[]),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AddressBindingReportInstance {
            context,
            params: self.params.as_ref(),
        })
    }
}

struct AddressBindingReportInstance<'a> {
    context: &'a Context<'a>,
    params: Option<&'a ObjectParams>,
}

impl TestInstance for AddressBindingReportInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        create_destroy_object_test(self.context, self.params)
    }
}

/// `createAddressBindingReportTests`
pub fn create_address_binding_report_tests() -> TestCaseGroup {
    let mut address_binding_report_tests = TestCaseGroup::new("address_binding_report");

    // Check emitted callbacks are properly paired
    let mut group = TestCaseGroup::new("create_and_destroy_object");
    for (name, params) in create_destroy_object_cases() {
        group.add_child(Box::new(AddressBindingReportCase { name, params }) as Box<dyn TestCase>);
    }
    address_binding_report_tests.add_child(group);

    address_binding_report_tests
}
