// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiArrayTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `oversized_array.wsi` subtree is registered as
// gated names (`array_wsi_cases.txt`, the mustpass list) except `wsi.headless.*` (wsi/array_wsi_tests.rs). The four cases that need a graphics pipeline
// (`create_pipeline_binaries`, `get_pipeline_executable_*`) take their shaders from
// `shaders/manifest/api_array.toml`.

use std::mem::{MaybeUninit, size_of};

use vulkanalia::prelude::v1_0::*;

use super::case_util::add_case;
use crate::generated::shaders::api_array::ARRAY_PIPELINE;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::obj_util::{make_pipeline_layout, make_render_pass};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WSI_CASE_NAMES: &str = include_str!("array_wsi_cases.txt");

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `ArrayFunction`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ArrayFunction {
    EnumeratePhysicalDevices,
    EnumerateInstanceLayerProperties,
    EnumerateInstanceExtensionProperties,
    EnumerateDeviceExtensionProperties,
    GetPipelineCacheData,
    CreatePipelineBinaries,
    EnumeratePhysicalDeviceGroups,
    GetPhysicalDeviceCalibrateableTimeDomains,
    GetPhysicalDeviceCooperativeMatrixProperties,
    GetPipelineExecutableProperties,
    GetPipelineExecutableStatistics,
    GetPipelineExecutableInternalRepresentations,
    GetPhysicalDeviceToolProperties,
    GetPhysicalDeviceFragmentShadingRates,
}

/// An entry the implementation has not written still holds the poison pattern. Structures
/// get their `sType`/`pNext` filled in, as the query requires, and the rest stays 0xDE.
pub(crate) trait Poison: Copy {
    fn poison() -> Self;
}

fn poison_bytes<R>() -> R {
    let mut value = MaybeUninit::<R>::uninit();
    unsafe {
        std::ptr::write_bytes(value.as_mut_ptr().cast::<u8>(), 0xDE, size_of::<R>());
        value.assume_init()
    }
}

fn bytes_of<R>(value: &R) -> &[u8] {
    unsafe { std::slice::from_raw_parts((value as *const R).cast::<u8>(), size_of::<R>()) }
}

macro_rules! plain_poison {
    ($($ty:ty),* $(,)?) => {
        $(impl Poison for $ty {
            fn poison() -> Self {
                poison_bytes::<Self>()
            }
        })*
    };
}

plain_poison!(
    vk::SurfaceFormatKHR,
    vk::PresentModeKHR,
    vk::Rect2D,
    vk::Image,
    vk::PhysicalDevice,
    vk::LayerProperties,
    vk::ExtensionProperties,
    vk::TimeDomainKHR,
    vk::PipelineBinaryKHR,
    u8
);

impl Poison for vk::SurfaceFormat2KHR {
    fn poison() -> Self {
        let mut s = poison_bytes::<Self>();
        s.s_type = vk::StructureType::SURFACE_FORMAT_2_KHR;
        s.next = std::ptr::null_mut();
        s
    }
}

impl Poison for vk::PhysicalDeviceGroupProperties {
    fn poison() -> Self {
        let mut s = poison_bytes::<Self>();
        s.s_type = vk::StructureType::PHYSICAL_DEVICE_GROUP_PROPERTIES;
        s.next = std::ptr::null_mut();
        s
    }
}

impl Poison for vk::CooperativeMatrixPropertiesKHR {
    fn poison() -> Self {
        let mut s = poison_bytes::<Self>();
        s.s_type = vk::StructureType::COOPERATIVE_MATRIX_PROPERTIES_KHR;
        s.next = std::ptr::null_mut();
        s
    }
}

impl Poison for vk::PipelineExecutablePropertiesKHR {
    fn poison() -> Self {
        let mut s = poison_bytes::<Self>();
        s.s_type = vk::StructureType::PIPELINE_EXECUTABLE_PROPERTIES_KHR;
        s.next = std::ptr::null_mut();
        s
    }
}

impl Poison for vk::PipelineExecutableStatisticKHR {
    fn poison() -> Self {
        let mut s = poison_bytes::<Self>();
        s.s_type = vk::StructureType::PIPELINE_EXECUTABLE_STATISTIC_KHR;
        s.next = std::ptr::null_mut();
        s
    }
}

impl Poison for vk::PipelineExecutableInternalRepresentationKHR {
    fn poison() -> Self {
        let mut s = poison_bytes::<Self>();
        s.s_type = vk::StructureType::PIPELINE_EXECUTABLE_INTERNAL_REPRESENTATION_KHR;
        s.next = std::ptr::null_mut();
        s.data_size = 0;
        s.data = std::ptr::null_mut();
        s
    }
}

impl Poison for vk::PhysicalDeviceToolProperties {
    fn poison() -> Self {
        let mut s = poison_bytes::<Self>();
        s.s_type = vk::StructureType::PHYSICAL_DEVICE_TOOL_PROPERTIES;
        s.next = std::ptr::null_mut();
        s
    }
}

impl Poison for vk::PhysicalDeviceFragmentShadingRateKHR {
    fn poison() -> Self {
        let mut s = poison_bytes::<Self>();
        s.s_type = vk::StructureType::PHYSICAL_DEVICE_FRAGMENT_SHADING_RATE_KHR;
        s.next = std::ptr::null_mut();
        s
    }
}

/// `getOversizedArraySize`
fn oversized_array_size(function: ArrayFunction, array_size: usize) -> usize {
    match function {
        ArrayFunction::GetPipelineCacheData => array_size + 512,
        _ => array_size * 64,
    }
}

fn check_result(result: vk::Result, what: &str) -> Result<(), TestError> {
    if result == vk::Result::SUCCESS {
        Ok(())
    } else {
        Err(TestError::Fail(format!("{what} returned {result:?}")))
    }
}

/// `validateArray`, both the generic form and the `uint8_t` one: a one byte poison pattern
/// occurs in valid data all the time, so only the entries past what the first query announced
/// are checked there.
fn validate_array<R: Poison>(implementation_count: usize, written_count: usize, array: &[R]) -> Result<(), TestError> {
    let poison_value = R::poison();
    let first = if size_of::<R>() == 1 {
        if written_count <= implementation_count {
            return Ok(());
        }
        implementation_count
    } else {
        0
    };

    for (i, entry) in array.iter().enumerate().take(written_count).skip(first) {
        if bytes_of(entry) == bytes_of(&poison_value) {
            return Err(TestError::Fail(format!(
                "Implementation did not write entry {i} in the array"
            )));
        }
    }
    Ok(())
}

/// `oversizedArrayTestImpl`. `query(count, array)` is `arrayFunc`; the count goes in as the
/// capacity and comes back as what was written.
fn oversized_array_test_impl<R: Poison>(
    function: ArrayFunction,
    query: &dyn Fn(&mut usize, *mut R) -> vk::Result,
) -> TestOutcome {
    oversized_array_test_impl_with_cleanup(function, query, &|_, _| {})
}

/// `oversizedArrayTestImpl` of the `WsiArrayFunction` cases (none of them is `GetPipelineCacheData`)
pub(crate) fn oversized_array_test_wsi<R: Poison>(query: &dyn Fn(&mut usize, *mut R) -> vk::Result) -> TestOutcome {
    oversized_array_test_impl(ArrayFunction::EnumeratePhysicalDevices, query)
}

/// The same with `destroyArray`: `destroy(array, written_count)` runs once the entries are checked.
fn oversized_array_test_impl_with_cleanup<R: Poison>(
    function: ArrayFunction,
    query: &dyn Fn(&mut usize, *mut R) -> vk::Result,
    destroy: &dyn Fn(&[R], usize),
) -> TestOutcome {
    let mut implementation_count: usize = 0;
    check_result(query(&mut implementation_count, std::ptr::null_mut()), "array query")?;

    log::info!("Queried count = {implementation_count}");

    if implementation_count == 0 {
        return Err(TestError::NotSupported("Function returned 0 count".to_string()));
    }

    // Grown well past the queried size in case the number changes between the two queries
    let array_size = oversized_array_size(function, implementation_count);

    log::info!("Test array size = {array_size}");

    let mut array = vec![R::poison(); array_size];

    let mut written_count = array_size;
    check_result(query(&mut written_count, array.as_mut_ptr()), "array query")?;

    log::info!("Written count = {written_count}");

    if written_count > array_size {
        return Err(TestError::Fail(format!(
            "More entries written ({written_count}) than the provided array size ({array_size})"
        )));
    }

    validate_array(implementation_count, written_count, &array)?;
    destroy(&array, written_count);

    // Equal is expected, but the count may legitimately have moved between the calls
    if written_count > implementation_count {
        return Ok(TestStatus::new(
            TestResult::QualityWarning,
            "The written array count may not have been updated",
        ));
    }

    Ok(TestStatus::pass("Pass"))
}

/// Runs a `(physical device, count, array)` extension query where the count is a `u32` in the
/// API and a `size_t` here, like upstream's `(uint32_t *)&count` cast.
pub(crate) fn with_u32_count(count: &mut usize, call: impl FnOnce(&mut u32) -> vk::Result) -> vk::Result {
    let mut narrow = *count as u32;
    let result = call(&mut narrow);
    *count = narrow as usize;
    result
}

/// `createGraphicsPipeline`: a trivial pipeline created with every capture flag, the subject of the pipeline binary
/// and pipeline executable queries.
fn create_graphics_pipeline<'a>(context: &'a Context<'_>) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let device = context.get_device();
    let render_size = 256u32;

    let render_pass = make_render_pass(device, vk::Format::R8G8B8A8_UNORM)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;

    let binaries = context.get_binary_collection();
    let vert_shader_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader_module = create_shader_module(device, binaries.get("frag")?)?;

    let vertex_bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: 4 * size_of::<f32>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let vertex_attributes = [vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&vertex_bindings)
        .vertex_attribute_descriptions(&vertex_attributes);
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(*vert_shader_module)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(*frag_shader_module)
            .name(b"main\0")
            .build(),
    ];
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: render_size as f32,
        height: render_size as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: render_size,
            height: render_size,
        },
    }];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state =
        vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
    let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);

    let mut pipeline_create_flags2 = vk::PipelineCreateFlags2CreateInfo {
        flags: vk::PipelineCreateFlags2::CAPTURE_DATA_KHR
            | vk::PipelineCreateFlags2::CAPTURE_INTERNAL_REPRESENTATIONS_KHR
            | vk::PipelineCreateFlags2::CAPTURE_STATISTICS_KHR,
        ..Default::default()
    };
    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&color_blend_state)
        .layout(*pipeline_layout)
        .render_pass(*render_pass)
        .subpass(0)
        .base_pipeline_index(0)
        .push_next(&mut pipeline_create_flags2);
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// Executable 0 is the one the statistics and internal representation queries read, so the pipeline needs one.
fn require_pipeline_executable(context: &Context<'_>, pipeline: vk::Pipeline) -> Result<(), TestError> {
    let device = context.get_device();
    let pipeline_info = vk::PipelineInfoKHR {
        pipeline,
        ..Default::default()
    };

    let mut pipeline_executable_count = 0u32;
    unsafe {
        (device.commands().get_pipeline_executable_properties_khr)(
            device.handle(),
            &pipeline_info,
            &mut pipeline_executable_count,
            std::ptr::null_mut(),
        )
    };

    if pipeline_executable_count == 0 {
        return Err(TestError::NotSupported(
            "No pipeline executables for test pipeline".to_string(),
        ));
    }
    Ok(())
}

/// `oversizedArrayTest`
fn oversized_array_test(context: &Context<'_>, function: ArrayFunction) -> TestOutcome {
    let instance = context.get_instance();
    let commands = instance.commands();
    let physical_device = context.get_physical_device();

    match function {
        ArrayFunction::EnumeratePhysicalDevices => {
            let handle = instance.handle();
            oversized_array_test_impl::<vk::PhysicalDevice>(function, &|count, array| {
                with_u32_count(count, |c| unsafe {
                    (commands.enumerate_physical_devices)(handle, c, array)
                })
            })
        }
        ArrayFunction::EnumerateInstanceLayerProperties => {
            let entry_commands = context.get_platform().entry.commands();
            oversized_array_test_impl::<vk::LayerProperties>(function, &|count, array| {
                with_u32_count(count, |c| unsafe {
                    (entry_commands.enumerate_instance_layer_properties)(c, array)
                })
            })
        }
        ArrayFunction::EnumerateInstanceExtensionProperties => {
            let entry_commands = context.get_platform().entry.commands();
            oversized_array_test_impl::<vk::ExtensionProperties>(function, &|count, array| {
                with_u32_count(count, |c| unsafe {
                    (entry_commands.enumerate_instance_extension_properties)(std::ptr::null(), c, array)
                })
            })
        }
        ArrayFunction::EnumerateDeviceExtensionProperties => {
            oversized_array_test_impl::<vk::ExtensionProperties>(function, &|count, array| {
                with_u32_count(count, |c| unsafe {
                    (commands.enumerate_device_extension_properties)(physical_device, std::ptr::null(), c, array)
                })
            })
        }
        ArrayFunction::GetPipelineCacheData => {
            let device = context.get_device();
            let create_info = vk::PipelineCacheCreateInfo::builder();
            let cache =
                unsafe { device.create_pipeline_cache(&create_info, None) }.vk_check("vkCreatePipelineCache")?;
            let get_data = device.commands().get_pipeline_cache_data;
            let handle = device.handle();

            let outcome = oversized_array_test_impl::<u8>(function, &|count, array| unsafe {
                get_data(handle, cache, count, array.cast())
            });

            unsafe { device.destroy_pipeline_cache(cache, None) };
            outcome
        }
        ArrayFunction::EnumeratePhysicalDeviceGroups => {
            let handle = instance.handle();
            oversized_array_test_impl::<vk::PhysicalDeviceGroupProperties>(function, &|count, array| {
                with_u32_count(count, |c| unsafe {
                    (commands.enumerate_physical_device_groups)(handle, c, array)
                })
            })
        }
        ArrayFunction::GetPhysicalDeviceCalibrateableTimeDomains => {
            let get_domains = if context.is_device_functionality_supported("VK_KHR_calibrated_timestamps") {
                commands.get_physical_device_calibrateable_time_domains_khr
            } else {
                commands.get_physical_device_calibrateable_time_domains_ext
            };
            oversized_array_test_impl::<vk::TimeDomainKHR>(function, &|count, array| {
                with_u32_count(count, |c| unsafe { get_domains(physical_device, c, array) })
            })
        }
        ArrayFunction::GetPhysicalDeviceCooperativeMatrixProperties => {
            oversized_array_test_impl::<vk::CooperativeMatrixPropertiesKHR>(function, &|count, array| {
                with_u32_count(count, |c| unsafe {
                    (commands.get_physical_device_cooperative_matrix_properties_khr)(physical_device, c, array)
                })
            })
        }
        ArrayFunction::CreatePipelineBinaries => {
            let device = context.get_device();
            let pipeline = create_graphics_pipeline(context)?;
            let pipeline_handle = *pipeline;
            let create_binaries = device.commands().create_pipeline_binaries_khr;
            let destroy_binary = device.commands().destroy_pipeline_binary_khr;
            let handle = device.handle();

            oversized_array_test_impl_with_cleanup::<vk::PipelineBinaryKHR>(
                function,
                &|count, array| {
                    let create_info = vk::PipelineBinaryCreateInfoKHR {
                        pipeline: pipeline_handle,
                        ..Default::default()
                    };
                    let mut handles_info = vk::PipelineBinaryHandlesInfoKHR {
                        pipeline_binary_count: *count as u32,
                        pipeline_binaries: array,
                        ..Default::default()
                    };
                    let result = unsafe { create_binaries(handle, &create_info, std::ptr::null(), &mut handles_info) };
                    *count = handles_info.pipeline_binary_count as usize;
                    result
                },
                &|array, written_count| {
                    for binary in &array[..written_count] {
                        unsafe { destroy_binary(handle, *binary, std::ptr::null()) };
                    }
                },
            )
        }
        ArrayFunction::GetPipelineExecutableProperties => {
            let device = context.get_device();
            let pipeline = create_graphics_pipeline(context)?;
            let get_properties = device.commands().get_pipeline_executable_properties_khr;
            let handle = device.handle();
            let pipeline_info = vk::PipelineInfoKHR {
                pipeline: *pipeline,
                ..Default::default()
            };

            oversized_array_test_impl::<vk::PipelineExecutablePropertiesKHR>(function, &|count, array| {
                with_u32_count(count, |c| unsafe { get_properties(handle, &pipeline_info, c, array) })
            })
        }
        ArrayFunction::GetPipelineExecutableStatistics => {
            let device = context.get_device();
            let pipeline = create_graphics_pipeline(context)?;
            require_pipeline_executable(context, *pipeline)?;
            let get_statistics = device.commands().get_pipeline_executable_statistics_khr;
            let handle = device.handle();
            let executable_info = vk::PipelineExecutableInfoKHR {
                pipeline: *pipeline,
                executable_index: 0,
                ..Default::default()
            };

            oversized_array_test_impl::<vk::PipelineExecutableStatisticKHR>(function, &|count, array| {
                with_u32_count(count, |c| unsafe { get_statistics(handle, &executable_info, c, array) })
            })
        }
        ArrayFunction::GetPipelineExecutableInternalRepresentations => {
            let device = context.get_device();
            let pipeline = create_graphics_pipeline(context)?;
            require_pipeline_executable(context, *pipeline)?;
            let get_representations = device.commands().get_pipeline_executable_internal_representations_khr;
            let handle = device.handle();
            let executable_info = vk::PipelineExecutableInfoKHR {
                pipeline: *pipeline,
                executable_index: 0,
                ..Default::default()
            };

            oversized_array_test_impl::<vk::PipelineExecutableInternalRepresentationKHR>(function, &|count, array| {
                with_u32_count(count, |c| unsafe {
                    get_representations(handle, &executable_info, c, array)
                })
            })
        }
        ArrayFunction::GetPhysicalDeviceToolProperties => {
            let get_tools = if context.get_device_properties().api_version >= vk::make_version(1, 3, 0) {
                commands.get_physical_device_tool_properties
            } else {
                commands.get_physical_device_tool_properties_ext
            };
            oversized_array_test_impl::<vk::PhysicalDeviceToolProperties>(function, &|count, array| {
                with_u32_count(count, |c| unsafe { get_tools(physical_device, c, array) })
            })
        }
        ArrayFunction::GetPhysicalDeviceFragmentShadingRates => {
            oversized_array_test_impl::<vk::PhysicalDeviceFragmentShadingRateKHR>(function, &|count, array| {
                with_u32_count(count, |c| unsafe {
                    (commands.get_physical_device_fragment_shading_rates_khr)(physical_device, c, array)
                })
            })
        }
    }
}

/// `checkSupport`
fn check_support(context: &Context<'_>, function: ArrayFunction) -> Result<(), TestError> {
    match function {
        ArrayFunction::CreatePipelineBinaries => {
            context.require_device_functionality("VK_KHR_pipeline_binary")?;
            context.require_device_functionality("VK_KHR_maintenance5")
        }
        ArrayFunction::GetPipelineExecutableProperties
        | ArrayFunction::GetPipelineExecutableStatistics
        | ArrayFunction::GetPipelineExecutableInternalRepresentations => {
            context.require_device_functionality("VK_KHR_pipeline_executable_properties")?;
            context.require_device_functionality("VK_KHR_maintenance5")
        }
        ArrayFunction::EnumeratePhysicalDeviceGroups => context.require_device_functionality("VK_KHR_device_group"),
        ArrayFunction::GetPhysicalDeviceCalibrateableTimeDomains => {
            if !context.is_device_functionality_supported("VK_KHR_calibrated_timestamps")
                && !context.is_device_functionality_supported("VK_EXT_calibrated_timestamps")
            {
                return Err(TestError::NotSupported(
                    "VK_KHR_calibrated_timestamps and VK_EXT_calibrated_timestamps are not supported".to_string(),
                ));
            }
            Ok(())
        }
        ArrayFunction::GetPhysicalDeviceCooperativeMatrixProperties => {
            context.require_device_functionality("VK_KHR_cooperative_matrix")
        }
        ArrayFunction::GetPhysicalDeviceToolProperties => context.require_device_functionality("VK_EXT_tooling_info"),
        ArrayFunction::GetPhysicalDeviceFragmentShadingRates => {
            context.require_device_functionality("VK_KHR_fragment_shading_rate")
        }
        _ => Ok(()),
    }
}

struct OversizedArrayCase {
    name: &'static str,
    function: ArrayFunction,
}

impl TestCase for OversizedArrayCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support(context, self.function)
    }

    fn programs(&self) -> BinaryCollection {
        match self.function {
            ArrayFunction::CreatePipelineBinaries
            | ArrayFunction::GetPipelineExecutableProperties
            | ArrayFunction::GetPipelineExecutableStatistics
            | ArrayFunction::GetPipelineExecutableInternalRepresentations => ARRAY_PIPELINE.programs,
            _ => NO_PROGRAMS,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OversizedArrayInstance {
            context,
            function: self.function,
        })
    }
}

struct OversizedArrayInstance<'a> {
    context: &'a Context<'a>,
    function: ArrayFunction,
}

impl TestInstance for OversizedArrayInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        oversized_array_test(self.context, self.function)
    }
}

/// `createOversizedArrayCases`, in upstream's enum order
fn create_oversized_array_cases() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("core");

    let case = |name: &'static str, function: ArrayFunction| OversizedArrayCase { name, function };

    add_case(
        &mut group,
        case("enumerate_physical_devices", ArrayFunction::EnumeratePhysicalDevices),
    );
    add_case(
        &mut group,
        case(
            "enumerate_instance_layer_properties",
            ArrayFunction::EnumerateInstanceLayerProperties,
        ),
    );
    add_case(
        &mut group,
        case(
            "enumerate_instance_extension_properties",
            ArrayFunction::EnumerateInstanceExtensionProperties,
        ),
    );
    add_case(
        &mut group,
        case(
            "enumerate_device_extension_properties",
            ArrayFunction::EnumerateDeviceExtensionProperties,
        ),
    );
    add_case(
        &mut group,
        case("get_pipeline_cache_data", ArrayFunction::GetPipelineCacheData),
    );
    add_case(
        &mut group,
        case("create_pipeline_binaries", ArrayFunction::CreatePipelineBinaries),
    );
    add_case(
        &mut group,
        case(
            "enumerate_physical_device_groups",
            ArrayFunction::EnumeratePhysicalDeviceGroups,
        ),
    );
    add_case(
        &mut group,
        case(
            "get_physical_device_calibrateable_time_domains",
            ArrayFunction::GetPhysicalDeviceCalibrateableTimeDomains,
        ),
    );
    add_case(
        &mut group,
        case(
            "get_physical_device_cooperative_matrix_properties",
            ArrayFunction::GetPhysicalDeviceCooperativeMatrixProperties,
        ),
    );
    add_case(
        &mut group,
        case(
            "get_pipeline_executable_properties",
            ArrayFunction::GetPipelineExecutableProperties,
        ),
    );
    add_case(
        &mut group,
        case(
            "get_pipeline_executable_statistics",
            ArrayFunction::GetPipelineExecutableStatistics,
        ),
    );
    add_case(
        &mut group,
        case(
            "get_pipeline_executable_internal_representations",
            ArrayFunction::GetPipelineExecutableInternalRepresentations,
        ),
    );
    add_case(
        &mut group,
        case(
            "get_physical_device_tool_properties",
            ArrayFunction::GetPhysicalDeviceToolProperties,
        ),
    );
    add_case(
        &mut group,
        case(
            "get_physical_device_fragment_shading_rates",
            ArrayFunction::GetPhysicalDeviceFragmentShadingRates,
        ),
    );

    group
}

/// `createArrayTests`
pub fn create_array_tests() -> TestCaseGroup {
    let mut array = TestCaseGroup::new("array");
    let mut oversized = TestCaseGroup::new("oversized_array");
    oversized.add_child(create_oversized_array_cases());
    let mut headless = crate::vkt::tests::wsi::array_wsi_cases();
    for child in crate::vkt::gated::build_gated_groups_with(
        WSI_CASE_NAMES,
        &["VK_KHR_surface"],
        "the window system queries (only the headless platform exists here)",
        &mut |path| headless.remove(path),
    ) {
        oversized.add_child(child);
    }
    array.add_child(oversized);
    array
}
