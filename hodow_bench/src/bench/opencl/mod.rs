//! OpenCL through a library opened at run time - no link-time dependency, and the choice of
//! library is part of what is measured: a board can carry an OpenCL 1.2 and a 3.0
//! implementation side by side under different sonames.

mod api;

use std::ffi::{CStr, c_void};
use std::ptr::{self, null, null_mut};
use std::sync::Arc;
use std::time::Instant;

use api::{
    Api, CL_DEVICE_EXTENSIONS, CL_DEVICE_GLOBAL_MEM_SIZE, CL_DEVICE_HOST_UNIFIED_MEMORY, CL_DEVICE_IL_VERSION,
    CL_DEVICE_IMAGE_SUPPORT, CL_DEVICE_LOCAL_MEM_SIZE, CL_DEVICE_MAX_COMPUTE_UNITS, CL_DEVICE_MAX_WORK_GROUP_SIZE,
    CL_DEVICE_NAME, CL_DEVICE_TYPE, CL_DEVICE_TYPE_ALL, CL_DEVICE_TYPE_GPU, CL_DEVICE_VERSION, CL_DRIVER_VERSION,
    CL_IMAGE_FORMAT_NOT_SUPPORTED, CL_INVALID_IMAGE_FORMAT_DESCRIPTOR, CL_KERNEL_WORK_GROUP_SIZE, CL_MAP_READ,
    CL_MAP_WRITE, CL_MAP_WRITE_INVALIDATE_REGION, CL_MEM_ALLOC_HOST_PTR, CL_MEM_COPY_HOST_PTR, CL_MEM_OBJECT_IMAGE2D,
    CL_MEM_READ_ONLY, CL_MEM_READ_WRITE, CL_MEM_USE_HOST_PTR, CL_PLATFORM_NAME, CL_PLATFORM_VERSION,
    CL_PROFILING_COMMAND_END, CL_PROFILING_COMMAND_START, CL_PROGRAM_BUILD_LOG, CL_QUEUE_PROFILING_ENABLE,
    CL_QUEUE_PROPERTIES, CL_R, CL_SUCCESS, CL_TRUE, CL_UNSIGNED_INT8, CL_UNSIGNED_INT16, cl_command_queue, cl_context,
    cl_device_id, cl_image_desc, cl_image_format, cl_int, cl_kernel, cl_map_flags, cl_mem, cl_mem_flags, cl_program,
    error_name,
};

use super::data::{as_bytes, bayer_rg10, gaussian_weights, gemm_inputs, gray_u8, random_bytes, u32_bytes, words};
use super::spec::{ClDevice, RowStatus, Strategy, Task, Variant};
use super::{Bench, FrameTimes};

const SOURCE: &str = include_str!("kernels.cl");
const DEFAULT_TILE: [u32; 2] = [32, 8];

/// Pixels per work-item: the vector variants' own width, four for the pipelines' debayer
/// under every other variant.
fn vector_width(variant: Variant) -> usize {
    match variant {
        Variant::Vec8 => 8,
        Variant::Vec16 => 16,
        _ => 4,
    }
}

/// Sonames worth trying, in order. Two that resolve to the same library are reported once.
pub const CANDIDATES: &[&str] = &["libOpenCL.so.1", "libOpenCL.so.3", "libOpenCL.so"];

pub fn check(code: cl_int, what: &str) -> Result<(), String> {
    if code == CL_SUCCESS {
        Ok(())
    } else {
        Err(format!("{what}: {}", error_name(code)))
    }
}

/// Every candidate that loads and has a device, without duplicates.
pub fn probe() -> (Vec<ClDevice>, Vec<String>) {
    let mut found: Vec<(usize, ClDevice)> = Vec::new();
    let mut notes = Vec::new();
    for lib in CANDIDATES {
        match Session::open(lib) {
            Ok(session) => {
                let key = session.api.get_platform_ids as usize;
                if found.iter().any(|(k, _)| *k == key) {
                    continue;
                }
                found.push((key, session.info.clone()));
            }
            Err(e) => notes.push(format!("{lib}: {e}")),
        }
    }
    if found.is_empty() && notes.iter().any(|n| n.contains("no OpenCL platform")) {
        notes.push(
            "the OpenCL loader is here but no driver (ICD) is registered in /etc/OpenCL/vendors - see `just doctor`"
                .into(),
        );
    }
    (found.into_iter().map(|(_, d)| d).collect(), notes)
}

pub struct Session {
    api: Arc<Api>,
    device: cl_device_id,
    context: cl_context,
    queue: cl_command_queue,
    pub info: ClDevice,
    pub context_ms: f64,
}

impl Drop for Session {
    fn drop(&mut self) {
        unsafe {
            (self.api.release_command_queue)(self.queue);
            (self.api.release_context)(self.context);
        }
    }
}

fn info_string(f: impl Fn(usize, *mut c_void, *mut usize) -> cl_int) -> String {
    let mut len = 0usize;
    if f(0, null_mut(), &mut len) != CL_SUCCESS || len == 0 {
        return String::new();
    }
    let mut buf = vec![0u8; len];
    if f(len, buf.as_mut_ptr().cast(), null_mut()) != CL_SUCCESS {
        return String::new();
    }
    CStr::from_bytes_until_nul(&buf).map_or_default(|s| s.to_string_lossy().trim().to_string())
}

fn info_value<T: Default>(f: impl Fn(usize, *mut c_void, *mut usize) -> cl_int) -> T {
    let mut value = T::default();
    f(size_of::<T>(), (&mut value as *mut T).cast(), null_mut());
    value
}

impl Session {
    pub fn open(lib: &str) -> Result<Self, String> {
        let api = Arc::new(Api::load(lib)?);
        let start = Instant::now();
        let mut count = 0u32;
        let code = unsafe { (api.get_platform_ids)(0, null_mut(), &mut count) };
        if code != CL_SUCCESS || count == 0 {
            return Err(format!(
                "no OpenCL platform ({})",
                if code == CL_SUCCESS {
                    "none listed".into()
                } else {
                    error_name(code)
                }
            ));
        }
        let mut platforms = vec![null_mut(); count as usize];
        check(
            unsafe { (api.get_platform_ids)(count, platforms.as_mut_ptr(), null_mut()) },
            "clGetPlatformIDs",
        )?;
        let mut chosen = None;
        for device_type in [CL_DEVICE_TYPE_GPU, CL_DEVICE_TYPE_ALL] {
            for &platform in &platforms {
                let mut device = null_mut();
                let mut n = 0u32;
                if unsafe { (api.get_device_ids)(platform, device_type, 1, &mut device, &mut n) } == CL_SUCCESS && n > 0
                {
                    chosen = Some((platform, device));
                    break;
                }
            }
            if chosen.is_some() {
                break;
            }
        }
        let (platform, device) = chosen.ok_or("no OpenCL device")?;
        let platform_info = |param| {
            info_string(|size, value, ret| unsafe { (api.get_platform_info)(platform, param, size, value, ret) })
        };
        let device_string =
            |param| info_string(|size, value, ret| unsafe { (api.get_device_info)(device, param, size, value, ret) });
        let device_u32 = |param| {
            info_value::<u32>(|size, value, ret| unsafe { (api.get_device_info)(device, param, size, value, ret) })
        };
        let device_u64 = |param| {
            info_value::<u64>(|size, value, ret| unsafe { (api.get_device_info)(device, param, size, value, ret) })
        };
        let device_usize = |param| {
            info_value::<usize>(|size, value, ret| unsafe { (api.get_device_info)(device, param, size, value, ret) })
        };
        let info = ClDevice {
            lib: lib.to_string(),
            platform: platform_info(CL_PLATFORM_NAME),
            platform_version: platform_info(CL_PLATFORM_VERSION),
            device: device_string(CL_DEVICE_NAME),
            device_version: device_string(CL_DEVICE_VERSION),
            driver_version: device_string(CL_DRIVER_VERSION),
            is_gpu: device_u64(CL_DEVICE_TYPE) & CL_DEVICE_TYPE_GPU != 0,
            compute_units: device_u32(CL_DEVICE_MAX_COMPUTE_UNITS),
            max_work_group: device_usize(CL_DEVICE_MAX_WORK_GROUP_SIZE) as u64,
            local_mem_kb: device_u64(CL_DEVICE_LOCAL_MEM_SIZE) / 1024,
            global_mem_mb: device_u64(CL_DEVICE_GLOBAL_MEM_SIZE) >> 20,
            image_support: device_u32(CL_DEVICE_IMAGE_SUPPORT) != 0,
            unified_memory: device_u32(CL_DEVICE_HOST_UNIFIED_MEMORY) != 0,
            il_version: device_string(CL_DEVICE_IL_VERSION),
            extensions: device_string(CL_DEVICE_EXTENSIONS),
        };
        let mut err = CL_SUCCESS;
        let context = unsafe { (api.create_context)(null(), 1, &device, null(), null_mut(), &mut err) };
        check(err, "clCreateContext")?;
        let queue = match api.create_command_queue {
            Some(create) => unsafe { create(context, device, CL_QUEUE_PROFILING_ENABLE, &mut err) },
            None => {
                let Some(create) = api.create_command_queue_with_properties else {
                    unsafe { (api.release_context)(context) };
                    return Err("library exports no way to create a command queue".into());
                };
                let props = [CL_QUEUE_PROPERTIES, CL_QUEUE_PROFILING_ENABLE, 0];
                unsafe { create(context, device, props.as_ptr(), &mut err) }
            }
        };
        if err != CL_SUCCESS {
            unsafe { (api.release_context)(context) };
            return Err(format!("clCreateCommandQueue: {}", error_name(err)));
        }
        Ok(Self {
            api,
            device,
            context,
            queue,
            info,
            context_ms: start.elapsed().as_secs_f64() * 1e3,
        })
    }

    fn build(&self, options: &str) -> Result<Program, String> {
        let api = &self.api;
        let mut err = CL_SUCCESS;
        let source = SOURCE.as_ptr().cast();
        let len = SOURCE.len();
        let program = unsafe { (api.create_program_with_source)(self.context, 1, &source, &len, &mut err) };
        check(err, "clCreateProgramWithSource")?;
        let program = Program(api.clone(), program);
        let options = std::ffi::CString::new(options).expect("options carry no NUL");
        let code = unsafe { (api.build_program)(program.1, 1, &self.device, options.as_ptr(), null(), null_mut()) };
        if code != CL_SUCCESS {
            let log = info_string(|size, value, ret| unsafe {
                (api.get_program_build_info)(program.1, self.device, CL_PROGRAM_BUILD_LOG, size, value, ret)
            });
            let log: String = log.lines().take(8).collect::<Vec<_>>().join(" / ");
            return Err(format!("clBuildProgram: {}: {log}", error_name(code)));
        }
        Ok(program)
    }

    fn kernel(&self, program: &Program, name: &str) -> Result<Kernel, String> {
        let mut err = CL_SUCCESS;
        let cname = std::ffi::CString::new(name).expect("kernel names carry no NUL");
        let kernel = unsafe { (self.api.create_kernel)(program.1, cname.as_ptr(), &mut err) };
        check(err, &format!("clCreateKernel({name})"))?;
        Ok(Kernel(self.api.clone(), kernel))
    }

    fn buffer(&self, flags: cl_mem_flags, size: usize, host: *mut c_void) -> Result<Mem, String> {
        let mut err = CL_SUCCESS;
        let mem = unsafe { (self.api.create_buffer)(self.context, flags, size.max(1), host, &mut err) };
        check(err, &format!("clCreateBuffer({size} bytes)"))?;
        Ok(Mem(self.api.clone(), mem))
    }

    fn image(&self, flags: cl_mem_flags, data_type: u32, width: usize, height: usize) -> Result<Mem, Refusal> {
        if !self.info.image_support {
            return Err((RowStatus::Unsupported, "the device has no image support".into()));
        }
        let format = cl_image_format {
            image_channel_order: CL_R,
            image_channel_data_type: data_type,
        };
        let desc = cl_image_desc {
            image_type: CL_MEM_OBJECT_IMAGE2D,
            image_width: width,
            image_height: height,
            ..cl_image_desc::default()
        };
        let mut err = CL_SUCCESS;
        let mem = unsafe { (self.api.create_image)(self.context, flags, &format, &desc, null_mut(), &mut err) };
        if err == CL_IMAGE_FORMAT_NOT_SUPPORTED || err == CL_INVALID_IMAGE_FORMAT_DESCRIPTOR {
            return Err((RowStatus::Unsupported, format!("clCreateImage: {}", error_name(err))));
        }
        check(err, "clCreateImage").map_err(|e| (RowStatus::Failed, e))?;
        Ok(Mem(self.api.clone(), mem))
    }

    fn finish(&self) -> Result<(), String> {
        check(unsafe { (self.api.finish)(self.queue) }, "clFinish")
    }
}

struct Program(Arc<Api>, cl_program);
struct Kernel(Arc<Api>, cl_kernel);
struct Mem(Arc<Api>, cl_mem);

impl Drop for Program {
    fn drop(&mut self) {
        unsafe { (self.0.release_program)(self.1) };
    }
}
impl Drop for Kernel {
    fn drop(&mut self) {
        unsafe { (self.0.release_kernel)(self.1) };
    }
}
impl Drop for Mem {
    fn drop(&mut self) {
        unsafe { (self.0.release_mem_object)(self.1) };
    }
}

/// Page-aligned memory the application owns, for `CL_MEM_USE_HOST_PTR`.
struct HostBuf {
    ptr: *mut u8,
    layout: std::alloc::Layout,
}

impl HostBuf {
    fn new(data: &[u8]) -> Self {
        let layout =
            std::alloc::Layout::from_size_align(data.len().max(1).next_multiple_of(4096), 4096).expect("valid layout");
        let ptr = unsafe { std::alloc::alloc_zeroed(layout) };
        assert!(!ptr.is_null(), "out of memory");
        unsafe { ptr::copy_nonoverlapping(data.as_ptr(), ptr, data.len()) };
        Self { ptr, layout }
    }
}

impl Drop for HostBuf {
    fn drop(&mut self) {
        unsafe { std::alloc::dealloc(self.ptr, self.layout) };
    }
}

#[derive(Clone)]
enum Arg<'a> {
    Mem(&'a Mem),
    I32(i32),
    U8(u8),
    /// That many bytes of local memory.
    Local(usize),
}

struct Launch {
    kernel: Kernel,
    global: [usize; 2],
    local: Option<[usize; 2]>,
}

/// The input as the device sees it, and where the application's copy of it lives.
struct Endpoint {
    mem: Mem,
    len: usize,
    /// For an image input: its size, uploaded with `clEnqueueWriteImage`.
    image: Option<[usize; 2]>,
    /// The application's data: a plain vector, or for zero-copy the memory the buffer wraps.
    host: Vec<u8>,
    wrapped: Option<HostBuf>,
}

pub struct ClBench<'s> {
    s: &'s Session,
    /// Cleared once the driver refuses `CL_MAP_WRITE_INVALIDATE_REGION`; plain write mapping from then on.
    invalidate: std::cell::Cell<bool>,
    task: Task,
    strategy: Strategy,
    input: Option<Endpoint>,
    output: Option<Endpoint>,
    launches: Vec<Launch>,
    _keep: Vec<Mem>,
    _program: Option<Program>,
}

fn set_args(s: &Session, kernel: &Kernel, args: &[Arg]) -> Result<(), String> {
    for (i, arg) in args.iter().enumerate() {
        let code = unsafe {
            match arg {
                Arg::Mem(m) => {
                    (s.api.set_kernel_arg)(kernel.1, i as u32, size_of::<cl_mem>(), (&m.1 as *const cl_mem).cast())
                }
                Arg::I32(v) => (s.api.set_kernel_arg)(kernel.1, i as u32, 4, (v as *const i32).cast()),
                Arg::U8(v) => (s.api.set_kernel_arg)(kernel.1, i as u32, 1, (v as *const u8).cast()),
                Arg::Local(bytes) => (s.api.set_kernel_arg)(kernel.1, i as u32, *bytes, null()),
            }
        };
        check(code, &format!("clSetKernelArg({i})"))?;
    }
    Ok(())
}

impl<'s> ClBench<'s> {
    fn endpoint(s: &Session, data: Vec<u8>, read_only: bool, strategy: Strategy) -> Result<Endpoint, String> {
        let access = if read_only { CL_MEM_READ_ONLY } else { CL_MEM_READ_WRITE };
        let len = data.len();
        let (mem, wrapped) = match strategy {
            Strategy::Copy => (
                s.buffer(access | CL_MEM_COPY_HOST_PTR, len, data.as_ptr() as *mut c_void)?,
                None,
            ),
            Strategy::Map => (
                s.buffer(
                    access | CL_MEM_ALLOC_HOST_PTR | CL_MEM_COPY_HOST_PTR,
                    len,
                    data.as_ptr() as *mut c_void,
                )?,
                None,
            ),
            Strategy::ZeroCopy => {
                let host = HostBuf::new(&data);
                (
                    s.buffer(access | CL_MEM_USE_HOST_PTR, len, host.ptr.cast())?,
                    Some(host),
                )
            }
        };
        Ok(Endpoint {
            mem,
            len,
            image: None,
            host: data,
            wrapped,
        })
    }

    pub fn new(
        s: &'s Session,
        task: Task,
        variant: Variant,
        strategy: Strategy,
        local: Option<[u32; 2]>,
    ) -> Result<Self, Refusal> {
        let failed = |e: String| (RowStatus::Failed, e);
        if matches!(task, Task::Cnn { .. }) {
            return Err((RowStatus::Unsupported, "the network runs on TFLite only".into()));
        }
        if variant == Variant::Unrolled {
            return Err((
                RowStatus::Unsupported,
                "the unrolled variant is written for GLES and Vulkan; OpenCL gets R as a build constant".into(),
            ));
        }
        let radius = task.blur_radius().unwrap_or(0) as usize;
        let tile = if variant == Variant::Local {
            local.unwrap_or(DEFAULT_TILE)
        } else {
            DEFAULT_TILE
        };
        let lanes = vector_width(variant);
        let options = format!("-D R={radius} -D TW={} -D TH={} -D VN={lanes}", tile[0], tile[1]);
        let program = s.build(&options).map_err(failed)?;
        let local = if variant == Variant::Local {
            Some([tile[0] as usize, tile[1] as usize])
        } else {
            local.map(|[x, y]| [x as usize, y as usize])
        };
        let mut keep = Vec::new();
        let mut launches = Vec::new();
        let kernel = |name: &str| s.kernel(&program, name).map_err(failed);
        let launch = |kernel: Kernel,
                      args: &[Arg],
                      global: [usize; 2],
                      local: Option<[usize; 2]>|
         -> Result<Launch, Refusal> {
            set_args(s, &kernel, args).map_err(failed)?;
            if let Some([x, y]) = local {
                let limit = info_value::<usize>(|size, value, ret| unsafe {
                    (s.api.get_kernel_work_group_info)(kernel.1, s.device, CL_KERNEL_WORK_GROUP_SIZE, size, value, ret)
                });
                if limit > 0 && x * y > limit {
                    return Err((
                        RowStatus::Unsupported,
                        format!("work-group {x}x{y} is over this kernel's limit of {limit}"),
                    ));
                }
            }
            Ok(Launch { kernel, global, local })
        };

        let weights = gaussian_weights(radius);
        let weight_bytes: Vec<u8> = if matches!(variant, Variant::F32 | Variant::F16) {
            weights
                .iter()
                .flat_map(|&w| (f32::from(w) / 256.0).to_ne_bytes())
                .collect()
        } else {
            as_bytes(&weights).to_vec()
        };

        // Gray image -> blur variant -> `dst`, appended to `launches`.
        let blur_into = |launches: &mut Vec<Launch>,
                         keep: &mut Vec<Mem>,
                         gray: GrayIn,
                         dst: &Mem,
                         w: usize,
                         h: usize|
         -> Result<(), Refusal> {
            let wt = s
                .buffer(
                    CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                    weight_bytes.len(),
                    weight_bytes.as_ptr() as *mut c_void,
                )
                .map_err(failed)?;
            let (wi, hi) = (w as i32, h as i32);
            let vector = [w.div_ceil(lanes), h];
            match (variant, gray) {
                (Variant::Image, GrayIn::Image(src)) => {
                    let tmp = s.image(CL_MEM_READ_WRITE, CL_UNSIGNED_INT16, w, h)?;
                    launches.push(launch(
                        kernel("blur_h_image")?,
                        &[Arg::Mem(src), Arg::Mem(&tmp), Arg::Mem(&wt)],
                        [w, h],
                        local,
                    )?);
                    launches.push(launch(
                        kernel("blur_v_image")?,
                        &[Arg::Mem(&tmp), Arg::Mem(dst), Arg::Mem(&wt)],
                        [w, h],
                        local,
                    )?);
                    keep.push(tmp);
                }
                #[expect(clippy::unreachable, reason = "the message states the invariant")]
                (Variant::Image, GrayIn::Buffer(_)) => unreachable!("image blur is always fed an image"),
                (Variant::Naive, GrayIn::Buffer(src)) => {
                    launches.push(launch(
                        kernel("blur_naive")?,
                        &[Arg::Mem(src), Arg::Mem(dst), Arg::Mem(&wt), Arg::I32(wi), Arg::I32(hi)],
                        [w, h],
                        local,
                    )?);
                }
                (_, GrayIn::Buffer(src)) => {
                    let (h_name, v_name, tmp_bytes, global) = match variant {
                        Variant::Separable => ("blur_h", "blur_v", 2, [w, h]),
                        Variant::Local => ("blur_h_local", "blur_v_local", 2, [w, h]),
                        Variant::Vec4 | Variant::Vec8 | Variant::Vec16 => ("blur_h_vec", "blur_v_vec", 2, vector),
                        Variant::F32 => ("blur_h_f32", "blur_v_f32", 4, [w, h]),
                        Variant::F16 => ("blur_h_f16", "blur_v_f16", 2, [w, h]),
                        #[expect(clippy::unreachable, reason = "the message states the invariant")]
                        Variant::Naive | Variant::Image | Variant::Unrolled => unreachable!("handled above"),
                    };
                    let tmp = s
                        .buffer(CL_MEM_READ_WRITE, w * h * tmp_bytes, null_mut())
                        .map_err(failed)?;
                    launches.push(launch(
                        kernel(h_name)?,
                        &[Arg::Mem(src), Arg::Mem(&tmp), Arg::Mem(&wt), Arg::I32(wi), Arg::I32(hi)],
                        global,
                        local,
                    )?);
                    launches.push(launch(
                        kernel(v_name)?,
                        &[Arg::Mem(&tmp), Arg::Mem(dst), Arg::Mem(&wt), Arg::I32(wi), Arg::I32(hi)],
                        global,
                        local,
                    )?);
                    keep.push(tmp);
                }
                #[expect(clippy::unreachable, reason = "the message states the invariant")]
                (_, GrayIn::Image(_)) => unreachable!("only the image variant takes an image"),
            }
            keep.push(wt);
            Ok(())
        };

        let endpoint = |data: Vec<u8>, read_only: bool| Self::endpoint(s, data, read_only, strategy).map_err(failed);
        let (input, output) = match task {
            Task::Debayer { width, height } => {
                let (ow, oh) = (width as usize / 2, height as usize / 2);
                let input = endpoint(as_bytes(&bayer_rg10(width, height)).to_vec(), true)?;
                let output = endpoint(vec![0; ow * oh], false)?;
                let (name, global) = if variant == Variant::Naive {
                    ("debayer", [ow, oh])
                } else {
                    ("debayer_vec", [ow.div_ceil(lanes.min(8)), oh])
                };
                launches.push(launch(
                    kernel(name)?,
                    &[
                        Arg::Mem(&input.mem),
                        Arg::Mem(&output.mem),
                        Arg::I32(ow as i32),
                        Arg::I32(oh as i32),
                    ],
                    global,
                    local,
                )?);
                (Some(input), Some(output))
            }
            Task::Blur { width, height, .. } => {
                let (w, h) = (width as usize, height as usize);
                let gray = gray_u8(width, height);
                let output = endpoint(vec![0; w * h], false)?;
                let input = if variant == Variant::Image {
                    if strategy != Strategy::Copy {
                        return Err((RowStatus::Unsupported, "image input is only uploaded by copy".into()));
                    }
                    let mem = s.image(CL_MEM_READ_ONLY, CL_UNSIGNED_INT8, w, h)?;
                    Endpoint {
                        mem,
                        len: w * h,
                        image: Some([w, h]),
                        host: gray,
                        wrapped: None,
                    }
                } else {
                    endpoint(gray, true)?
                };
                let gray_in = if variant == Variant::Image {
                    GrayIn::Image(&input.mem)
                } else {
                    GrayIn::Buffer(&input.mem)
                };
                blur_into(&mut launches, &mut keep, gray_in, &output.mem, w, h)?;
                (Some(input), Some(output))
            }
            Task::Pipeline { width, height, .. } => {
                let (ow, oh) = (width as usize / 2, height as usize / 2);
                let input = endpoint(as_bytes(&bayer_rg10(width, height)).to_vec(), true)?;
                let output = endpoint(vec![0; ow * oh * 3 / 2], false)?;
                let gray = if variant == Variant::Image {
                    s.image(CL_MEM_READ_WRITE, CL_UNSIGNED_INT8, ow, oh)?
                } else {
                    s.buffer(CL_MEM_READ_WRITE, ow * oh, null_mut()).map_err(failed)?
                };
                let (name, global) = match variant {
                    Variant::Image => ("debayer_image", [ow, oh]),
                    Variant::Naive => ("debayer", [ow, oh]),
                    _ => ("debayer_vec", [ow.div_ceil(lanes.min(8)), oh]),
                };
                launches.push(launch(
                    kernel(name)?,
                    &[
                        Arg::Mem(&input.mem),
                        Arg::Mem(&gray),
                        Arg::I32(ow as i32),
                        Arg::I32(oh as i32),
                    ],
                    global,
                    local,
                )?);
                let gray_in = if variant == Variant::Image {
                    GrayIn::Image(&gray)
                } else {
                    GrayIn::Buffer(&gray)
                };
                blur_into(&mut launches, &mut keep, gray_in, &output.mem, ow, oh)?;
                let chroma = ow * oh / 2;
                let fill = [
                    Arg::Mem(&output.mem),
                    Arg::I32((ow * oh) as i32),
                    Arg::I32(chroma as i32),
                    Arg::U8(128),
                ];
                launches.push(launch(kernel("fill_u8")?, &fill, [chroma.div_ceil(4), 1], None)?);
                keep.push(gray);
                (Some(input), Some(output))
            }
            Task::Upload { bytes } => (Some(endpoint(random_bytes(bytes as usize), false)?), None),
            Task::Download { bytes } => (None, Some(endpoint(random_bytes(bytes as usize), false)?)),
            Task::Dispatch => {
                launches.push(launch(kernel("empty")?, &[], [1, 1], None)?);
                (None, None)
            }
            Task::Morph { width, height } | Task::Sobel { width, height } => {
                if variant != Variant::Naive {
                    return Err((
                        RowStatus::Unsupported,
                        "only the one-pixel-per-work-item kernel is written for this".into(),
                    ));
                }
                let (w, h) = (width as usize, height as usize);
                let input = endpoint(gray_u8(width, height), true)?;
                let output = endpoint(vec![0; w * h], false)?;
                let dims = [Arg::I32(w as i32), Arg::I32(h as i32)];
                if matches!(task, Task::Sobel { .. }) {
                    launches.push(launch(
                        kernel("sobel")?,
                        &[
                            Arg::Mem(&input.mem),
                            Arg::Mem(&output.mem),
                            dims[0].clone(),
                            dims[1].clone(),
                        ],
                        [w, h],
                        local,
                    )?);
                } else {
                    let eroded = s.buffer(CL_MEM_READ_WRITE, w * h, null_mut()).map_err(failed)?;
                    launches.push(launch(
                        kernel("erode")?,
                        &[
                            Arg::Mem(&input.mem),
                            Arg::Mem(&eroded),
                            dims[0].clone(),
                            dims[1].clone(),
                        ],
                        [w, h],
                        local,
                    )?);
                    launches.push(launch(
                        kernel("dilate")?,
                        &[
                            Arg::Mem(&eroded),
                            Arg::Mem(&output.mem),
                            dims[0].clone(),
                            dims[1].clone(),
                        ],
                        [w, h],
                        local,
                    )?);
                    keep.push(eroded);
                }
                (Some(input), Some(output))
            }
            Task::Histogram { width, height } => {
                let n = (width * height) as usize;
                let input = endpoint(gray_u8(width, height), true)?;
                let output = endpoint(vec![0; 1024], false)?;
                launches.push(launch(
                    kernel("clear_u32")?,
                    &[Arg::Mem(&output.mem), Arg::I32(256)],
                    [256, 1],
                    None,
                )?);
                match variant {
                    Variant::Naive => launches.push(launch(
                        kernel("histogram_global")?,
                        &[Arg::Mem(&input.mem), Arg::Mem(&output.mem), Arg::I32(n as i32)],
                        [n, 1],
                        None,
                    )?),
                    Variant::Local => {
                        // As many work-items per group as this kernel allows, up to one per bin.
                        let k = kernel("histogram_local")?;
                        let limit = info_value::<usize>(|size, value, ret| unsafe {
                            (s.api.get_kernel_work_group_info)(
                                k.1,
                                s.device,
                                CL_KERNEL_WORK_GROUP_SIZE,
                                size,
                                value,
                                ret,
                            )
                        });
                        let group = limit.clamp(1, 256);
                        launches.push(launch(
                            k,
                            &[Arg::Mem(&input.mem), Arg::Mem(&output.mem), Arg::I32(n as i32)],
                            [64 * group, 1],
                            Some([group, 1]),
                        )?);
                    }
                    _ => {
                        return Err((
                            RowStatus::Unsupported,
                            "histogram has a global-atomics (naive) and a local-memory kernel".into(),
                        ));
                    }
                }
                (Some(input), Some(output))
            }
            Task::Moments { width, height } => {
                if variant != Variant::Naive {
                    return Err((
                        RowStatus::Unsupported,
                        "only the row-per-work-item kernel is written for this".into(),
                    ));
                }
                let (w, h) = (width as usize, height as usize);
                let input = endpoint(gray_u8(width, height), true)?;
                let output = endpoint(vec![0; h * 16], false)?;
                let args = [
                    Arg::Mem(&input.mem),
                    Arg::Mem(&input.mem),
                    Arg::Mem(&output.mem),
                    Arg::I32(w as i32),
                    Arg::I32(h as i32),
                    Arg::I32(0),
                ];
                launches.push(launch(kernel("moments")?, &args, [h, 1], None)?);
                (Some(input), Some(output))
            }
            Task::Eye { width, height } => {
                if matches!(variant, Variant::Image | Variant::Local) {
                    return Err((
                        RowStatus::Unsupported,
                        "the eye pipeline runs the buffer blurs only".into(),
                    ));
                }
                let (w, h) = (width as usize / 2, height as usize / 2);
                let input = endpoint(as_bytes(&bayer_rg10(width, height)).to_vec(), true)?;
                let output = endpoint(vec![0; h * 16], false)?;
                let gray = s.buffer(CL_MEM_READ_WRITE, w * h, null_mut()).map_err(failed)?;
                let blurred = s.buffer(CL_MEM_READ_WRITE, w * h, null_mut()).map_err(failed)?;
                let mask = s.buffer(CL_MEM_READ_WRITE, w * h, null_mut()).map_err(failed)?;
                let (wi, hi) = (w as i32, h as i32);
                let (name, global) = if variant == Variant::Naive {
                    ("debayer", [w, h])
                } else {
                    ("debayer_vec", [w.div_ceil(lanes.min(8)), h])
                };
                launches.push(launch(
                    kernel(name)?,
                    &[Arg::Mem(&input.mem), Arg::Mem(&gray), Arg::I32(wi), Arg::I32(hi)],
                    global,
                    local,
                )?);
                blur_into(&mut launches, &mut keep, GrayIn::Buffer(&gray), &blurred, w, h)?;
                launches.push(launch(
                    kernel("erode")?,
                    &[Arg::Mem(&blurred), Arg::Mem(&mask), Arg::I32(wi), Arg::I32(hi)],
                    [w, h],
                    local,
                )?);
                launches.push(launch(
                    kernel("dilate")?,
                    &[Arg::Mem(&mask), Arg::Mem(&gray), Arg::I32(wi), Arg::I32(hi)],
                    [w, h],
                    local,
                )?);
                let args = [
                    Arg::Mem(&gray),
                    Arg::Mem(&blurred),
                    Arg::Mem(&output.mem),
                    Arg::I32(wi),
                    Arg::I32(hi),
                    Arg::I32(1),
                ];
                launches.push(launch(kernel("moments")?, &args, [h, 1], None)?);
                keep.extend([gray, blurred, mask]);
                (Some(input), Some(output))
            }
            Task::Gemm { n, float } => {
                let n = n as usize;
                let (a, b) = gemm_inputs(n as u32, float);
                let input = endpoint(u32_bytes(&a), true)?;
                let bm = s
                    .buffer(
                        CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                        n * n * 4,
                        u32_bytes(&b).as_ptr() as *mut c_void,
                    )
                    .map_err(failed)?;
                let output = endpoint(vec![0; n * n * 4], false)?;
                let ty = if float { "f32" } else { "i32" };
                let (name, local) = match variant {
                    Variant::Naive => (format!("gemm_{ty}"), local),
                    Variant::Local => (format!("gemm_{ty}_tiled"), Some([16, 16])),
                    _ => {
                        return Err((
                            RowStatus::Unsupported,
                            "gemm has a naive and a tiled (local) kernel".into(),
                        ));
                    }
                };
                launches.push(launch(
                    kernel(&name)?,
                    &[
                        Arg::Mem(&input.mem),
                        Arg::Mem(&bm),
                        Arg::Mem(&output.mem),
                        Arg::I32(n as i32),
                    ],
                    [n, n],
                    local,
                )?);
                keep.push(bm);
                (Some(input), Some(output))
            }
            Task::Reduce { n } => {
                let input = endpoint(u32_bytes(&words(n, 21)), true)?;
                let output = endpoint(vec![0; 4], false)?;
                launches.push(launch(
                    kernel("clear_u32")?,
                    &[Arg::Mem(&output.mem), Arg::I32(1)],
                    [1, 1],
                    None,
                )?);
                let k = kernel("reduce_u32")?;
                let limit = info_value::<usize>(|size, value, ret| unsafe {
                    (s.api.get_kernel_work_group_info)(k.1, s.device, CL_KERNEL_WORK_GROUP_SIZE, size, value, ret)
                });
                // The tree halves the group, so the largest power of two the kernel allows.
                let group = 1usize << (usize::BITS - 1 - limit.clamp(1, 256).leading_zeros());
                launches.push(launch(
                    k,
                    &[
                        Arg::Mem(&input.mem),
                        Arg::Mem(&output.mem),
                        Arg::I32(n as i32),
                        Arg::Local(group * 4),
                    ],
                    [64 * group, 1],
                    Some([group, 1]),
                )?);
                (Some(input), Some(output))
            }
            Task::Mandelbrot { width, height } => {
                let (w, h) = (width as usize, height as usize);
                let output = endpoint(vec![0; w * h], false)?;
                launches.push(launch(
                    kernel("mandelbrot")?,
                    &[Arg::Mem(&output.mem), Arg::I32(w as i32), Arg::I32(h as i32)],
                    [w, h],
                    local,
                )?);
                (None, Some(output))
            }
            Task::Alu { n, float } => {
                let input = endpoint(u32_bytes(&words(n, 31)), true)?;
                let output = endpoint(vec![0; n as usize * 4], false)?;
                let name = if float { "alu_f32" } else { "alu_u32" };
                launches.push(launch(
                    kernel(name)?,
                    &[Arg::Mem(&input.mem), Arg::Mem(&output.mem), Arg::I32(n as i32)],
                    [n as usize, 1],
                    None,
                )?);
                (Some(input), Some(output))
            }
            Task::Sort { n } => {
                if !n.is_power_of_two() {
                    return Err((
                        RowStatus::Unsupported,
                        "the bitonic network needs a power of two".into(),
                    ));
                }
                let input = endpoint(u32_bytes(&words(n, 41)), true)?;
                let output = endpoint(vec![0; n as usize * 4], false)?;
                launches.push(launch(
                    kernel("copy_u32x4")?,
                    &[Arg::Mem(&input.mem), Arg::Mem(&output.mem)],
                    [n as usize / 4, 1],
                    None,
                )?);
                let mut k = 2;
                while k <= n {
                    let mut j = k / 2;
                    while j > 0 {
                        launches.push(launch(
                            kernel("bitonic")?,
                            &[Arg::Mem(&output.mem), Arg::I32(j as i32), Arg::I32(k as i32)],
                            [n as usize, 1],
                            None,
                        )?);
                        j /= 2;
                    }
                    k *= 2;
                }
                (Some(input), Some(output))
            }
            #[expect(clippy::unreachable, reason = "the message states the invariant")]
            Task::Cnn { .. } => unreachable!("refused above"),
            Task::Copy { bytes } => {
                let input = endpoint(random_bytes(bytes as usize), true)?;
                let output = endpoint(vec![0; bytes as usize], false)?;
                launches.push(launch(
                    kernel("copy_u32x4")?,
                    &[Arg::Mem(&input.mem), Arg::Mem(&output.mem)],
                    [bytes as usize / 16, 1],
                    None,
                )?);
                (Some(input), Some(output))
            }
        };
        let bench = ClBench {
            s,
            invalidate: std::cell::Cell::new(true),
            task,
            strategy,
            input,
            output,
            launches,
            _keep: keep,
            _program: Some(program),
        };
        // An image input starts empty; every other input was created with its data.
        if bench.input.as_ref().is_some_and(|i| i.image.is_some()) {
            bench.upload().map_err(failed)?;
        }
        Ok(bench)
    }

    fn map(&self, mem: &Mem, flags: cl_map_flags, len: usize) -> Result<*mut u8, String> {
        let mut err = CL_SUCCESS;
        let ptr = unsafe {
            (self.s.api.enqueue_map_buffer)(
                self.s.queue,
                mem.1,
                CL_TRUE,
                flags,
                0,
                len,
                0,
                null(),
                null_mut(),
                &mut err,
            )
        };
        check(err, "clEnqueueMapBuffer")?;
        Ok(ptr.cast())
    }

    fn unmap(&self, mem: &Mem, ptr: *mut u8) -> Result<(), String> {
        check(
            unsafe { (self.s.api.enqueue_unmap_mem_object)(self.s.queue, mem.1, ptr.cast(), 0, null(), null_mut()) },
            "clEnqueueUnmapMemObject",
        )
    }

    fn upload(&self) -> Result<(), String> {
        let Some(input) = &self.input else { return Ok(()) };
        let api = &self.s.api;
        if let Some([w, h]) = input.image {
            let origin = [0usize; 3];
            let region = [w, h, 1];
            let code = unsafe {
                (api.enqueue_write_image)(
                    self.s.queue,
                    input.mem.1,
                    CL_TRUE,
                    origin.as_ptr(),
                    region.as_ptr(),
                    w,
                    0,
                    input.host.as_ptr().cast(),
                    0,
                    null(),
                    null_mut(),
                )
            };
            return check(code, "clEnqueueWriteImage");
        }
        match self.strategy {
            Strategy::Copy => check(
                unsafe {
                    (api.enqueue_write_buffer)(
                        self.s.queue,
                        input.mem.1,
                        CL_TRUE,
                        0,
                        input.len,
                        input.host.as_ptr().cast(),
                        0,
                        null(),
                        null_mut(),
                    )
                },
                "clEnqueueWriteBuffer",
            ),
            Strategy::Map => {
                let ptr = if self.invalidate.get() {
                    match self.map(&input.mem, CL_MAP_WRITE_INVALIDATE_REGION, input.len) {
                        Ok(ptr) => ptr,
                        Err(_) => {
                            self.invalidate.set(false);
                            self.map(&input.mem, CL_MAP_WRITE, input.len)?
                        }
                    }
                } else {
                    self.map(&input.mem, CL_MAP_WRITE, input.len)?
                };
                unsafe { ptr::copy_nonoverlapping(input.host.as_ptr(), ptr, input.len) };
                self.unmap(&input.mem, ptr)?;
                self.s.finish()
            }
            // The data is already where the buffer lives - the camera would have put it there.
            Strategy::ZeroCopy => {
                let ptr = self.map(&input.mem, CL_MAP_WRITE, input.len)?;
                self.unmap(&input.mem, ptr)?;
                self.s.finish()
            }
        }
    }

    fn download(&mut self) -> Result<(), String> {
        let Some(output) = &mut self.output else { return Ok(()) };
        let api = &self.s.api;
        match self.strategy {
            Strategy::Copy => check(
                unsafe {
                    (api.enqueue_read_buffer)(
                        self.s.queue,
                        output.mem.1,
                        CL_TRUE,
                        0,
                        output.len,
                        output.host.as_mut_ptr().cast(),
                        0,
                        null(),
                        null_mut(),
                    )
                },
                "clEnqueueReadBuffer",
            ),
            Strategy::Map => {
                let mut err = CL_SUCCESS;
                let ptr: *mut u8 = unsafe {
                    (api.enqueue_map_buffer)(
                        self.s.queue,
                        output.mem.1,
                        CL_TRUE,
                        CL_MAP_READ,
                        0,
                        output.len,
                        0,
                        null(),
                        null_mut(),
                        &mut err,
                    )
                }
                .cast();
                check(err, "clEnqueueMapBuffer")?;
                unsafe { ptr::copy_nonoverlapping(ptr, output.host.as_mut_ptr(), output.len) };
                check(
                    unsafe {
                        (api.enqueue_unmap_mem_object)(self.s.queue, output.mem.1, ptr.cast(), 0, null(), null_mut())
                    },
                    "clEnqueueUnmapMemObject",
                )?;
                self.s.finish()
            }
            // Reading the result in place, from the memory the buffer wraps.
            Strategy::ZeroCopy => {
                let mut err = CL_SUCCESS;
                let ptr = unsafe {
                    (api.enqueue_map_buffer)(
                        self.s.queue,
                        output.mem.1,
                        CL_TRUE,
                        CL_MAP_READ,
                        0,
                        output.len,
                        0,
                        null(),
                        null_mut(),
                        &mut err,
                    )
                };
                check(err, "clEnqueueMapBuffer")?;
                check(
                    unsafe { (api.enqueue_unmap_mem_object)(self.s.queue, output.mem.1, ptr, 0, null(), null_mut()) },
                    "clEnqueueUnmapMemObject",
                )?;
                self.s.finish()
            }
        }
    }

    /// Enqueues every launch and waits; the device's own kernel time comes from profiling.
    fn compute(&self) -> Result<Option<f64>, String> {
        let api = &self.s.api;
        let mut events = Vec::with_capacity(self.launches.len());
        for launch in &self.launches {
            let local = launch.local.filter(|_| launch.global[1] > 1 || launch.global[0] > 1);
            let global = match local {
                Some(l) => [
                    launch.global[0].next_multiple_of(l[0]),
                    launch.global[1].next_multiple_of(l[1]),
                ],
                None => launch.global,
            };
            let local_ptr = local.as_ref().map_or(null(), |l| l.as_ptr());
            let mut event = null_mut();
            let code = unsafe {
                (api.enqueue_nd_range_kernel)(
                    self.s.queue,
                    launch.kernel.1,
                    2,
                    null(),
                    global.as_ptr(),
                    local_ptr,
                    0,
                    null(),
                    &mut event,
                )
            };
            if code != CL_SUCCESS {
                for e in events {
                    unsafe { (api.release_event)(e) };
                }
                let mut why = format!("clEnqueueNDRangeKernel: {}", error_name(code));
                if let Some([x, y]) = local {
                    let limit = info_value::<usize>(|size, value, ret| unsafe {
                        (api.get_kernel_work_group_info)(
                            launch.kernel.1,
                            self.s.device,
                            CL_KERNEL_WORK_GROUP_SIZE,
                            size,
                            value,
                            ret,
                        )
                    });
                    why.push_str(&format!(
                        " for work-group {x}x{y}; the kernel reports a limit of {limit}"
                    ));
                }
                return Err(why);
            }
            events.push(event);
        }
        let finished = self.s.finish();
        let mut gpu_ns = Some(0u64);
        for event in events {
            let read = |param| {
                let mut v = 0u64;
                let code =
                    unsafe { (api.get_event_profiling_info)(event, param, 8, (&mut v as *mut u64).cast(), null_mut()) };
                (code == CL_SUCCESS).then_some(v)
            };
            gpu_ns = match (gpu_ns, read(CL_PROFILING_COMMAND_START), read(CL_PROFILING_COMMAND_END)) {
                (Some(total), Some(start), Some(end)) if end >= start => Some(total + (end - start)),
                _ => None,
            };
            unsafe { (api.release_event)(event) };
        }
        finished?;
        Ok(gpu_ns.filter(|&ns| ns > 0).map(|ns| ns as f64 / 1e6))
    }
}

enum GrayIn<'a> {
    Buffer(&'a Mem),
    Image(&'a Mem),
}

/// Why a row could not be built: not available here, or broken.
pub type Refusal = (RowStatus, String);

impl ClBench<'_> {
    /// One frame enqueued without waiting: copies are non-blocking, zero-copy maps are
    /// enqueued with their unmaps, map transfers block on their maps as they must.
    fn enqueue_frame(&mut self) -> Result<(), String> {
        let api = self.s.api.clone();
        let queue = self.s.queue;
        let kernels_only = matches!(self.task, Task::Dispatch | Task::Copy { .. });
        if !kernels_only && let Some(input) = &self.input {
            match (self.strategy, input.image) {
                (_, Some([w, h])) => check(
                    unsafe {
                        (api.enqueue_write_image)(
                            queue,
                            input.mem.1,
                            0,
                            [0usize; 3].as_ptr(),
                            [w, h, 1].as_ptr(),
                            w,
                            0,
                            input.host.as_ptr().cast(),
                            0,
                            null(),
                            null_mut(),
                        )
                    },
                    "clEnqueueWriteImage",
                )?,
                (Strategy::Copy, None) => check(
                    unsafe {
                        (api.enqueue_write_buffer)(
                            queue,
                            input.mem.1,
                            0,
                            0,
                            input.len,
                            input.host.as_ptr().cast(),
                            0,
                            null(),
                            null_mut(),
                        )
                    },
                    "clEnqueueWriteBuffer",
                )?,
                (Strategy::Map, None) => {
                    let ptr = self.map(
                        &input.mem,
                        if self.invalidate.get() {
                            CL_MAP_WRITE_INVALIDATE_REGION
                        } else {
                            CL_MAP_WRITE
                        },
                        input.len,
                    )?;
                    unsafe { ptr::copy_nonoverlapping(input.host.as_ptr(), ptr, input.len) };
                    self.unmap(&input.mem, ptr)?;
                }
                (Strategy::ZeroCopy, None) => {
                    let mut err = CL_SUCCESS;
                    let ptr = unsafe {
                        (api.enqueue_map_buffer)(
                            queue,
                            input.mem.1,
                            0,
                            CL_MAP_WRITE,
                            0,
                            input.len,
                            0,
                            null(),
                            null_mut(),
                            &mut err,
                        )
                    };
                    check(err, "clEnqueueMapBuffer")?;
                    check(
                        unsafe { (api.enqueue_unmap_mem_object)(queue, input.mem.1, ptr, 0, null(), null_mut()) },
                        "clEnqueueUnmapMemObject",
                    )?;
                }
            }
        }
        for launch in &self.launches {
            let local = launch.local.filter(|_| launch.global[1] > 1 || launch.global[0] > 1);
            let global = match local {
                Some(l) => [
                    launch.global[0].next_multiple_of(l[0]),
                    launch.global[1].next_multiple_of(l[1]),
                ],
                None => launch.global,
            };
            let local_ptr = local.as_ref().map_or(null(), |l| l.as_ptr());
            check(
                unsafe {
                    (api.enqueue_nd_range_kernel)(
                        queue,
                        launch.kernel.1,
                        2,
                        null(),
                        global.as_ptr(),
                        local_ptr,
                        0,
                        null(),
                        null_mut(),
                    )
                },
                "clEnqueueNDRangeKernel",
            )?;
        }
        if !kernels_only && let Some(output) = &mut self.output {
            match self.strategy {
                Strategy::Copy => check(
                    unsafe {
                        (api.enqueue_read_buffer)(
                            queue,
                            output.mem.1,
                            0,
                            0,
                            output.len,
                            output.host.as_mut_ptr().cast(),
                            0,
                            null(),
                            null_mut(),
                        )
                    },
                    "clEnqueueReadBuffer",
                )?,
                Strategy::Map => {
                    let mut err = CL_SUCCESS;
                    let ptr: *mut u8 = unsafe {
                        (api.enqueue_map_buffer)(
                            queue,
                            output.mem.1,
                            CL_TRUE,
                            CL_MAP_READ,
                            0,
                            output.len,
                            0,
                            null(),
                            null_mut(),
                            &mut err,
                        )
                    }
                    .cast();
                    check(err, "clEnqueueMapBuffer")?;
                    unsafe { ptr::copy_nonoverlapping(ptr, output.host.as_mut_ptr(), output.len) };
                    check(
                        unsafe {
                            (api.enqueue_unmap_mem_object)(queue, output.mem.1, ptr.cast(), 0, null(), null_mut())
                        },
                        "clEnqueueUnmapMemObject",
                    )?;
                }
                Strategy::ZeroCopy => {
                    let mut err = CL_SUCCESS;
                    let ptr = unsafe {
                        (api.enqueue_map_buffer)(
                            queue,
                            output.mem.1,
                            0,
                            CL_MAP_READ,
                            0,
                            output.len,
                            0,
                            null(),
                            null_mut(),
                            &mut err,
                        )
                    };
                    check(err, "clEnqueueMapBuffer")?;
                    check(
                        unsafe { (api.enqueue_unmap_mem_object)(queue, output.mem.1, ptr, 0, null(), null_mut()) },
                        "clEnqueueUnmapMemObject",
                    )?;
                }
            }
        }
        Ok(())
    }
}

impl Bench for ClBench<'_> {
    fn stream(&mut self, frames: u32) -> Result<(), String> {
        for _ in 0..frames {
            self.enqueue_frame()?;
        }
        self.s.finish()
    }

    fn frame(&mut self) -> Result<FrameTimes, String> {
        let kernels_only = matches!(self.task, Task::Dispatch | Task::Copy { .. });
        let t0 = Instant::now();
        if !kernels_only {
            self.upload()?;
        }
        let t1 = Instant::now();
        let gpu = if self.launches.is_empty() {
            None
        } else {
            self.compute()?
        };
        let t2 = Instant::now();
        if !kernels_only {
            self.download()?;
        }
        let t3 = Instant::now();
        let ms = |a: Instant, b: Instant| (b - a).as_secs_f64() * 1e3;
        Ok(FrameTimes {
            upload: ms(t0, t1),
            compute: ms(t1, t2),
            download: ms(t2, t3),
            gpu,
        })
    }

    fn note(&self) -> Option<String> {
        (!self.invalidate.get())
            .then(|| "the driver refused CL_MAP_WRITE_INVALIDATE_REGION; mapped with CL_MAP_WRITE".to_string())
    }

    fn output(&mut self) -> Result<Vec<u8>, String> {
        let endpoint = match self.task {
            Task::Upload { .. } => self.input.as_ref(),
            Task::Dispatch => return Ok(Vec::new()),
            _ => self.output.as_ref(),
        };
        let endpoint = endpoint.ok_or("nothing to read back")?;
        let mut out = vec![0u8; endpoint.len];
        let code = unsafe {
            (self.s.api.enqueue_read_buffer)(
                self.s.queue,
                endpoint.mem.1,
                CL_TRUE,
                0,
                endpoint.len,
                out.as_mut_ptr().cast(),
                0,
                null(),
                null_mut(),
            )
        };
        check(code, "clEnqueueReadBuffer (verification)")?;
        Ok(out)
    }
}
