// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/vulkan/generated/vulkan (the VK_AMD_gpa_interface part of vkDefs.h and the device interface)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: written by hand from vk.xml for hodow_cts: vulkanalia 0.35 predates VK_AMD_gpa_interface, so its structures, the
// feature and property structs and the commands (loaded through vkGetDeviceProcAddr) are declared here. Structure types are the
// extension's (number 134) offsets from 1000133000. Non-dispatchable handles are 64 bit integers, 0 is null.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::TestError;
use crate::vkt::Context;

pub const EXTENSION_NAME: &str = "VK_AMD_gpa_interface";

pub type GpaSessionHandle = u64;

pub const GPA_SAMPLE_TYPE_CUMULATIVE: i32 = 0;
pub const GPA_SAMPLE_TYPE_TIMING: i32 = 2;

pub const GPA_PERF_BLOCK_ATC: i32 = 26;
pub const GPA_PERF_BLOCK_ATC_L2: i32 = 27;
pub const GPA_PERF_BLOCK_RPB: i32 = 30;
pub const GPA_PERF_BLOCK_UMCCH: i32 = 32;
pub const GPA_PERF_BLOCK_GL1CG: i32 = 36;
pub const GPA_PERF_BLOCK_CHCG: i32 = 41;
pub const GPA_PERF_BLOCK_GUS: i32 = 42;
pub const GPA_PERF_BLOCK_PC: i32 = 50;
pub const GPA_PERF_BLOCK_GRBM_SE: i32 = 18;

fn structure_type(offset: i32) -> vk::StructureType {
    vk::StructureType::from_raw(1_000_133_000 + offset)
}

/// `VkGpaDeviceGetClockInfoAMD`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct GpaDeviceGetClockInfo {
    pub s_type: vk::StructureType,
    pub next: *mut c_void,
    pub memory_clock_ratio_to_peak: f32,
    pub engine_clock_ratio_to_peak: f32,
    pub memory_clock_frequency: u32,
    pub engine_clock_frequency: u32,
}

impl Default for GpaDeviceGetClockInfo {
    fn default() -> Self {
        Self {
            s_type: structure_type(6),
            next: std::ptr::null_mut(),
            memory_clock_ratio_to_peak: 0.0,
            engine_clock_ratio_to_peak: 0.0,
            memory_clock_frequency: 0,
            engine_clock_frequency: 0,
        }
    }
}

/// `VkGpaSessionCreateInfoAMD`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct GpaSessionCreateInfo {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub secondary_copy_source: GpaSessionHandle,
}

impl GpaSessionCreateInfo {
    pub fn new(secondary_copy_source: GpaSessionHandle) -> Self {
        Self {
            s_type: structure_type(3),
            next: std::ptr::null(),
            secondary_copy_source,
        }
    }
}

/// `VkGpaPerfBlockPropertiesAMD`
#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct GpaPerfBlockProperties {
    pub block_type: i32,
    pub flags: u32,
    pub instance_count: u32,
    pub max_event_id: u32,
    pub max_global_only_counters: u32,
    pub max_global_shared_counters: u32,
    pub max_streaming_counters: u32,
}

/// `VkGpaPerfCounterAMD`
#[repr(C)]
#[derive(Clone, Copy, Debug, Default)]
pub struct GpaPerfCounter {
    pub block_type: i32,
    pub block_instance: u32,
    pub event_id: u32,
}

/// `VkGpaSampleBeginInfoAMD`
#[repr(C)]
#[derive(Clone, Copy, Debug)]
pub struct GpaSampleBeginInfo {
    pub s_type: vk::StructureType,
    pub next: *const c_void,
    pub sample_type: i32,
    pub sample_internal_operations: vk::Bool32,
    pub cache_flush_on_counter_collection: vk::Bool32,
    pub sq_shader_mask_enable: vk::Bool32,
    pub sq_shader_mask: u32,
    pub perf_counter_count: u32,
    pub perf_counters: *const GpaPerfCounter,
    pub streaming_perf_trace_sample_interval: u32,
    pub perf_counter_device_memory_limit: vk::DeviceSize,
    pub sq_thread_trace_enable: vk::Bool32,
    pub sq_thread_trace_suppress_instruction_tokens: vk::Bool32,
    pub sq_thread_trace_device_memory_limit: vk::DeviceSize,
    pub timing_pre_sample: vk::PipelineStageFlags,
    pub timing_post_sample: vk::PipelineStageFlags,
}

impl GpaSampleBeginInfo {
    /// The counters must outlive the command.
    pub fn new(
        sample_type: i32,
        perf_counters: &[GpaPerfCounter],
        timing_pre_sample: vk::PipelineStageFlags,
        timing_post_sample: vk::PipelineStageFlags,
    ) -> Self {
        Self {
            s_type: structure_type(2),
            next: std::ptr::null(),
            sample_type,
            sample_internal_operations: vk::FALSE,
            cache_flush_on_counter_collection: vk::FALSE,
            sq_shader_mask_enable: vk::FALSE,
            sq_shader_mask: 0,
            perf_counter_count: perf_counters.len() as u32,
            perf_counters: if perf_counters.is_empty() {
                std::ptr::null()
            } else {
                perf_counters.as_ptr()
            },
            streaming_perf_trace_sample_interval: 0,
            perf_counter_device_memory_limit: 0,
            sq_thread_trace_enable: vk::FALSE,
            sq_thread_trace_suppress_instruction_tokens: vk::FALSE,
            sq_thread_trace_device_memory_limit: 0,
            timing_pre_sample,
            timing_post_sample,
        }
    }
}

/// `VkPhysicalDeviceGpaFeaturesAMD`
#[repr(C)]
#[derive(Debug)]
pub struct GpaFeatures {
    pub s_type: vk::StructureType,
    pub next: *mut c_void,
    pub perf_counters: vk::Bool32,
    pub streaming_perf_counters: vk::Bool32,
    pub sq_thread_tracing: vk::Bool32,
    pub clock_modes: vk::Bool32,
}

impl Default for GpaFeatures {
    fn default() -> Self {
        Self {
            s_type: structure_type(0),
            next: std::ptr::null_mut(),
            perf_counters: vk::FALSE,
            streaming_perf_counters: vk::FALSE,
            sq_thread_tracing: vk::FALSE,
            clock_modes: vk::FALSE,
        }
    }
}

unsafe impl vk::ExtendsPhysicalDeviceFeatures2 for GpaFeatures {}

unsafe impl vk::Cast for GpaFeatures {
    type Target = GpaFeatures;

    fn into(self) -> Self::Target {
        self
    }
}

/// `VkPhysicalDeviceGpaPropertiesAMD`
#[repr(C)]
#[derive(Debug)]
pub struct GpaProperties {
    pub s_type: vk::StructureType,
    pub next: *mut c_void,
    pub flags: u32,
    pub max_sqtt_se_buffer_size: vk::DeviceSize,
    pub shader_engine_count: u32,
    pub perf_block_count: u32,
    pub perf_blocks: *mut GpaPerfBlockProperties,
}

impl Default for GpaProperties {
    fn default() -> Self {
        Self {
            s_type: structure_type(1),
            next: std::ptr::null_mut(),
            flags: 0,
            max_sqtt_se_buffer_size: 0,
            shader_engine_count: 0,
            perf_block_count: 0,
            perf_blocks: std::ptr::null_mut(),
        }
    }
}

unsafe impl vk::ExtendsPhysicalDeviceProperties2 for GpaProperties {}

unsafe impl vk::Cast for GpaProperties {
    type Target = GpaProperties;

    fn into(self) -> Self::Target {
        self
    }
}

type CreateSessionFn = unsafe extern "system" fn(
    vk::Device,
    *const GpaSessionCreateInfo,
    *const c_void,
    *mut GpaSessionHandle,
) -> vk::Result;
type DestroySessionFn = unsafe extern "system" fn(vk::Device, GpaSessionHandle, *const c_void);
type GetClockInfoFn = unsafe extern "system" fn(vk::Device, *mut GpaDeviceGetClockInfo) -> vk::Result;
type CmdSessionFn = unsafe extern "system" fn(vk::CommandBuffer, GpaSessionHandle) -> vk::Result;
type CmdBeginSampleFn =
    unsafe extern "system" fn(vk::CommandBuffer, GpaSessionHandle, *const GpaSampleBeginInfo, *mut u32) -> vk::Result;
type CmdEndSampleFn = unsafe extern "system" fn(vk::CommandBuffer, GpaSessionHandle, u32);
type CmdCopyResultsFn = unsafe extern "system" fn(vk::CommandBuffer, GpaSessionHandle);
type SessionStatusFn = unsafe extern "system" fn(vk::Device, GpaSessionHandle) -> vk::Result;
type SessionResultsFn =
    unsafe extern "system" fn(vk::Device, GpaSessionHandle, u32, *mut usize, *mut c_void) -> vk::Result;

macro_rules! load_command {
    ($instance:expr, $device:expr, $name:expr, $type:ty) => {{
        let function = unsafe { $instance.get_device_proc_addr($device.handle(), $name) };
        function
            .map(|function| unsafe { std::mem::transmute::<unsafe extern "system" fn(), $type>(function) })
            .ok_or_else(|| {
                TestError::Fail(format!(
                    "{} is not exposed by a device with {EXTENSION_NAME}",
                    stringify!($name)
                ))
            })?
    }};
}

/// The entry points of VK_AMD_gpa_interface, loaded with `vkGetDeviceProcAddr`.
pub struct Commands {
    create_session: CreateSessionFn,
    destroy_session: DestroySessionFn,
    get_clock_info: GetClockInfoFn,
    cmd_begin_session: CmdSessionFn,
    cmd_end_session: CmdSessionFn,
    cmd_begin_sample: CmdBeginSampleFn,
    cmd_end_sample: CmdEndSampleFn,
    cmd_copy_results: CmdCopyResultsFn,
    get_session_status: SessionStatusFn,
    get_session_results: SessionResultsFn,
    reset_session: SessionStatusFn,
}

impl Commands {
    /// Loads the commands of `device`, which must have been created with the extension.
    pub fn load(instance: &Instance, device: &Device) -> Result<Self, TestError> {
        Ok(Self {
            create_session: load_command!(instance, device, c"vkCreateGpaSessionAMD", CreateSessionFn),
            destroy_session: load_command!(instance, device, c"vkDestroyGpaSessionAMD", DestroySessionFn),
            get_clock_info: load_command!(instance, device, c"vkGetGpaDeviceClockInfoAMD", GetClockInfoFn),
            cmd_begin_session: load_command!(instance, device, c"vkCmdBeginGpaSessionAMD", CmdSessionFn),
            cmd_end_session: load_command!(instance, device, c"vkCmdEndGpaSessionAMD", CmdSessionFn),
            cmd_begin_sample: load_command!(instance, device, c"vkCmdBeginGpaSampleAMD", CmdBeginSampleFn),
            cmd_end_sample: load_command!(instance, device, c"vkCmdEndGpaSampleAMD", CmdEndSampleFn),
            cmd_copy_results: load_command!(instance, device, c"vkCmdCopyGpaSessionResultsAMD", CmdCopyResultsFn),
            get_session_status: load_command!(instance, device, c"vkGetGpaSessionStatusAMD", SessionStatusFn),
            get_session_results: load_command!(instance, device, c"vkGetGpaSessionResultsAMD", SessionResultsFn),
            reset_session: load_command!(instance, device, c"vkResetGpaSessionAMD", SessionStatusFn),
        })
    }

    /// `vkGetGpaDeviceClockInfoAMD`
    pub fn device_clock_info(&self, device: &Device) -> Result<GpaDeviceGetClockInfo, TestError> {
        let mut info = GpaDeviceGetClockInfo::default();
        check(
            unsafe { (self.get_clock_info)(device.handle(), &mut info) },
            "vkGetGpaDeviceClockInfoAMD",
        )?;
        Ok(info)
    }

    /// `vkGetGpaSessionStatusAMD`, the raw result: `SUCCESS` and `NOT_READY` are both legitimate answers.
    pub fn session_status(&self, device: &Device, session: GpaSessionHandle) -> vk::Result {
        unsafe { (self.get_session_status)(device.handle(), session) }
    }

    /// `vkResetGpaSessionAMD`
    pub fn reset_session(&self, device: &Device, session: GpaSessionHandle) -> vk::Result {
        unsafe { (self.reset_session)(device.handle(), session) }
    }

    /// `cmdBeginGpaSessionAMD` of the test: some commands of this extension return a `VkResult`, so the wrapper checks it.
    pub fn begin_session(&self, cmd_buffer: vk::CommandBuffer, session: GpaSessionHandle) -> Result<(), TestError> {
        check(
            unsafe { (self.cmd_begin_session)(cmd_buffer, session) },
            "vkCmdBeginGpaSessionAMD",
        )
    }

    /// `cmdEndGpaSessionAMD` of the test
    pub fn end_session(&self, cmd_buffer: vk::CommandBuffer, session: GpaSessionHandle) -> Result<(), TestError> {
        check(
            unsafe { (self.cmd_end_session)(cmd_buffer, session) },
            "vkCmdEndGpaSessionAMD",
        )
    }

    /// `cmdBeginGpaSampleAMD` of the test: returns the sample id instead of writing through a pointer.
    pub fn begin_sample(
        &self,
        cmd_buffer: vk::CommandBuffer,
        session: GpaSessionHandle,
        info: &GpaSampleBeginInfo,
    ) -> Result<u32, TestError> {
        let mut sample_id = u32::MAX;
        check(
            unsafe { (self.cmd_begin_sample)(cmd_buffer, session, info, &mut sample_id) },
            "vkCmdBeginGpaSampleAMD",
        )?;
        Ok(sample_id)
    }

    /// `cmdEndGpaSampleAMD` of the test
    pub fn end_sample(&self, cmd_buffer: vk::CommandBuffer, session: GpaSessionHandle, sample_id: u32) {
        unsafe { (self.cmd_end_sample)(cmd_buffer, session, sample_id) };
    }

    /// `vkCmdCopyGpaSessionResultsAMD`
    pub fn copy_session_results(&self, cmd_buffer: vk::CommandBuffer, session: GpaSessionHandle) {
        unsafe { (self.cmd_copy_results)(cmd_buffer, session) };
    }

    /// `vkGetGpaSessionResultsAMD`: the size when `data` is `None`, otherwise fills `data` and returns the size written.
    pub fn session_results(
        &self,
        device: &Device,
        session: GpaSessionHandle,
        sample_id: u32,
        data: Option<&mut [u8]>,
    ) -> Result<usize, TestError> {
        let (mut size, pointer) = match data {
            Some(data) => (data.len(), data.as_mut_ptr().cast::<c_void>()),
            None => (0, std::ptr::null_mut()),
        };
        check(
            unsafe { (self.get_session_results)(device.handle(), session, sample_id, &mut size, pointer) },
            "vkGetGpaSessionResultsAMD",
        )?;
        Ok(size)
    }
}

/// `VK_CHECK` for a raw result: only the success codes pass
fn check(result: vk::Result, what: &str) -> Result<(), TestError> {
    match result {
        vk::Result::SUCCESS => Ok(()),
        vk::Result::ERROR_OUT_OF_HOST_MEMORY => Err(TestError::OutOfHostMemory(format!("{what} returned {result:?}"))),
        vk::Result::ERROR_OUT_OF_DEVICE_MEMORY => Err(TestError::ResourceError(format!("{what} returned {result:?}"))),
        vk::Result::ERROR_DEVICE_LOST => Err(TestError::DeviceLost(format!("{what} returned {result:?}"))),
        _ => Err(TestError::InternalError(format!("{what} returned {result:?}"))),
    }
}

/// `makeGpaSession` result: destroyed on drop
pub struct GpaSession<'a> {
    commands: &'a Commands,
    device: &'a Device,
    handle: GpaSessionHandle,
}

impl<'a> GpaSession<'a> {
    /// `vkCreateGpaSessionAMD`
    pub fn new(
        commands: &'a Commands,
        device: &'a Device,
        secondary_copy_source: GpaSessionHandle,
    ) -> Result<Self, TestError> {
        let info = GpaSessionCreateInfo::new(secondary_copy_source);
        let mut handle: GpaSessionHandle = 0;
        check(
            unsafe { (commands.create_session)(device.handle(), &info, std::ptr::null(), &mut handle) },
            "vkCreateGpaSessionAMD",
        )?;
        Ok(Self {
            commands,
            device,
            handle,
        })
    }

    pub fn get(&self) -> GpaSessionHandle {
        self.handle
    }
}

impl Drop for GpaSession<'_> {
    fn drop(&mut self) {
        unsafe { (self.commands.destroy_session)(self.device.handle(), self.handle, std::ptr::null()) };
    }
}

/// `checkFeatureSupport`: the extension and the feature bits named by the flags
pub const FEATURE_PERF_COUNTERS: u32 = 1 << 0;
pub const FEATURE_STREAMING_PERF_COUNTERS: u32 = 1 << 1;
pub const FEATURE_SQ_THREAD_TRACING: u32 = 1 << 2;
pub const FEATURE_CLOCK_MODES: u32 = 1 << 3;

pub fn check_feature_support(context: &Context<'_>, flags: u32) -> Result<(), TestError> {
    context.require_device_functionality(EXTENSION_NAME)?;
    let mut features = GpaFeatures::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    let missing = |flag: u32, value: vk::Bool32, name: &str| {
        if flags & flag != 0 && value == vk::FALSE {
            Err(TestError::NotSupported(format!("{name} not supported")))
        } else {
            Ok(())
        }
    };
    missing(FEATURE_PERF_COUNTERS, features.perf_counters, "perfCounters")?;
    missing(
        FEATURE_STREAMING_PERF_COUNTERS,
        features.streaming_perf_counters,
        "streamingPerfCounters",
    )?;
    missing(FEATURE_SQ_THREAD_TRACING, features.sq_thread_tracing, "sqThreadTracing")?;
    missing(FEATURE_CLOCK_MODES, features.clock_modes, "clockModes")
}

/// The commands of the context's device.
pub fn load_commands(context: &Context<'_>) -> Result<Commands, TestError> {
    Commands::load(context.get_instance(), context.get_device())
}

/// `getDevicePerfBlocks`: a double call, first for the count and then for the data
pub fn get_device_perf_blocks(context: &Context<'_>) -> Vec<GpaPerfBlockProperties> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let mut gpa_properties = GpaProperties::default();
    let mut perf_blocks = Vec::new();

    {
        let mut props2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut gpa_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut props2) };
    }
    if gpa_properties.perf_block_count > 0 {
        perf_blocks.resize(
            gpa_properties.perf_block_count as usize,
            GpaPerfBlockProperties::default(),
        );
        gpa_properties.perf_blocks = perf_blocks.as_mut_ptr();
        let mut props2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut gpa_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut props2) };
    }
    perf_blocks
}
