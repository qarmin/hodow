//! GLES 3.1 compute: the shared [`Plan`] run through shader storage buffers.
//!
//! GLES has no `glGetBufferSubData`, so a result always comes back through
//! `glMapBufferRange(GL_MAP_READ_BIT)`; the strategies differ only in how the input goes up -
//! `glBufferSubData` for copy, a write mapping that invalidates the buffer for map. There is
//! no way to hand GLES the application's own memory, so zero-copy does not exist here.

use std::cell::RefCell;
use std::collections::HashMap;
use std::time::Instant;

use hodow_gpu::opengl::burn::{gl_string, parse_version};
use hodow_gpu::opengl::{GlApiHint, GpuOptions, OpenGLMode, init_opengl};

use super::shaders::{self, Plan, Refusal};
use super::spec::{RowStatus, Strategy, Task, Variant};
use super::{Bench, FrameTimes};

pub struct Session {
    _ctx: Option<OpenGLMode>,
    pub label: String,
    programs: RefCell<HashMap<String, u32>>,
}

impl Drop for Session {
    fn drop(&mut self) {
        for (_, program) in self.programs.borrow_mut().drain() {
            unsafe { gl::DeleteProgram(program) };
        }
    }
}

fn gl_error(what: &str) -> Result<(), String> {
    let code = unsafe { gl::GetError() };
    if code == gl::NO_ERROR {
        Ok(())
    } else {
        Err(format!("{what}: GL error {code:#06x}"))
    }
}

impl Session {
    pub fn open() -> Result<Session, String> {
        let opts = GpuOptions {
            no_window: true,
            gl_api: GlApiHint::Gles { major: 3, minor: 1 },
            ..Default::default()
        };
        let ctx = init_opengl(&opts).map_err(|e| format!("no GLES context: {e}"))?;
        let version = unsafe { gl_string(gl::VERSION) };
        let renderer = unsafe { gl_string(gl::RENDERER) };
        Self::check_compute(&version)?;
        Ok(Session {
            _ctx: Some(ctx),
            label: format!("{version} - {renderer}"),
            programs: RefCell::default(),
        })
    }

    /// A session on the context the caller already made current, which stays the caller's.
    pub fn on_current_context() -> Result<Session, String> {
        let version = unsafe { gl_string(gl::VERSION) };
        let renderer = unsafe { gl_string(gl::RENDERER) };
        Self::check_compute(&version)?;
        Ok(Session {
            _ctx: None,
            label: format!("{version} - {renderer}"),
            programs: RefCell::default(),
        })
    }

    fn check_compute(version: &str) -> Result<(), String> {
        let (es, major, minor) = parse_version(version);
        // A desktop context takes ES 3.1 shaders from 4.5 (ARB_ES3_1_compatibility).
        let floor = if es { (3, 1) } else { (4, 5) };
        if (major, minor) < floor {
            return Err(format!("{version} has no GLES 3.1 compute shaders"));
        }
        Ok(())
    }

    /// The program for a WGSL source, compiled once per session.
    fn program(&self, wgsl: &str) -> Result<u32, String> {
        if let Some(&p) = self.programs.borrow().get(wgsl) {
            return Ok(p);
        }
        let glsl = shaders::glsl_es(wgsl)?;
        let program = unsafe { compile(&glsl)? };
        self.programs.borrow_mut().insert(wgsl.to_string(), program);
        Ok(program)
    }
}

unsafe fn compile(source: &str) -> Result<u32, String> {
    unsafe {
        let shader = gl::CreateShader(gl::COMPUTE_SHADER);
        let ptr = source.as_ptr().cast();
        let len = source.len() as i32;
        gl::ShaderSource(shader, 1, &ptr, &len);
        gl::CompileShader(shader);
        let mut ok = 0;
        gl::GetShaderiv(shader, gl::COMPILE_STATUS, &mut ok);
        if ok == 0 {
            let log = log(shader, gl::GetShaderiv, gl::GetShaderInfoLog);
            gl::DeleteShader(shader);
            return Err(format!("GLSL did not compile: {log}"));
        }
        let program = gl::CreateProgram();
        gl::AttachShader(program, shader);
        gl::LinkProgram(program);
        gl::DeleteShader(shader);
        gl::GetProgramiv(program, gl::LINK_STATUS, &mut ok);
        if ok == 0 {
            let log = log(program, gl::GetProgramiv, gl::GetProgramInfoLog);
            gl::DeleteProgram(program);
            return Err(format!("program did not link: {log}"));
        }
        Ok(program)
    }
}

type GetIv = unsafe fn(u32, u32, *mut i32);
type GetLog = unsafe fn(u32, i32, *mut i32, *mut gl::types::GLchar);

unsafe fn log(object: u32, get_iv: GetIv, get_log: GetLog) -> String {
    unsafe {
        let mut len = 0;
        get_iv(object, gl::INFO_LOG_LENGTH, &mut len);
        let mut buf = vec![0u8; len.max(1) as usize];
        get_log(object, len, std::ptr::null_mut(), buf.as_mut_ptr().cast());
        let text = String::from_utf8_lossy(&buf).trim_end_matches('\0').trim().to_string();
        text.lines().take(6).collect::<Vec<_>>().join(" / ")
    }
}

struct Launch {
    program: u32,
    ubo: u32,
    src: u32,
    dst: u32,
    aux: u32,
    groups: [u32; 3],
}

pub struct GlBench<'s> {
    _s: &'s Session,
    plan: Plan,
    strategy: Strategy,
    names: Vec<u32>,
    launches: Vec<Launch>,
    input: Vec<u8>,
    output: Vec<u8>,
}

impl Drop for GlBench<'_> {
    fn drop(&mut self) {
        unsafe {
            gl::DeleteBuffers(self.names.len() as i32, self.names.as_ptr());
            for l in &self.launches {
                gl::DeleteBuffers(1, &l.ubo);
            }
        }
    }
}

impl<'s> GlBench<'s> {
    pub fn new(s: &'s Session, task: Task, variant: Variant, strategy: Strategy) -> Result<GlBench<'s>, Refusal> {
        if strategy == Strategy::ZeroCopy {
            return Err((
                RowStatus::Unsupported,
                "GLES cannot use the application's own memory".into(),
            ));
        }
        let plan = shaders::plan(task, variant)?;
        let failed = |e: String| (RowStatus::Failed, e);
        unsafe {
            while gl::GetError() != gl::NO_ERROR {}
            let mut names = vec![0u32; plan.buffers.len()];
            gl::GenBuffers(names.len() as i32, names.as_mut_ptr());
            for (name, data) in names.iter().zip(&plan.buffers) {
                gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, *name);
                gl::BufferData(
                    gl::SHADER_STORAGE_BUFFER,
                    data.len() as isize,
                    data.as_ptr().cast(),
                    gl::DYNAMIC_DRAW,
                );
            }
            let mut bench = GlBench {
                _s: s,
                input: plan.input.map(|i| plan.buffers[i].clone()).unwrap_or_default(),
                output: vec![0; plan.output_len],
                strategy,
                names,
                launches: Vec::new(),
                plan,
            };
            gl_error("buffer allocation").map_err(failed)?;
            for l in &bench.plan.launches {
                let program = s.program(&l.source).map_err(failed)?;
                let mut ubo = 0;
                gl::GenBuffers(1, &mut ubo);
                gl::BindBuffer(gl::UNIFORM_BUFFER, ubo);
                gl::BufferData(gl::UNIFORM_BUFFER, 16, l.params.as_ptr().cast(), gl::STATIC_DRAW);
                bench.launches.push(Launch {
                    program,
                    ubo,
                    src: bench.names[l.src],
                    dst: bench.names[l.dst],
                    aux: bench.names[l.aux],
                    groups: l.groups,
                });
            }
            gl_error("program setup").map_err(failed)?;
            Ok(bench)
        }
    }

    /// A frame with no glFinish anywhere; only the readback's map waits, as it must.
    unsafe fn enqueue_frame(&mut self) -> Result<(), String> {
        let (up, down) = self.plan.transfers;
        unsafe {
            if up && let Some(input) = self.plan.input {
                gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, self.names[input]);
                gl::BufferSubData(
                    gl::SHADER_STORAGE_BUFFER,
                    0,
                    self.input.len() as isize,
                    self.input.as_ptr().cast(),
                );
            }
            for l in &self.launches {
                gl::UseProgram(l.program);
                gl::BindBufferBase(gl::UNIFORM_BUFFER, 0, l.ubo);
                gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 1, l.src);
                gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 2, l.dst);
                gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 3, self.names[1]);
                gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 4, l.aux);
                gl::DispatchCompute(l.groups[0], l.groups[1], l.groups[2]);
                gl::MemoryBarrier(gl::SHADER_STORAGE_BARRIER_BIT);
            }
            if down && let Some(output) = self.plan.output {
                self.output = self.read(output, self.plan.output_len)?;
            }
            gl_error("stream frame")
        }
    }

    unsafe fn upload(&mut self) -> Result<(), String> {
        let Some(input) = self.plan.input else { return Ok(()) };
        unsafe {
            gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, self.names[input]);
            match self.strategy {
                Strategy::Copy => gl::BufferSubData(
                    gl::SHADER_STORAGE_BUFFER,
                    0,
                    self.input.len() as isize,
                    self.input.as_ptr().cast(),
                ),
                _ => {
                    let ptr = gl::MapBufferRange(
                        gl::SHADER_STORAGE_BUFFER,
                        0,
                        self.input.len() as isize,
                        gl::MAP_WRITE_BIT | gl::MAP_INVALIDATE_BUFFER_BIT,
                    );
                    if ptr.is_null() {
                        return Err(format!(
                            "glMapBufferRange(write) returned null (GL error {:#06x})",
                            gl::GetError()
                        ));
                    }
                    std::ptr::copy_nonoverlapping(self.input.as_ptr(), ptr.cast(), self.input.len());
                    gl::UnmapBuffer(gl::SHADER_STORAGE_BUFFER);
                }
            }
            gl::Finish();
            gl_error("upload")
        }
    }

    unsafe fn compute(&self) -> Result<(), String> {
        unsafe {
            for l in &self.launches {
                gl::UseProgram(l.program);
                gl::BindBufferBase(gl::UNIFORM_BUFFER, 0, l.ubo);
                gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 1, l.src);
                gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 2, l.dst);
                gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 3, self.names[1]);
                gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 4, l.aux);
                gl::DispatchCompute(l.groups[0], l.groups[1], l.groups[2]);
                gl::MemoryBarrier(gl::SHADER_STORAGE_BARRIER_BIT);
            }
            gl::Finish();
            gl_error("dispatch")
        }
    }

    unsafe fn read(&mut self, buffer: usize, len: usize) -> Result<Vec<u8>, String> {
        unsafe {
            gl::MemoryBarrier(gl::BUFFER_UPDATE_BARRIER_BIT | gl::SHADER_STORAGE_BARRIER_BIT);
            gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, self.names[buffer]);
            let ptr = gl::MapBufferRange(gl::SHADER_STORAGE_BUFFER, 0, len as isize, gl::MAP_READ_BIT);
            if ptr.is_null() {
                return Err(format!(
                    "glMapBufferRange(read) returned null (GL error {:#06x})",
                    gl::GetError()
                ));
            }
            let mut out = std::mem::take(&mut self.output);
            out.resize(len, 0);
            std::ptr::copy_nonoverlapping(ptr.cast::<u8>(), out.as_mut_ptr(), len);
            gl::UnmapBuffer(gl::SHADER_STORAGE_BUFFER);
            gl_error("download")?;
            Ok(out)
        }
    }
}

impl Bench for GlBench<'_> {
    fn stream(&mut self, frames: u32) -> Result<(), String> {
        for _ in 0..frames {
            unsafe { self.enqueue_frame()? };
        }
        unsafe { gl::Finish() };
        Ok(())
    }

    fn frame(&mut self) -> Result<FrameTimes, String> {
        let (up, down) = self.plan.transfers;
        let t0 = Instant::now();
        if up {
            unsafe { self.upload()? };
        }
        let t1 = Instant::now();
        if !self.launches.is_empty() {
            unsafe { self.compute()? };
        }
        let t2 = Instant::now();
        if down && let Some(output) = self.plan.output {
            self.output = unsafe { self.read(output, self.plan.output_len)? };
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
        match (self.plan.output, self.plan.input) {
            (Some(o), _) => unsafe { self.read(o, self.plan.output_len) },
            (None, Some(i)) => {
                let len = self.input.len();
                unsafe { self.read(i, len) }
            }
            (None, None) => Ok(Vec::new()),
        }
    }
}
