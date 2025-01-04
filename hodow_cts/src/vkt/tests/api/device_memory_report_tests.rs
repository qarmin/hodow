// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryDeviceMemoryReportTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2021 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream repeats the object kinds of `vktApiObjectManagementTests.cpp` as its own
// templated structs; here the creation of each object goes through `object_management_tests`' `Resources` and `create_object`, which
// build the same objects with the same parameters, on a device created with `VK_EXT_device_memory_report`. The group is registered
// under `memory` (see `memory::create_tests`) although the file sits next to the object management port it shares code with.
// `external_memory` registers the only handle type upstream lists, an Android hardware buffer, which a Linux device never supports.

use std::collections::BTreeSet;
use std::ffi::c_void;
use std::sync::Mutex;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::object_management_tests::{
    BufferParams, BufferViewParams, CommandBufferParams, DescriptorPoolParams, DescriptorSetLayoutParams,
    DeviceMemoryParams, Environment, ImageParams, ImageViewParams, ObjectParams, PipelineLayoutParams, QueryPoolParams,
    Resources, create_object, image_params, make_extent_3d, make_subresource_range,
};
use crate::generated::shaders::api_object_management::OBJECT_MANAGEMENT;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum CallbackMarker {
    Unknown,
    Allocate,
    Free,
    #[allow(dead_code)]
    Import,
    #[allow(dead_code)]
    Unimport,
    #[allow(dead_code)]
    AllocationFailed,
}

/// `VkDeviceMemoryReportCallbackDataEXT`, the members the checks read.
#[derive(Clone, Copy)]
struct Record {
    event_type: vk::DeviceMemoryReportEventTypeEXT,
    memory_object_id: u64,
    size: vk::DeviceSize,
    object_type: vk::ObjectType,
    object_handle: u64,
    heap_index: u32,
}

/// `CallbackRecorder`; the driver may report from any thread, hence the locks.
struct CallbackRecorder {
    records: Mutex<Vec<(Record, CallbackMarker)>>,
    marker: Mutex<CallbackMarker>,
}

impl CallbackRecorder {
    fn new() -> Self {
        Self {
            records: Mutex::new(Vec::new()),
            marker: Mutex::new(CallbackMarker::Unknown),
        }
    }

    fn records(&self) -> Vec<(Record, CallbackMarker)> {
        self.records.lock().expect("recorder lock").clone()
    }

    fn set_callback_marker(&self, marker: CallbackMarker) {
        *self.marker.lock().expect("recorder lock") = marker;
    }

    fn callback_internal(&self, data: &vk::DeviceMemoryReportCallbackDataEXT) {
        let marker = *self.marker.lock().expect("recorder lock");
        let record = Record {
            event_type: data.type_,
            memory_object_id: data.memory_object_id,
            size: data.size,
            object_type: data.object_type,
            object_handle: data.object_handle,
            heap_index: data.heap_index,
        };
        self.records.lock().expect("recorder lock").push((record, marker));
    }
}

/// `CallbackRecorder::callback`
unsafe extern "system" fn memory_report_callback(
    callback_data: *const vk::DeviceMemoryReportCallbackDataEXT,
    user_data: *mut c_void,
) {
    let recorder = unsafe { &*(user_data as *const CallbackRecorder) };
    recorder.callback_internal(unsafe { &*callback_data });
}

/// A device that is destroyed with the scope, like `DeviceWrapper`.
struct ReportDevice {
    device: Device,
}

impl Drop for ReportDevice {
    fn drop(&mut self) {
        unsafe { self.device.destroy_device(None) };
    }
}

/// `createDeviceWithMemoryReport`
fn create_device_with_memory_report(
    context: &Context<'_>,
    recorder: &CallbackRecorder,
) -> Result<ReportDevice, TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let queue_priorities = [1.0f32];
    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(context.get_universal_queue_family_index())
        .queue_priorities(&queue_priorities)
        .build()];
    let enabled_extensions = [c"VK_EXT_device_memory_report".as_ptr()];
    let mut device_memory_report_features =
        vk::PhysicalDeviceDeviceMemoryReportFeaturesEXT::builder().device_memory_report(true);
    let mut device_memory_report_create_info = vk::DeviceDeviceMemoryReportCreateInfoEXT::builder()
        .flags(vk::DeviceMemoryReportFlagsEXT::empty())
        .user_callback(Some(memory_report_callback))
        .user_data(unsafe { &mut *(recorder as *const CallbackRecorder).cast_mut().cast::<c_void>() });
    // Enable all available features since some tests require them to be enabled, VK_IMAGE_VIEW_CUBE_ARRAY for example
    let enabled_features = unsafe { instance.get_physical_device_features(physical_device) };
    let device_create_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&enabled_extensions)
        .enabled_features(&enabled_features)
        .push_next(&mut device_memory_report_create_info)
        .push_next(&mut device_memory_report_features);

    let device =
        unsafe { instance.create_device(physical_device, &device_create_info, None) }.vk_check("vkCreateDevice")?;
    Ok(ReportDevice { device })
}

/// `checkSupport(Context &)`
fn check_support_device_memory_report(context: &Context<'_>) -> Result<(), TestError> {
    if !context.is_device_functionality_supported("VK_EXT_device_memory_report") {
        return Err(TestError::NotSupported(
            "VK_EXT_device_memory_report not supported".to_string(),
        ));
    }

    let mut device_memory_report_features = vk::PhysicalDeviceDeviceMemoryReportFeaturesEXT::default();
    let mut avail_features = vk::PhysicalDeviceFeatures2::builder().push_next(&mut device_memory_report_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut avail_features)
    };

    if device_memory_report_features.device_memory_report == vk::FALSE {
        return Err(TestError::NotSupported(
            "VK_EXT_device_memory_report not supported".to_string(),
        ));
    }
    Ok(())
}

/// `validateCallbackRecords`
fn validate_callback_records(context: &Context<'_>, recorder: &CallbackRecorder) -> bool {
    let memory_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };
    let mut memory_object_set: BTreeSet<(u64, u64)> = BTreeSet::new();

    for (record, _) in recorder.records() {
        if (record.event_type == vk::DeviceMemoryReportEventTypeEXT::ALLOCATE
            || record.event_type == vk::DeviceMemoryReportEventTypeEXT::ALLOCATION_FAILED)
            && record.heap_index >= memory_properties.memory_heap_count
        {
            log::info!("memoryHeapCount: {}", memory_properties.memory_heap_count);
            log::info!("{}", describe_record(&record));
            return false;
        }

        if record.event_type == vk::DeviceMemoryReportEventTypeEXT::ALLOCATION_FAILED {
            log::info!("Observed ALLOCATION_FAILED event");
            log::info!("{}", describe_record(&record));
            continue;
        }

        if record.event_type == vk::DeviceMemoryReportEventTypeEXT::ALLOCATE
            || record.event_type == vk::DeviceMemoryReportEventTypeEXT::IMPORT
        {
            memory_object_set.insert((record.memory_object_id, record.object_handle));
            continue;
        }

        if record.event_type == vk::DeviceMemoryReportEventTypeEXT::FREE
            || record.event_type == vk::DeviceMemoryReportEventTypeEXT::UNIMPORT
        {
            let object_pair = (record.memory_object_id, record.object_handle);
            if !memory_object_set.remove(&object_pair) {
                log::info!("Unpaired or out-of-order free/unimport event");
                log::info!("{}", describe_record(&record));
                return false;
            }
        }
    }

    if !memory_object_set.is_empty() {
        log::info!("Unpaired alloc/import event");
        return false;
    }

    true
}

fn describe_record(record: &Record) -> String {
    format!(
        "VkDeviceMemoryReportCallbackDataEXT {{ type: {:?}, memoryObjectId: {}, size: {}, objectType: {:?}, objectHandle: {}, heapIndex: {} }}",
        record.event_type,
        record.memory_object_id,
        record.size,
        record.object_type,
        record.object_handle,
        record.heap_index
    )
}

/// `createDestroyObjectTest<Object>`
fn create_destroy_object_test(context: &Context<'_>, params: Option<&ObjectParams>) -> TestOutcome {
    let recorder = CallbackRecorder::new();

    match params {
        // `Device::create`: the device itself is the object.
        None => {
            let _device = create_device_with_memory_report(context, &recorder)?;
        }
        Some(params) => {
            // `EnvClone`: every other object is created on a device that reports to the recorder.
            let device = create_device_with_memory_report(context, &recorder)?;
            let platform = context.get_platform();
            let env = Environment {
                entry: &platform.entry,
                api_version: platform.api_version,
                device: &device.device,
                queue_family_index: context.get_universal_queue_family_index(),
                programs: OBJECT_MANAGEMENT.programs,
                allocation_callbacks: None,
                max_resource_consumers: 1,
            };
            let res = Resources::new(&env, params)?;
            let _object = create_object(&env, &res, params)?;
        }
    }

    if !validate_callback_records(context, &recorder) {
        return Ok(TestStatus::fail("Invalid device memory report callback"));
    }

    Ok(TestStatus::pass("Ok"))
}

fn check(condition: bool, what: &str) -> Result<(), TestError> {
    if condition {
        Ok(())
    } else {
        Err(TestError::Fail(format!("Check '{what}' failed")))
    }
}

/// `vkDeviceMemoryAllocateAndFreeTest`
fn vk_device_memory_allocate_and_free_test(context: &Context<'_>) -> TestOutcome {
    let recorder = CallbackRecorder::new();
    let device = create_device_with_memory_report(context, &recorder)?;
    let memory_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };
    let test_size: vk::DeviceSize = 1024;
    let test_type_index: u32 = 0;
    let test_heap_index = memory_properties.memory_types[test_type_index as usize].heap_index;

    recorder.set_callback_marker(CallbackMarker::Allocate);

    let memory_allocate_info = vk::MemoryAllocateInfo::builder()
        .allocation_size(test_size)
        .memory_type_index(test_type_index);
    let memory = match unsafe { device.device.allocate_memory(&memory_allocate_info, None) } {
        Ok(memory) => memory,
        Err(_) => {
            return Ok(TestStatus::fail(format!(
                "Unable to allocate {test_size} bytes of memory"
            )));
        }
    };
    let object_handle = memory.as_raw();

    recorder.set_callback_marker(CallbackMarker::Free);
    unsafe { device.device.free_memory(memory, None) };

    recorder.set_callback_marker(CallbackMarker::Unknown);

    let mut allocate_event = false;
    let mut free_event = false;
    let mut memory_object_id: u64 = 0;

    for (record, marker) in recorder.records() {
        if record.object_handle == object_handle && record.event_type == vk::DeviceMemoryReportEventTypeEXT::ALLOCATE {
            check(marker == CallbackMarker::Allocate, "marker == MARKER_ALLOCATE")?;
            check(
                record.object_type == vk::ObjectType::DEVICE_MEMORY,
                "record.objectType == VK_OBJECT_TYPE_DEVICE_MEMORY",
            )?;
            check(memory_object_id == 0, "memoryObjectId == 0")?;
            check(record.memory_object_id != 0, "record.memoryObjectId != 0")?;
            check(
                record.size >= test_size,
                &format!("record.size={}, testSize={}", record.size, test_size),
            )?;
            check(
                record.heap_index == test_heap_index,
                "record.heapIndex == testHeapIndex",
            )?;

            memory_object_id = record.memory_object_id;
            allocate_event = true;
        } else if record.object_handle == object_handle && record.event_type == vk::DeviceMemoryReportEventTypeEXT::FREE
        {
            check(marker == CallbackMarker::Free, "marker == MARKER_FREE")?;
            check(
                record.memory_object_id == memory_object_id,
                &format!(
                    "record.memoryObjectId={}, memoryObjectId={}",
                    record.memory_object_id, memory_object_id
                ),
            )?;

            free_event = true;
        }
    }

    check(allocate_event, "allocateEvent")?;
    check(free_event, "freeEvent")?;

    Ok(TestStatus::pass("Ok"))
}

#[derive(Clone)]
enum Kind {
    /// `createDestroyObjectTest<Device>`, which has no object parameters.
    CreateDestroyDevice,
    CreateDestroyObject(ObjectParams),
    VkDeviceMemoryAllocateAndFree,
    /// `testImportAndUnimportExternalMemory` for the Android hardware buffer handle type.
    ImportAndUnimportExternalMemory,
}

struct DeviceMemoryReportCase {
    name: &'static str,
    kind: Kind,
}

impl TestCase for DeviceMemoryReportCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // `checkSupport<ImageView>`
        if let Kind::CreateDestroyObject(ObjectParams::ImageView(params)) = &self.kind
            && params.view_type == vk::ImageViewType::CUBE_ARRAY
            && context.get_device_features().image_cube_array == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Core feature imageCubeArray not supported".to_string(),
            ));
        }

        check_support_device_memory_report(context)?;

        if matches!(self.kind, Kind::ImportAndUnimportExternalMemory) {
            // The `checkSupport(Context &, VkExternalMemoryHandleTypeFlagBits)` overload; the instance extension is core from 1.1.
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
            context.require_device_functionality("VK_KHR_get_memory_requirements2")?;
            context.require_device_functionality("VK_ANDROID_external_memory_android_hardware_buffer")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match &self.kind {
            Kind::CreateDestroyObject(
                ObjectParams::ShaderModule { .. } | ObjectParams::GraphicsPipeline | ObjectParams::ComputePipeline,
            ) => OBJECT_MANAGEMENT.programs,
            _ => BinaryCollection::new(&[]),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DeviceMemoryReportInstance {
            context,
            kind: &self.kind,
        })
    }
}

struct DeviceMemoryReportInstance<'a> {
    context: &'a Context<'a>,
    kind: &'a Kind,
}

impl TestInstance for DeviceMemoryReportInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::CreateDestroyDevice => create_destroy_object_test(self.context, None),
            Kind::CreateDestroyObject(params) => create_destroy_object_test(self.context, Some(params)),
            Kind::VkDeviceMemoryAllocateAndFree => vk_device_memory_allocate_and_free_test(self.context),
            Kind::ImportAndUnimportExternalMemory => Err(TestError::NotPorted(
                "importing and unimporting an Android hardware buffer".to_string(),
            )),
        }
    }
}

/// The cases of `s_createDestroyObjectGroup`, in upstream's order; `None` is the device itself. `memory.address_binding_report` has
/// the very same table.
pub(super) fn create_destroy_object_cases() -> Vec<(&'static str, Option<ObjectParams>)> {
    let img_1d = image_params(
        vk::ImageCreateFlags::empty(),
        vk::ImageType::_1D,
        make_extent_3d(256, 1, 1),
        4,
        vk::ImageUsageFlags::SAMPLED,
    );
    let img_2d = image_params(
        vk::ImageCreateFlags::empty(),
        vk::ImageType::_2D,
        make_extent_3d(64, 64, 1),
        12,
        vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::COLOR_ATTACHMENT,
    );
    let img_cube = image_params(
        vk::ImageCreateFlags::CUBE_COMPATIBLE,
        vk::ImageType::_2D,
        make_extent_3d(64, 64, 1),
        12,
        vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::COLOR_ATTACHMENT,
    );
    let img_3d = image_params(
        vk::ImageCreateFlags::empty(),
        vk::ImageType::_3D,
        make_extent_3d(64, 64, 4),
        1,
        vk::ImageUsageFlags::SAMPLED,
    );
    let image_view = |image: ImageParams, view_type: vk::ImageViewType, layer_count: u32| {
        Some(ObjectParams::ImageView(ImageViewParams {
            image,
            view_type,
            format: image.format,
            subresource_range: make_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layer_count),
        }))
    };
    let single_ubo_desc_layout = DescriptorSetLayoutParams::single(
        0,
        vk::DescriptorType::UNIFORM_BUFFER,
        1,
        vk::ShaderStageFlags::VERTEX,
        false,
    );
    let buffer =
        |size: vk::DeviceSize, usage: vk::BufferUsageFlags| Some(ObjectParams::Buffer(BufferParams { size, usage }));
    let buffer_view = |usage: vk::BufferUsageFlags| {
        Some(ObjectParams::BufferView(BufferViewParams {
            buffer: BufferParams { size: 8192, usage },
            format: vk::Format::R8G8B8A8_UNORM,
            offset: 0,
            range: 4096,
        }))
    };
    let descriptor_pool = |flags: vk::DescriptorPoolCreateFlags| {
        Some(ObjectParams::DescriptorPool(DescriptorPoolParams {
            flags,
            max_sets: 4,
            pool_sizes: vec![vk::DescriptorPoolSize {
                type_: vk::DescriptorType::UNIFORM_BUFFER,
                descriptor_count: 3,
            }],
        }))
    };
    let command_buffer = |level: vk::CommandBufferLevel| {
        Some(ObjectParams::CommandBuffer(CommandBufferParams {
            command_pool_flags: vk::CommandPoolCreateFlags::empty(),
            level,
        }))
    };

    vec![
        ("device", None),
        (
            "device_memory_small",
            Some(ObjectParams::DeviceMemory(DeviceMemoryParams {
                size: 1024,
                memory_type_index: 0,
            })),
        ),
        (
            "buffer_uniform_small",
            buffer(1024, vk::BufferUsageFlags::UNIFORM_BUFFER),
        ),
        (
            "buffer_uniform_large",
            buffer(1024 * 1024 * 16, vk::BufferUsageFlags::UNIFORM_BUFFER),
        ),
        (
            "buffer_storage_small",
            buffer(1024, vk::BufferUsageFlags::STORAGE_BUFFER),
        ),
        (
            "buffer_storage_large",
            buffer(1024 * 1024 * 16, vk::BufferUsageFlags::STORAGE_BUFFER),
        ),
        (
            "buffer_view_uniform_r8g8b8a8_unorm",
            buffer_view(vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER),
        ),
        (
            "buffer_view_storage_r8g8b8a8_unorm",
            buffer_view(vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER),
        ),
        ("image_1d", Some(ObjectParams::Image(img_1d))),
        ("image_2d", Some(ObjectParams::Image(img_2d))),
        ("image_3d", Some(ObjectParams::Image(img_3d))),
        ("image_view_1d", image_view(img_1d, vk::ImageViewType::_1D, 1)),
        ("image_view_1d_arr", image_view(img_1d, vk::ImageViewType::_1D_ARRAY, 4)),
        ("image_view_2d", image_view(img_2d, vk::ImageViewType::_2D, 1)),
        ("image_view_2d_arr", image_view(img_2d, vk::ImageViewType::_2D_ARRAY, 8)),
        ("image_view_cube", image_view(img_cube, vk::ImageViewType::CUBE, 6)),
        (
            "image_view_cube_arr",
            image_view(img_cube, vk::ImageViewType::CUBE_ARRAY, 12),
        ),
        ("image_view_3d", image_view(img_3d, vk::ImageViewType::_3D, 1)),
        ("semaphore", Some(ObjectParams::Semaphore)),
        ("event", Some(ObjectParams::Event)),
        ("fence", Some(ObjectParams::Fence(vk::FenceCreateFlags::empty()))),
        (
            "fence_signaled",
            Some(ObjectParams::Fence(vk::FenceCreateFlags::SIGNALED)),
        ),
        (
            "query_pool",
            Some(ObjectParams::QueryPool(QueryPoolParams {
                query_type: vk::QueryType::OCCLUSION,
                entry_count: 1,
                pipeline_statistics: vk::QueryPipelineStatisticFlags::empty(),
            })),
        ),
        (
            "shader_module",
            Some(ObjectParams::ShaderModule { binary_name: "test" }),
        ),
        (
            "pipeline_cache",
            Some(ObjectParams::PipelineCache { extern_sync: false }),
        ),
        ("sampler", Some(ObjectParams::Sampler)),
        (
            "descriptor_set_layout_empty",
            Some(ObjectParams::DescriptorSetLayout(DescriptorSetLayoutParams::empty())),
        ),
        (
            "descriptor_set_layout_single",
            Some(ObjectParams::DescriptorSetLayout(single_ubo_desc_layout.clone())),
        ),
        (
            "pipeline_layout_empty",
            Some(ObjectParams::PipelineLayout(PipelineLayoutParams {
                descriptor_set_layouts: Vec::new(),
            })),
        ),
        (
            "pipeline_layout_single",
            Some(ObjectParams::PipelineLayout(PipelineLayoutParams {
                descriptor_set_layouts: vec![single_ubo_desc_layout.clone()],
            })),
        ),
        ("render_pass", Some(ObjectParams::RenderPass)),
        ("graphics_pipeline", Some(ObjectParams::GraphicsPipeline)),
        ("compute_pipeline", Some(ObjectParams::ComputePipeline)),
        (
            "descriptor_pool",
            descriptor_pool(vk::DescriptorPoolCreateFlags::empty()),
        ),
        (
            "descriptor_pool_free_descriptor_set",
            descriptor_pool(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET),
        ),
        (
            "descriptor_set",
            Some(ObjectParams::DescriptorSet(single_ubo_desc_layout)),
        ),
        ("framebuffer", Some(ObjectParams::Framebuffer)),
        (
            "command_pool",
            Some(ObjectParams::CommandPool(vk::CommandPoolCreateFlags::empty())),
        ),
        (
            "command_pool_transient",
            Some(ObjectParams::CommandPool(vk::CommandPoolCreateFlags::TRANSIENT)),
        ),
        (
            "command_buffer_primary",
            command_buffer(vk::CommandBufferLevel::PRIMARY),
        ),
        (
            "command_buffer_secondary",
            command_buffer(vk::CommandBufferLevel::SECONDARY),
        ),
    ]
}

/// `createObjectTestsGroup` over `s_createDestroyObjectGroup`
fn create_object_tests_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("create_and_destroy_object");
    for (name, params) in create_destroy_object_cases() {
        let kind = match params {
            Some(params) => Kind::CreateDestroyObject(params),
            None => Kind::CreateDestroyDevice,
        };
        group.add_child(Box::new(DeviceMemoryReportCase { name, kind }) as Box<dyn TestCase>);
    }
    group
}

/// `createDeviceMemoryReportTests`
pub fn create_device_memory_report_tests() -> TestCaseGroup {
    let mut device_memory_report_tests = TestCaseGroup::new("device_memory_report");

    // Check emitted callbacks are properly paired
    device_memory_report_tests.add_child(create_object_tests_group());

    // Check callbacks are emitted properly for VkDeviceMemory
    let mut vk_device_memory = TestCaseGroup::new("vk_device_memory");
    vk_device_memory.add_child(Box::new(DeviceMemoryReportCase {
        name: "allocate_and_free",
        kind: Kind::VkDeviceMemoryAllocateAndFree,
    }) as Box<dyn TestCase>);
    device_memory_report_tests.add_child(vk_device_memory);

    // Check callbacks are emitted properly for external memory
    let mut external_memory = TestCaseGroup::new("external_memory");
    external_memory.add_child(Box::new(DeviceMemoryReportCase {
        name: "import_and_unimport_android_hardware_buffer",
        kind: Kind::ImportAndUnimportExternalMemory,
    }) as Box<dyn TestCase>);
    device_memory_report_tests.add_child(external_memory);

    device_memory_report_tests
}
