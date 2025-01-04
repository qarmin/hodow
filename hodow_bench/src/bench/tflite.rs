//! TensorFlow Lite through its C API, opened at run time: the CPU kernels it ships, and the
//! NPU through the VX delegate (`libvx_delegate.so`, TIM-VX over OpenVX) when that is
//! installed. Models are written by `tflite_model.rs`, so there is nothing to download.
//!
//! The delegate's answers are compared with the same model on TFLite's own CPU kernels; a
//! quantized graph rounds its own way, so that, and not the bench's integer blur, is what
//! a delegate has to agree with.

use std::ffi::{c_char, c_void};
use std::time::Instant;

use libloading::Library;

use super::data::gray_u8;
use super::spec::{RowStatus, Task, TfliteDelegate};
use super::{Bench, FrameTimes, tflite_model};

pub type Refusal = (RowStatus, String);

const LIBRARIES: &[&str] = &[
    "libtensorflowlite_c.so",
    "libtensorflow-lite.so",
    "libtensorflow-lite.so.2.19.0",
    "/usr/lib/libtensorflow-lite.so.2.19.0",
];
const VX_DELEGATE: &[&str] = &["libvx_delegate.so", "/usr/lib/libvx_delegate.so"];

type Opaque = *mut c_void;

pub struct Api {
    _lib: Library,
    pub name: String,
    model_create: unsafe extern "C" fn(*const c_void, usize) -> Opaque,
    model_delete: unsafe extern "C" fn(Opaque),
    options_create: unsafe extern "C" fn() -> Opaque,
    options_delete: unsafe extern "C" fn(Opaque),
    options_threads: unsafe extern "C" fn(Opaque, i32),
    options_delegate: unsafe extern "C" fn(Opaque, Opaque),
    interpreter_create: unsafe extern "C" fn(Opaque, Opaque) -> Opaque,
    interpreter_delete: unsafe extern "C" fn(Opaque),
    allocate: unsafe extern "C" fn(Opaque) -> i32,
    input: unsafe extern "C" fn(Opaque, i32) -> Opaque,
    output: unsafe extern "C" fn(Opaque, i32) -> Opaque,
    copy_in: unsafe extern "C" fn(Opaque, *const c_void, usize) -> i32,
    copy_out: unsafe extern "C" fn(Opaque, *mut c_void, usize) -> i32,
    invoke: unsafe extern "C" fn(Opaque) -> i32,
    byte_size: unsafe extern "C" fn(Opaque) -> usize,
}

impl Api {
    pub fn load() -> Result<Self, String> {
        let mut tried = Vec::new();
        for name in LIBRARIES {
            match unsafe { Library::new(*name) } {
                Ok(lib) => return unsafe { Self::from(lib, name) },
                Err(e) => tried.push(format!("{name}: {e}")),
            }
        }
        Err(format!("no TensorFlow Lite library ({})", tried.join("; ")))
    }

    unsafe fn from(lib: Library, name: &str) -> Result<Self, String> {
        macro_rules! sym {
            ($s:literal) => {
                *unsafe { lib.get(concat!($s, "\0").as_bytes()) }.map_err(|e| format!("{}: {e}", $s))?
            };
        }
        Ok(Self {
            model_create: sym!("TfLiteModelCreate"),
            model_delete: sym!("TfLiteModelDelete"),
            options_create: sym!("TfLiteInterpreterOptionsCreate"),
            options_delete: sym!("TfLiteInterpreterOptionsDelete"),
            options_threads: sym!("TfLiteInterpreterOptionsSetNumThreads"),
            options_delegate: sym!("TfLiteInterpreterOptionsAddDelegate"),
            interpreter_create: sym!("TfLiteInterpreterCreate"),
            interpreter_delete: sym!("TfLiteInterpreterDelete"),
            allocate: sym!("TfLiteInterpreterAllocateTensors"),
            input: sym!("TfLiteInterpreterGetInputTensor"),
            output: sym!("TfLiteInterpreterGetOutputTensor"),
            copy_in: sym!("TfLiteTensorCopyFromBuffer"),
            copy_out: sym!("TfLiteTensorCopyToBuffer"),
            invoke: sym!("TfLiteInterpreterInvoke"),
            byte_size: sym!("TfLiteTensorByteSize"),
            name: name.to_string(),
            _lib: lib,
        })
    }
}

/// `tflite_plugin_create_delegate`, the entry point every external delegate exports.
struct VxDelegate {
    _lib: Library,
    delegate: Opaque,
    destroy: unsafe extern "C" fn(Opaque),
}

impl VxDelegate {
    fn load() -> Result<Self, String> {
        let mut tried = Vec::new();
        for name in VX_DELEGATE {
            let lib = match unsafe { Library::new(*name) } {
                Ok(l) => l,
                Err(e) => {
                    tried.push(format!("{name}: {e}"));
                    continue;
                }
            };
            type Create = unsafe extern "C" fn(
                *const *const c_char,
                *const *const c_char,
                usize,
                Option<unsafe extern "C" fn(*const c_char)>,
            ) -> Opaque;
            let create: Create =
                *unsafe { lib.get(b"tflite_plugin_create_delegate\0") }.map_err(|e| format!("{name}: {e}"))?;
            let destroy: unsafe extern "C" fn(Opaque) =
                *unsafe { lib.get(b"tflite_plugin_destroy_delegate\0") }.map_err(|e| format!("{name}: {e}"))?;
            let delegate = unsafe { create(std::ptr::null(), std::ptr::null(), 0, None) };
            if delegate.is_null() {
                return Err(format!("{name}: tflite_plugin_create_delegate returned null"));
            }
            return Ok(Self {
                _lib: lib,
                delegate,
                destroy,
            });
        }
        Err(format!("no VX delegate, so no NPU ({})", tried.join("; ")))
    }
}

impl Drop for VxDelegate {
    fn drop(&mut self) {
        unsafe { (self.destroy)(self.delegate) };
    }
}

pub fn model(task: Task) -> Result<(Vec<u8>, Vec<u8>, usize), Refusal> {
    match task {
        Task::Blur { width, height, radius } => {
            let model = tflite_model::blur(width, height, radius as usize)
                .ok_or((RowStatus::Unsupported, "radius 0 has a weight uint8 cannot hold".into()))?;
            Ok((model, gray_u8(width, height), (width * height) as usize))
        }
        Task::Cnn { size } => {
            let input: Vec<u8> = gray_u8(size * 3, size).into_iter().collect();
            Ok((tflite_model::cnn(size), input, tflite_model::cnn_output_len(size)))
        }
        _ => Err((RowStatus::Unsupported, "no TFLite model for this task".into())),
    }
}

pub struct TfliteBench {
    api: std::sync::Arc<Api>,
    _delegate: Option<VxDelegate>,
    _model_bytes: Vec<u64>,
    model: Opaque,
    options: Opaque,
    interpreter: Opaque,
    input: Vec<u8>,
    output: Vec<u8>,
}

impl Drop for TfliteBench {
    fn drop(&mut self) {
        unsafe {
            (self.api.interpreter_delete)(self.interpreter);
            (self.api.options_delete)(self.options);
            (self.api.model_delete)(self.model);
        }
    }
}

impl TfliteBench {
    #[expect(
        clippy::needless_pass_by_value,
        reason = "the call sites build the arguments in place"
    )]
    pub fn new(api: std::sync::Arc<Api>, task: Task, delegate: TfliteDelegate) -> Result<Self, Refusal> {
        let (bytes, input, output_len) = model(task)?;
        let vx = match delegate {
            TfliteDelegate::Vx => Some(VxDelegate::load().map_err(|e| (RowStatus::Unsupported, e))?),
            TfliteDelegate::Cpu { .. } => None,
        };
        // The interpreter keeps pointing into the model's memory, aligned as FlatBuffers expects.
        let mut words = vec![0u64; bytes.len().div_ceil(8)];
        unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), words.as_mut_ptr().cast::<u8>(), bytes.len()) };
        let failed = |e: &str| (RowStatus::Failed, e.to_string());
        unsafe {
            let model = (api.model_create)(words.as_ptr().cast(), bytes.len());
            if model.is_null() {
                return Err(failed("TfLiteModelCreate rejected the model"));
            }
            let options = (api.options_create)();
            if let TfliteDelegate::Cpu { threads } = delegate {
                (api.options_threads)(options, threads as i32);
            }
            if let Some(vx) = &vx {
                (api.options_delegate)(options, vx.delegate);
            }
            let interpreter = (api.interpreter_create)(model, options);
            if interpreter.is_null() {
                (api.options_delete)(options);
                (api.model_delete)(model);
                return Err(failed("TfLiteInterpreterCreate failed (delegate refused the graph?)"));
            }
            let bench = Self {
                api: api.clone(),
                _delegate: vx,
                _model_bytes: words,
                model,
                options,
                interpreter,
                input,
                output: vec![0; output_len],
            };
            if (api.allocate)(interpreter) != 0 {
                return Err(failed("TfLiteInterpreterAllocateTensors failed"));
            }
            let (input_size, output_size) = (
                (api.byte_size)((api.input)(interpreter, 0)),
                (api.byte_size)((api.output)(interpreter, 0)),
            );
            if input_size != bench.input.len() || output_size != bench.output.len() {
                return Err(failed(&format!(
                    "tensor sizes {input_size}/{output_size}, expected {}/{}",
                    bench.input.len(),
                    bench.output.len()
                )));
            }
            Ok(bench)
        }
    }
}

impl Bench for TfliteBench {
    fn frame(&mut self) -> Result<FrameTimes, String> {
        let api = &self.api;
        let t0 = Instant::now();
        let code = unsafe {
            (api.copy_in)(
                (api.input)(self.interpreter, 0),
                self.input.as_ptr().cast(),
                self.input.len(),
            )
        };
        if code != 0 {
            return Err(format!("TfLiteTensorCopyFromBuffer: status {code}"));
        }
        let t1 = Instant::now();
        let code = unsafe { (api.invoke)(self.interpreter) };
        if code != 0 {
            return Err(format!("TfLiteInterpreterInvoke: status {code}"));
        }
        let t2 = Instant::now();
        let code = unsafe {
            (api.copy_out)(
                (api.output)(self.interpreter, 0),
                self.output.as_mut_ptr().cast(),
                self.output.len(),
            )
        };
        if code != 0 {
            return Err(format!("TfLiteTensorCopyToBuffer: status {code}"));
        }
        let t3 = Instant::now();
        let ms = |a: Instant, b: Instant| (b - a).as_secs_f64() * 1e3;
        Ok(FrameTimes {
            upload: ms(t0, t1),
            compute: ms(t1, t2),
            download: ms(t2, t3),
            gpu: None,
        })
    }

    fn output(&mut self) -> Result<Vec<u8>, String> {
        Ok(self.output.clone())
    }
}
