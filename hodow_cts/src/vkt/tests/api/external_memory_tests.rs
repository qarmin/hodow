// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiExternalMemoryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-VK.api.external`: exporting and importing semaphores, fences and memory through external handles. Upstream creates an
// instance and a device per case with only the extensions the handle type needs; the cases here run on the default device, which
// has every extension the driver advertises, and ask for the same extensions in `checkSupport`. Only the POSIX file descriptor
// handle types (opaque fd, sync fd, dma-buf) can be exercised on this platform. The Win32, Fuchsia, Android hardware buffer and
// Metal ones are registered with upstream's names and their extension checks, which is where they stop on a Linux driver.
//
// The `send_over_socket` cases do the SCM_RIGHTS round trip over a socket pair through hand-declared libc calls (`send_fd_over_socket`). Not ported: the Android hardware buffer ones;
// those report NotPorted instead of a verdict. The `info` cases of a handle type ask the physical device only.

use std::cell::Cell;
use std::os::fd::RawFd;
use std::time::Instant;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1, KhrExternalMemoryFdExtensionDeviceCommands};

use crate::generated::shaders::api_external::GET_NATIVE_FD;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::util::external_memory_util::{
    DedicatedTo, NativeHandle, Permanence, Transference, allocate_exportable_memory, choose_host_visible_memory_type,
    choose_memory_type, create_and_import_fence, create_and_import_semaphore, create_exportable_fence,
    create_exportable_semaphore, create_external_buffer, create_external_image, external_fence_type_name,
    external_memory_type_name, external_semaphore_type_name, fence_handle_type_transference, get_fence_native,
    get_memory_fd, get_memory_native, get_semaphore_native, import_fence, import_memory, import_semaphore,
    is_supported_fence_permanence, is_supported_semaphore_permanence, semaphore_handle_type_transference,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

unsafe extern "C" {
    fn dup2(old_fd: i32, new_fd: i32) -> i32;
    fn dup3(old_fd: i32, new_fd: i32, flags: i32) -> i32;
    fn socketpair(domain: i32, kind: i32, protocol: i32, sv: *mut i32) -> i32;
    fn sendmsg(socket: i32, message: *const MsgHdr, flags: i32) -> isize;
    fn recvmsg(socket: i32, message: *mut MsgHdr, flags: i32) -> isize;
}

// `struct iovec`, `struct msghdr` and `struct cmsghdr` as the Linux ABI lays them out (size_t members are `usize`, so the layout follows the pointer width).
#[repr(C)]
struct IoVec {
    base: *mut u8,
    len: usize,
}

#[repr(C)]
struct MsgHdr {
    name: *mut u8,
    name_len: u32,
    iov: *mut IoVec,
    iov_len: usize,
    control: *mut u8,
    control_len: usize,
    flags: i32,
}

#[repr(C)]
struct CmsgHdr {
    len: usize,
    level: i32,
    kind: i32,
}

const AF_UNIX: i32 = 1;
const SOCK_STREAM: i32 = 1;
const SOL_SOCKET: i32 = 1;
const SCM_RIGHTS: i32 = 1;

fn cmsg_align(len: usize) -> usize {
    (len + std::mem::size_of::<usize>() - 1) & !(std::mem::size_of::<usize>() - 1)
}

/// `CMSG_LEN(sizeof(int))`
fn cmsg_len_of_fd() -> usize {
    cmsg_align(std::mem::size_of::<CmsgHdr>()) + std::mem::size_of::<i32>()
}

/// `CMSG_SPACE(sizeof(int))`
fn cmsg_space_of_fd() -> usize {
    cmsg_align(std::mem::size_of::<CmsgHdr>()) + cmsg_align(std::mem::size_of::<i32>())
}

/// What the three `testXxxFdSendOverSocket` have in common: the descriptor goes over a socket pair as SCM_RIGHTS and the one that
/// arrives is returned, to be imported.
fn send_fd_over_socket(fd: &NativeHandle) -> Result<NativeHandle, TestError> {
    let mut sv = [0i32; 2];
    if unsafe { socketpair(AF_UNIX, SOCK_STREAM, 0, sv.as_mut_ptr()) } != 0 {
        log::info!("Failed to create socket pair: '{}'", std::io::Error::last_os_error());
        return Err(TestError::Fail("Failed to create socket pair".to_string()));
    }
    let src_socket = NativeHandle::from_fd(sv[0]);
    let dst_socket = NativeHandle::from_fd(sv[1]);
    let send_data = *b"deqp";

    // Send FD
    {
        // u64 words keep the control message aligned as `cmsghdr` needs
        let mut control = [0u64; 4];
        assert!(cmsg_space_of_fd() <= std::mem::size_of_val(&control));
        let mut iov = IoVec {
            base: send_data.as_ptr().cast_mut(),
            len: send_data.len(),
        };
        let mut msg = MsgHdr {
            name: std::ptr::null_mut(),
            name_len: 0,
            iov: &mut iov,
            iov_len: 1,
            control: control.as_mut_ptr().cast(),
            control_len: cmsg_space_of_fd(),
            flags: 0,
        };
        // SAFETY: `control` is large enough and aligned for one header plus an int.
        unsafe {
            let cmsg = control.as_mut_ptr().cast::<CmsgHdr>();
            (*cmsg).level = SOL_SOCKET;
            (*cmsg).kind = SCM_RIGHTS;
            (*cmsg).len = cmsg_len_of_fd();
            control
                .as_mut_ptr()
                .cast::<u8>()
                .add(cmsg_align(std::mem::size_of::<CmsgHdr>()))
                .cast::<i32>()
                .write(fd.fd());
        }
        msg.control_len = cmsg_len_of_fd();

        if unsafe { sendmsg(src_socket.fd(), &msg, 0) } < 0 {
            log::info!("Failed to send fd over socket: '{}'", std::io::Error::last_os_error());
            return Err(TestError::Fail("Failed to send fd over socket".to_string()));
        }
    }

    // Recv FD
    let mut control = [0u64; 4];
    let mut recv_data = [0u8; 4];
    let mut iov = IoVec {
        base: recv_data.as_mut_ptr(),
        len: recv_data.len(),
    };
    let mut msg = MsgHdr {
        name: std::ptr::null_mut(),
        name_len: 0,
        iov: &mut iov,
        iov_len: 1,
        control: control.as_mut_ptr().cast(),
        control_len: cmsg_space_of_fd(),
        flags: 0,
    };
    let bytes = unsafe { recvmsg(dst_socket.fd(), &mut msg, 0) };
    if bytes < 0 {
        log::info!("Failed to recv fd over socket: '{}'", std::io::Error::last_os_error());
        return Err(TestError::Fail("Failed to recv fd over socket".to_string()));
    }
    if bytes as usize != send_data.len() {
        return Err(TestError::Fail(
            "recvmsg() returned unexpected number of bytes".to_string(),
        ));
    }

    // SAFETY: the kernel wrote a control message of `msg.control_len` bytes at the start of `control`.
    let (level, kind, len, new_fd) = unsafe {
        let cmsg = control.as_ptr().cast::<CmsgHdr>();
        let new_fd = control
            .as_ptr()
            .cast::<u8>()
            .add(cmsg_align(std::mem::size_of::<CmsgHdr>()))
            .cast::<i32>()
            .read();
        ((*cmsg).level, (*cmsg).kind, (*cmsg).len, new_fd)
    };
    let new_fd = NativeHandle::from_fd(new_fd);

    if level != SOL_SOCKET || kind != SCM_RIGHTS || len != cmsg_len_of_fd() {
        return Err(TestError::Fail(
            "Unexpected control message received from socket".to_string(),
        ));
    }
    if recv_data != send_data {
        return Err(TestError::Fail("Unexpected data received from socket".to_string()));
    }
    if new_fd.fd() < 0 {
        return Err(TestError::Fail("Didn't receive valid fd from socket".to_string()));
    }
    Ok(new_fd)
}

const MINUS_ONE_PASS: &str =
    "Pass: got -1 as a file descriptor, which is valid with a handle type of copy transference";

macro_rules! pass_if_minus_one {
    ($handle:expr) => {
        if $handle.is_minus_one() {
            return Ok(TestStatus::pass(MINUS_ONE_PASS));
        }
    };
}

#[derive(Clone, Copy)]
struct SemaphoreConfig {
    handle: vk::ExternalSemaphoreHandleTypeFlags,
    permanence: Permanence,
}

#[derive(Clone, Copy)]
struct FenceConfig {
    handle: vk::ExternalFenceHandleTypeFlags,
    permanence: Permanence,
}

#[derive(Clone, Copy)]
struct MemoryConfig {
    handle: vk::ExternalMemoryHandleTypeFlags,
    host_visible: bool,
    dedicated: bool,
}

#[derive(Clone, Copy)]
struct BufferConfig {
    handle: vk::ExternalMemoryHandleTypeFlags,
    dedicated: bool,
}

#[derive(Clone, Copy)]
struct ImageConfig {
    handle: vk::ExternalMemoryHandleTypeFlags,
    tiling: vk::ImageTiling,
    dedicated: bool,
}

fn semaphore_import_flags(permanence: Permanence) -> vk::SemaphoreImportFlags {
    if permanence == Permanence::Temporary {
        vk::SemaphoreImportFlags::TEMPORARY
    } else {
        vk::SemaphoreImportFlags::empty()
    }
}

fn fence_import_flags(permanence: Permanence) -> vk::FenceImportFlags {
    if permanence == Permanence::Temporary {
        vk::FenceImportFlags::TEMPORARY
    } else {
        vk::FenceImportFlags::empty()
    }
}

/// The default device and the universal queue the cases run on.
struct Env<'a> {
    device: &'a Device,
    queue: vk::Queue,
    queue_family_index: u32,
}

impl<'a> Env<'a> {
    fn new(context: &'a Context<'_>) -> Self {
        Self {
            device: context.get_device(),
            queue: context.get_universal_queue(),
            queue_family_index: context.get_universal_queue_family_index(),
        }
    }

    fn wait_idle(&self) -> Result<(), TestError> {
        unsafe { self.device.queue_wait_idle(self.queue) }.vk_check("vkQueueWaitIdle")
    }
}

fn create_plain_semaphore(device: &Device) -> Result<Unique<'_, vk::Semaphore>, TestError> {
    let semaphore =
        unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }.vk_check("vkCreateSemaphore")?;
    Ok(Unique::new(device, semaphore))
}

fn create_plain_fence(device: &Device) -> Result<Unique<'_, vk::Fence>, TestError> {
    let fence = unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
    Ok(Unique::new(device, fence))
}

/// `submitEmptySignal` for a semaphore.
fn submit_empty_signal_semaphore(env: &Env<'_>, semaphore: vk::Semaphore) -> Result<(), TestError> {
    let signals = [semaphore];
    let submit = vk::SubmitInfo::builder().signal_semaphores(&signals);
    unsafe { env.device.queue_submit(env.queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")
}

/// `submitEmptyWait`
fn submit_empty_wait_semaphore(env: &Env<'_>, semaphore: vk::Semaphore) -> Result<(), TestError> {
    let waits = [semaphore];
    let stages = [vk::PipelineStageFlags::ALL_COMMANDS];
    let submit = vk::SubmitInfo::builder()
        .wait_semaphores(&waits)
        .wait_dst_stage_mask(&stages);
    unsafe { env.device.queue_submit(env.queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")
}

/// `submitEmptySignal` for a fence.
fn submit_empty_signal_fence(env: &Env<'_>, fence: vk::Fence) -> Result<(), TestError> {
    let submit = vk::SubmitInfo::builder();
    unsafe { env.device.queue_submit(env.queue, &[submit], fence) }.vk_check("vkQueueSubmit")
}

fn wait_for_fence(env: &Env<'_>, fence: vk::Fence) -> Result<(), TestError> {
    unsafe { env.device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

fn reset_fence(env: &Env<'_>, fence: vk::Fence) -> Result<(), TestError> {
    unsafe { env.device.reset_fences(&[fence]) }.vk_check("vkResetFences")
}

fn create_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(-1)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

thread_local! {
    /// The static `yWorkSize` of `tuneWorkSizeYAndPrepareCommandBuffer`: tuned once and kept for the cases that follow.
    static Y_WORK_SIZE: Cell<u32> = const { Cell::new(1) };
}

/// What the long-running submit signals when it completes.
#[derive(Clone, Copy)]
enum SignalTarget {
    Semaphore(vk::Semaphore),
    Fence(vk::Fence),
}

/// `submitAtomicCalculationsAndGetSemaphoreNative` / `...GetFenceNative`: submits a compute dispatch long enough that the object it
/// signals is not signalled yet when `get_native` exports it, since a sync fd of a signalled object is allowed to be -1.
fn submit_atomic_calculations_and_get_native(
    context: &Context<'_>,
    env: &Env<'_>,
    target: SignalTarget,
    get_native: &mut dyn FnMut() -> Result<NativeHandle, TestError>,
) -> Result<NativeHandle, TestError> {
    let device = env.device;
    let limits = &context.get_device_properties().limits;
    let max_x_work_size = limits.max_compute_work_group_size[0];
    let max_y_work_size = limits.max_compute_work_group_size[1];
    let work_group_count = u64::from(max_x_work_size) * u64::from(max_y_work_size);
    let output_buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize * work_group_count;

    let output_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::LOCAL,
    )?;
    let shader = create_shader_module(device, context.get_binary_collection().get("compute")?)?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
    let pipeline = create_compute_pipeline(device, *pipeline_layout, *shader)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
    let output_buffer_info = vk::DescriptorBufferInfo {
        buffer: output_buffer.get(),
        offset: 0,
        range: output_buffer_size,
    };
    DescriptorSetUpdateBuilder::new()
        .write_single(
            *descriptor_set,
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &output_buffer_info,
        )
        .update(device);
    let compute_finish_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        output_buffer.get(),
        0,
        output_buffer_size,
    );

    let event = unsafe { device.create_event(&vk::EventCreateInfo::builder(), None) }.vk_check("vkCreateEvent")?;
    let event = Unique::new(device, event);
    let cmd_pool = make_command_pool(device, env.queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let record = |y_work_size: u32| -> Result<(), TestError> {
        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            // The event is set after the work was submitted, and its state tells afterwards whether the work had already finished.
            device.cmd_set_event(*cmd_buffer, *event, vk::PipelineStageFlags::BOTTOM_OF_PIPE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[],
            );
            device.cmd_dispatch(*cmd_buffer, max_x_work_size, y_work_size, 1);
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[compute_finish_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *cmd_buffer)
    };

    // `tuneWorkSizeYAndPrepareCommandBuffer`: double the work until one run takes over 9 ms.
    let tuning_fence = create_plain_fence(device)?;
    let mut y_work_size = Y_WORK_SIZE.with(Cell::get);
    let mut out_loop = false;
    loop {
        record(y_work_size)?;
        if out_loop {
            break;
        }

        let cmd_buffers = [*cmd_buffer];
        let submit = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
        let time_start = Instant::now();
        unsafe { device.queue_submit(env.queue, &[submit], *tuning_fence) }.vk_check("vkQueueSubmit")?;
        wait_for_fence(env, *tuning_fence)?;
        let elapsed_ms = time_start.elapsed().as_millis();

        if elapsed_ms > 9 {
            out_loop = true;
            continue;
        }

        y_work_size *= 2;
        if y_work_size > max_y_work_size {
            y_work_size = max_y_work_size;
            out_loop = true;
        }

        unsafe { device.reset_command_buffer(*cmd_buffer, vk::CommandBufferResetFlags::empty()) }
            .vk_check("vkResetCommandBuffer")?;
        reset_fence(env, *tuning_fence)?;
    }
    Y_WORK_SIZE.with(|size| size.set(y_work_size));

    let cmd_buffers = [*cmd_buffer];
    match target {
        SignalTarget::Semaphore(semaphore) => {
            let signals = [semaphore];
            let submit = vk::SubmitInfo::builder()
                .command_buffers(&cmd_buffers)
                .signal_semaphores(&signals);
            unsafe { device.queue_submit(env.queue, &[submit], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
        }
        SignalTarget::Fence(fence) => {
            let submit = vk::SubmitInfo::builder().command_buffers(&cmd_buffers);
            unsafe { device.queue_submit(env.queue, &[submit], fence) }.vk_check("vkQueueSubmit")?;
        }
    }

    let native = get_native()?;

    // -1 is valid if the object was signalled properly, which the event tells.
    if native.is_minus_one()
        && unsafe { device.get_event_status(*event) }.vk_check("vkGetEventStatus")? != vk::SuccessCode::EVENT_SET
    {
        return Err(TestError::Fail(
            "a sync fd of -1 was returned for work that has not finished".to_string(),
        ));
    }

    env.wait_idle()?;
    Ok(native)
}

/// What `if (transference == COPY) submitAtomicCalculations...; else get...Native` does, with `always_atomic` for the cases that run
/// the calculation whatever the transference is.
fn export_semaphore(
    context: &Context<'_>,
    env: &Env<'_>,
    config: SemaphoreConfig,
    semaphore: vk::Semaphore,
    always_atomic: bool,
) -> Result<NativeHandle, TestError> {
    if always_atomic || semaphore_handle_type_transference(config.handle) == Transference::Copy {
        submit_atomic_calculations_and_get_native(context, env, SignalTarget::Semaphore(semaphore), &mut || {
            get_semaphore_native(env.device, semaphore, config.handle)
        })
    } else {
        get_semaphore_native(env.device, semaphore, config.handle)
    }
}

fn export_fence(
    context: &Context<'_>,
    env: &Env<'_>,
    config: FenceConfig,
    fence: vk::Fence,
    always_atomic: bool,
    expect_unsignaled: bool,
) -> Result<NativeHandle, TestError> {
    if always_atomic || fence_handle_type_transference(config.handle) == Transference::Copy {
        submit_atomic_calculations_and_get_native(context, env, SignalTarget::Fence(fence), &mut || {
            get_fence_native(env.device, fence, config.handle, expect_unsignaled)
        })
    } else {
        get_fence_native(env.device, fence, config.handle, expect_unsignaled)
    }
}

// ---------------------------------------------------------------------------------
// Semaphores
// ---------------------------------------------------------------------------------

/// `testSemaphoreQueries`
fn semaphore_queries(
    context: &Context<'_>,
    semaphore_type: vk::SemaphoreType,
    handle: vk::ExternalSemaphoreHandleTypeFlags,
) -> TestOutcome {
    let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
        .semaphore_type(semaphore_type)
        .initial_value(0);
    let info = vk::PhysicalDeviceExternalSemaphoreInfo::builder()
        .push_next(&mut type_info)
        .handle_type(handle);
    let mut properties = vk::ExternalSemaphoreProperties::default();
    unsafe {
        context
            .get_instance()
            .get_physical_device_external_semaphore_properties(context.get_physical_device(), &info, &mut properties)
    };

    if semaphore_type == vk::SemaphoreType::TIMELINE {
        if properties
            .compatible_handle_types
            .contains(vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD)
        {
            return Ok(TestStatus::fail("Timeline semaphores are not compatible with SYNC_FD"));
        }
        if properties
            .export_from_imported_handle_types
            .contains(vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD)
        {
            return Ok(TestStatus::fail("Timeline semaphores imported from SYNC_FD"));
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreImportTwice`
fn semaphore_import_twice(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = semaphore_handle_type_transference(config.handle);
    let semaphore = create_exportable_semaphore(env.device, config.handle)?;
    let mut handle_a = export_semaphore(context, &env, config, *semaphore, false)?;
    pass_if_minus_one!(handle_a);

    let mut handle_b = handle_a.try_clone()?;
    let flags = semaphore_import_flags(config.permanence);
    let semaphore_a = create_and_import_semaphore(env.device, config.handle, &mut handle_a, flags)?;
    let semaphore_b = create_and_import_semaphore(env.device, config.handle, &mut handle_b, flags)?;

    if transference == Transference::Copy {
        submit_empty_wait_semaphore(&env, *semaphore_a)?;
    } else {
        submit_empty_signal_semaphore(&env, *semaphore_a)?;
        submit_empty_wait_semaphore(&env, *semaphore_b)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreImportReimport`
fn semaphore_import_reimport(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = semaphore_handle_type_transference(config.handle);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let mut handle_a = export_semaphore(context, &env, config, *semaphore_a, false)?;
    pass_if_minus_one!(handle_a);

    let mut handle_b = handle_a.try_clone()?;
    let flags = semaphore_import_flags(config.permanence);
    let semaphore_b = create_and_import_semaphore(env.device, config.handle, &mut handle_a, flags)?;
    import_semaphore(env.device, *semaphore_b, config.handle, &mut handle_b, flags)?;

    if transference == Transference::Copy {
        submit_empty_wait_semaphore(&env, *semaphore_b)?;
    } else {
        submit_empty_signal_semaphore(&env, *semaphore_a)?;
        submit_empty_wait_semaphore(&env, *semaphore_b)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreSignalExportImportWait`
fn semaphore_signal_export_import_wait(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let mut handle = export_semaphore(context, &env, config, *semaphore_a, true)?;
    pass_if_minus_one!(handle);

    let semaphore_b = create_and_import_semaphore(
        env.device,
        config.handle,
        &mut handle,
        semaphore_import_flags(config.permanence),
    )?;
    submit_empty_wait_semaphore(&env, *semaphore_b)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreExportSignalImportWait`
fn semaphore_export_signal_import_wait(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let mut handle = get_semaphore_native(env.device, *semaphore_a, config.handle)?;
    submit_empty_signal_semaphore(&env, *semaphore_a)?;

    let semaphore_b = create_and_import_semaphore(
        env.device,
        config.handle,
        &mut handle,
        semaphore_import_flags(config.permanence),
    )?;
    submit_empty_wait_semaphore(&env, *semaphore_b)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreExportImportSignalWait`
fn semaphore_export_import_signal_wait(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let mut handle = get_semaphore_native(env.device, *semaphore_a, config.handle)?;
    let semaphore_b = create_and_import_semaphore(
        env.device,
        config.handle,
        &mut handle,
        semaphore_import_flags(config.permanence),
    )?;
    submit_empty_signal_semaphore(&env, *semaphore_a)?;
    submit_empty_wait_semaphore(&env, *semaphore_b)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreSignalImport`
fn semaphore_signal_import(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = semaphore_handle_type_transference(config.handle);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let semaphore_b = create_plain_semaphore(env.device)?;

    submit_empty_signal_semaphore(&env, *semaphore_b)?;
    env.wait_idle()?;

    let mut handle = export_semaphore(context, &env, config, *semaphore_a, false)?;
    pass_if_minus_one!(handle);
    import_semaphore(
        env.device,
        *semaphore_b,
        config.handle,
        &mut handle,
        semaphore_import_flags(config.permanence),
    )?;

    if transference == Transference::Copy {
        submit_empty_wait_semaphore(&env, *semaphore_b)?;
    } else {
        submit_empty_signal_semaphore(&env, *semaphore_a)?;
        submit_empty_wait_semaphore(&env, *semaphore_b)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreSignalWaitImport`
fn semaphore_signal_wait_import(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let semaphore_b = create_plain_semaphore(env.device)?;
    let mut handle = get_semaphore_native(env.device, *semaphore_a, config.handle)?;

    submit_empty_signal_semaphore(&env, *semaphore_b)?;
    submit_empty_wait_semaphore(&env, *semaphore_b)?;
    env.wait_idle()?;

    import_semaphore(
        env.device,
        *semaphore_b,
        config.handle,
        &mut handle,
        semaphore_import_flags(config.permanence),
    )?;
    submit_empty_signal_semaphore(&env, *semaphore_a)?;
    submit_empty_wait_semaphore(&env, *semaphore_b)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreImportSyncFdSignaled`
fn semaphore_import_sync_fd_signaled(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let mut handle = NativeHandle::from_fd(-1);
    let semaphore = create_and_import_semaphore(
        env.device,
        config.handle,
        &mut handle,
        semaphore_import_flags(config.permanence),
    )?;
    submit_empty_wait_semaphore(&env, *semaphore)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreMultipleExports`
fn semaphore_multiple_exports(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    const EXPORT_COUNT: usize = 1024;
    let env = Env::new(context);
    let semaphore = create_exportable_semaphore(env.device, config.handle)?;

    for _ in 0..EXPORT_COUNT {
        let handle = export_semaphore(context, &env, config, *semaphore, false)?;
        pass_if_minus_one!(handle);
    }

    submit_empty_signal_semaphore(&env, *semaphore)?;
    submit_empty_wait_semaphore(&env, *semaphore)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreMultipleImports`
fn semaphore_multiple_imports(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    const IMPORT_COUNT: usize = 4 * 1024;
    let env = Env::new(context);
    let transference = semaphore_handle_type_transference(config.handle);
    let flags = semaphore_import_flags(config.permanence);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let mut handle_a = export_semaphore(context, &env, config, *semaphore_a, false)?;
    pass_if_minus_one!(handle_a);

    for _ in 0..IMPORT_COUNT {
        let mut handle_b = handle_a.try_clone()?;
        let _semaphore_b = create_and_import_semaphore(env.device, config.handle, &mut handle_b, flags)?;
    }

    if transference == Transference::Copy {
        import_semaphore(env.device, *semaphore_a, config.handle, &mut handle_a, flags)?;
        submit_empty_wait_semaphore(&env, *semaphore_a)?;
    } else {
        submit_empty_signal_semaphore(&env, *semaphore_a)?;
        submit_empty_wait_semaphore(&env, *semaphore_a)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreTransference`
fn semaphore_transference(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = semaphore_handle_type_transference(config.handle);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let mut handle = export_semaphore(context, &env, config, *semaphore_a, true)?;
    pass_if_minus_one!(handle);

    let semaphore_b = create_and_import_semaphore(
        env.device,
        config.handle,
        &mut handle,
        semaphore_import_flags(config.permanence),
    )?;
    let (a, b) = (*semaphore_a, *semaphore_b);

    match (config.permanence, transference) {
        (Permanence::Permanent, Transference::Copy) | (Permanence::Temporary, Transference::Copy) => {
            submit_empty_signal_semaphore(&env, a)?;
            submit_empty_wait_semaphore(&env, b)?;
            env.wait_idle()?;
            submit_empty_signal_semaphore(&env, b)?;
            submit_empty_wait_semaphore(&env, a)?;
            submit_empty_wait_semaphore(&env, b)?;
            env.wait_idle()?;
        }
        (Permanence::Permanent, Transference::Reference) => {
            submit_empty_wait_semaphore(&env, b)?;
            env.wait_idle()?;
            submit_empty_signal_semaphore(&env, a)?;
            submit_empty_wait_semaphore(&env, b)?;
            submit_empty_signal_semaphore(&env, b)?;
            submit_empty_wait_semaphore(&env, a)?;
            env.wait_idle()?;
        }
        (Permanence::Temporary, Transference::Reference) => {
            submit_empty_wait_semaphore(&env, b)?;
            env.wait_idle()?;
            submit_empty_signal_semaphore(&env, a)?;
            submit_empty_signal_semaphore(&env, b)?;
            submit_empty_wait_semaphore(&env, b)?;
            submit_empty_wait_semaphore(&env, a)?;
            env.wait_idle()?;
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testSemaphoreFdDup`
fn semaphore_fd_dup(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = semaphore_handle_type_transference(config.handle);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let fd = export_semaphore(context, &env, config, *semaphore_a, false)?;
    pass_if_minus_one!(fd);

    let mut new_fd = fd.try_clone()?;
    let semaphore_b = create_and_import_semaphore(
        env.device,
        config.handle,
        &mut new_fd,
        semaphore_import_flags(config.permanence),
    )?;
    if transference == Transference::Copy {
        submit_empty_wait_semaphore(&env, *semaphore_b)?;
    } else {
        submit_empty_signal_semaphore(&env, *semaphore_a)?;
        submit_empty_wait_semaphore(&env, *semaphore_b)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// What `testSemaphoreFdDup2` and `testSemaphoreFdDup3` share, with `dup` the call under test.
fn semaphore_fd_dup_over(
    context: &Context<'_>,
    config: SemaphoreConfig,
    dup: &dyn Fn(RawFd, RawFd) -> i32,
    name: &str,
) -> TestOutcome {
    let env = Env::new(context);
    let transference = semaphore_handle_type_transference(config.handle);
    let semaphore_a = create_exportable_semaphore(env.device, config.handle)?;
    let semaphore_b = create_exportable_semaphore(env.device, config.handle)?;

    let fd = export_semaphore(context, &env, config, *semaphore_a, false)?;
    let mut second_fd = export_semaphore(context, &env, config, *semaphore_b, false)?;
    if fd.is_minus_one() || second_fd.is_minus_one() {
        return Ok(TestStatus::pass(MINUS_ONE_PASS));
    }

    let new_fd = dup(fd.fd(), second_fd.fd());
    if new_fd < 0 {
        log::info!("{name}() failed: '{}'", std::io::Error::last_os_error());
        return Ok(TestStatus::fail(format!("Failed to call {name}() for semaphores fd")));
    }

    let semaphore_c = create_and_import_semaphore(
        env.device,
        config.handle,
        &mut second_fd,
        semaphore_import_flags(config.permanence),
    )?;
    if transference == Transference::Copy {
        submit_empty_wait_semaphore(&env, *semaphore_c)?;
    } else {
        submit_empty_signal_semaphore(&env, *semaphore_a)?;
        submit_empty_wait_semaphore(&env, *semaphore_c)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

fn semaphore_fd_dup2(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    semaphore_fd_dup_over(context, config, &|old, new| unsafe { dup2(old, new) }, "dup2")
}

fn semaphore_fd_dup3(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    semaphore_fd_dup_over(context, config, &|old, new| unsafe { dup3(old, new, 0) }, "dup3")
}

/// `testSemaphoreFdSendOverSocket`
fn semaphore_fd_send_over_socket(context: &Context<'_>, config: SemaphoreConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = semaphore_handle_type_transference(config.handle);
    let semaphore = create_exportable_semaphore(env.device, config.handle)?;
    let fd = export_semaphore(context, &env, config, *semaphore, false)?;
    pass_if_minus_one!(fd);

    let mut new_fd = send_fd_over_socket(&fd)?;
    let new_semaphore = create_and_import_semaphore(
        env.device,
        config.handle,
        &mut new_fd,
        semaphore_import_flags(config.permanence),
    )?;
    if transference == Transference::Copy {
        submit_empty_wait_semaphore(&env, *new_semaphore)?;
    } else {
        submit_empty_signal_semaphore(&env, *new_semaphore)?;
        submit_empty_wait_semaphore(&env, *new_semaphore)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------
// Fences
// ---------------------------------------------------------------------------------

/// `testFenceQueries`
fn fence_queries(context: &Context<'_>, handle: vk::ExternalFenceHandleTypeFlags) -> TestOutcome {
    let info = vk::PhysicalDeviceExternalFenceInfo::builder().handle_type(handle);
    let mut properties = vk::ExternalFenceProperties::default();
    unsafe {
        context.get_instance().get_physical_device_external_fence_properties(
            context.get_physical_device(),
            &info,
            &mut properties,
        )
    };
    log::info!("{properties:?}");
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceImportTwice`
fn fence_import_twice(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = fence_handle_type_transference(config.handle);
    let fence = create_exportable_fence(env.device, config.handle)?;
    let mut handle_a = export_fence(context, &env, config, *fence, false, true)?;
    pass_if_minus_one!(handle_a);

    let mut handle_b = handle_a.try_clone()?;
    let flags = fence_import_flags(config.permanence);
    let fence_a = create_and_import_fence(env.device, config.handle, &mut handle_a, flags)?;
    let fence_b = create_and_import_fence(env.device, config.handle, &mut handle_b, flags)?;

    if transference == Transference::Copy {
        wait_for_fence(&env, *fence_a)?;
    } else {
        submit_empty_signal_fence(&env, *fence_a)?;
        wait_for_fence(&env, *fence_b)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceImportReimport`
fn fence_import_reimport(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = fence_handle_type_transference(config.handle);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let mut handle_a = export_fence(context, &env, config, *fence_a, false, true)?;
    pass_if_minus_one!(handle_a);

    let mut handle_b = handle_a.try_clone()?;
    let flags = fence_import_flags(config.permanence);
    let fence_b = create_and_import_fence(env.device, config.handle, &mut handle_a, flags)?;
    import_fence(env.device, *fence_b, config.handle, &mut handle_b, flags)?;

    if transference == Transference::Copy {
        wait_for_fence(&env, *fence_b)?;
    } else {
        submit_empty_signal_fence(&env, *fence_a)?;
        wait_for_fence(&env, *fence_b)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceSignalExportImportWait`
fn fence_signal_export_import_wait(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let mut handle = export_fence(context, &env, config, *fence_a, true, true)?;
    pass_if_minus_one!(handle);

    let fence_b = create_and_import_fence(
        env.device,
        config.handle,
        &mut handle,
        fence_import_flags(config.permanence),
    )?;
    wait_for_fence(&env, *fence_b)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceImportSyncFdSignaled`
fn fence_import_sync_fd_signaled(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let mut handle = NativeHandle::from_fd(-1);
    let fence = create_and_import_fence(
        env.device,
        config.handle,
        &mut handle,
        fence_import_flags(config.permanence),
    )?;
    if unsafe { env.device.wait_for_fences(&[*fence], true, 0) }.vk_check("vkWaitForFences")?
        != vk::SuccessCode::SUCCESS
    {
        return Ok(TestStatus::pass("Imported -1 sync fd isn't signaled"));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceExportSignalImportWait`
fn fence_export_signal_import_wait(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let mut handle = get_fence_native(env.device, *fence_a, config.handle, true)?;
    submit_empty_signal_fence(&env, *fence_a)?;

    let fence_b = create_and_import_fence(
        env.device,
        config.handle,
        &mut handle,
        fence_import_flags(config.permanence),
    )?;
    wait_for_fence(&env, *fence_b)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceExportImportSignalWait`
fn fence_export_import_signal_wait(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let mut handle = get_fence_native(env.device, *fence_a, config.handle, true)?;
    let fence_b = create_and_import_fence(
        env.device,
        config.handle,
        &mut handle,
        fence_import_flags(config.permanence),
    )?;
    submit_empty_signal_fence(&env, *fence_a)?;
    wait_for_fence(&env, *fence_b)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceSignalImport`
fn fence_signal_import(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = fence_handle_type_transference(config.handle);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let fence_b = create_plain_fence(env.device)?;

    submit_empty_signal_fence(&env, *fence_b)?;
    env.wait_idle()?;

    let mut handle = export_fence(context, &env, config, *fence_a, false, true)?;
    pass_if_minus_one!(handle);
    import_fence(
        env.device,
        *fence_b,
        config.handle,
        &mut handle,
        fence_import_flags(config.permanence),
    )?;

    if transference == Transference::Copy {
        wait_for_fence(&env, *fence_b)?;
    } else {
        submit_empty_signal_fence(&env, *fence_a)?;
        wait_for_fence(&env, *fence_b)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceReset`
fn fence_reset(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = fence_handle_type_transference(config.handle);
    let flags = fence_import_flags(config.permanence);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let fence_b = create_plain_fence(env.device)?;
    let fence_c = create_plain_fence(env.device)?;

    submit_empty_signal_fence(&env, *fence_b)?;
    env.wait_idle()?;

    let mut handle =
        submit_atomic_calculations_and_get_native(context, &env, SignalTarget::Fence(*fence_a), &mut || {
            get_fence_native(env.device, *fence_a, config.handle, true)
        })?;
    pass_if_minus_one!(handle);

    let mut handle_b = handle.try_clone()?;
    import_fence(env.device, *fence_b, config.handle, &mut handle_b, flags)?;
    import_fence(env.device, *fence_c, config.handle, &mut handle, flags)?;
    env.wait_idle()?;

    reset_fence(&env, *fence_b)?;

    if config.permanence == Permanence::Temporary || transference == Transference::Copy {
        // Resetting fenceB restores its prior payload without touching fenceC's, or it is a separate copy of the payload.
        wait_for_fence(&env, *fence_c)?;
        // fenceB is back in its prior state, which is reset, or it has a payload of its own.
        submit_empty_signal_fence(&env, *fence_b)?;
        wait_for_fence(&env, *fence_b)?;
    } else {
        // Resetting the fence reset all of them.
        submit_empty_signal_fence(&env, *fence_c)?;
        wait_for_fence(&env, *fence_a)?;
        wait_for_fence(&env, *fence_b)?;
        wait_for_fence(&env, *fence_c)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceSignalWaitImport`
fn fence_signal_wait_import(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let fence_b = create_plain_fence(env.device)?;
    let mut handle = get_fence_native(env.device, *fence_a, config.handle, true)?;

    submit_empty_signal_fence(&env, *fence_b)?;
    wait_for_fence(&env, *fence_b)?;
    env.wait_idle()?;

    import_fence(
        env.device,
        *fence_b,
        config.handle,
        &mut handle,
        fence_import_flags(config.permanence),
    )?;
    submit_empty_signal_fence(&env, *fence_a)?;
    wait_for_fence(&env, *fence_b)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceMultipleExports`
fn fence_multiple_exports(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    const EXPORT_COUNT: usize = 1024;
    let env = Env::new(context);
    let fence = create_exportable_fence(env.device, config.handle)?;

    for export_ndx in 0..EXPORT_COUNT {
        let handle = export_fence(context, &env, config, *fence, false, export_ndx == 0)?;
        pass_if_minus_one!(handle);
    }

    submit_empty_signal_fence(&env, *fence)?;
    wait_for_fence(&env, *fence)?;
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceMultipleImports`
fn fence_multiple_imports(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    const IMPORT_COUNT: usize = 4 * 1024;
    let env = Env::new(context);
    let transference = fence_handle_type_transference(config.handle);
    let flags = fence_import_flags(config.permanence);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let mut handle_a = export_fence(context, &env, config, *fence_a, false, true)?;
    pass_if_minus_one!(handle_a);

    for _ in 0..IMPORT_COUNT {
        let mut handle_b = handle_a.try_clone()?;
        let _fence_b = create_and_import_fence(env.device, config.handle, &mut handle_b, flags)?;
    }

    if transference == Transference::Copy {
        import_fence(env.device, *fence_a, config.handle, &mut handle_a, flags)?;
        wait_for_fence(&env, *fence_a)?;
    } else {
        submit_empty_signal_fence(&env, *fence_a)?;
        wait_for_fence(&env, *fence_a)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceTransference`
fn fence_transference(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = fence_handle_type_transference(config.handle);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let mut handle = export_fence(context, &env, config, *fence_a, true, true)?;
    pass_if_minus_one!(handle);

    let fence_b = create_and_import_fence(
        env.device,
        config.handle,
        &mut handle,
        fence_import_flags(config.permanence),
    )?;
    let (a, b) = (*fence_a, *fence_b);

    match (config.permanence, transference) {
        (_, Transference::Copy) => {
            submit_empty_signal_fence(&env, a)?;
            wait_for_fence(&env, b)?;
            env.wait_idle()?;
            reset_fence(&env, b)?;
            submit_empty_signal_fence(&env, b)?;
            wait_for_fence(&env, a)?;
            wait_for_fence(&env, b)?;
            env.wait_idle()?;
        }
        (Permanence::Permanent, Transference::Reference) => {
            wait_for_fence(&env, b)?;
            env.wait_idle()?;
            reset_fence(&env, b)?;
            submit_empty_signal_fence(&env, a)?;
            wait_for_fence(&env, b)?;
            reset_fence(&env, a)?;
            submit_empty_signal_fence(&env, b)?;
            wait_for_fence(&env, a)?;
            env.wait_idle()?;
        }
        (Permanence::Temporary, Transference::Reference) => {
            wait_for_fence(&env, b)?;
            env.wait_idle()?;
            reset_fence(&env, a)?;
            reset_fence(&env, b)?;
            submit_empty_signal_fence(&env, a)?;
            submit_empty_signal_fence(&env, b)?;
            wait_for_fence(&env, b)?;
            wait_for_fence(&env, a)?;
            env.wait_idle()?;
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testFenceFdDup`
fn fence_fd_dup(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = fence_handle_type_transference(config.handle);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let fd = export_fence(context, &env, config, *fence_a, false, true)?;
    pass_if_minus_one!(fd);

    let mut new_fd = fd.try_clone()?;
    let fence_b = create_and_import_fence(
        env.device,
        config.handle,
        &mut new_fd,
        fence_import_flags(config.permanence),
    )?;
    if transference == Transference::Copy {
        wait_for_fence(&env, *fence_b)?;
    } else {
        submit_empty_signal_fence(&env, *fence_a)?;
        wait_for_fence(&env, *fence_b)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

/// What `testFenceFdDup2` and `testFenceFdDup3` share.
fn fence_fd_dup_over(
    context: &Context<'_>,
    config: FenceConfig,
    dup: &dyn Fn(RawFd, RawFd) -> i32,
    name: &str,
) -> TestOutcome {
    let env = Env::new(context);
    let transference = fence_handle_type_transference(config.handle);
    let fence_a = create_exportable_fence(env.device, config.handle)?;
    let fence_b = create_exportable_fence(env.device, config.handle)?;

    let fd = export_fence(context, &env, config, *fence_a, false, true)?;
    let mut second_fd = export_fence(context, &env, config, *fence_b, false, true)?;
    if fd.is_minus_one() || second_fd.is_minus_one() {
        return Ok(TestStatus::pass(MINUS_ONE_PASS));
    }

    let new_fd = dup(fd.fd(), second_fd.fd());
    if new_fd < 0 {
        log::info!("{name}() failed: '{}'", std::io::Error::last_os_error());
        return Ok(TestStatus::fail(format!("Failed to call {name}() for fences fd")));
    }

    let fence_c = create_and_import_fence(
        env.device,
        config.handle,
        &mut second_fd,
        fence_import_flags(config.permanence),
    )?;
    if transference == Transference::Copy {
        wait_for_fence(&env, *fence_c)?;
    } else {
        submit_empty_signal_fence(&env, *fence_a)?;
        wait_for_fence(&env, *fence_c)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

fn fence_fd_dup2(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    fence_fd_dup_over(context, config, &|old, new| unsafe { dup2(old, new) }, "dup2")
}

fn fence_fd_dup3(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    fence_fd_dup_over(context, config, &|old, new| unsafe { dup3(old, new, 0) }, "dup3")
}

/// `testFenceFdSendOverSocket`
fn fence_fd_send_over_socket(context: &Context<'_>, config: FenceConfig) -> TestOutcome {
    let env = Env::new(context);
    let transference = fence_handle_type_transference(config.handle);
    let fence = create_exportable_fence(env.device, config.handle)?;
    let fd = export_fence(context, &env, config, *fence, false, true)?;
    pass_if_minus_one!(fd);

    let mut new_fd = send_fd_over_socket(&fd)?;
    let new_fence = create_and_import_fence(
        env.device,
        config.handle,
        &mut new_fd,
        fence_import_flags(config.permanence),
    )?;
    if transference == Transference::Copy {
        wait_for_fence(&env, *new_fence)?;
    } else {
        submit_empty_signal_fence(&env, *new_fence)?;
        wait_for_fence(&env, *new_fence)?;
    }
    env.wait_idle()?;
    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------
// Memory, buffers and images
// ---------------------------------------------------------------------------------

/// `genTestData`
fn gen_test_data(seed: u32, size: usize) -> Vec<u8> {
    let mut rng = Random::new(seed);
    (0..size).map(|_| rng.get_uint8()).collect()
}

/// `writeHostMemory`
fn write_host_memory(device: &Device, memory: vk::DeviceMemory, data: &[u8]) -> Result<(), TestError> {
    let ptr = unsafe { device.map_memory(memory, 0, data.len() as vk::DeviceSize, vk::MemoryMapFlags::empty()) }
        .vk_check("vkMapMemory")?;
    unsafe { std::ptr::copy_nonoverlapping(data.as_ptr(), ptr.cast::<u8>(), data.len()) };
    let range = vk::MappedMemoryRange::builder()
        .memory(memory)
        .offset(0)
        .size(vk::WHOLE_SIZE);
    let flushed = unsafe { device.flush_mapped_memory_ranges(&[range]) }.vk_check("vkFlushMappedMemoryRanges");
    unsafe { device.unmap_memory(memory) };
    flushed
}

/// `checkHostMemory`
fn check_host_memory(device: &Device, memory: vk::DeviceMemory, data: &[u8]) -> Result<(), TestError> {
    let ptr = unsafe { device.map_memory(memory, 0, data.len() as vk::DeviceSize, vk::MemoryMapFlags::empty()) }
        .vk_check("vkMapMemory")?;
    let range = vk::MappedMemoryRange::builder()
        .memory(memory)
        .offset(0)
        .size(vk::WHOLE_SIZE);
    let invalidated =
        unsafe { device.invalidate_mapped_memory_ranges(&[range]) }.vk_check("vkInvalidateMappedMemoryRanges");
    let matches = invalidated.map(|()| unsafe { std::slice::from_raw_parts(ptr.cast::<u8>(), data.len()) } == data);
    unsafe { device.unmap_memory(memory) };
    if matches? {
        Ok(())
    } else {
        Err(TestError::Fail("Memory contents don't match".to_string()))
    }
}

/// `getExportedMemoryTypeIndex`
fn get_exported_memory_type_index(
    context: &Context<'_>,
    host_visible: bool,
    memory_bits: u32,
) -> Result<u32, TestError> {
    if host_visible {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_memory_properties(context.get_physical_device())
        };
        choose_host_visible_memory_type(memory_bits, &properties)
    } else {
        Ok(choose_memory_type(memory_bits))
    }
}

fn transfer_usage() -> vk::BufferUsageFlags {
    vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST
}
const BUFFER_SIZE: vk::DeviceSize = 1024;

/// The buffer that only supplies requirements, and the exportable memory allocated from them, which every memory test starts from.
struct ExportedMemory<'a> {
    requirements: vk::MemoryRequirements,
    memory_type_index: u32,
    memory: Unique<'a, vk::DeviceMemory>,
    buffer: Unique<'a, vk::Buffer>,
}

fn export_memory<'a>(
    context: &Context<'_>,
    env: &Env<'a>,
    config: MemoryConfig,
) -> Result<ExportedMemory<'a>, TestError> {
    let buffer = create_external_buffer(
        env.device,
        env.queue_family_index,
        config.handle,
        BUFFER_SIZE,
        vk::BufferCreateFlags::empty(),
        transfer_usage(),
    )?;
    let requirements = unsafe { env.device.get_buffer_memory_requirements(*buffer) };
    let memory_type_index =
        get_exported_memory_type_index(context, config.host_visible, requirements.memory_type_bits)?;
    let dedicated_to = if config.dedicated {
        DedicatedTo::Buffer(*buffer)
    } else {
        DedicatedTo::None
    };
    let memory = allocate_exportable_memory(
        env.device,
        requirements.size,
        memory_type_index,
        config.handle,
        dedicated_to,
    )?;
    Ok(ExportedMemory {
        requirements,
        memory_type_index,
        memory,
        buffer,
    })
}

fn import_memory_for_buffer<'a>(
    env: &Env<'a>,
    config: MemoryConfig,
    exported: &ExportedMemory<'_>,
    buffer: vk::Buffer,
    handle: &mut NativeHandle,
) -> Result<Unique<'a, vk::DeviceMemory>, TestError> {
    let dedicated_to = if config.dedicated {
        DedicatedTo::Buffer(buffer)
    } else {
        DedicatedTo::None
    };
    import_memory(
        env.device,
        &exported.requirements,
        config.handle,
        exported.memory_type_index,
        handle,
        dedicated_to,
    )
}

fn new_external_buffer<'a>(
    env: &Env<'a>,
    handle: vk::ExternalMemoryHandleTypeFlags,
) -> Result<Unique<'a, vk::Buffer>, TestError> {
    create_external_buffer(
        env.device,
        env.queue_family_index,
        handle,
        BUFFER_SIZE,
        vk::BufferCreateFlags::empty(),
        transfer_usage(),
    )
}

/// `testMemoryImportTwice`
fn memory_import_twice(context: &Context<'_>, config: MemoryConfig) -> TestOutcome {
    const SEED: u32 = 1261033864;
    let env = Env::new(context);
    let test_data = gen_test_data(SEED, BUFFER_SIZE as usize);
    let exported = export_memory(context, &env, config)?;

    if config.host_visible {
        write_host_memory(env.device, *exported.memory, &test_data)?;
    }
    let mut handle_a = get_memory_native(env.device, *exported.memory, config.handle)?;

    let buffer_a = new_external_buffer(&env, config.handle)?;
    let buffer_b = new_external_buffer(&env, config.handle)?;
    let mut handle_b = handle_a.try_clone()?;
    let memory_a = import_memory_for_buffer(&env, config, &exported, *buffer_a, &mut handle_a)?;
    let memory_b = import_memory_for_buffer(&env, config, &exported, *buffer_b, &mut handle_b)?;

    if config.host_visible {
        let test_data_a = gen_test_data(SEED ^ 124798807, BUFFER_SIZE as usize);
        let test_data_b = gen_test_data(SEED ^ 970834278, BUFFER_SIZE as usize);
        check_host_memory(env.device, *memory_a, &test_data)?;
        check_host_memory(env.device, *memory_b, &test_data)?;
        write_host_memory(env.device, *memory_a, &test_data_a)?;
        write_host_memory(env.device, *memory_b, &test_data_b)?;
        check_host_memory(env.device, *memory_a, &test_data_b)?;
        check_host_memory(env.device, *exported.memory, &test_data_b)?;
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testMemoryMultipleImports`
fn memory_multiple_imports(context: &Context<'_>, config: MemoryConfig) -> TestOutcome {
    const COUNT: usize = 4 * 1024;
    let env = Env::new(context);
    let exported = export_memory(context, &env, config)?;
    let handle_a = get_memory_native(env.device, *exported.memory, config.handle)?;

    for _ in 0..COUNT {
        let buffer_b = new_external_buffer(&env, config.handle)?;
        let mut handle_b = handle_a.try_clone()?;
        let _memory_b = import_memory_for_buffer(&env, config, &exported, *buffer_b, &mut handle_b)?;
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testMemoryMultipleExports`
fn memory_multiple_exports(context: &Context<'_>, config: MemoryConfig) -> TestOutcome {
    const COUNT: usize = 4 * 1024;
    let env = Env::new(context);
    let exported = export_memory(context, &env, config)?;

    for _ in 0..COUNT {
        let _handle = get_memory_native(env.device, *exported.memory, config.handle)?;
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testMemoryFdProperties`
fn memory_fd_properties(context: &Context<'_>, config: MemoryConfig) -> TestOutcome {
    let env = Env::new(context);
    let exported = export_memory(context, &env, config)?;
    let handle = get_memory_native(env.device, *exported.memory, config.handle)?;

    let mut properties = vk::MemoryFdPropertiesKHR::default();
    match unsafe {
        env.device
            .get_memory_fd_properties_khr(config.handle, handle.fd(), &mut properties)
    } {
        Ok(_) => Ok(TestStatus::pass("Pass")),
        Err(error) => Ok(TestStatus::fail(format!(
            "vkGetMemoryFdPropertiesKHR failed for {}: {error}",
            external_memory_type_name(config.handle)
        ))),
    }
}

/// What `testMemoryFdDup`, `testMemoryFdDup2` and `testMemoryFdDup3` share: a second descriptor of the exported memory is imported,
/// and what the original memory holds is seen through the import and the other way round.
fn memory_fd_dup_over(
    context: &Context<'_>,
    config: MemoryConfig,
    seed: u32,
    second_seed_xor: u32,
    duplicate: &dyn Fn(NativeHandle, NativeHandle) -> Result<NativeHandle, TestError>,
) -> TestOutcome {
    let env = Env::new(context);
    let test_data = gen_test_data(seed, BUFFER_SIZE as usize);
    let exported = export_memory(context, &env, config)?;

    if config.host_visible {
        write_host_memory(env.device, *exported.memory, &test_data)?;
    }

    let fd = NativeHandle::from_fd(get_memory_fd(env.device, *exported.memory, config.handle)?);
    let second_fd = NativeHandle::from_fd(get_memory_fd(env.device, *exported.memory, config.handle)?);
    let mut new_fd = duplicate(fd, second_fd)?;

    let new_buffer = new_external_buffer(&env, config.handle)?;
    let new_memory = import_memory_for_buffer(&env, config, &exported, *new_buffer, &mut new_fd)?;
    if config.host_visible {
        let test_data_a = gen_test_data(seed ^ second_seed_xor, BUFFER_SIZE as usize);
        check_host_memory(env.device, *new_memory, &test_data)?;
        write_host_memory(env.device, *new_memory, &test_data_a)?;
        check_host_memory(env.device, *exported.memory, &test_data_a)?;
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testMemoryFdDup`
fn memory_fd_dup(context: &Context<'_>, config: MemoryConfig) -> TestOutcome {
    memory_fd_dup_over(context, config, 851493858, 672929437, &|fd, _unused| {
        fd.try_clone().inspect_err(|error| log::info!("dup() failed: {error}"))
    })
}

/// `testMemoryFdDup2`
fn memory_fd_dup2(context: &Context<'_>, config: MemoryConfig) -> TestOutcome {
    memory_fd_dup_over(context, config, 224466865, 99012346, &|fd, second_fd| {
        if unsafe { dup2(fd.fd(), second_fd.fd()) } < 0 {
            log::info!("dup2() failed: '{}'", std::io::Error::last_os_error());
            return Err(TestError::Fail("Failed to call dup2() for memorys fd".to_string()));
        }
        Ok(second_fd)
    })
}

/// `testMemoryFdDup3`
fn memory_fd_dup3(context: &Context<'_>, config: MemoryConfig) -> TestOutcome {
    memory_fd_dup_over(context, config, 2554088961, 4210342378, &|fd, second_fd| {
        if unsafe { dup3(fd.fd(), second_fd.fd(), 0) } < 0 {
            log::info!("dup3() failed: '{}'", std::io::Error::last_os_error());
            return Err(TestError::Fail("Failed to call dup3() for memorys fd".to_string()));
        }
        Ok(second_fd)
    })
}

/// `testMemoryFdSendOverSocket`
fn memory_fd_send_over_socket(context: &Context<'_>, config: MemoryConfig) -> TestOutcome {
    memory_fd_dup_over(context, config, 3403586456, 23478978, &|fd, _unused| {
        send_fd_over_socket(&fd)
    })
}

/// `testMemoryZeroHandleType`: an export info with no handle types is the same as none.
fn memory_zero_handle_type(context: &Context<'_>) -> TestOutcome {
    const SEED: u32 = 1261033864;
    let env = Env::new(context);
    let test_data = gen_test_data(SEED, BUFFER_SIZE as usize);

    let properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };
    let compatible_mem_types = (0..properties.memory_type_count)
        .filter(|&index| {
            properties.memory_types[index as usize]
                .property_flags
                .contains(vk::MemoryPropertyFlags::HOST_VISIBLE)
        })
        .fold(0u32, |mask, index| mask | (1 << index));

    // Only allocated to get memory requirements.
    let buffer = create_external_buffer(
        env.device,
        env.queue_family_index,
        vk::ExternalMemoryHandleTypeFlags::empty(),
        BUFFER_SIZE,
        vk::BufferCreateFlags::empty(),
        transfer_usage(),
    )?;
    let requirements = unsafe { env.device.get_buffer_memory_requirements(*buffer) };

    let mut export_info = vk::ExportMemoryAllocateInfo::default();
    let memory_type_index = (requirements.memory_type_bits & compatible_mem_types).trailing_zeros();
    let info = vk::MemoryAllocateInfo::builder()
        .allocation_size(requirements.size)
        .memory_type_index(memory_type_index)
        .push_next(&mut export_info);
    let memory = Unique::new(
        env.device,
        unsafe { env.device.allocate_memory(&info, None) }.vk_check("vkAllocateMemory")?,
    );

    write_host_memory(env.device, *memory, &test_data)?;
    check_host_memory(env.device, *memory, &test_data)?;
    Ok(TestStatus::pass("Pass"))
}

/// Which of the three orders `testBuffer...` and `testImage...` bind, export and import in.
#[derive(Clone, Copy, PartialEq, Eq)]
enum BindOrder {
    BindExportImportBind,
    ExportBindImportBind,
    ExportImportBindBind,
}

fn buffer_bind_export_import(context: &Context<'_>, config: BufferConfig, order: BindOrder) -> TestOutcome {
    let env = Env::new(context);
    let buffer_a = new_external_buffer(&env, config.handle)?;
    let requirements = unsafe { env.device.get_buffer_memory_requirements(*buffer_a) };
    let exported_memory_type_index = choose_memory_type(requirements.memory_type_bits);
    let dedicated_to = if config.dedicated {
        DedicatedTo::Buffer(*buffer_a)
    } else {
        DedicatedTo::None
    };
    let memory_a = allocate_exportable_memory(
        env.device,
        requirements.size,
        exported_memory_type_index,
        config.handle,
        dedicated_to,
    )?;

    let bind = |buffer: vk::Buffer, memory: vk::DeviceMemory| {
        unsafe { env.device.bind_buffer_memory(buffer, memory, 0) }.vk_check("vkBindBufferMemory")
    };
    let mut handle = match order {
        BindOrder::BindExportImportBind => {
            bind(*buffer_a, *memory_a)?;
            get_memory_native(env.device, *memory_a, config.handle)?
        }
        BindOrder::ExportBindImportBind => {
            let handle = get_memory_native(env.device, *memory_a, config.handle)?;
            bind(*buffer_a, *memory_a)?;
            handle
        }
        BindOrder::ExportImportBindBind => get_memory_native(env.device, *memory_a, config.handle)?,
    };

    let buffer_b = new_external_buffer(&env, config.handle)?;
    let dedicated_to = if config.dedicated {
        DedicatedTo::Buffer(*buffer_b)
    } else {
        DedicatedTo::None
    };
    let memory_b = import_memory(
        env.device,
        &requirements,
        config.handle,
        exported_memory_type_index,
        &mut handle,
        dedicated_to,
    )?;
    if order == BindOrder::ExportImportBindBind {
        bind(*buffer_a, *memory_a)?;
    }
    bind(*buffer_b, *memory_b)?;
    Ok(TestStatus::pass("Pass"))
}

fn buffer_bind_export_import_bind(context: &Context<'_>, config: BufferConfig) -> TestOutcome {
    buffer_bind_export_import(context, config, BindOrder::BindExportImportBind)
}

fn buffer_export_bind_import_bind(context: &Context<'_>, config: BufferConfig) -> TestOutcome {
    buffer_bind_export_import(context, config, BindOrder::ExportBindImportBind)
}

fn buffer_export_import_bind_bind(context: &Context<'_>, config: BufferConfig) -> TestOutcome {
    buffer_bind_export_import(context, config, BindOrder::ExportImportBindBind)
}

fn image_usage(handle: vk::ExternalMemoryHandleTypeFlags) -> vk::ImageUsageFlags {
    let sampled = if handle == vk::ExternalMemoryHandleTypeFlags::ANDROID_HARDWARE_BUFFER_ANDROID {
        vk::ImageUsageFlags::SAMPLED
    } else {
        vk::ImageUsageFlags::empty()
    };
    vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | sampled
}

fn image_bind_export_import(context: &Context<'_>, config: ImageConfig, order: BindOrder) -> TestOutcome {
    const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
    const WIDTH: u32 = 64;
    const HEIGHT: u32 = 64;
    let env = Env::new(context);
    let usage = image_usage(config.handle);
    let is_ahb = config.handle == vk::ExternalMemoryHandleTypeFlags::ANDROID_HARDWARE_BUFFER_ANDROID;

    let image_a = create_external_image(
        env.device,
        env.queue_family_index,
        config.handle,
        FORMAT,
        WIDTH,
        HEIGHT,
        config.tiling,
        vk::ImageCreateFlags::empty(),
        usage,
        1,
        1,
    )?;
    let requirements = if is_ahb {
        vk::MemoryRequirements::default()
    } else {
        unsafe { env.device.get_image_memory_requirements(*image_a) }
    };
    let exported_memory_type_index = choose_memory_type(requirements.memory_type_bits);
    let dedicated_to = if config.dedicated {
        DedicatedTo::Image(*image_a)
    } else {
        DedicatedTo::None
    };
    let memory_a = allocate_exportable_memory(
        env.device,
        requirements.size,
        exported_memory_type_index,
        config.handle,
        dedicated_to,
    )?;

    let bind = |image: vk::Image, memory: vk::DeviceMemory| {
        unsafe { env.device.bind_image_memory(image, memory, 0) }.vk_check("vkBindImageMemory")
    };
    let mut handle = match order {
        BindOrder::BindExportImportBind => {
            bind(*image_a, *memory_a)?;
            get_memory_native(env.device, *memory_a, config.handle)?
        }
        BindOrder::ExportBindImportBind if is_ahb && config.dedicated => {
            // An Android hardware buffer needs the image memory bound first.
            bind(*image_a, *memory_a)?;
            get_memory_native(env.device, *memory_a, config.handle)?
        }
        BindOrder::ExportBindImportBind => {
            let handle = get_memory_native(env.device, *memory_a, config.handle)?;
            bind(*image_a, *memory_a)?;
            handle
        }
        BindOrder::ExportImportBindBind => get_memory_native(env.device, *memory_a, config.handle)?,
    };

    let image_b = create_external_image(
        env.device,
        env.queue_family_index,
        config.handle,
        FORMAT,
        WIDTH,
        HEIGHT,
        config.tiling,
        vk::ImageCreateFlags::empty(),
        usage,
        1,
        1,
    )?;
    let idx = if is_ahb { u32::MAX } else { exported_memory_type_index };
    let dedicated_to = if config.dedicated {
        DedicatedTo::Image(*image_b)
    } else {
        DedicatedTo::None
    };
    let memory_b = import_memory(env.device, &requirements, config.handle, idx, &mut handle, dedicated_to)?;
    if order == BindOrder::ExportImportBindBind {
        bind(*image_a, *memory_a)?;
    }
    bind(*image_b, *memory_b)?;
    Ok(TestStatus::pass("Pass"))
}

fn image_bind_export_import_bind(context: &Context<'_>, config: ImageConfig) -> TestOutcome {
    image_bind_export_import(context, config, BindOrder::BindExportImportBind)
}

fn image_export_bind_import_bind(context: &Context<'_>, config: ImageConfig) -> TestOutcome {
    image_bind_export_import(context, config, BindOrder::ExportBindImportBind)
}

fn image_export_import_bind_bind(context: &Context<'_>, config: ImageConfig) -> TestOutcome {
    image_bind_export_import(context, config, BindOrder::ExportImportBindBind)
}

/// `getMemoryDedicatedRequirements` for a buffer.
fn buffer_requires_dedicated(device: &Device, buffer: vk::Buffer) -> bool {
    let info = vk::BufferMemoryRequirementsInfo2::builder().buffer(buffer);
    let mut dedicated = vk::MemoryDedicatedRequirements::default();
    {
        let mut requirements = vk::MemoryRequirements2::builder().push_next(&mut dedicated);
        unsafe { device.get_buffer_memory_requirements2(&info, &mut requirements) };
    }
    dedicated.requires_dedicated_allocation != vk::FALSE
}

/// `getMemoryDedicatedRequirements` for an image.
fn image_requires_dedicated(device: &Device, image: vk::Image) -> bool {
    let info = vk::ImageMemoryRequirementsInfo2::builder().image(image);
    let mut dedicated = vk::MemoryDedicatedRequirements::default();
    {
        let mut requirements = vk::MemoryRequirements2::builder().push_next(&mut dedicated);
        unsafe { device.get_image_memory_requirements2(&info, &mut requirements) };
    }
    dedicated.requires_dedicated_allocation != vk::FALSE
}

/// `testBufferQueries`
fn buffer_queries(context: &Context<'_>, handle: vk::ExternalMemoryHandleTypeFlags) -> TestOutcome {
    let create_flags = [
        vk::BufferCreateFlags::empty(),
        vk::BufferCreateFlags::SPARSE_BINDING,
        vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_RESIDENCY,
        vk::BufferCreateFlags::SPARSE_BINDING | vk::BufferCreateFlags::SPARSE_ALIASED,
    ];
    let usage_flags = [
        vk::BufferUsageFlags::TRANSFER_SRC,
        vk::BufferUsageFlags::TRANSFER_DST,
        vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER,
        vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER,
        vk::BufferUsageFlags::UNIFORM_BUFFER,
        vk::BufferUsageFlags::STORAGE_BUFFER,
        vk::BufferUsageFlags::INDEX_BUFFER,
        vk::BufferUsageFlags::VERTEX_BUFFER,
        vk::BufferUsageFlags::INDIRECT_BUFFER,
    ];
    let env = Env::new(context);
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let features = context.get_device_features();

    // Upstream creates its device lazily, and with the dedicated allocation extensions only once a handle type needs them.
    let mut device_created = false;
    let mut device_has_dedicated = false;

    for create_flag in create_flags {
        for usage_flag in usage_flags {
            if create_flag.contains(vk::BufferCreateFlags::SPARSE_BINDING) && features.sparse_binding == vk::FALSE {
                continue;
            }
            if create_flag.contains(vk::BufferCreateFlags::SPARSE_ALIASED)
                && features.sparse_residency_aliased == vk::FALSE
            {
                continue;
            }
            if create_flag.contains(vk::BufferCreateFlags::SPARSE_RESIDENCY)
                && features.sparse_residency_buffer == vk::FALSE
            {
                continue;
            }

            let info = vk::PhysicalDeviceExternalBufferInfo::builder()
                .flags(create_flag)
                .usage(usage_flag)
                .handle_type(handle);
            let mut properties = vk::ExternalBufferProperties::default();
            unsafe { instance.get_physical_device_external_buffer_properties(physical_device, &info, &mut properties) };
            log::info!("{properties:?}");

            let features2 = properties.external_memory_properties.external_memory_features;
            let requires_dedicated = features2.contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY);
            if features2
                .intersects(vk::ExternalMemoryFeatureFlags::EXPORTABLE | vk::ExternalMemoryFeatureFlags::IMPORTABLE)
                && (!device_created || (requires_dedicated && !device_has_dedicated))
            {
                device_created = true;
                device_has_dedicated = requires_dedicated;
            }

            if features2.contains(vk::ExternalMemoryFeatureFlags::EXPORTABLE) {
                if device_has_dedicated {
                    let buffer = create_external_buffer(
                        env.device,
                        env.queue_family_index,
                        handle,
                        1024,
                        create_flag,
                        usage_flag,
                    )?;
                    if requires_dedicated != buffer_requires_dedicated(env.device, *buffer) {
                        return Ok(TestStatus::fail(
                            "vkGetPhysicalDeviceExternalBufferProperties and vkGetBufferMemoryRequirements2 report different dedicated requirements",
                        ));
                    }
                } else if requires_dedicated {
                    return Ok(TestStatus::fail(
                        "a handle type that requires dedicated allocation was reported to a device without the dedicated allocation extensions",
                    ));
                }
            }
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testBufferQueriesMaintenance5`: the same query with the usage given in a `VkBufferUsageFlags2CreateInfo` instead of the info.
fn buffer_queries_maintenance5(context: &Context<'_>, handle: vk::ExternalMemoryHandleTypeFlags) -> TestOutcome {
    let usage_flags = [
        vk::BufferUsageFlags::TRANSFER_SRC,
        vk::BufferUsageFlags::TRANSFER_DST,
        vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER,
        vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER,
        vk::BufferUsageFlags::UNIFORM_BUFFER,
        vk::BufferUsageFlags::STORAGE_BUFFER,
        vk::BufferUsageFlags::INDEX_BUFFER,
        vk::BufferUsageFlags::VERTEX_BUFFER,
        vk::BufferUsageFlags::INDIRECT_BUFFER,
    ];
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    for usage_flag in usage_flags {
        let info1 = vk::PhysicalDeviceExternalBufferInfo::builder()
            .usage(usage_flag)
            .handle_type(handle);
        let mut properties1 = vk::ExternalBufferProperties::default();
        unsafe { instance.get_physical_device_external_buffer_properties(physical_device, &info1, &mut properties1) };

        let mut usage_flags2 = vk::BufferUsageFlags2CreateInfo::builder()
            .usage(vk::BufferUsageFlags2::from_bits_truncate(u64::from(usage_flag.bits())));
        let info2 = vk::PhysicalDeviceExternalBufferInfo::builder()
            .usage(vk::BufferUsageFlags::empty())
            .handle_type(handle)
            .push_next(&mut usage_flags2);
        let mut properties2 = vk::ExternalBufferProperties::default();
        unsafe { instance.get_physical_device_external_buffer_properties(physical_device, &info2, &mut properties2) };

        let (p1, p2) = (
            properties1.external_memory_properties,
            properties2.external_memory_properties,
        );
        if p1.external_memory_features != p2.external_memory_features
            || p1.export_from_imported_handle_types != p2.export_from_imported_handle_types
            || p1.compatible_handle_types != p2.compatible_handle_types
        {
            // Upstream reports this as a pass with a message of "Fail".
            return Ok(TestStatus::pass(format!("Fail ({})", usage_flag.bits())));
        }
    }
    Ok(TestStatus::pass("Pass"))
}

/// `testImageQueries`
fn image_queries(context: &Context<'_>, handle: vk::ExternalMemoryHandleTypeFlags) -> TestOutcome {
    let create_flags = [
        vk::ImageCreateFlags::empty(),
        vk::ImageCreateFlags::SPARSE_BINDING,
        vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_RESIDENCY,
        vk::ImageCreateFlags::SPARSE_BINDING | vk::ImageCreateFlags::SPARSE_ALIASED,
        vk::ImageCreateFlags::MUTABLE_FORMAT,
        vk::ImageCreateFlags::CUBE_COMPATIBLE,
    ];
    let usage_flags = [
        vk::ImageUsageFlags::TRANSFER_SRC,
        vk::ImageUsageFlags::TRANSFER_DST,
        vk::ImageUsageFlags::SAMPLED,
        vk::ImageUsageFlags::STORAGE,
        vk::ImageUsageFlags::COLOR_ATTACHMENT,
        vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
        vk::ImageUsageFlags::TRANSIENT_ATTACHMENT | vk::ImageUsageFlags::COLOR_ATTACHMENT,
        vk::ImageUsageFlags::TRANSIENT_ATTACHMENT | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
        vk::ImageUsageFlags::TRANSIENT_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT,
        vk::ImageUsageFlags::INPUT_ATTACHMENT,
    ];
    let env = Env::new(context);
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    let features = context.get_device_features();

    let mut device_created = false;
    let mut device_has_dedicated = false;

    for create_flag in create_flags {
        for usage_flag in usage_flags {
            let format = if usage_flag.contains(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT) {
                vk::Format::D16_UNORM
            } else {
                vk::Format::R8G8B8A8_UNORM
            };
            let tiling = vk::ImageTiling::OPTIMAL;

            if create_flag.contains(vk::ImageCreateFlags::SPARSE_BINDING) && features.sparse_binding == vk::FALSE {
                continue;
            }
            if create_flag.contains(vk::ImageCreateFlags::SPARSE_RESIDENCY)
                && features.sparse_residency_image_2d == vk::FALSE
            {
                continue;
            }
            if create_flag.contains(vk::ImageCreateFlags::SPARSE_ALIASED)
                && features.sparse_residency_aliased == vk::FALSE
            {
                continue;
            }

            let mut external_info = vk::PhysicalDeviceExternalImageFormatInfo::builder().handle_type(handle);
            let info = vk::PhysicalDeviceImageFormatInfo2::builder()
                .push_next(&mut external_info)
                .format(format)
                .type_(vk::ImageType::_2D)
                .tiling(tiling)
                .usage(usage_flag)
                .flags(create_flag);
            let mut external_properties = vk::ExternalImageFormatProperties::default();
            let result = {
                let mut properties = vk::ImageFormatProperties2::builder().push_next(&mut external_properties);
                unsafe {
                    instance.get_physical_device_image_format_properties2(physical_device, &info, &mut properties)
                }
            };
            match result {
                Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => continue,
                other => other.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
            }
            log::info!("{external_properties:?}");

            let features2 = external_properties.external_memory_properties.external_memory_features;
            let requires_dedicated = features2.contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY);
            if features2
                .intersects(vk::ExternalMemoryFeatureFlags::EXPORTABLE | vk::ExternalMemoryFeatureFlags::IMPORTABLE)
                && (!device_created || (requires_dedicated && !device_has_dedicated))
            {
                device_created = true;
                device_has_dedicated = requires_dedicated;
            }

            if features2.contains(vk::ExternalMemoryFeatureFlags::EXPORTABLE) {
                if device_has_dedicated {
                    // Memory requirements cannot be queried without binding the image.
                    if handle == vk::ExternalMemoryHandleTypeFlags::ANDROID_HARDWARE_BUFFER_ANDROID {
                        continue;
                    }
                    let image = create_external_image(
                        env.device,
                        env.queue_family_index,
                        handle,
                        format,
                        16,
                        16,
                        tiling,
                        create_flag,
                        usage_flag,
                        1,
                        1,
                    )?;
                    if requires_dedicated != image_requires_dedicated(env.device, *image) {
                        return Ok(TestStatus::fail(
                            "vkGetPhysicalDeviceExternalBufferProperties and vkGetBufferMemoryRequirements2 report different dedicated requirements",
                        ));
                    }
                } else if requires_dedicated {
                    return Ok(TestStatus::fail(
                        "a handle type that requires dedicated allocation was reported to a device without the dedicated allocation extensions",
                    ));
                }
            }
        }
    }
    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------
// checkSupport
// ---------------------------------------------------------------------------------

/// What a case exports, which is what its extension and capability checks are about.
#[derive(Clone, Copy)]
enum Subject {
    Semaphore(vk::ExternalSemaphoreHandleTypeFlags),
    Fence(vk::ExternalFenceHandleTypeFlags),
    Buffer {
        handle: vk::ExternalMemoryHandleTypeFlags,
        dedicated: bool,
    },
    Image {
        handle: vk::ExternalMemoryHandleTypeFlags,
        tiling: vk::ImageTiling,
        dedicated: bool,
    },
}

/// The variants of upstream's `checkSupport*` functions.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Support {
    Common,
    WithEvent,
    WithTransference,
    WithPlatformLimit,
    WithWin32Limit,
    WithAhb,
    Nothing,
}

/// `getDeviceExtensions` for a semaphore handle type.
fn require_semaphore_extensions(
    context: &Context<'_>,
    handle: vk::ExternalSemaphoreHandleTypeFlags,
) -> Result<(), TestError> {
    let mut uses_external_semaphore = false;
    if handle == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD
        || handle == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD
    {
        context.require_device_functionality("VK_KHR_external_semaphore_fd")?;
        uses_external_semaphore = true;
    }
    if handle == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32
        || handle == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32_KMT
    {
        context.require_device_functionality("VK_KHR_external_semaphore_win32")?;
        uses_external_semaphore = true;
    }
    if handle == vk::ExternalSemaphoreHandleTypeFlags::ZIRCON_EVENT_FUCHSIA {
        context.require_device_functionality("VK_FUCHSIA_external_semaphore")?;
    }
    if uses_external_semaphore {
        context.require_device_functionality("VK_KHR_external_semaphore")?;
    }
    Ok(())
}

/// `getDeviceExtensions` for a fence handle type.
fn require_fence_extensions(context: &Context<'_>, handle: vk::ExternalFenceHandleTypeFlags) -> Result<(), TestError> {
    let mut uses_external_fence = false;
    if handle == vk::ExternalFenceHandleTypeFlags::SYNC_FD || handle == vk::ExternalFenceHandleTypeFlags::OPAQUE_FD {
        context.require_device_functionality("VK_KHR_external_fence_fd")?;
        uses_external_fence = true;
    }
    if handle == vk::ExternalFenceHandleTypeFlags::OPAQUE_WIN32
        || handle == vk::ExternalFenceHandleTypeFlags::OPAQUE_WIN32_KMT
    {
        context.require_device_functionality("VK_KHR_external_fence_win32")?;
        uses_external_fence = true;
    }
    if uses_external_fence {
        context.require_device_functionality("VK_KHR_external_fence")?;
    }
    Ok(())
}

/// `getDeviceExtensions` for a memory handle type.
fn require_memory_extensions(
    context: &Context<'_>,
    handle: vk::ExternalMemoryHandleTypeFlags,
) -> Result<(), TestError> {
    let mut uses_external_memory = false;
    if handle == vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD
        || handle == vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT
    {
        context.require_device_functionality("VK_KHR_external_memory_fd")?;
        uses_external_memory = true;
    }
    if handle == vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT {
        context.require_device_functionality("VK_EXT_external_memory_dma_buf")?;
    }
    if handle == vk::ExternalMemoryHandleTypeFlags::ZIRCON_VMO_FUCHSIA {
        context.require_device_functionality("VK_FUCHSIA_external_memory")?;
    }
    let win32 = vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32
        | vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32_KMT
        | vk::ExternalMemoryHandleTypeFlags::D3D11_TEXTURE
        | vk::ExternalMemoryHandleTypeFlags::D3D11_TEXTURE_KMT
        | vk::ExternalMemoryHandleTypeFlags::D3D12_HEAP
        | vk::ExternalMemoryHandleTypeFlags::D3D12_RESOURCE;
    if handle.intersects(win32) {
        context.require_device_functionality("VK_KHR_external_memory_win32")?;
        uses_external_memory = true;
    }
    if handle == vk::ExternalMemoryHandleTypeFlags::ANDROID_HARDWARE_BUFFER_ANDROID {
        context.require_device_functionality("VK_ANDROID_external_memory_android_hardware_buffer")?;
        context.require_device_functionality("VK_KHR_sampler_ycbcr_conversion")?;
        context.require_device_functionality("VK_EXT_queue_family_foreign")?;
        uses_external_memory = true;
    }
    if handle == vk::ExternalMemoryHandleTypeFlags::MTLBUFFER_EXT
        || handle == vk::ExternalMemoryHandleTypeFlags::MTLTEXTURE_EXT
    {
        context.require_device_functionality("VK_EXT_external_memory_metal")?;
        uses_external_memory = true;
    }
    if uses_external_memory {
        context.require_device_functionality("VK_KHR_external_memory")?;
    }
    Ok(())
}

/// `checkSemaphoreSupport`
fn check_semaphore_support(
    context: &Context<'_>,
    handle: vk::ExternalSemaphoreHandleTypeFlags,
) -> Result<(), TestError> {
    let info = vk::PhysicalDeviceExternalSemaphoreInfo::builder().handle_type(handle);
    let mut properties = vk::ExternalSemaphoreProperties::default();
    unsafe {
        context
            .get_instance()
            .get_physical_device_external_semaphore_properties(context.get_physical_device(), &info, &mut properties)
    };
    if !properties
        .external_semaphore_features
        .contains(vk::ExternalSemaphoreFeatureFlags::EXPORTABLE)
    {
        return Err(TestError::NotSupported(
            "Semaphore doesn't support exporting in external type".to_string(),
        ));
    }
    if !properties
        .external_semaphore_features
        .contains(vk::ExternalSemaphoreFeatureFlags::IMPORTABLE)
    {
        return Err(TestError::NotSupported(
            "Semaphore doesn't support importing in external type".to_string(),
        ));
    }
    Ok(())
}

/// `checkFenceSupport`
fn check_fence_support(context: &Context<'_>, handle: vk::ExternalFenceHandleTypeFlags) -> Result<(), TestError> {
    let info = vk::PhysicalDeviceExternalFenceInfo::builder().handle_type(handle);
    let mut properties = vk::ExternalFenceProperties::default();
    unsafe {
        context.get_instance().get_physical_device_external_fence_properties(
            context.get_physical_device(),
            &info,
            &mut properties,
        )
    };
    if !properties
        .external_fence_features
        .contains(vk::ExternalFenceFeatureFlags::EXPORTABLE)
    {
        return Err(TestError::NotSupported(
            "Fence doesn't support exporting in external type".to_string(),
        ));
    }
    if !properties
        .external_fence_features
        .contains(vk::ExternalFenceFeatureFlags::IMPORTABLE)
    {
        return Err(TestError::NotSupported(
            "Fence doesn't support importing in external type".to_string(),
        ));
    }
    Ok(())
}

/// `checkBufferSupport`
fn check_buffer_support(
    context: &Context<'_>,
    handle: vk::ExternalMemoryHandleTypeFlags,
    usage: vk::BufferUsageFlags,
    dedicated: bool,
) -> Result<(), TestError> {
    let info = vk::PhysicalDeviceExternalBufferInfo::builder()
        .flags(vk::BufferCreateFlags::empty())
        .usage(usage)
        .handle_type(handle);
    let mut properties = vk::ExternalBufferProperties::default();
    unsafe {
        context.get_instance().get_physical_device_external_buffer_properties(
            context.get_physical_device(),
            &info,
            &mut properties,
        )
    };
    let features = properties.external_memory_properties.external_memory_features;
    if !features.contains(vk::ExternalMemoryFeatureFlags::EXPORTABLE) {
        return Err(TestError::NotSupported(
            "External handle type doesn't support exporting buffer".to_string(),
        ));
    }
    if !features.contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE) {
        return Err(TestError::NotSupported(
            "External handle type doesn't support importing buffer".to_string(),
        ));
    }
    if !dedicated && features.contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY) {
        return Err(TestError::NotSupported(
            "External handle type requires dedicated allocation".to_string(),
        ));
    }
    Ok(())
}

/// `checkImageSupport`
fn check_image_support(
    context: &Context<'_>,
    handle: vk::ExternalMemoryHandleTypeFlags,
    usage: vk::ImageUsageFlags,
    format: vk::Format,
    tiling: vk::ImageTiling,
    dedicated: bool,
) -> Result<(), TestError> {
    let mut external_info = vk::PhysicalDeviceExternalImageFormatInfo::builder().handle_type(handle);
    let info = vk::PhysicalDeviceImageFormatInfo2::builder()
        .push_next(&mut external_info)
        .format(format)
        .type_(vk::ImageType::_2D)
        .tiling(tiling)
        .usage(usage)
        .flags(vk::ImageCreateFlags::empty());
    let mut external_properties = vk::ExternalImageFormatProperties::default();
    {
        let mut properties = vk::ImageFormatProperties2::builder().push_next(&mut external_properties);
        match unsafe {
            context.get_instance().get_physical_device_image_format_properties2(
                context.get_physical_device(),
                &info,
                &mut properties,
            )
        } {
            Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                return Err(TestError::NotSupported(
                    "External handle type doesn't support exporting image".to_string(),
                ));
            }
            other => other.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?,
        }
    }
    let features = external_properties.external_memory_properties.external_memory_features;
    if !features.contains(vk::ExternalMemoryFeatureFlags::EXPORTABLE) {
        return Err(TestError::NotSupported(
            "External handle type doesn't support exporting image".to_string(),
        ));
    }
    if !features.contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE) {
        return Err(TestError::NotSupported(
            "External handle type doesn't support importing image".to_string(),
        ));
    }
    if !dedicated && features.contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY) {
        return Err(TestError::NotSupported(
            "External handle type requires dedicated allocation".to_string(),
        ));
    }
    Ok(())
}

/// `commonCheckSupport`
fn common_check_support(context: &Context<'_>, subject: Subject) -> Result<(), TestError> {
    match subject {
        Subject::Semaphore(handle) => {
            require_semaphore_extensions(context, handle)?;
            check_semaphore_support(context, handle)
        }
        Subject::Fence(handle) => {
            require_fence_extensions(context, handle)?;
            check_fence_support(context, handle)
        }
        Subject::Buffer { handle, dedicated } => {
            require_memory_extensions(context, handle)?;
            check_buffer_support(context, handle, transfer_usage(), dedicated)
        }
        Subject::Image {
            handle,
            tiling,
            dedicated,
        } => {
            require_memory_extensions(context, handle)?;
            check_image_support(
                context,
                handle,
                image_usage(handle),
                vk::Format::R8G8B8A8_UNORM,
                tiling,
                dedicated,
            )
        }
    }
}

/// `checkEvent`: events are optional on a portability subset device.
fn check_event(context: &Context<'_>) -> Result<(), TestError> {
    if context.is_device_functionality_supported("VK_KHR_portability_subset") {
        return Err(TestError::NotSupported(
            "VK_KHR_portability_subset: Events are not supported by this implementation".to_string(),
        ));
    }
    Ok(())
}

fn subject_transference_is_copy(subject: Subject) -> bool {
    match subject {
        Subject::Semaphore(handle) => semaphore_handle_type_transference(handle) == Transference::Copy,
        Subject::Fence(handle) => fence_handle_type_transference(handle) == Transference::Copy,
        Subject::Buffer { .. } | Subject::Image { .. } => false,
    }
}

fn check_support_variant(context: &Context<'_>, support: Support, subject: Subject) -> Result<(), TestError> {
    match support {
        Support::Nothing => Ok(()),
        Support::Common | Support::WithPlatformLimit => common_check_support(context, subject),
        Support::WithEvent => {
            check_event(context)?;
            common_check_support(context, subject)
        }
        Support::WithTransference => {
            if subject_transference_is_copy(subject) {
                check_event(context)?;
            }
            common_check_support(context, subject)
        }
        Support::WithWin32Limit => Err(TestError::NotSupported(
            "Platform doesn't support tested functionality".to_string(),
        )),
        Support::WithAhb => {
            if let Subject::Image {
                handle,
                dedicated: true,
                ..
            } = subject
                && handle == vk::ExternalMemoryHandleTypeFlags::ANDROID_HARDWARE_BUFFER_ANDROID
            {
                // An Android hardware buffer needs the image memory bound first, which this test cannot do.
                return Err(TestError::NotSupported(
                    "Unsupported for Android Hardware Buffer".to_string(),
                ));
            }
            common_check_support(context, subject)
        }
    }
}

// ---------------------------------------------------------------------------------
// The cases
// ---------------------------------------------------------------------------------

type SemaphoreFn = fn(&Context<'_>, SemaphoreConfig) -> TestOutcome;
type FenceFn = fn(&Context<'_>, FenceConfig) -> TestOutcome;
type MemoryFn = fn(&Context<'_>, MemoryConfig) -> TestOutcome;
type BufferFn = fn(&Context<'_>, BufferConfig) -> TestOutcome;
type ImageFn = fn(&Context<'_>, ImageConfig) -> TestOutcome;
type MemoryQueryFn = fn(&Context<'_>, vk::ExternalMemoryHandleTypeFlags) -> TestOutcome;

enum Body {
    SemaphoreQueries {
        semaphore_type: vk::SemaphoreType,
        handle: vk::ExternalSemaphoreHandleTypeFlags,
    },
    Semaphore {
        run: SemaphoreFn,
        config: SemaphoreConfig,
        support: Support,
    },
    FenceQueries {
        handle: vk::ExternalFenceHandleTypeFlags,
    },
    Fence {
        run: FenceFn,
        config: FenceConfig,
        support: Support,
    },
    Memory {
        run: MemoryFn,
        config: MemoryConfig,
        support: Support,
    },
    Buffer {
        run: BufferFn,
        config: BufferConfig,
        support: Support,
    },
    Image {
        run: ImageFn,
        config: ImageConfig,
        support: Support,
    },
    MemoryQueries {
        run: MemoryQueryFn,
        handle: vk::ExternalMemoryHandleTypeFlags,
    },
    MemoryQueriesMaintenance5 {
        run: MemoryQueryFn,
        handle: vk::ExternalMemoryHandleTypeFlags,
    },
    ZeroHandleMemory,
    /// The Android hardware buffer format cases, which need a platform this port has no access to.
    AndroidHardwareBuffer,
}

struct ExternalCase {
    name: String,
    body: Body,
    stub: bool,
}

impl TestCase for ExternalCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match &self.body {
            Body::SemaphoreQueries { semaphore_type, handle } => {
                if *semaphore_type == vk::SemaphoreType::TIMELINE {
                    context.require_device_functionality("VK_KHR_timeline_semaphore")?;
                }
                if *handle == vk::ExternalSemaphoreHandleTypeFlags::ZIRCON_EVENT_FUCHSIA {
                    context.require_device_functionality("VK_FUCHSIA_external_semaphore")?;
                }
                Ok(())
            }
            Body::FenceQueries { .. } | Body::MemoryQueries { .. } | Body::ZeroHandleMemory => Ok(()),
            Body::Semaphore { config, support, .. } => {
                check_support_variant(context, *support, Subject::Semaphore(config.handle))
            }
            Body::Fence { config, support, .. } => {
                check_support_variant(context, *support, Subject::Fence(config.handle))
            }
            Body::Memory { config, support, .. } => check_support_variant(
                context,
                *support,
                Subject::Buffer {
                    handle: config.handle,
                    dedicated: config.dedicated,
                },
            ),
            Body::Buffer { config, support, .. } => check_support_variant(
                context,
                *support,
                Subject::Buffer {
                    handle: config.handle,
                    dedicated: config.dedicated,
                },
            ),
            Body::Image { config, support, .. } => check_support_variant(
                context,
                *support,
                Subject::Image {
                    handle: config.handle,
                    tiling: config.tiling,
                    dedicated: config.dedicated,
                },
            ),
            Body::MemoryQueriesMaintenance5 { .. } => context.require_device_functionality("VK_KHR_maintenance5"),
            Body::AndroidHardwareBuffer => {
                context.require_device_functionality("VK_ANDROID_external_memory_android_hardware_buffer")?;
                Err(TestError::NotPorted(
                    "the Android hardware buffer format cases".to_string(),
                ))
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        match self.body {
            Body::Semaphore { .. } | Body::Fence { .. } => GET_NATIVE_FD.programs,
            _ => BinaryCollection::new(&[]),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExternalInstance {
            context,
            body: &self.body,
        })
    }

    fn is_stub(&self) -> bool {
        self.stub
    }
}

struct ExternalInstance<'a> {
    context: &'a Context<'a>,
    body: &'a Body,
}

impl TestInstance for ExternalInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        match self.body {
            Body::SemaphoreQueries { semaphore_type, handle } => semaphore_queries(context, *semaphore_type, *handle),
            Body::Semaphore { run, config, .. } => run(context, *config),
            Body::FenceQueries { handle } => fence_queries(context, *handle),
            Body::Fence { run, config, .. } => run(context, *config),
            Body::Memory { run, config, .. } => run(context, *config),
            Body::Buffer { run, config, .. } => run(context, *config),
            Body::Image { run, config, .. } => run(context, *config),
            Body::MemoryQueries { run, handle } | Body::MemoryQueriesMaintenance5 { run, handle } => {
                run(context, *handle)
            }
            Body::ZeroHandleMemory => memory_zero_handle_type(context),
            Body::AndroidHardwareBuffer => Err(TestError::NotPorted(
                "the Android hardware buffer format cases".to_string(),
            )),
        }
    }
}

fn add_case(group: &mut TestCaseGroup, name: impl Into<String>, body: Body) {
    group.add_child(Box::new(ExternalCase {
        name: name.into(),
        body,
        stub: false,
    }) as Box<dyn TestCase>);
}

const PERMANENCES: [(&str, Permanence); 2] = [
    ("temporary", Permanence::Temporary),
    ("permanent", Permanence::Permanent),
];

/// `createFenceTests(testCtx, externalType)`
fn create_fence_handle_tests(handle: vk::ExternalFenceHandleTypeFlags) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(external_fence_type_name(handle));
    add_case(&mut group, "info", Body::FenceQueries { handle });

    let is_win32 = handle == vk::ExternalFenceHandleTypeFlags::OPAQUE_WIN32
        || handle == vk::ExternalFenceHandleTypeFlags::OPAQUE_WIN32_KMT;
    let is_fd =
        handle == vk::ExternalFenceHandleTypeFlags::SYNC_FD || handle == vk::ExternalFenceHandleTypeFlags::OPAQUE_FD;

    for (permanence_name, permanence) in PERMANENCES {
        let config = FenceConfig { handle, permanence };
        if !is_supported_fence_permanence(handle, permanence) {
            continue;
        }
        let fence = |run: FenceFn, support: Support| Body::Fence { run, config, support };

        if is_win32 {
            // Test creating a fence with win32 properties.
            add_case(
                &mut group,
                format!("create_win32_{permanence_name}"),
                fence(fence_import_twice, Support::WithWin32Limit),
            );
        }

        add_case(
            &mut group,
            format!("import_twice_{permanence_name}"),
            fence(fence_import_twice, Support::WithTransference),
        );
        add_case(
            &mut group,
            format!("reimport_{permanence_name}"),
            fence(fence_import_reimport, Support::WithTransference),
        );
        add_case(
            &mut group,
            format!("import_multiple_times_{permanence_name}"),
            fence(fence_multiple_imports, Support::WithTransference),
        );
        add_case(
            &mut group,
            format!("signal_export_import_wait_{permanence_name}"),
            fence(fence_signal_export_import_wait, Support::WithEvent),
        );
        add_case(
            &mut group,
            format!("signal_import_{permanence_name}"),
            fence(fence_signal_import, Support::WithTransference),
        );
        add_case(
            &mut group,
            format!("reset_{permanence_name}"),
            fence(fence_reset, Support::WithEvent),
        );
        add_case(
            &mut group,
            format!("transference_{permanence_name}"),
            fence(fence_transference, Support::WithEvent),
        );

        if handle == vk::ExternalFenceHandleTypeFlags::SYNC_FD {
            add_case(
                &mut group,
                format!("import_signaled_{permanence_name}"),
                fence(fence_import_sync_fd_signaled, Support::Common),
            );
        }

        if is_fd {
            add_case(
                &mut group,
                format!("export_multiple_times_{permanence_name}"),
                fence(fence_multiple_exports, Support::WithTransference),
            );
            add_case(
                &mut group,
                format!("dup_{permanence_name}"),
                fence(fence_fd_dup, Support::WithTransference),
            );
            add_case(
                &mut group,
                format!("dup2_{permanence_name}"),
                fence(fence_fd_dup2, Support::WithTransference),
            );
            add_case(
                &mut group,
                format!("dup3_{permanence_name}"),
                fence(fence_fd_dup3, Support::WithTransference),
            );
            add_case(
                &mut group,
                format!("send_over_socket_{permanence_name}"),
                fence(fence_fd_send_over_socket, Support::WithTransference),
            );
        }

        if fence_handle_type_transference(handle) == Transference::Reference {
            add_case(
                &mut group,
                format!("signal_wait_import_{permanence_name}"),
                fence(fence_signal_wait_import, Support::Common),
            );
            add_case(
                &mut group,
                format!("export_signal_import_wait_{permanence_name}"),
                fence(fence_export_signal_import_wait, Support::Common),
            );
            add_case(
                &mut group,
                format!("export_import_signal_wait_{permanence_name}"),
                fence(fence_export_import_signal_wait, Support::Common),
            );
        }
    }

    group
}

/// `createFenceTests(testCtx)`
fn create_fence_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fence");
    group.add_child(create_fence_handle_tests(vk::ExternalFenceHandleTypeFlags::SYNC_FD));
    group.add_child(create_fence_handle_tests(vk::ExternalFenceHandleTypeFlags::OPAQUE_FD));
    group.add_child(create_fence_handle_tests(
        vk::ExternalFenceHandleTypeFlags::OPAQUE_WIN32,
    ));
    group.add_child(create_fence_handle_tests(
        vk::ExternalFenceHandleTypeFlags::OPAQUE_WIN32_KMT,
    ));
    group
}

/// `createSemaphoreTests(testCtx, externalType)`
fn create_semaphore_handle_tests(handle: vk::ExternalSemaphoreHandleTypeFlags) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(external_semaphore_type_name(handle));

    for (name, semaphore_type) in [
        ("binary", vk::SemaphoreType::BINARY),
        ("timeline", vk::SemaphoreType::TIMELINE),
    ] {
        add_case(
            &mut group,
            format!("info_{name}"),
            Body::SemaphoreQueries { semaphore_type, handle },
        );
    }

    let is_win32 = handle == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32
        || handle == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32_KMT;
    let is_fd = handle == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD
        || handle == vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD;

    for (permanence_name, permanence) in PERMANENCES {
        let config = SemaphoreConfig { handle, permanence };
        if !is_supported_semaphore_permanence(handle, permanence) {
            continue;
        }
        let semaphore = |run: SemaphoreFn, support: Support| Body::Semaphore { run, config, support };

        if is_win32 {
            // Test creating a semaphore with win32 properties.
            add_case(
                &mut group,
                format!("create_win32_{permanence_name}"),
                semaphore(semaphore_import_twice, Support::WithWin32Limit),
            );
        }

        add_case(
            &mut group,
            format!("import_twice_{permanence_name}"),
            semaphore(semaphore_import_twice, Support::WithTransference),
        );
        add_case(
            &mut group,
            format!("reimport_{permanence_name}"),
            semaphore(semaphore_import_reimport, Support::WithTransference),
        );
        add_case(
            &mut group,
            format!("import_multiple_times_{permanence_name}"),
            semaphore(semaphore_multiple_imports, Support::WithTransference),
        );
        add_case(
            &mut group,
            format!("signal_export_import_wait_{permanence_name}"),
            semaphore(semaphore_signal_export_import_wait, Support::WithEvent),
        );
        add_case(
            &mut group,
            format!("signal_import_{permanence_name}"),
            semaphore(semaphore_signal_import, Support::WithTransference),
        );
        add_case(
            &mut group,
            format!("transference_{permanence_name}"),
            semaphore(semaphore_transference, Support::WithEvent),
        );

        if handle == vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD {
            add_case(
                &mut group,
                format!("import_signaled_{permanence_name}"),
                semaphore(semaphore_import_sync_fd_signaled, Support::WithTransference),
            );
        }

        if is_fd {
            add_case(
                &mut group,
                format!("export_multiple_times_{permanence_name}"),
                semaphore(semaphore_multiple_exports, Support::WithTransference),
            );
            add_case(
                &mut group,
                format!("dup_{permanence_name}"),
                semaphore(semaphore_fd_dup, Support::WithTransference),
            );
            add_case(
                &mut group,
                format!("dup2_{permanence_name}"),
                semaphore(semaphore_fd_dup2, Support::WithTransference),
            );
            add_case(
                &mut group,
                format!("dup3_{permanence_name}"),
                semaphore(semaphore_fd_dup3, Support::WithTransference),
            );
            add_case(
                &mut group,
                format!("send_over_socket_{permanence_name}"),
                semaphore(semaphore_fd_send_over_socket, Support::WithTransference),
            );
        }

        if semaphore_handle_type_transference(handle) == Transference::Reference {
            add_case(
                &mut group,
                format!("signal_wait_import_{permanence_name}"),
                semaphore(semaphore_signal_wait_import, Support::Common),
            );
            add_case(
                &mut group,
                format!("export_signal_import_wait_{permanence_name}"),
                semaphore(semaphore_export_signal_import_wait, Support::Common),
            );
            add_case(
                &mut group,
                format!("export_import_signal_wait_{permanence_name}"),
                semaphore(semaphore_export_import_signal_wait, Support::WithEvent),
            );
        }
    }

    group
}

/// `createSemaphoreTests(testCtx)`
fn create_semaphore_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("semaphore");
    group.add_child(create_semaphore_handle_tests(
        vk::ExternalSemaphoreHandleTypeFlags::SYNC_FD,
    ));
    group.add_child(create_semaphore_handle_tests(
        vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_FD,
    ));
    group.add_child(create_semaphore_handle_tests(
        vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32,
    ));
    group.add_child(create_semaphore_handle_tests(
        vk::ExternalSemaphoreHandleTypeFlags::OPAQUE_WIN32_KMT,
    ));
    group.add_child(create_semaphore_handle_tests(
        vk::ExternalSemaphoreHandleTypeFlags::ZIRCON_EVENT_FUCHSIA,
    ));
    group
}

/// `ahbFormats` of `createMemoryTests`
const AHB_IMAGE_FORMATS: [&str; 15] = [
    "r8g8b8_unorm",
    "r8g8b8a8_unorm",
    "r5g6b5_unorm_pack16",
    "r16g16b16a16_sfloat",
    "a2b10g10r10_unorm_pack32",
    "d16_unorm",
    "x8_d24_unorm_pack32",
    "d24_unorm_s8_uint",
    "d32_sfloat",
    "d32_sfloat_s8_uint",
    "s8_uint",
    "r8_unorm",
    "r16_uint",
    "r16g16_uint",
    "r10x6g10x6b10x6a10x6_unorm_4pack16",
];

/// `AndroidHardwareBufferInstance::getFormatName` of every format but BLOB.
const AHB_EXTERNAL_FORMATS: [&str; 30] = [
    "AHARDWAREBUFFER_FORMAT_R8G8B8A8_UNORM",
    "AHARDWAREBUFFER_FORMAT_R8G8B8X8_UNORM",
    "AHARDWAREBUFFER_FORMAT_R8G8B8_UNORM",
    "AHARDWAREBUFFER_FORMAT_R5G6B5_UNORM",
    "AHARDWAREBUFFER_FORMAT_R16G16B16A16_FLOAT",
    "AHARDWAREBUFFER_FORMAT_R10G10B10A2_UNORM",
    "AHARDWAREBUFFER_FORMAT_D16_UNORM",
    "AHARDWAREBUFFER_FORMAT_D24_UNORM",
    "AHARDWAREBUFFER_FORMAT_D24_UNORM_S8_UINT",
    "AHARDWAREBUFFER_FORMAT_D32_FLOAT",
    "AHARDWAREBUFFER_FORMAT_D32_FLOAT_S8_UINT",
    "AHARDWAREBUFFER_FORMAT_S8_UINT",
    "AHARDWAREBUFFER_FORMAT_Y8Cb8Cr8_420",
    "AHARDWAREBUFFER_FORMAT_YCbCr_P010",
    "AHARDWAREBUFFER_FORMAT_R8_UNORM",
    "AHARDWAREBUFFER_FORMAT_R16_UINT",
    "AHARDWAREBUFFER_FORMAT_R16G16_UINT",
    "AHARDWAREBUFFER_FORMAT_R10G10B10A10_UNORM",
    "AHARDWAREBUFFER_FORMAT_B8G8R8A8_UNORM",
    "AHARDWAREBUFFER_FORMAT_YV12",
    "AHARDWAREBUFFER_FORMAT_Y8",
    "AHARDWAREBUFFER_FORMAT_Y16",
    "AHARDWAREBUFFER_FORMAT_RAW16",
    "AHARDWAREBUFFER_FORMAT_RAW10",
    "AHARDWAREBUFFER_FORMAT_RAW12",
    "AHARDWAREBUFFER_FORMAT_RAW_OPAQUE",
    "AHARDWAREBUFFER_FORMAT_YCbCr_422_SP",
    "AHARDWAREBUFFER_FORMAT_YCrCb_420_SP",
    "AHARDWAREBUFFER_FORMAT_YCbCr_422_I",
    "AHARDWAREBUFFER_FORMAT_IMPLEMENTATION_DEFINED",
];

/// `createMemoryTests(testCtx, externalType)`
fn create_memory_handle_tests(handle: vk::ExternalMemoryHandleTypeFlags) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(external_memory_type_name(handle));

    let is_win32 = handle == vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32
        || handle == vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32_KMT;
    let is_fd = handle == vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD
        || handle == vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT;

    for dedicated in [false, true] {
        let mut dedicated_group = TestCaseGroup::new(if dedicated { "dedicated" } else { "suballocated" });

        for host_visible in [false, true] {
            let mut host_visible_group = TestCaseGroup::new(if host_visible { "host_visible" } else { "device_only" });
            let config = MemoryConfig {
                handle,
                host_visible,
                dedicated,
            };
            let memory = |run: MemoryFn, support: Support| Body::Memory { run, config, support };

            if is_win32 {
                // Test creating memory with win32 properties.
                add_case(
                    &mut host_visible_group,
                    "create_win32",
                    memory(memory_import_twice, Support::WithWin32Limit),
                );
            }

            add_case(
                &mut host_visible_group,
                "import_twice",
                memory(memory_import_twice, Support::Common),
            );
            add_case(
                &mut host_visible_group,
                "import_multiple_times",
                memory(memory_multiple_imports, Support::Common),
            );

            if is_fd {
                add_case(
                    &mut host_visible_group,
                    "dup",
                    memory(memory_fd_dup, Support::WithPlatformLimit),
                );
                add_case(
                    &mut host_visible_group,
                    "dup2",
                    memory(memory_fd_dup2, Support::WithPlatformLimit),
                );
                add_case(
                    &mut host_visible_group,
                    "dup3",
                    memory(memory_fd_dup3, Support::WithPlatformLimit),
                );
                add_case(
                    &mut host_visible_group,
                    "send_over_socket",
                    memory(memory_fd_send_over_socket, Support::WithPlatformLimit),
                );
                add_case(
                    &mut host_visible_group,
                    "export_multiple_times",
                    memory(memory_multiple_exports, Support::Common),
                );
            }

            if handle == vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT {
                add_case(
                    &mut host_visible_group,
                    "fd_properties",
                    memory(memory_fd_properties, Support::Common),
                );
            }

            dedicated_group.add_child(host_visible_group);
        }

        {
            let mut buffer_group = TestCaseGroup::new("buffer");
            let config = BufferConfig { handle, dedicated };
            let buffer = |run: BufferFn| Body::Buffer {
                run,
                config,
                support: Support::Common,
            };

            add_case(
                &mut buffer_group,
                "info",
                Body::MemoryQueries {
                    run: buffer_queries,
                    handle,
                },
            );
            add_case(
                &mut buffer_group,
                "maintenance5",
                Body::MemoryQueriesMaintenance5 {
                    run: buffer_queries_maintenance5,
                    handle,
                },
            );
            add_case(
                &mut buffer_group,
                "bind_export_import_bind",
                buffer(buffer_bind_export_import_bind),
            );
            add_case(
                &mut buffer_group,
                "export_bind_import_bind",
                buffer(buffer_export_bind_import_bind),
            );
            add_case(
                &mut buffer_group,
                "export_import_bind_bind",
                buffer(buffer_export_import_bind_bind),
            );

            dedicated_group.add_child(buffer_group);
        }

        {
            let mut image_group = TestCaseGroup::new("image");
            let config = ImageConfig {
                handle,
                tiling: vk::ImageTiling::OPTIMAL,
                dedicated,
            };
            let image = |run: ImageFn, support: Support| Body::Image { run, config, support };

            add_case(
                &mut image_group,
                "info",
                Body::MemoryQueries {
                    run: image_queries,
                    handle,
                },
            );
            add_case(
                &mut image_group,
                "bind_export_import_bind",
                image(image_bind_export_import_bind, Support::Common),
            );
            add_case(
                &mut image_group,
                "export_bind_import_bind",
                image(image_export_bind_import_bind, Support::Common),
            );
            add_case(
                &mut image_group,
                "export_import_bind_bind",
                image(image_export_import_bind_bind, Support::WithAhb),
            );

            dedicated_group.add_child(image_group);
        }

        group.add_child(dedicated_group);
    }

    if handle == vk::ExternalMemoryHandleTypeFlags::ANDROID_HARDWARE_BUFFER_ANDROID {
        for ahb_format_properties_name in ["ahb_format_properties", "ahb_format_properties_2"] {
            let mut ahb_group = TestCaseGroup::new(ahb_format_properties_name);

            let mut format_group = TestCaseGroup::new("image_formats");
            for name in AHB_IMAGE_FORMATS {
                add_case(&mut format_group, name, Body::AndroidHardwareBuffer);
            }
            ahb_group.add_child(format_group);

            let mut external_format_resolve = TestCaseGroup::new("external_format_resolve");
            for name in AHB_EXTERNAL_FORMATS {
                add_case(&mut external_format_resolve, name, Body::AndroidHardwareBuffer);
            }
            ahb_group.add_child(external_format_resolve);

            group.add_child(ahb_group);
        }
    }

    group
}

/// `createMemoryTests(testCtx)`
fn create_memory_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("memory");
    group.add_child(create_memory_handle_tests(vk::ExternalMemoryHandleTypeFlags::OPAQUE_FD));
    group.add_child(create_memory_handle_tests(
        vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32,
    ));
    group.add_child(create_memory_handle_tests(
        vk::ExternalMemoryHandleTypeFlags::OPAQUE_WIN32_KMT,
    ));
    group.add_child(create_memory_handle_tests(
        vk::ExternalMemoryHandleTypeFlags::ANDROID_HARDWARE_BUFFER_ANDROID,
    ));
    group.add_child(create_memory_handle_tests(
        vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
    ));
    group.add_child(create_memory_handle_tests(
        vk::ExternalMemoryHandleTypeFlags::ZIRCON_VMO_FUCHSIA,
    ));
    group.add_child(create_memory_handle_tests(
        vk::ExternalMemoryHandleTypeFlags::MTLBUFFER_EXT,
    ));
    group.add_child(create_memory_handle_tests(
        vk::ExternalMemoryHandleTypeFlags::MTLTEXTURE_EXT,
    ));
    group
}

/// `createExternalMemoryTests`
pub fn create_external_memory_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("external");
    group.add_child(create_semaphore_tests());
    group.add_child(create_memory_tests());
    group.add_child(create_fence_tests());

    let mut misc = TestCaseGroup::new("misc");
    add_case(&mut misc, "zero_handle_memory", Body::ZeroHandleMemory);
    group.add_child(misc);
    group
}
