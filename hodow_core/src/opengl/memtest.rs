//! GPU memory test (memtest86-style) over OpenGL.
//!
//! Allocates a large GPU buffer and, for a set of bit patterns, verifies that:
//!   1. the data survives an upload -> download round-trip (storage + both transfer paths), and
//!   2. a compute shader can read-modify-write every word correctly (GPU access to the memory).
//!
//! Any mismatch is a bit error in GPU memory (or the transfer path). Expected values are
//! derived analytically from each pattern, so this is driver/vendor independent.

use crate::opengl::GpuOptions;

#[derive(Debug, Clone)]
pub struct PatternResult {
    pub name: String,
    /// Round-trip (upload/download) word errors.
    pub roundtrip_errors: u64,
    /// Compute read-modify-write word errors (0 if compute unavailable).
    pub compute_errors: u64,
    /// First mismatch as (word_index, got, expected), if any.
    pub first_error: Option<(usize, u32, u32)>,
}

#[derive(Debug, Clone)]
pub struct MemtestReport {
    pub buffer_bytes: usize,
    pub compute_used: bool,
    pub patterns: Vec<PatternResult>,
}

impl MemtestReport {
    pub fn total_errors(&self) -> u64 {
        self.patterns.iter().map(|p| p.roundtrip_errors + p.compute_errors).sum()
    }
}

/// A named pattern generator: given a word index, produce the expected word.
struct Pattern {
    name: &'static str,
    word: fn(usize) -> u32,
}

const PATTERNS: &[Pattern] = &[
    Pattern {
        name: "zeros",
        word: |_| 0x0000_0000,
    },
    Pattern {
        name: "ones",
        word: |_| 0xFFFF_FFFF,
    },
    Pattern {
        name: "checker_AA",
        word: |_| 0xAAAA_AAAA,
    },
    Pattern {
        name: "checker_55",
        word: |_| 0x5555_5555,
    },
    Pattern {
        name: "address",
        word: |i| i as u32,
    },
    Pattern {
        name: "inv_address",
        word: |i| !(i as u32),
    },
];

// Grid-stride loop: a bounded number of work groups is dispatched (a single dimension is
// limited to GL_MAX_COMPUTE_WORK_GROUP_COUNT, guaranteed >= 65535), and each invocation strides
// over the whole buffer. This scales to arbitrarily large buffers.
/// The same kernel twice, because no single `#version` reaches every driver that can run it:
/// `310 es` is the only one a GLES 3.1 driver accepts (an i.MX/Vivante board could not run the
/// memory test at all before), and a desktop context needs GL 4.5 to accept that spelling, so
/// `430` covers 4.3/4.4. Tried in order; the first that compiles wins.
const COMPUTE_SRCS: &[&[u8]] = &[
    b"#version 310 es\nlayout(local_size_x=256) in;\nlayout(std430, binding=0) buffer B { uint data[]; };\nuniform uint uCount;\nvoid main(){ uint stride = gl_NumWorkGroups.x * gl_WorkGroupSize.x; for (uint i = gl_GlobalInvocationID.x; i < uCount; i += stride) { data[i] = data[i] ^ 0xFFFFFFFFu; } }\n\0",
    b"#version 430\nlayout(local_size_x=256) in;\nlayout(std430, binding=0) buffer B { uint data[]; };\nuniform uint uCount;\nvoid main(){ uint stride = gl_NumWorkGroups.x * gl_WorkGroupSize.x; for (uint i = gl_GlobalInvocationID.x; i < uCount; i += stride) { data[i] = data[i] ^ 0xFFFFFFFFu; } }\n\0",
];

/// Read the SSBO back into `dst`. GLES has no `glGetBufferSubData`, so this maps the range -
/// which a desktop driver serves just as well, so there is one path rather than two.
///
/// # Safety
/// Requires a current context with the buffer bound to `GL_SHADER_STORAGE_BUFFER`.
unsafe fn read_ssbo(dst: &mut [u32]) -> Result<(), String> {
    unsafe {
        let bytes = std::mem::size_of_val(dst) as isize;
        let ptr = gl::MapBufferRange(gl::SHADER_STORAGE_BUFFER, 0, bytes, gl::MAP_READ_BIT) as *const u32;
        if ptr.is_null() {
            return Err("glMapBufferRange returned null while reading the test buffer back".into());
        }
        std::ptr::copy_nonoverlapping(ptr, dst.as_mut_ptr(), dst.len());
        gl::UnmapBuffer(gl::SHADER_STORAGE_BUFFER);
        Ok(())
    }
}

/// Build the compute program from the first source the driver accepts, reporting every
/// rejection if none of them compiles.
///
/// # Safety
/// Requires a current GL context.
unsafe fn build_compute_any(sources: &[&[u8]]) -> Result<u32, String> {
    let mut failures = Vec::new();
    for src in sources {
        match unsafe { build_compute(src) } {
            Ok(p) => return Ok(p),
            Err(e) => failures.push(e),
        }
    }
    Err(format!("no compute shader variant compiled: {}", failures.join("; ")))
}

/// Max work groups to dispatch in one dimension (GL guarantees at least this many).
const MAX_GROUPS: usize = 65535;

/// Run the GPU memory test with a buffer of `size_mb` megabytes.
pub fn run_memtest(opts: &GpuOptions, size_mb: usize) -> Result<MemtestReport, String> {
    // Keep the context alive for the whole test (it must stay current).
    let _ctx = crate::opengl::init_opengl(opts).map_err(|e| format!("failed to create GL context: {e}"))?;
    let size_mb = size_mb.max(1);
    let count = size_mb * 1024 * 1024 / 4;
    // SAFETY: standard GL buffer lifecycle; all objects deleted before returning.
    unsafe { run_inner(count) }
}

unsafe fn run_inner(count: usize) -> Result<MemtestReport, String> {
    unsafe {
        while gl::GetError() != gl::NO_ERROR {}

        let bytes = count * 4;
        let compute_used = gl_supports_compute();

        let program = if compute_used { Some(build_compute_any(COMPUTE_SRCS)?) } else { None };
        let u_count_loc = program.map(|p| {
            gl::UseProgram(p);
            gl::GetUniformLocation(p, c"uCount".as_ptr())
        });

        let mut ssbo = 0u32;
        gl::GenBuffers(1, &mut ssbo);
        gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, ssbo);
        gl::BufferData(gl::SHADER_STORAGE_BUFFER, bytes as isize, std::ptr::null(), gl::DYNAMIC_READ);
        if let Some(e) = gl_error() {
            gl::DeleteBuffers(1, &ssbo);
            if let Some(p) = program {
                gl::DeleteProgram(p);
            }
            return Err(format!("failed to allocate {}-byte GPU buffer: {e}", bytes));
        }
        gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, ssbo);

        let mut host = vec![0u32; count];
        let mut readback = vec![0u32; count];
        let mut patterns = Vec::new();

        for p in PATTERNS {
            for (i, w) in host.iter_mut().enumerate() {
                *w = (p.word)(i);
            }

            // 1) Upload -> download round-trip.
            gl::BufferSubData(gl::SHADER_STORAGE_BUFFER, 0, bytes as isize, host.as_ptr() as *const std::ffi::c_void);
            read_ssbo(&mut readback)?;
            let (rt_errors, mut first) = compare(&readback, |i| (p.word)(i));

            // 2) Compute read-modify-write (invert), then verify against the inverted pattern.
            let mut compute_errors = 0u64;
            if let (Some(prog), Some(loc)) = (program, u_count_loc) {
                gl::UseProgram(prog);
                gl::Uniform1ui(loc, count as u32);
                let groups = count.div_ceil(256).min(MAX_GROUPS) as u32;
                gl::DispatchCompute(groups, 1, 1);
                gl::MemoryBarrier(gl::SHADER_STORAGE_BARRIER_BIT | gl::BUFFER_UPDATE_BARRIER_BIT);
                gl::Finish();
                read_ssbo(&mut readback)?;
                let (ce, cf) = compare(&readback, |i| !(p.word)(i));
                compute_errors = ce;
                if first.is_none() {
                    first = cf;
                }
            }

            patterns.push(PatternResult {
                name: p.name.to_string(),
                roundtrip_errors: rt_errors,
                compute_errors,
                first_error: first,
            });
        }

        gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, 0);
        gl::DeleteBuffers(1, &ssbo);
        if let Some(p) = program {
            gl::UseProgram(0);
            gl::DeleteProgram(p);
        }

        Ok(MemtestReport {
            buffer_bytes: bytes,
            compute_used,
            patterns,
        })
    }
}

/// Compare `actual` word-by-word against `expected(i)`. Returns (error_count, first_mismatch).
fn compare(actual: &[u32], expected: impl Fn(usize) -> u32) -> (u64, Option<(usize, u32, u32)>) {
    let mut errors = 0u64;
    let mut first = None;
    for (i, &got) in actual.iter().enumerate() {
        let exp = expected(i);
        if got != exp {
            errors += 1;
            if first.is_none() {
                first = Some((i, got, exp));
            }
        }
    }
    (errors, first)
}

unsafe fn gl_error() -> Option<u32> {
    let e = unsafe { gl::GetError() };
    if e == gl::NO_ERROR { None } else { Some(e) }
}

unsafe fn gl_supports_compute() -> bool {
    let mut major = 0i32;
    let mut minor = 0i32;
    unsafe {
        gl::GetIntegerv(gl::MAJOR_VERSION, &mut major);
        gl::GetIntegerv(gl::MINOR_VERSION, &mut minor);
        while gl::GetError() != gl::NO_ERROR {}
    }
    major > 4 || (major == 4 && minor >= 3)
}

unsafe fn build_compute(src: &[u8]) -> Result<u32, String> {
    unsafe {
        let cs = gl::CreateShader(gl::COMPUTE_SHADER);
        gl::ShaderSource(cs, 1, &(src.as_ptr() as *const gl::types::GLchar), std::ptr::null());
        gl::CompileShader(cs);
        let mut ok = 0i32;
        gl::GetShaderiv(cs, gl::COMPILE_STATUS, &mut ok);
        if ok == 0 {
            gl::DeleteShader(cs);
            return Err("memtest compute shader failed to compile".into());
        }
        let program = gl::CreateProgram();
        gl::AttachShader(program, cs);
        gl::LinkProgram(program);
        gl::DeleteShader(cs);
        let mut linked = 0i32;
        gl::GetProgramiv(program, gl::LINK_STATUS, &mut linked);
        if linked == 0 {
            gl::DeleteProgram(program);
            return Err("memtest compute program failed to link".into());
        }
        Ok(program)
    }
}
