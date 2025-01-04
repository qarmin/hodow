//! The slice of the OpenCL C API the benchmark uses, resolved from a library at run time.

#![allow(non_camel_case_types)]

use std::ffi::{c_char, c_void};

use libloading::Library;

pub type cl_int = i32;
pub type cl_uint = u32;
pub type cl_bool = u32;
pub type cl_platform_id = *mut c_void;
pub type cl_device_id = *mut c_void;
pub type cl_context = *mut c_void;
pub type cl_command_queue = *mut c_void;
pub type cl_mem = *mut c_void;
pub type cl_program = *mut c_void;
pub type cl_kernel = *mut c_void;
pub type cl_event = *mut c_void;
pub type cl_mem_flags = u64;
pub type cl_map_flags = u64;

#[repr(C)]
pub struct cl_image_format {
    pub image_channel_order: u32,
    pub image_channel_data_type: u32,
}

#[repr(C)]
pub struct cl_image_desc {
    pub image_type: u32,
    pub image_width: usize,
    pub image_height: usize,
    pub image_depth: usize,
    pub image_array_size: usize,
    pub image_row_pitch: usize,
    pub image_slice_pitch: usize,
    pub num_mip_levels: u32,
    pub num_samples: u32,
    pub buffer: cl_mem,
}

impl Default for cl_image_desc {
    fn default() -> Self {
        Self {
            image_type: 0,
            image_width: 0,
            image_height: 0,
            image_depth: 0,
            image_array_size: 0,
            image_row_pitch: 0,
            image_slice_pitch: 0,
            num_mip_levels: 0,
            num_samples: 0,
            buffer: std::ptr::null_mut(),
        }
    }
}

pub const CL_SUCCESS: cl_int = 0;
pub const CL_IMAGE_FORMAT_NOT_SUPPORTED: cl_int = -10;
pub const CL_INVALID_IMAGE_FORMAT_DESCRIPTOR: cl_int = -39;
pub const CL_TRUE: cl_bool = 1;

pub const CL_DEVICE_TYPE_GPU: u64 = 1 << 2;
pub const CL_DEVICE_TYPE_ALL: u64 = 0xFFFF_FFFF;

pub const CL_PLATFORM_VERSION: u32 = 0x0901;
pub const CL_PLATFORM_NAME: u32 = 0x0902;
pub const CL_DEVICE_TYPE: u32 = 0x1000;
pub const CL_DEVICE_MAX_COMPUTE_UNITS: u32 = 0x1002;
pub const CL_DEVICE_MAX_WORK_GROUP_SIZE: u32 = 0x1004;
pub const CL_DEVICE_IMAGE_SUPPORT: u32 = 0x1016;
pub const CL_DEVICE_GLOBAL_MEM_SIZE: u32 = 0x101F;
pub const CL_DEVICE_LOCAL_MEM_SIZE: u32 = 0x1023;
pub const CL_DEVICE_NAME: u32 = 0x102B;
pub const CL_DRIVER_VERSION: u32 = 0x102D;
pub const CL_DEVICE_VERSION: u32 = 0x102F;
pub const CL_DEVICE_EXTENSIONS: u32 = 0x1030;
pub const CL_DEVICE_HOST_UNIFIED_MEMORY: u32 = 0x1035;
pub const CL_DEVICE_IL_VERSION: u32 = 0x105B;

pub const CL_QUEUE_PROPERTIES: u64 = 0x1093;
pub const CL_QUEUE_PROFILING_ENABLE: u64 = 1 << 1;

pub const CL_MEM_READ_WRITE: cl_mem_flags = 1;
pub const CL_MEM_READ_ONLY: cl_mem_flags = 1 << 2;
pub const CL_MEM_USE_HOST_PTR: cl_mem_flags = 1 << 3;
pub const CL_MEM_ALLOC_HOST_PTR: cl_mem_flags = 1 << 4;
pub const CL_MEM_COPY_HOST_PTR: cl_mem_flags = 1 << 5;

pub const CL_MAP_READ: cl_map_flags = 1;
pub const CL_MAP_WRITE: cl_map_flags = 1 << 1;
pub const CL_MAP_WRITE_INVALIDATE_REGION: cl_map_flags = 1 << 2;

pub const CL_R: u32 = 0x10B0;
pub const CL_UNSIGNED_INT8: u32 = 0x10DA;
pub const CL_UNSIGNED_INT16: u32 = 0x10DB;
pub const CL_MEM_OBJECT_IMAGE2D: u32 = 0x10F1;

pub const CL_PROGRAM_BUILD_LOG: u32 = 0x1183;
pub const CL_KERNEL_WORK_GROUP_SIZE: u32 = 0x11B0;
pub const CL_PROFILING_COMMAND_START: u32 = 0x1282;
pub const CL_PROFILING_COMMAND_END: u32 = 0x1283;

pub fn error_name(code: cl_int) -> String {
    let name = match code {
        -1 => "CL_DEVICE_NOT_FOUND",
        -2 => "CL_DEVICE_NOT_AVAILABLE",
        -3 => "CL_COMPILER_NOT_AVAILABLE",
        -4 => "CL_MEM_OBJECT_ALLOCATION_FAILURE",
        -5 => "CL_OUT_OF_RESOURCES",
        -6 => "CL_OUT_OF_HOST_MEMORY",
        -7 => "CL_PROFILING_INFO_NOT_AVAILABLE",
        -10 => "CL_IMAGE_FORMAT_NOT_SUPPORTED",
        -11 => "CL_BUILD_PROGRAM_FAILURE",
        -12 => "CL_MAP_FAILURE",
        -30 => "CL_INVALID_VALUE",
        -33 => "CL_INVALID_DEVICE",
        -34 => "CL_INVALID_CONTEXT",
        -36 => "CL_INVALID_COMMAND_QUEUE",
        -37 => "CL_INVALID_HOST_PTR",
        -38 => "CL_INVALID_MEM_OBJECT",
        -39 => "CL_INVALID_IMAGE_FORMAT_DESCRIPTOR",
        -40 => "CL_INVALID_IMAGE_SIZE",
        -43 => "CL_INVALID_BUILD_OPTIONS",
        -44 => "CL_INVALID_PROGRAM",
        -45 => "CL_INVALID_PROGRAM_EXECUTABLE",
        -46 => "CL_INVALID_KERNEL_NAME",
        -48 => "CL_INVALID_KERNEL",
        -49 => "CL_INVALID_ARG_INDEX",
        -50 => "CL_INVALID_ARG_VALUE",
        -51 => "CL_INVALID_ARG_SIZE",
        -52 => "CL_INVALID_KERNEL_ARGS",
        -53 => "CL_INVALID_WORK_DIMENSION",
        -54 => "CL_INVALID_WORK_GROUP_SIZE",
        -55 => "CL_INVALID_WORK_ITEM_SIZE",
        -59 => "CL_INVALID_OPERATION",
        -61 => "CL_INVALID_BUFFER_SIZE",
        -63 => "CL_INVALID_GLOBAL_WORK_SIZE",
        -1001 => "CL_PLATFORM_NOT_FOUND_KHR",
        _ => "",
    };
    if name.is_empty() {
        format!("error {code}")
    } else {
        format!("{name} ({code})")
    }
}

type Notify = *const c_void;

macro_rules! api {
    ($($field:ident = $symbol:literal: fn($($arg:ty),*) -> $ret:ty;)*) => {
        pub struct Api {
            _lib: Library,
            $(pub $field: unsafe extern "C" fn($($arg),*) -> $ret,)*
            pub create_command_queue: Option<unsafe extern "C" fn(cl_context, cl_device_id, u64, *mut cl_int) -> cl_command_queue>,
            pub create_command_queue_with_properties: Option<unsafe extern "C" fn(cl_context, cl_device_id, *const u64, *mut cl_int) -> cl_command_queue>,
        }

        impl Api {
            pub fn load(path: &str) -> Result<Api, String> {
                unsafe {
                    let lib = Library::new(path).map_err(|e| format!("cannot open: {e}"))?;
                    $(let $field = *lib.get::<unsafe extern "C" fn($($arg),*) -> $ret>(concat!($symbol, "\0").as_bytes()).map_err(|e| format!("{}: {e}", $symbol))?;)*
                    let create_command_queue = lib.get(b"clCreateCommandQueue\0").ok().map(|s| *s);
                    let create_command_queue_with_properties = lib.get(b"clCreateCommandQueueWithProperties\0").ok().map(|s| *s);
                    Ok(Api { $($field,)* create_command_queue, create_command_queue_with_properties, _lib: lib })
                }
            }
        }
    };
}

api! {
    get_platform_ids = "clGetPlatformIDs": fn(cl_uint, *mut cl_platform_id, *mut cl_uint) -> cl_int;
    get_platform_info = "clGetPlatformInfo": fn(cl_platform_id, u32, usize, *mut c_void, *mut usize) -> cl_int;
    get_device_ids = "clGetDeviceIDs": fn(cl_platform_id, u64, cl_uint, *mut cl_device_id, *mut cl_uint) -> cl_int;
    get_device_info = "clGetDeviceInfo": fn(cl_device_id, u32, usize, *mut c_void, *mut usize) -> cl_int;
    create_context = "clCreateContext": fn(*const isize, cl_uint, *const cl_device_id, Notify, *mut c_void, *mut cl_int) -> cl_context;
    create_buffer = "clCreateBuffer": fn(cl_context, cl_mem_flags, usize, *mut c_void, *mut cl_int) -> cl_mem;
    create_image = "clCreateImage": fn(cl_context, cl_mem_flags, *const cl_image_format, *const cl_image_desc, *mut c_void, *mut cl_int) -> cl_mem;
    create_program_with_source = "clCreateProgramWithSource": fn(cl_context, cl_uint, *const *const c_char, *const usize, *mut cl_int) -> cl_program;
    build_program = "clBuildProgram": fn(cl_program, cl_uint, *const cl_device_id, *const c_char, Notify, *mut c_void) -> cl_int;
    get_program_build_info = "clGetProgramBuildInfo": fn(cl_program, cl_device_id, u32, usize, *mut c_void, *mut usize) -> cl_int;
    create_kernel = "clCreateKernel": fn(cl_program, *const c_char, *mut cl_int) -> cl_kernel;
    set_kernel_arg = "clSetKernelArg": fn(cl_kernel, cl_uint, usize, *const c_void) -> cl_int;
    enqueue_nd_range_kernel = "clEnqueueNDRangeKernel": fn(cl_command_queue, cl_kernel, cl_uint, *const usize, *const usize, *const usize, cl_uint, *const cl_event, *mut cl_event) -> cl_int;
    enqueue_write_buffer = "clEnqueueWriteBuffer": fn(cl_command_queue, cl_mem, cl_bool, usize, usize, *const c_void, cl_uint, *const cl_event, *mut cl_event) -> cl_int;
    enqueue_read_buffer = "clEnqueueReadBuffer": fn(cl_command_queue, cl_mem, cl_bool, usize, usize, *mut c_void, cl_uint, *const cl_event, *mut cl_event) -> cl_int;
    enqueue_write_image = "clEnqueueWriteImage": fn(cl_command_queue, cl_mem, cl_bool, *const usize, *const usize, usize, usize, *const c_void, cl_uint, *const cl_event, *mut cl_event) -> cl_int;
    enqueue_map_buffer = "clEnqueueMapBuffer": fn(cl_command_queue, cl_mem, cl_bool, cl_map_flags, usize, usize, cl_uint, *const cl_event, *mut cl_event, *mut cl_int) -> *mut c_void;
    enqueue_unmap_mem_object = "clEnqueueUnmapMemObject": fn(cl_command_queue, cl_mem, *mut c_void, cl_uint, *const cl_event, *mut cl_event) -> cl_int;
    get_kernel_work_group_info = "clGetKernelWorkGroupInfo": fn(cl_kernel, cl_device_id, u32, usize, *mut c_void, *mut usize) -> cl_int;
    get_event_profiling_info = "clGetEventProfilingInfo": fn(cl_event, u32, usize, *mut c_void, *mut usize) -> cl_int;
    finish = "clFinish": fn(cl_command_queue) -> cl_int;
    release_event = "clReleaseEvent": fn(cl_event) -> cl_int;
    release_mem_object = "clReleaseMemObject": fn(cl_mem) -> cl_int;
    release_kernel = "clReleaseKernel": fn(cl_kernel) -> cl_int;
    release_program = "clReleaseProgram": fn(cl_program) -> cl_int;
    release_command_queue = "clReleaseCommandQueue": fn(cl_command_queue) -> cl_int;
    release_context = "clReleaseContext": fn(cl_context) -> cl_int;
}
