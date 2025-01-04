// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/vktTestCase.hpp / .cpp (vkt::Context)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's Context also carries the
// resource interface, the pipeline compiler and the VulkanSC machinery; none of that
// is ported, so this is the default-device slice of it.

use std::cell::RefCell;
use std::ffi::{CStr, CString, c_char, c_void};
use std::rc::Rc;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::mem_util::SimpleAllocator;
use crate::vk::platform::{Platform, PlatformError};
use crate::vk::programs::BinaryCollection;

/// `VkPhysicalDevicePrimitiveRestartIndexFeaturesEXT`, which vulkanalia does not know.
#[repr(C)]
#[derive(Debug)]
pub struct PrimitiveRestartIndexFeaturesExt {
    pub s_type: vk::StructureType,
    pub next: *mut c_void,
    pub primitive_restart_index: vk::Bool32,
}

impl Default for PrimitiveRestartIndexFeaturesExt {
    fn default() -> Self {
        Self {
            s_type: vk::StructureType::from_raw(1_000_678_000),
            next: std::ptr::null_mut(),
            primitive_restart_index: vk::FALSE,
        }
    }
}

unsafe impl vk::ExtendsPhysicalDeviceFeatures2 for PrimitiveRestartIndexFeaturesExt {}

unsafe impl vk::Cast for PrimitiveRestartIndexFeaturesExt {
    type Target = PrimitiveRestartIndexFeaturesExt;

    fn into(self) -> Self::Target {
        self
    }
}

/// `VkPhysicalDeviceShaderOCPMicroscalingTypesFeaturesEXT`, which vulkanalia does not know.
#[repr(C)]
#[derive(Debug)]
pub struct ShaderOcpMicroscalingTypesFeaturesExt {
    pub s_type: vk::StructureType,
    pub next: *mut c_void,
    pub shader_float4: vk::Bool32,
    pub shader_float6: vk::Bool32,
    pub shader_float8_unsigned_e8m0: vk::Bool32,
    pub shader_mx_int8: vk::Bool32,
}

impl Default for ShaderOcpMicroscalingTypesFeaturesExt {
    fn default() -> Self {
        Self {
            s_type: vk::StructureType::from_raw(1_000_672_000),
            next: std::ptr::null_mut(),
            shader_float4: vk::FALSE,
            shader_float6: vk::FALSE,
            shader_float8_unsigned_e8m0: vk::FALSE,
            shader_mx_int8: vk::FALSE,
        }
    }
}

unsafe impl vk::ExtendsPhysicalDeviceFeatures2 for ShaderOcpMicroscalingTypesFeaturesExt {}

unsafe impl vk::Cast for ShaderOcpMicroscalingTypesFeaturesExt {
    type Target = ShaderOcpMicroscalingTypesFeaturesExt;

    fn into(self) -> Self::Target {
        self
    }
}

/// `VkPhysicalDeviceShaderConstantDataFeaturesKHR`, which vulkanalia does not know.
#[repr(C)]
#[derive(Debug)]
pub struct ShaderConstantDataFeaturesKhr {
    pub s_type: vk::StructureType,
    pub next: *mut c_void,
    pub shader_constant_data: vk::Bool32,
}

impl Default for ShaderConstantDataFeaturesKhr {
    fn default() -> Self {
        Self {
            s_type: vk::StructureType::from_raw(1_000_231_000),
            next: std::ptr::null_mut(),
            shader_constant_data: vk::FALSE,
        }
    }
}

unsafe impl vk::ExtendsPhysicalDeviceFeatures2 for ShaderConstantDataFeaturesKhr {}

unsafe impl vk::Cast for ShaderConstantDataFeaturesKhr {
    type Target = ShaderConstantDataFeaturesKhr;

    fn into(self) -> Self::Target {
        self
    }
}

/// `vkt::Context` - the default instance, physical device, device, queue and
/// allocator that a test runs against unless it builds its own.
pub struct Context<'a> {
    platform: &'a Platform,
    physical_device: vk::PhysicalDevice,
    device: Device,
    universal_queue: vk::Queue,
    universal_queue_family_index: u32,
    /// `Context::getComputeQueue` / `getTransferQueue`, absent when the device has no
    /// such family. A queue may only be fetched from a family the device was *created*
    /// with, so these are resolved once here rather than on demand in a test.
    compute_queue: Option<(vk::Queue, u32)>,
    transfer_queue: Option<(vk::Queue, u32)>,
    default_allocator: SimpleAllocator,
    device_properties: vk::PhysicalDeviceProperties,
    device_features: vk::PhysicalDeviceFeatures,
    device_extensions: Vec<String>,
    binary_collection: BinaryCollection,
    /// `MultiQueues`' device, built on first use and shared by every case that asks
    /// for it. Upstream caches it in a static for the same reason: creating a device
    /// per case is the dominant cost of a group with thousands of them.
    multi_queue_device: RefCell<Option<Rc<MultiQueueDevice>>>,
}

impl<'a> Context<'a> {
    /// Creates the default device on `physical_device`.
    ///
    /// Upstream picks the queue family with GRAPHICS|COMPUTE for the "universal"
    /// queue; the same choice is made here so a test that assumes both capabilities
    /// on `getUniversalQueue()` behaves identically.
    pub fn new(
        platform: &'a Platform,
        physical_device: vk::PhysicalDevice,
        binary_collection: BinaryCollection,
    ) -> Result<Self, TestError> {
        Self::new_with_robustness(
            platform,
            physical_device,
            binary_collection,
            RobustnessFeatures::default(),
        )
    }

    /// `new`, with the `RobustnessFeatures` left on in the device: a whole second Context a test runs the shared helpers on.
    pub fn new_with_robustness(
        platform: &'a Platform,
        physical_device: vk::PhysicalDevice,
        binary_collection: BinaryCollection,
        robustness: RobustnessFeatures,
    ) -> Result<Self, TestError> {
        let instance = &platform.instance;

        let queue_families = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
        let universal_queue_family_index = queue_families
            .iter()
            .position(|f| {
                f.queue_flags.contains(vk::QueueFlags::GRAPHICS) && f.queue_flags.contains(vk::QueueFlags::COMPUTE)
            })
            .ok_or_else(|| TestError::NotSupported("no queue family supports both graphics and compute".to_string()))?
            as u32;

        // `findQueueFamilyIndexWithCapsNoThrow(COMPUTE, excluding GRAPHICS)` and its
        // transfer twin, matching upstream's DefaultDevice exactly - a case that is
        // NotSupported here has to be NotSupported there.
        let compute_queue_family_index = queue_families
            .iter()
            .position(|f| {
                f.queue_flags.contains(vk::QueueFlags::COMPUTE) && !f.queue_flags.contains(vk::QueueFlags::GRAPHICS)
            })
            .map(|i| i as u32);
        let transfer_queue_family_index = queue_families
            .iter()
            .position(|f| {
                f.queue_flags.contains(vk::QueueFlags::TRANSFER)
                    && !f.queue_flags.contains(vk::QueueFlags::GRAPHICS)
                    && !f.queue_flags.contains(vk::QueueFlags::COMPUTE)
            })
            .map(|i| i as u32);

        // Every family a test may later ask a queue from has to be requested here.
        // vkGetDeviceQueue on a family the device was not created with is undefined
        // behaviour, and in practice segfaults rather than returning an error.
        let mut families = vec![universal_queue_family_index];
        for extra in [compute_queue_family_index, transfer_queue_family_index]
            .into_iter()
            .flatten()
        {
            if !families.contains(&extra) {
                families.push(extra);
            }
        }

        let priorities = [1.0f32];
        let queue_infos: Vec<vk::DeviceQueueCreateInfo> = families
            .iter()
            .map(|&family| {
                vk::DeviceQueueCreateInfo::builder()
                    .queue_family_index(family)
                    .queue_priorities(&priorities)
                    .build()
            })
            .collect();

        let mut device_features = unsafe { instance.get_physical_device_features(physical_device) };
        if robustness.no_large_points {
            device_features.large_points = vk::FALSE;
        }

        let (device, available_extensions) =
            create_device_with_everything_robustness(instance, physical_device, &queue_infos, &[], robustness)?;

        let universal_queue = unsafe { device.get_device_queue(universal_queue_family_index, 0) };
        let compute_queue = compute_queue_family_index.map(|i| (unsafe { device.get_device_queue(i, 0) }, i));
        let transfer_queue = transfer_queue_family_index.map(|i| (unsafe { device.get_device_queue(i, 0) }, i));
        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };
        let device_properties = unsafe { instance.get_physical_device_properties(physical_device) };

        Ok(Self {
            platform,
            physical_device,
            device,
            universal_queue,
            universal_queue_family_index,
            compute_queue,
            transfer_queue,
            default_allocator: SimpleAllocator::new(memory_properties),
            device_properties,
            device_features,
            device_extensions: available_extensions,
            binary_collection,
            multi_queue_device: RefCell::new(None),
        })
    }

    /// `MultiQueues` - a second device created with up to two queues from *every*
    /// queue family, for the tests that need to synchronise across queues.
    ///
    /// The default device only requests the universal, compute-only and transfer-only
    /// families with one queue each, and `vkGetDeviceQueue` on a family the device was
    /// not created with is undefined behaviour, so those tests cannot use it.
    ///
    /// Upstream keys its cache on the synchronization type, timeline-semaphore and
    /// maintenance8 flags because it only enables the extensions a case asks for. This
    /// device enables everything the physical device advertises, exactly as
    /// `Context::new` does, so one device covers every key.
    pub fn multi_queue_device(&self) -> Result<Rc<MultiQueueDevice>, TestError> {
        if let Some(existing) = self.multi_queue_device.borrow().as_ref() {
            return Ok(Rc::clone(existing));
        }
        let created = Rc::new(MultiQueueDevice::new(self.platform, self.physical_device)?);
        *self.multi_queue_device.borrow_mut() = Some(Rc::clone(&created));
        Ok(created)
    }

    /// `Context::getDeviceInterface` and `Context::getDevice` collapsed into one,
    /// since `vulkanalia::Device` is both.
    pub fn get_device(&self) -> &Device {
        &self.device
    }

    /// `Context::getInstanceInterface`
    /// The loader, instance and API version the whole run shares. A test that builds
    /// its own instance or device starts from here.
    pub fn get_platform(&self) -> &Platform {
        self.platform
    }

    pub fn get_instance(&self) -> &Instance {
        &self.platform.instance
    }

    /// `Context::getPhysicalDevice`
    pub fn get_physical_device(&self) -> vk::PhysicalDevice {
        self.physical_device
    }

    /// `Context::getUniversalQueue`
    pub fn get_universal_queue(&self) -> vk::Queue {
        self.universal_queue
    }

    /// `Context::getComputeQueue` with its family index, or `None` when the device has
    /// no compute-only family.
    pub fn get_compute_queue(&self) -> Option<(vk::Queue, u32)> {
        self.compute_queue
    }

    /// `Context::getTransferQueue` with its family index.
    pub fn get_transfer_queue(&self) -> Option<(vk::Queue, u32)> {
        self.transfer_queue
    }

    /// `Context::getUniversalQueueFamilyIndex`
    pub fn get_universal_queue_family_index(&self) -> u32 {
        self.universal_queue_family_index
    }

    /// `Context::getDefaultAllocator`
    pub fn get_default_allocator(&self) -> &SimpleAllocator {
        &self.default_allocator
    }

    /// `Context::getDeviceProperties`
    pub fn get_device_properties(&self) -> &vk::PhysicalDeviceProperties {
        &self.device_properties
    }

    /// `Context::getDeviceFeatures`
    pub fn get_device_features(&self) -> &vk::PhysicalDeviceFeatures {
        &self.device_features
    }

    /// `Context::isDeviceFunctionalitySupported` - the same question without the
    /// NotSupported, for the checks that accept any of several extensions.
    pub fn is_device_functionality_supported(&self, extension: &str) -> bool {
        self.require_device_functionality(extension).is_ok()
    }

    /// `Context::requireDeviceFunctionality`
    ///
    /// Upstream throws NotSupportedError here; returning it has the same effect, since
    /// the runner turns it into a NotSupported verdict rather than a failure. A device
    /// that lacks an extension is not a device that failed a test.
    pub fn require_device_functionality(&self, extension: &str) -> Result<(), TestError> {
        if self.device_extensions.iter().any(|e| e == extension) {
            return Ok(());
        }
        // An extension promoted into core need not be advertised any more, and upstream
        // treats that as supported. Without this a 1.2+ driver that dropped the string
        // would get NotSupported here and a real verdict from deqp-vk - a difference
        // that says nothing about the driver.
        if let Some(promoted_in) = promoted_to_core_version(extension)
            && self.device_properties.api_version >= promoted_in
        {
            return Ok(());
        }
        Err(TestError::NotSupported(format!(
            "{extension} is not supported by this implementation"
        )))
    }

    /// `Context::getDeviceExtensions`
    pub fn get_device_extensions(&self) -> &[String] {
        &self.device_extensions
    }

    /// `Context::getBinaryCollection`
    pub fn get_binary_collection(&self) -> BinaryCollection {
        self.binary_collection
    }

    /// Swaps in the shader collection belonging to the case that is about to run.
    /// Upstream rebuilds the whole Context per case; reusing the device across a batch
    /// is what makes batching worthwhile, so only the collection is swapped.
    pub fn set_binary_collection(&mut self, binary_collection: BinaryCollection) {
        self.binary_collection = binary_collection;
    }

    /// Human-readable device name, used in the run header and the result file.
    pub fn device_name(&self) -> String {
        let bytes = &self.device_properties.device_name;
        let end = bytes.iter().position(|&c| c == 0).unwrap_or(bytes.len());
        bytes[..end].iter().map(|&c| c as u8 as char).collect()
    }

    pub fn api_version(&self) -> (u32, u32, u32) {
        let v = self.device_properties.api_version;
        (vk::version_major(v), vk::version_minor(v), vk::version_patch(v))
    }
}

impl Drop for Context<'_> {
    fn drop(&mut self) {
        unsafe {
            // A device that is already lost cannot be waited on; ignore the result so
            // teardown after a device-lost test does not itself become an error.
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

/// The core version an extension was promoted into, for the extensions the ported
/// tests ask for. Kept as an explicit table rather than derived from vk.xml: the list
/// is short, and a wrong entry here silently turns a real verdict into NotSupported.
fn promoted_to_core_version(extension: &str) -> Option<u32> {
    Some(match extension {
        "VK_KHR_spirv_1_4" | "VK_KHR_shader_float16_int8" | "VK_KHR_8bit_storage" | "VK_KHR_16bit_storage" => {
            vk::make_version(1, 2, 0)
        }
        "VK_KHR_separate_depth_stencil_layouts" | "VK_KHR_create_renderpass2" => vk::make_version(1, 2, 0),
        "VK_KHR_zero_initialize_workgroup_memory" | "VK_KHR_shader_terminate_invocation" => vk::make_version(1, 3, 0),
        "VK_KHR_depth_stencil_resolve" => vk::make_version(1, 2, 0),
        "VK_KHR_dynamic_rendering" => vk::make_version(1, 3, 0),
        "VK_KHR_device_group" | "VK_KHR_storage_buffer_storage_class" | "VK_KHR_dedicated_allocation" => {
            vk::make_version(1, 1, 0)
        }
        "VK_KHR_external_memory"
        | "VK_KHR_external_semaphore"
        | "VK_KHR_external_fence"
        | "VK_KHR_get_memory_requirements2" => vk::make_version(1, 1, 0),
        "VK_KHR_timeline_semaphore" => vk::make_version(1, 2, 0),
        "VK_KHR_synchronization2" => vk::make_version(1, 3, 0),
        "VK_KHR_copy_commands2" => vk::make_version(1, 3, 0),
        _ => return None,
    })
}

/// Picks the physical device the run targets. Mirrors `--deqp-vk-device-id`, which is
/// 1-based upstream.
pub fn select_physical_device(platform: &Platform, device_id: usize) -> Result<vk::PhysicalDevice, PlatformError> {
    let devices = platform.physical_devices()?;
    if devices.is_empty() {
        return Err(PlatformError::Unavailable("no Vulkan physical devices".to_string()));
    }
    devices.get(device_id.saturating_sub(1)).copied().ok_or_else(|| {
        PlatformError::InitError(format!("device id {device_id} out of range (found {})", devices.len()))
    })
}

/// Creates a device with every extension the physical device advertises and the
/// feature structs the ported groups need, which is what upstream's `DefaultDevice`
/// does.
///
/// `checkSupport` queries the *physical device*, so without enabling the feature
/// structs a case whose extension is advertised would be let through and then run
/// against a device where the corresponding feature bit was never turned on - the
/// shader's capability is unenabled, and the verdict becomes meaningless. The chain is
/// queried and then handed straight back to `vkCreateDevice`.
///
/// Returns the device and the extension names it was created with.
fn create_device_with_everything(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    queue_infos: &[vk::DeviceQueueCreateInfo],
    excluded_extensions: &[&str],
) -> Result<(Device, Vec<String>), TestError> {
    create_device_with_everything_robustness(
        instance,
        physical_device,
        queue_infos,
        excluded_extensions,
        RobustnessFeatures::default(),
    )
}

/// The features that change what every other test's accesses do, left off on the default device and asked for by name by the
/// tests that need them (`robustness.*`): robustBufferAccess2, robustImageAccess and the 64-bit image atomics the R64 cases use.
#[derive(Clone, Copy, Default)]
pub struct RobustnessFeatures {
    pub robust_buffer_access2: bool,
    pub robust_image_access: bool,
    pub shader_image_int64_atomics: bool,
    pub robust_image_access2: bool,
    /// `RF_PIPELINE_ROBUSTNESS`: pipelineRobustness on and robustBufferAccess off, the robustness is then asked for per pipeline.
    pub pipeline_robustness: bool,
    /// `largePoints` forced off in the device, for the cases that need it disabled (`addFeature(.., largePoints, VK_FALSE, VK_FALSE, false)`).
    pub no_large_points: bool,
}

/// `create_device_with_everything`, optionally with the `RobustnessFeatures` left on.
fn create_device_with_everything_robustness(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    queue_infos: &[vk::DeviceQueueCreateInfo],
    excluded_extensions: &[&str],
    robustness_features: RobustnessFeatures,
) -> Result<(Device, Vec<String>), TestError> {
    let available_extensions: Vec<String> =
        unsafe { instance.enumerate_device_extension_properties(physical_device, None) }
            .vk_check("vkEnumerateDeviceExtensionProperties")?
            .iter()
            .map(|e| {
                unsafe { CStr::from_ptr(e.extension_name.as_ptr()) }
                    .to_string_lossy()
                    .into_owned()
            })
            .collect();

    // Enabling every available extension is the point here, but the presentation family
    // cannot be: `VK_KHR_swapchain` needs the `VK_KHR_surface` *instance* extension,
    // which a headless run has no reason to ask for, and a dozen more device extensions
    // in turn need swapchain. Enabling any of them without their dependency is invalid
    // (VUID-vkCreateDevice-ppEnabledExtensionNames-01387). Matched by substring rather
    // than by name so a new one does not silently reintroduce the problem - nothing in
    // the suite presents to a surface, so dropping the whole family costs no coverage.
    let presentation_only = |n: &str| {
        n.contains("swapchain") || n.contains("present") || n.contains("display") || n == "VK_EXT_hdr_metadata"
    };
    let extension_names: Vec<CString> = available_extensions
        .iter()
        .filter(|n| !presentation_only(n) && !excluded_extensions.contains(&n.as_str()))
        .filter_map(|n| CString::new(n.as_str()).ok())
        .collect();
    let extension_ptrs: Vec<*const c_char> = extension_names.iter().map(|n| n.as_ptr()).collect();

    // No `VkPhysicalDeviceShaderFloat16Int8Features` here: the same chain is used for
    // the query and for vkCreateDevice, and creating with both it and
    // `VkPhysicalDeviceVulkan12Features` is invalid because the two could disagree
    // (VUID-VkDeviceCreateInfo-pNext-02830). The 1.2 struct already carries
    // shaderFloat16/shaderInt8, and nothing here reads the older one.
    let mut vulkan_11_features = vk::PhysicalDeviceVulkan11Features::default();
    let mut vulkan_12_features = vk::PhysicalDeviceVulkan12Features::default();
    let mut zero_init_features = vk::PhysicalDeviceZeroInitializeWorkgroupMemoryFeatures::default();
    let mut wmel_features = vk::PhysicalDeviceWorkgroupMemoryExplicitLayoutFeaturesKHR::default();
    // An extension being enabled does not enable the features it introduces: those have
    // to be asked for by name here. Leaving one out means a test can create the objects
    // its extension defines and then be told, correctly, that the feature is off - which
    // a permissive driver may let pass and a strict one will not.
    let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
    let mut dgc_features = vk::PhysicalDeviceDeviceGeneratedCommandsFeaturesEXT::default();
    let mut pgq_features = vk::PhysicalDevicePrimitivesGeneratedQueryFeaturesEXT::default();
    let mut color_write_features = vk::PhysicalDeviceColorWriteEnableFeaturesEXT::default();
    // The individual struct rather than `VkPhysicalDeviceVulkan13Features`: chaining
    // both is invalid (VUID-VkDeviceCreateInfo-pNext-06532), and nothing here needs the
    // rest of 1.3. Without it `vkCmdBeginRendering` is used with the feature off.
    let mut dynamic_rendering_features = vk::PhysicalDeviceDynamicRenderingFeatures::default();
    let mut conditional_rendering_features = vk::PhysicalDeviceConditionalRenderingFeaturesEXT::default();
    let mut nested_command_buffer_features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
    let mut maintenance7_features = vk::PhysicalDeviceMaintenance7FeaturesKHR::default();
    let mut maintenance8_features = vk::PhysicalDeviceMaintenance8FeaturesKHR::default();
    let mut maintenance9_features = vk::PhysicalDeviceMaintenance9FeaturesKHR::default();
    let mut image_robustness_features = vk::PhysicalDeviceImageRobustnessFeatures::default();
    let mut shader_image_atomic_int64_features = vk::PhysicalDeviceShaderImageAtomicInt64FeaturesEXT::default();
    let mut maintenance10_features = vk::PhysicalDeviceMaintenance10FeaturesKHR::default();
    let mut maintenance5_features = vk::PhysicalDeviceMaintenance5Features::default();
    let mut pipeline_executable_features = vk::PhysicalDevicePipelineExecutablePropertiesFeaturesKHR::default();
    let mut pipeline_binary_features = vk::PhysicalDevicePipelineBinaryFeaturesKHR::default();
    let mut early_late_features = vk::PhysicalDeviceShaderEarlyAndLateFragmentTestsFeaturesAMD::default();
    let mut descriptor_buffer_features = vk::PhysicalDeviceDescriptorBufferFeaturesEXT::default();
    let mut custom_border_color_features = vk::PhysicalDeviceCustomBorderColorFeaturesEXT::default();
    let mut border_color_swizzle_features = vk::PhysicalDeviceBorderColorSwizzleFeaturesEXT::default();
    let mut fragment_shader_interlock_features = vk::PhysicalDeviceFragmentShaderInterlockFeaturesEXT::default();
    let mut fragment_shading_rate_features = vk::PhysicalDeviceFragmentShadingRateFeaturesKHR::default();
    let mut multi_draw_features = vk::PhysicalDeviceMultiDrawFeaturesEXT::default();
    let mut line_rasterization_features = vk::PhysicalDeviceLineRasterizationFeaturesKHR::default();
    let mut legacy_dithering_features = vk::PhysicalDeviceLegacyDitheringFeaturesEXT::default();
    let mut legacy_vertex_attributes_features = vk::PhysicalDeviceLegacyVertexAttributesFeaturesEXT::default();
    let mut depth_clip_enable_features = vk::PhysicalDeviceDepthClipEnableFeaturesEXT::default();
    let mut depth_clip_control_features = vk::PhysicalDeviceDepthClipControlFeaturesEXT::default();
    let mut depth_bias_control_features = vk::PhysicalDeviceDepthBiasControlFeaturesEXT::default();
    let mut provoking_vertex_features = vk::PhysicalDeviceProvokingVertexFeaturesEXT::default();
    let mut dynamic_rendering_local_read_features = vk::PhysicalDeviceDynamicRenderingLocalReadFeatures::default();
    let mut rasterization_order_access_features =
        vk::PhysicalDeviceRasterizationOrderAttachmentAccessFeaturesEXT::default();
    let mut vertex_attribute_divisor_features = vk::PhysicalDeviceVertexAttributeDivisorFeatures::default();
    let mut vertex_input_dynamic_state_features = vk::PhysicalDeviceVertexInputDynamicStateFeaturesEXT::default();
    let mut maintenance6_features = vk::PhysicalDeviceMaintenance6Features::default();
    let mut extended_dynamic_state2_features = vk::PhysicalDeviceExtendedDynamicState2FeaturesEXT::default();
    let mut index_type_uint8_features = vk::PhysicalDeviceIndexTypeUint8Features::default();
    let mut depth_clamp_control_features = vk::PhysicalDeviceDepthClampControlFeaturesEXT::default();
    let mut extended_dynamic_state_features = vk::PhysicalDeviceExtendedDynamicStateFeaturesEXT::default();
    let mut dynamic_rendering_unused_attachments_features =
        vk::PhysicalDeviceDynamicRenderingUnusedAttachmentsFeaturesEXT::default();
    let mut inherited_viewport_scissor_features = vk::PhysicalDeviceInheritedViewportScissorFeaturesNV::default();
    let mut image_2d_view_of_3d_features = vk::PhysicalDeviceImage2DViewOf3DFeaturesEXT::default();
    let mut astc_decode_features = vk::PhysicalDeviceASTCDecodeFeaturesEXT::default();
    let mut host_image_copy_features = vk::PhysicalDeviceHostImageCopyFeatures::default();
    let mut image_sliced_view_of_3d_features = vk::PhysicalDeviceImageSlicedViewOf3DFeaturesEXT::default();
    let mut pipeline_creation_cache_control_features =
        vk::PhysicalDevicePipelineCreationCacheControlFeatures::default();
    let mut extended_dynamic_state3_features = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
    let mut shader_long_vector_features = vk::PhysicalDeviceShaderLongVectorFeaturesEXT::default();
    let mut raw_access_chains_features = vk::PhysicalDeviceRawAccessChainsFeaturesNV::default();
    let mut shader_64bit_indexing_features = vk::PhysicalDeviceShader64BitIndexingFeaturesEXT::default();
    let mut shader_untyped_pointers_features = vk::PhysicalDeviceShaderUntypedPointersFeaturesKHR::default();
    let mut copy_memory_indirect_features = vk::PhysicalDeviceCopyMemoryIndirectFeaturesKHR::default();
    let mut memory_decompression_features = vk::PhysicalDeviceMemoryDecompressionFeaturesEXT::default();
    let mut mesh_shader_features = vk::PhysicalDeviceMeshShaderFeaturesEXT::default();
    let mut shader_object_features = vk::PhysicalDeviceShaderObjectFeaturesEXT::default();
    let mut shader_terminate_invocation_features = vk::PhysicalDeviceShaderTerminateInvocationFeatures::default();
    let mut shader_integer_dot_product_features = vk::PhysicalDeviceShaderIntegerDotProductFeatures::default();
    let mut shader_maximal_reconvergence_features = vk::PhysicalDeviceShaderMaximalReconvergenceFeaturesKHR::default();
    let mut shader_quad_control_features = vk::PhysicalDeviceShaderQuadControlFeaturesKHR::default();
    let mut shader_tile_image_features = vk::PhysicalDeviceShaderTileImageFeaturesEXT::default();
    let mut shader_atomic_float_features = vk::PhysicalDeviceShaderAtomicFloatFeaturesEXT::default();
    let mut shader_demote_features = vk::PhysicalDeviceShaderDemoteToHelperInvocationFeatures::default();
    let mut subgroup_uniform_control_flow_features =
        vk::PhysicalDeviceShaderSubgroupUniformControlFlowFeaturesKHR::default();
    let mut subgroup_size_control_features = vk::PhysicalDeviceSubgroupSizeControlFeatures::default();
    let mut shader_atomic_float2_features = vk::PhysicalDeviceShaderAtomicFloat2FeaturesEXT::default();
    let mut shader_atomic_float16_vector_features = vk::PhysicalDeviceShaderAtomicFloat16VectorFeaturesNV::default();
    let mut fragment_shader_barycentric_features = vk::PhysicalDeviceFragmentShaderBarycentricFeaturesKHR::default();
    let mut blend_operation_advanced_features = vk::PhysicalDeviceBlendOperationAdvancedFeaturesEXT::default();
    let mut primitive_restart_index_features = PrimitiveRestartIndexFeaturesExt::default();
    let mut shader_constant_data_features = ShaderConstantDataFeaturesKhr::default();
    let mut shader_expect_assume_features = vk::PhysicalDeviceShaderExpectAssumeFeatures::default();
    let mut shader_bfloat16_features = vk::PhysicalDeviceShaderBfloat16FeaturesKHR::default();
    let mut shader_clock_features = vk::PhysicalDeviceShaderClockFeaturesKHR::default();
    let mut shader_float8_features = vk::PhysicalDeviceShaderFloat8FeaturesEXT::default();
    let mut acceleration_structure_features = vk::PhysicalDeviceAccelerationStructureFeaturesKHR::default();
    let mut ray_query_features = vk::PhysicalDeviceRayQueryFeaturesKHR::default();
    let mut ray_tracing_pipeline_features = vk::PhysicalDeviceRayTracingPipelineFeaturesKHR::default();
    let mut ocp_microscaling_features = ShaderOcpMicroscalingTypesFeaturesExt::default();
    let mut depth_clamp_zero_one_features = vk::PhysicalDeviceDepthClampZeroOneFeaturesKHR::default();
    let mut topology_list_restart_features = vk::PhysicalDevicePrimitiveTopologyListRestartFeaturesEXT::default();
    let mut graphics_pipeline_library_features = vk::PhysicalDeviceGraphicsPipelineLibraryFeaturesEXT::default();
    let mut replicated_composites_features = vk::PhysicalDeviceShaderReplicatedCompositesFeaturesEXT::default();
    let mut cooperative_matrix_features = vk::PhysicalDeviceCooperativeMatrixFeaturesKHR::default();
    let mut uniform_buffer_unsized_array_features =
        vk::PhysicalDeviceShaderUniformBufferUnsizedArrayFeaturesEXT::default();
    // Only nullDescriptor is wanted: the robustBufferAccess2/robustImageAccess2 bits are cleared again below, because they change
    // what every other test's out-of-bounds accesses do. The pointer is how they are reached once the chain borrows the struct.
    let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
    let robustness2_ptr: *mut vk::PhysicalDeviceRobustness2FeaturesEXT = &mut robustness2_features;
    let mut pipeline_robustness_features = vk::PhysicalDevicePipelineRobustnessFeatures::default();
    let mut mutable_descriptor_type_features = vk::PhysicalDeviceMutableDescriptorTypeFeaturesEXT::default();
    let mut device_address_commands_features =
        crate::vk::device_address_commands::DeviceAddressCommandsFeatures::default();
    let mut gpa_features = crate::vk::gpa_interface::GpaFeatures::default();
    let mut shader_float_controls2_features = vk::PhysicalDeviceShaderFloatControls2Features::default();
    let mut compute_shader_derivatives_features = vk::PhysicalDeviceComputeShaderDerivativesFeaturesKHR::default();
    let mut shader_fma_features = vk::PhysicalDeviceShaderFmaFeaturesKHR::default();
    let mut tensor_features = vk::PhysicalDeviceTensorFeaturesARM::default();
    let mut synchronization2_features = vk::PhysicalDeviceSynchronization2Features::default();
    let mut unified_image_layouts_features = vk::PhysicalDeviceUnifiedImageLayoutsFeaturesKHR::default();
    let mut descriptor_heap_features = vk::PhysicalDeviceDescriptorHeapFeaturesEXT::default();

    let mut features2 = vk::PhysicalDeviceFeatures2::builder()
        .push_next(&mut vulkan_11_features)
        .push_next(&mut vulkan_12_features)
        .push_next(&mut zero_init_features)
        .push_next(&mut wmel_features)
        .push_next(&mut xfb_features)
        .push_next(&mut dgc_features)
        .push_next(&mut pgq_features)
        .push_next(&mut color_write_features)
        .push_next(&mut dynamic_rendering_features)
        .push_next(&mut conditional_rendering_features)
        .push_next(&mut nested_command_buffer_features)
        .push_next(&mut maintenance7_features)
        .push_next(&mut maintenance8_features)
        .push_next(&mut maintenance10_features)
        .push_next(&mut early_late_features)
        .push_next(&mut maintenance5_features)
        .push_next(&mut pipeline_executable_features)
        .push_next(&mut pipeline_binary_features)
        .push_next(&mut descriptor_buffer_features)
        .push_next(&mut custom_border_color_features)
        .push_next(&mut border_color_swizzle_features)
        .push_next(&mut fragment_shader_interlock_features)
        .push_next(&mut fragment_shading_rate_features)
        .push_next(&mut multi_draw_features)
        .push_next(&mut line_rasterization_features)
        .push_next(&mut legacy_dithering_features)
        .push_next(&mut legacy_vertex_attributes_features)
        .push_next(&mut depth_clip_enable_features)
        .push_next(&mut depth_clip_control_features)
        .push_next(&mut depth_bias_control_features)
        .push_next(&mut provoking_vertex_features)
        .push_next(&mut dynamic_rendering_local_read_features)
        .push_next(&mut rasterization_order_access_features)
        .push_next(&mut vertex_attribute_divisor_features)
        .push_next(&mut vertex_input_dynamic_state_features)
        .push_next(&mut maintenance6_features)
        .push_next(&mut extended_dynamic_state2_features)
        .push_next(&mut index_type_uint8_features)
        .push_next(&mut depth_clamp_control_features)
        .push_next(&mut extended_dynamic_state_features)
        .push_next(&mut dynamic_rendering_unused_attachments_features)
        .push_next(&mut inherited_viewport_scissor_features)
        .push_next(&mut image_2d_view_of_3d_features)
        .push_next(&mut astc_decode_features)
        .push_next(&mut host_image_copy_features)
        .push_next(&mut image_sliced_view_of_3d_features)
        .push_next(&mut pipeline_creation_cache_control_features)
        .push_next(&mut extended_dynamic_state3_features)
        .push_next(&mut shader_long_vector_features)
        .push_next(&mut raw_access_chains_features)
        .push_next(&mut shader_64bit_indexing_features)
        .push_next(&mut shader_untyped_pointers_features)
        .push_next(&mut copy_memory_indirect_features)
        .push_next(&mut memory_decompression_features)
        .push_next(&mut mesh_shader_features)
        .push_next(&mut shader_object_features)
        .push_next(&mut shader_terminate_invocation_features)
        .push_next(&mut shader_integer_dot_product_features)
        .push_next(&mut shader_maximal_reconvergence_features)
        .push_next(&mut shader_quad_control_features)
        .push_next(&mut shader_tile_image_features)
        .push_next(&mut shader_atomic_float_features)
        .push_next(&mut shader_demote_features)
        .push_next(&mut subgroup_uniform_control_flow_features)
        .push_next(&mut subgroup_size_control_features)
        .push_next(&mut shader_atomic_float2_features)
        .push_next(&mut shader_atomic_float16_vector_features)
        .push_next(&mut fragment_shader_barycentric_features)
        .push_next(&mut blend_operation_advanced_features)
        .push_next(&mut primitive_restart_index_features)
        .push_next(&mut shader_constant_data_features)
        .push_next(&mut shader_expect_assume_features)
        .push_next(&mut shader_bfloat16_features)
        .push_next(&mut shader_clock_features)
        .push_next(&mut shader_float8_features)
        .push_next(&mut acceleration_structure_features)
        .push_next(&mut ray_query_features)
        .push_next(&mut ray_tracing_pipeline_features)
        .push_next(&mut ocp_microscaling_features)
        .push_next(&mut depth_clamp_zero_one_features)
        .push_next(&mut topology_list_restart_features)
        .push_next(&mut graphics_pipeline_library_features)
        .push_next(&mut replicated_composites_features)
        .push_next(&mut cooperative_matrix_features)
        .push_next(&mut uniform_buffer_unsized_array_features)
        .push_next(&mut mutable_descriptor_type_features)
        .push_next(&mut device_address_commands_features)
        .push_next(&mut gpa_features)
        .push_next(&mut shader_float_controls2_features)
        .push_next(&mut compute_shader_derivatives_features)
        .push_next(&mut shader_fma_features)
        .push_next(&mut tensor_features)
        .push_next(&mut synchronization2_features)
        .push_next(&mut unified_image_layouts_features)
        .push_next(&mut descriptor_heap_features)
        .push_next(unsafe { &mut *robustness2_ptr });
    if !excluded_extensions.contains(&"VK_KHR_maintenance9") {
        features2 = features2.push_next(&mut maintenance9_features);
    }
    if robustness_features.robust_image_access {
        features2 = features2.push_next(&mut image_robustness_features);
    }
    if robustness_features.shader_image_int64_atomics {
        features2 = features2.push_next(&mut shader_image_atomic_int64_features);
    }
    if robustness_features.pipeline_robustness {
        features2 = features2.push_next(&mut pipeline_robustness_features);
    }

    unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
    unsafe {
        if !robustness_features.robust_buffer_access2 {
            (*robustness2_ptr).robust_buffer_access2 = vk::FALSE;
        }
        if !robustness_features.robust_image_access2 {
            (*robustness2_ptr).robust_image_access2 = vk::FALSE;
        }
    }
    if robustness_features.pipeline_robustness {
        features2.features.robust_buffer_access = vk::FALSE;
    }
    if robustness_features.no_large_points {
        features2.features.large_points = vk::FALSE;
    }

    // `enabled_features` must stay unset: the core features travel inside the features2
    // chain instead, and Vulkan forbids providing both.
    let info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(queue_infos)
        .enabled_extension_names(&extension_ptrs)
        .push_next(&mut features2);

    let device = unsafe { instance.create_device(physical_device, &info, None) }.vk_check("vkCreateDevice")?;
    Ok((device, available_extensions))
}

/// `DeviceCreationExtensions` minus `excluded_extensions`: a device on `queue_family_index` that is created like the default one
/// except that the named extensions (and the feature structs they own) are left out.
pub fn create_device_without_extensions(
    instance: &Instance,
    physical_device: vk::PhysicalDevice,
    queue_family_index: u32,
    excluded_extensions: &[&str],
) -> Result<Device, TestError> {
    let priorities = [1.0f32];
    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(queue_family_index)
        .queue_priorities(&priorities)
        .build()];
    let (device, _extensions) =
        create_device_with_everything(instance, physical_device, &queue_infos, excluded_extensions)?;
    Ok(device)
}

/// `MultiQueues::QueueData` plus the family index it belongs to.
pub struct QueueFamilyQueues {
    pub family_index: u32,
    pub flags: vk::QueueFlags,
    pub queues: Vec<vk::Queue>,
}

/// `MultiQueues`' logical device: every queue family, up to two queues from each.
pub struct MultiQueueDevice {
    device: Device,
    allocator: SimpleAllocator,
    families: Vec<QueueFamilyQueues>,
}

impl MultiQueueDevice {
    pub fn new(platform: &Platform, physical_device: vk::PhysicalDevice) -> Result<Self, TestError> {
        let instance = &platform.instance;
        let queue_families = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };

        // `std::min(2u, queueCount)` per family, so a family with two queues can be
        // paired with itself.
        let counts: Vec<u32> = queue_families.iter().map(|f| f.queue_count.min(2)).collect();
        let priorities = [1.0f32, 1.0f32];
        let queue_infos: Vec<vk::DeviceQueueCreateInfo> = counts
            .iter()
            .enumerate()
            .map(|(family, &count)| {
                vk::DeviceQueueCreateInfo::builder()
                    .queue_family_index(family as u32)
                    .queue_priorities(&priorities[..count as usize])
                    .build()
            })
            .collect();

        let (device, _extensions) = create_device_with_everything(instance, physical_device, &queue_infos, &[])?;

        let families = counts
            .iter()
            .enumerate()
            .map(|(family, &count)| QueueFamilyQueues {
                family_index: family as u32,
                flags: queue_families[family].queue_flags,
                queues: (0..count)
                    .map(|i| unsafe { device.get_device_queue(family as u32, i) })
                    .collect(),
            })
            .collect();

        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };

        Ok(Self {
            device,
            allocator: SimpleAllocator::new(memory_properties),
            families,
        })
    }

    pub fn device(&self) -> &Device {
        &self.device
    }

    pub fn allocator(&self) -> &SimpleAllocator {
        &self.allocator
    }

    /// `MultiQueues::familyCount` and the per-family data behind it.
    pub fn families(&self) -> &[QueueFamilyQueues] {
        &self.families
    }
}

impl Drop for MultiQueueDevice {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}

/// A device created like the default one but with the requested `RobustnessFeatures` left on, destroyed when dropped.
///
/// Upstream's `createRobustBufferAccessDevice` builds the device a robustness test runs on; the Context's own clears
/// that bit because it changes what every other test's out of bounds accesses do.
pub struct RobustnessDevice {
    device: Device,
    queue_family_index: u32,
}

impl RobustnessDevice {
    pub fn new(
        instance: &Instance,
        physical_device: vk::PhysicalDevice,
        queue_family_index: u32,
        features: RobustnessFeatures,
    ) -> Result<Self, TestError> {
        let priorities = [1.0f32];
        let queue_infos = [vk::DeviceQueueCreateInfo::builder()
            .queue_family_index(queue_family_index)
            .queue_priorities(&priorities)
            .build()];
        let (device, _extensions) =
            create_device_with_everything_robustness(instance, physical_device, &queue_infos, &[], features)?;
        Ok(Self {
            device,
            queue_family_index,
        })
    }

    pub fn device(&self) -> &Device {
        &self.device
    }

    /// Queue 0 of the family the device was created with.
    pub fn queue(&self) -> vk::Queue {
        unsafe { self.device.get_device_queue(self.queue_family_index, 0) }
    }
}

impl Drop for RobustnessDevice {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            self.device.destroy_device(None);
        }
    }
}
