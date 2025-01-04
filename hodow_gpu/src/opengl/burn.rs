//! The OpenGL half of `hodow burn`: three small kernels meant to load the GPU as hard as
//! basic operations can, each with an output that is known exactly.
//!
//! Deliberately not conformance testing - that is `hodow_cts`. Every shader here is a few
//! lines of integer arithmetic, so a wrong answer points at the hardware or at the driver's
//! most basic paths, not at a corner of the specification.

use std::ffi::CStr;
use std::sync::atomic::{AtomicU64, AtomicUsize, Ordering};
use std::time::{Duration, Instant};

use glutin::context::PossiblyCurrentGlContext;

use crate::burn::{ALU_K1, ALU_K1_INV, ALU_K2, ALU_ROUNDS, BurnError, BurnReport, pattern_word, until};
use crate::opengl::{GlApiHint, GpuOptions, OpenGLMode, init_opengl};

const LOCAL_SIZE: u32 = 256;
const MAX_GROUPS: u32 = 65535;
const MAX_CHUNK_BYTES: u64 = 64 << 20;
const UPLOAD_WORDS: u32 = 1 << 18;
const ALU_WORDS: u32 = 1 << 20;
const RENDER_SIZE: i32 = 512;
const RENDER_DRAWS: u32 = 200;
const RENDER_ROUNDS: u32 = 16;
const NO_INJECT: u32 = u32::MAX;
const CONTEXT_THREADS: usize = 4;
const CONTEXT_WORDS: u32 = 1 << 16;
const PASSES_PER_CONTEXT: u32 = 4;
const THREAD_DONE: u64 = u64::MAX;

pub struct GlBurn {
    _ctx: OpenGLMode,
    opts: GpuOptions,
    pub label: String,
    es: bool,
    major: u32,
    minor: u32,
}

impl GlBurn {
    /// A context able to run compute: GLES 3.1 first (what the boards have), then desktop.
    pub fn open() -> Result<Self, BurnError> {
        let mut failures = Vec::new();
        for gl_api in [GlApiHint::Gles { major: 3, minor: 1 }, GlApiHint::Auto] {
            let opts = GpuOptions {
                no_window: true,
                gl_api,
                ..Default::default()
            };
            let ctx = match init_opengl(&opts) {
                Ok(ctx) => ctx,
                Err(e) => {
                    failures.push(e.to_string());
                    continue;
                }
            };
            let version = unsafe { gl_string(gl::VERSION) };
            let renderer = unsafe { gl_string(gl::RENDERER) };
            let (es, major, minor) = parse_version(&version);
            let burn = Self {
                _ctx: ctx,
                opts,
                label: format!(
                    "{} - {renderer}",
                    if es {
                        format!("GLES {major}.{minor}")
                    } else {
                        format!("GL {major}.{minor}")
                    }
                ),
                es,
                major,
                minor,
            };
            if burn.has_compute() {
                return Ok(burn);
            }
            failures.push(format!("{version} has no compute shaders"));
        }
        Err(BurnError::Unsupported(format!(
            "no OpenGL ES 3.1 / GL 4.3 compute context: {}",
            failures.join("; ")
        )))
    }

    fn has_compute(&self) -> bool {
        let at_least = |maj, min| (self.major, self.minor) >= (maj, min);
        if self.es { at_least(3, 1) } else { at_least(4, 3) }
    }

    fn compute_header(&self) -> &'static str {
        if self.es {
            "#version 310 es\nprecision highp int;\n"
        } else {
            "#version 430\n"
        }
    }

    fn graphics_header(&self) -> &'static str {
        if self.es {
            "#version 300 es\nprecision highp float;\nprecision highp int;\n"
        } else {
            "#version 330 core\n"
        }
    }

    /// How much memory the GPU tests may take, and where that number came from.
    #[expect(clippy::unused_self, reason = "same shape as the other burn methods")]
    pub fn memory_budget(&self) -> (u64, String) {
        unsafe {
            while gl::GetError() != gl::NO_ERROR {}
            if has_extension("GL_NVX_gpu_memory_info") {
                let mut kb = 0;
                gl::GetIntegerv(0x9049, &mut kb);
                if kb > 0 {
                    return (
                        kb as u64 * 1024 * 8 / 10,
                        "80% of free VRAM (GL_NVX_gpu_memory_info)".into(),
                    );
                }
            }
            if has_extension("GL_ATI_meminfo") {
                let mut kb = [0i32; 4];
                gl::GetIntegerv(0x87FC, kb.as_mut_ptr());
                if kb[0] > 0 {
                    return (kb[0] as u64 * 1024 * 8 / 10, "80% of free VRAM (GL_ATI_meminfo)".into());
                }
            }
        }
        match (
            meminfo_bytes("CmaTotal"),
            meminfo_bytes("CmaFree"),
            meminfo_bytes("MemAvailable"),
        ) {
            (Some(total), Some(free), _) if total > 0 => (free * 6 / 10, "60% of CmaFree".into()),
            (_, _, Some(available)) => (available / 4, "25% of MemAvailable (shared memory)".into()),
            _ => (256 << 20, "fixed 256 MB (nothing to size it from)".into()),
        }
    }

    /// Patterns written by a shader, inverted in place by a shader, and uploaded from the host,
    /// each read back and compared, over `bytes` of GPU buffers.
    pub fn memory(
        &self,
        bytes: u64,
        deadline: Instant,
        inject: bool,
        beat: &mut dyn FnMut(),
    ) -> Result<BurnReport, BurnError> {
        let source = format!(
            "{}layout(local_size_x={LOCAL_SIZE}) in;\nlayout(std430, binding=0) buffer B {{ uint data[]; }};\n\
             uniform uint uCount; uniform uint uSeed; uniform uint uBase; uniform uint uMode;\n{PATTERN_GLSL}\n\
             void main() {{ uint stride = gl_NumWorkGroups.x * gl_WorkGroupSize.x;\n\
             for (uint i = gl_GlobalInvocationID.x; i < uCount; i += stride) {{\n\
             if (uMode == 0u) {{ data[i] = pattern_word(uBase + i, uSeed); }} else {{ data[i] = ~data[i]; }} }} }}\n",
            self.compute_header()
        );
        unsafe {
            let program = Program::compute(&source)?;
            let mut max_block: i64 = 0;
            gl::GetInteger64v(gl::MAX_SHADER_STORAGE_BLOCK_SIZE, &mut max_block);
            let bytes = bytes.max(1 << 20);
            let chunk_bytes = (max_block.max(1 << 20) as u64).min(MAX_CHUNK_BYTES).min(bytes) & !1023;
            // A shared-memory driver may back a buffer with ordinary process memory, more than
            // once over (i.MX8MP's Vivante held 1.2 GB of anon RSS for ~550 MB of SSBOs), and
            // only once it is touched - so each chunk is written and read before MemAvailable
            // is asked whether there is room for the next.
            let floor = meminfo_bytes("MemTotal").map(|total| (total / 10).max(256 << 20));
            let buffers = Buffers::allocate(bytes, chunk_bytes, |buffer, words| {
                let Some(floor) = floor else { return true };
                gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, buffer);
                program.dispatch(&[("uCount", words), ("uSeed", 0), ("uBase", 0), ("uMode", 0)], words);
                if check_buffer(words, |_, _| {}).is_err() {
                    return false;
                }
                beat();
                meminfo_bytes("MemAvailable").is_none_or(|available| available >= floor)
            })?;
            let mut report = BurnReport::default();
            let mut host = Vec::with_capacity(UPLOAD_WORDS as usize);
            let passes = until(deadline, |pass| {
                let seed = 0x1234_5678u32.wrapping_add(pass as u32).wrapping_mul(0x0101_0101);
                let mut base = 0u32;
                for (chunk, &(buffer, words)) in buffers.list.iter().enumerate() {
                    gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, buffer);
                    gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, buffer);
                    let at = |i: usize| move || format!("buffer {chunk} word {i:#x}");

                    program.dispatch(
                        &[("uCount", words), ("uSeed", seed), ("uBase", base), ("uMode", 0)],
                        words,
                    );
                    if inject && pass == 0 && chunk == 0 {
                        let mid = words / 2;
                        let wrong = pattern_word(base + mid, seed) ^ 0x10;
                        gl::BufferSubData(
                            gl::SHADER_STORAGE_BUFFER,
                            (mid * 4) as isize,
                            4,
                            (&wrong as *const u32).cast(),
                        );
                    }
                    check_buffer(words, |i, got| {
                        report.check_word(at(i), pattern_word(base + i as u32, seed), got);
                    })?;
                    beat();

                    program.dispatch(&[("uCount", words), ("uMode", 1)], words);
                    check_buffer(words, |i, got| {
                        report.check_word(at(i), !pattern_word(base + i as u32, seed), got);
                    })?;
                    beat();

                    let uploaded = |i: u32| pattern_word(base + i, !seed).rotate_left(pass as u32);
                    for start in (0..words).step_by(UPLOAD_WORDS as usize) {
                        host.clear();
                        host.extend((start..words.min(start + UPLOAD_WORDS)).map(uploaded));
                        let (offset, size) = ((start as usize * 4) as isize, (host.len() * 4) as isize);
                        gl::BufferSubData(gl::SHADER_STORAGE_BUFFER, offset, size, host.as_ptr().cast());
                    }
                    check_buffer(words, |i, got| report.check_word(at(i), uploaded(i as u32), got))?;
                    beat();
                    base = base.wrapping_add(words);
                }
                gl_ok("memory pass")
            })?;
            report.passes = passes;
            report.detail = format!("{} MB in {} buffer(s)", buffers.bytes >> 20, buffers.list.len());
            if buffers.held_back {
                report
                    .detail
                    .push_str(" (stopped there: MemAvailable reached its reserve)");
            }
            Ok(report)
        }
    }

    /// Every invocation runs `ALU_ROUNDS` mixing rounds and then their inverses, so the
    /// result must be its own input - verifiable for every word at no host cost.
    fn alu_source(&self) -> String {
        format!(
            "{}layout(local_size_x={LOCAL_SIZE}) in;\nlayout(std430, binding=0) buffer B {{ uint data[]; }};\n\
             uniform uint uCount; uniform uint uSeed; uniform uint uRounds; uniform uint uInject;\n{}\n\
             void main() {{ uint stride = gl_NumWorkGroups.x * gl_WorkGroupSize.x;\n\
             for (uint i = gl_GlobalInvocationID.x; i < uCount; i += stride) {{\n\
             uint x = alu(i ^ uSeed); if (i == uInject) {{ x ^= 1u; }} data[i] = x; }} }}\n",
            self.compute_header(),
            alu_glsl()
        )
    }

    pub fn alu(&self, deadline: Instant, inject: bool, beat: &mut dyn FnMut()) -> Result<BurnReport, BurnError> {
        let source = self.alu_source();
        unsafe {
            let program = Program::compute(&source)?;
            let buffers = Buffers::allocate(ALU_WORDS as u64 * 4, ALU_WORDS as u64 * 4, |_, _| true)?;
            let (buffer, words) = buffers.list[0];
            gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, buffer);
            gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, buffer);
            let mut report = BurnReport::default();
            let passes = until(deadline, |pass| {
                let seed = (pass as u32).wrapping_mul(0x2545_F491);
                let injected = if inject && pass == 0 { words / 2 } else { NO_INJECT };
                program.dispatch(
                    &[
                        ("uCount", words),
                        ("uSeed", seed),
                        ("uRounds", ALU_ROUNDS),
                        ("uInject", injected),
                    ],
                    words,
                );
                check_buffer(words, |i, got| {
                    report.check_word(|| format!("invocation {i}"), i as u32 ^ seed, got);
                })?;
                beat();
                gl_ok("ALU pass")
            })?;
            report.passes = passes;
            report.detail = format!("{words} invocations x {} rounds", ALU_ROUNDS * 2);
            Ok(report)
        }
    }

    /// `RENDER_DRAWS` full-screen triangles blended additively into an RGBA8 target, each
    /// fragment adding 1/255 to red only if its own ALU round trip came out right, and a
    /// position-dependent 0 or 1/255 to green. Every pixel then has to read back exactly.
    /// `CONTEXT_THREADS` threads, each creating a context of its own, running the ALU kernel
    /// on it and destroying it again until `deadline`: creation, switching and teardown under
    /// contention, every result still checked. EGL allows a context per thread; the one
    /// process-wide thing is the `gl` crate's function table, which `open` already loaded and
    /// the threads only read - EGL 1.5 makes those pointers independent of the context.
    pub fn contexts(&self, deadline: Instant, inject: bool, beat: &mut dyn FnMut()) -> Result<BurnReport, BurnError> {
        let source = self.alu_source();
        let progress: Vec<AtomicU64> = (0..CONTEXT_THREADS).map(|_| AtomicU64::new(0)).collect();
        let finished = AtomicUsize::new(0);
        let results = std::thread::scope(|scope| {
            let handles: Vec<_> = (0..CONTEXT_THREADS)
                .map(|thread| {
                    let (opts, source, progress, finished) = (&self.opts, &source, &progress[thread], &finished);
                    scope.spawn(move || {
                        let result = context_churn(thread, opts, source, deadline, inject && thread == 0, progress);
                        progress.store(THREAD_DONE, Ordering::Relaxed);
                        finished.fetch_add(1, Ordering::Relaxed);
                        result
                    })
                })
                .collect();
            // A beat only once every thread has moved, so one thread stuck in the driver is a
            // hang even while the other three keep going.
            let mut seen = vec![0u64; CONTEXT_THREADS];
            while finished.load(Ordering::Relaxed) < CONTEXT_THREADS {
                std::thread::sleep(Duration::from_millis(50));
                let now: Vec<u64> = progress.iter().map(|p| p.load(Ordering::Relaxed)).collect();
                if now.iter().zip(&seen).all(|(&n, &s)| n > s || n == THREAD_DONE) {
                    beat();
                    seen = now;
                }
            }
            handles
                .into_iter()
                .enumerate()
                .map(|(thread, h)| {
                    h.join()
                        .unwrap_or_else(|_| Err(BurnError::Failed(format!("thread {thread} panicked"))))
                })
                .collect::<Vec<_>>()
        });
        let mut report = BurnReport::default();
        let mut contexts = 0;
        for result in results {
            let (part, created) = result?;
            contexts += created;
            report.passes += part.passes;
            report.errors += part.errors;
            let room = crate::burn::MAX_ERROR_SAMPLES.saturating_sub(report.samples.len());
            report.samples.extend(part.samples.into_iter().take(room));
        }
        report.detail = format!(
            "{CONTEXT_THREADS} threads, {contexts} contexts created and destroyed, {CONTEXT_WORDS} invocations per dispatch"
        );
        Ok(report)
    }

    pub fn render(&self, deadline: Instant, inject: bool, beat: &mut dyn FnMut()) -> Result<BurnReport, BurnError> {
        let vertex = format!(
            "{}void main() {{ vec2 p = vec2(float((gl_VertexID << 1) & 2), float(gl_VertexID & 2));\n\
             gl_Position = vec4(p * 2.0 - 1.0, 0.0, 1.0); }}\n",
            self.graphics_header()
        );
        let fragment = format!(
            "{}uniform uint uSeed; uniform uint uRounds; uniform ivec2 uInjectPx;\nout vec4 color;\n{}\n\
             void main() {{ uvec2 p = uvec2(gl_FragCoord.xy); uint v = (p.x * 4096u + p.y) ^ uSeed;\n\
             float ok = alu(v) == v ? 1.0 : 0.0; if (ivec2(p) == uInjectPx) {{ ok += 1.0; }}\n\
             color = vec4(ok, float((p.x ^ p.y) & 1u), 0.0, 0.0) / 255.0; }}\n",
            self.graphics_header(),
            alu_glsl()
        );
        unsafe {
            let program = Program::graphics(&vertex, &fragment)?;
            let target = RenderTarget::new(RENDER_SIZE)?;
            let mut report = BurnReport::default();
            let mut pixels = vec![0u8; (RENDER_SIZE * RENDER_SIZE * 4) as usize];
            let passes = until(deadline, |pass| {
                gl::BindFramebuffer(gl::FRAMEBUFFER, target.fbo);
                gl::Viewport(0, 0, RENDER_SIZE, RENDER_SIZE);
                gl::Disable(gl::DEPTH_TEST);
                gl::ClearColor(0.0, 0.0, 0.0, 0.0);
                gl::Clear(gl::COLOR_BUFFER_BIT);
                gl::Enable(gl::BLEND);
                gl::BlendFunc(gl::ONE, gl::ONE);
                gl::UseProgram(program.id);
                gl::BindVertexArray(target.vao);
                for draw in 0..RENDER_DRAWS {
                    let injected = inject && pass == 0 && draw == 0;
                    program.set_uint("uSeed", (pass as u32).wrapping_mul(31).wrapping_add(draw));
                    program.set_uint("uRounds", RENDER_ROUNDS);
                    gl::Uniform2i(
                        program.location("uInjectPx"),
                        if injected { 7 } else { -1 },
                        if injected { 7 } else { -1 },
                    );
                    gl::DrawArrays(gl::TRIANGLES, 0, 3);
                }
                gl::Disable(gl::BLEND);
                gl::ReadPixels(
                    0,
                    0,
                    RENDER_SIZE,
                    RENDER_SIZE,
                    gl::RGBA,
                    gl::UNSIGNED_BYTE,
                    pixels.as_mut_ptr().cast(),
                );
                for (index, px) in pixels.chunks_exact(4).enumerate() {
                    let (x, y) = (index as u32 % RENDER_SIZE as u32, index as u32 / RENDER_SIZE as u32);
                    let want = [
                        RENDER_DRAWS as u8,
                        if (x ^ y) & 1 == 1 { RENDER_DRAWS as u8 } else { 0 },
                        0,
                        0,
                    ];
                    if px != want {
                        report.record(|| format!("pixel ({x},{y}): expected {want:?} got {px:?}"));
                    }
                }
                beat();
                gl_ok("render pass")
            })?;
            report.passes = passes;
            report.detail = format!("{RENDER_SIZE}x{RENDER_SIZE}, {RENDER_DRAWS} blended draws per pass");
            Ok(report)
        }
    }
}

const PATTERN_GLSL: &str = "uint pattern_word(uint i, uint seed) { uint x = (i * 0x9E3779B1u) ^ seed; x ^= x >> 16u; x *= 0x7FEB352Du; x ^= x >> 15u; return x; }";

fn alu_glsl() -> String {
    format!(
        "uint alu(uint x) {{\n\
         for (uint r = 0u; r < uRounds; r++) {{ x *= {ALU_K1}u; x ^= x >> 17u; x += {ALU_K2}u + r; x = (x << 5u) | (x >> 27u); }}\n\
         for (uint r = uRounds; r > 0u; r--) {{ x = (x >> 5u) | (x << 27u); x -= {ALU_K2}u + (r - 1u); x ^= x >> 17u; x *= {ALU_K1_INV}u; }}\n\
         return x; }}"
    )
}

pub fn parse_version(version: &str) -> (bool, u32, u32) {
    let es = version.starts_with("OpenGL ES");
    let numbers = version
        .trim_start_matches("OpenGL ES")
        .trim_start_matches("-CM")
        .trim_start();
    let mut parts = numbers.split(|c: char| !c.is_ascii_digit()).filter(|s| !s.is_empty());
    let major = parts.next().and_then(|s| s.parse().ok()).unwrap_or(0);
    let minor = parts.next().and_then(|s| s.parse().ok()).unwrap_or(0);
    (es, major, minor)
}

/// # Safety
/// A GL context must be current on this thread and `name` a valid `glGetString` enum.
pub unsafe fn gl_string(name: u32) -> String {
    let ptr = unsafe { gl::GetString(name) };
    if ptr.is_null() {
        String::new()
    } else {
        unsafe { CStr::from_ptr(ptr.cast()) }.to_string_lossy().into_owned()
    }
}

unsafe fn has_extension(name: &str) -> bool {
    unsafe {
        let mut count = 0;
        gl::GetIntegerv(gl::NUM_EXTENSIONS, &mut count);
        (0..count.max(0) as u32).any(|i| {
            let ptr = gl::GetStringi(gl::EXTENSIONS, i);
            !ptr.is_null() && CStr::from_ptr(ptr.cast()).to_bytes() == name.as_bytes()
        })
    }
}

unsafe fn gl_ok(what: &str) -> Result<(), BurnError> {
    match unsafe { gl::GetError() } {
        gl::NO_ERROR => Ok(()),
        e => Err(BurnError::Failed(format!("{what}: GL error {e:#06x}"))),
    }
}

fn meminfo_bytes(name: &str) -> Option<u64> {
    std::fs::read_to_string("/proc/meminfo")
        .ok()?
        .lines()
        .find_map(|l| l.strip_prefix(name)?.strip_prefix(':').map(str::to_owned))
        .and_then(|v| v.trim().trim_end_matches("kB").trim().parse::<u64>().ok())
        .map(|kb| kb * 1024)
}

/// One thread of `GlBurn::contexts`. Returns its report and how many contexts it created.
fn context_churn(
    thread: usize,
    opts: &GpuOptions,
    source: &str,
    deadline: Instant,
    inject: bool,
    progress: &AtomicU64,
) -> Result<(BurnReport, u64), BurnError> {
    let mut report = BurnReport::default();
    let mut created = 0u64;
    loop {
        let ctx = OpenGLMode::create_with_opts(opts)
            .map_err(|e| BurnError::Failed(format!("thread {thread}: context {}: {e}", created + 1)))?;
        created += 1;
        let context = created;
        let failed = |e: BurnError| match e {
            BurnError::Unsupported(why) | BurnError::Failed(why) => {
                BurnError::Failed(format!("thread {thread}: context {context}: {why}"))
            }
        };
        unsafe {
            let program = Program::compute(source).map_err(failed)?;
            let buffers =
                Buffers::allocate(CONTEXT_WORDS as u64 * 4, CONTEXT_WORDS as u64 * 4, |_, _| true).map_err(failed)?;
            let (buffer, words) = buffers.list[0];
            gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, buffer);
            gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, buffer);
            for pass in 0..PASSES_PER_CONTEXT {
                let seed = ((thread as u32) << 28) ^ (context as u32).wrapping_mul(0x2545_F491) ^ pass;
                let injected = if inject && context == 1 && pass == 0 {
                    words / 2
                } else {
                    NO_INJECT
                };
                program.dispatch(
                    &[
                        ("uCount", words),
                        ("uSeed", seed),
                        ("uRounds", ALU_ROUNDS),
                        ("uInject", injected),
                    ],
                    words,
                );
                check_buffer(words, |i, got| {
                    report.check_word(
                        || format!("thread {thread} context {context} invocation {i}"),
                        i as u32 ^ seed,
                        got,
                    );
                })
                .map_err(failed)?;
                gl_ok("context pass").map_err(failed)?;
                report.passes += 1;
                progress.fetch_add(1, Ordering::Relaxed);
            }
            drop(buffers);
            drop(program);
        }
        ctx.inner
            .make_not_current_in_place()
            .map_err(|e| BurnError::Failed(format!("thread {thread}: context {context}: release: {e}")))?;
        drop(ctx);
        if Instant::now() >= deadline {
            return Ok((report, created));
        }
    }
}

/// Maps the bound SSBO and hands each of its `words` to `each` in place, so no host-side copy
/// of the buffer exists - on a shared-memory SoC that copy competes with the memory test.
/// GLES has no `glGetBufferSubData`.
unsafe fn check_buffer(words: u32, mut each: impl FnMut(usize, u32)) -> Result<(), BurnError> {
    unsafe {
        gl::MemoryBarrier(gl::SHADER_STORAGE_BARRIER_BIT | gl::BUFFER_UPDATE_BARRIER_BIT);
        let bytes = words as isize * 4;
        let ptr = gl::MapBufferRange(gl::SHADER_STORAGE_BUFFER, 0, bytes, gl::MAP_READ_BIT) as *const u32;
        if ptr.is_null() {
            return Err(BurnError::Failed(format!(
                "glMapBufferRange returned null (GL error {:#06x})",
                gl::GetError()
            )));
        }
        for (i, &got) in std::slice::from_raw_parts(ptr, words as usize).iter().enumerate() {
            each(i, got);
        }
        gl::UnmapBuffer(gl::SHADER_STORAGE_BUFFER);
        Ok(())
    }
}

struct Program {
    id: u32,
}

impl Program {
    unsafe fn compute(source: &str) -> Result<Self, BurnError> {
        unsafe {
            let shader = compile(gl::COMPUTE_SHADER, source)?;
            link(&[shader])
        }
    }

    unsafe fn graphics(vertex: &str, fragment: &str) -> Result<Self, BurnError> {
        unsafe {
            let vs = compile(gl::VERTEX_SHADER, vertex)?;
            let fs = compile(gl::FRAGMENT_SHADER, fragment)?;
            link(&[vs, fs])
        }
    }

    unsafe fn location(&self, name: &str) -> i32 {
        let name = std::ffi::CString::new(name).expect("uniform name has no NUL");
        unsafe { gl::GetUniformLocation(self.id, name.as_ptr()) }
    }

    unsafe fn set_uint(&self, name: &str, value: u32) {
        unsafe { gl::Uniform1ui(self.location(name), value) }
    }

    unsafe fn dispatch(&self, uniforms: &[(&str, u32)], words: u32) {
        unsafe {
            gl::UseProgram(self.id);
            for &(name, value) in uniforms {
                self.set_uint(name, value);
            }
            gl::DispatchCompute(words.div_ceil(LOCAL_SIZE).min(MAX_GROUPS), 1, 1);
            gl::Finish();
        }
    }
}

impl Drop for Program {
    fn drop(&mut self) {
        unsafe { gl::DeleteProgram(self.id) }
    }
}

unsafe fn compile(kind: u32, source: &str) -> Result<u32, BurnError> {
    unsafe {
        let shader = gl::CreateShader(kind);
        let ptr = source.as_ptr().cast();
        let len = source.len() as i32;
        gl::ShaderSource(shader, 1, &ptr, &len);
        gl::CompileShader(shader);
        let mut ok = 0;
        gl::GetShaderiv(shader, gl::COMPILE_STATUS, &mut ok);
        if ok == 0 {
            let log = info_log(shader, gl::GetShaderiv, gl::GetShaderInfoLog);
            gl::DeleteShader(shader);
            return Err(BurnError::Failed(format!("shader did not compile: {log}")));
        }
        Ok(shader)
    }
}

unsafe fn link(shaders: &[u32]) -> Result<Program, BurnError> {
    unsafe {
        let id = gl::CreateProgram();
        for &s in shaders {
            gl::AttachShader(id, s);
        }
        gl::LinkProgram(id);
        for &s in shaders {
            gl::DeleteShader(s);
        }
        let mut ok = 0;
        gl::GetProgramiv(id, gl::LINK_STATUS, &mut ok);
        if ok == 0 {
            let log = info_log(id, gl::GetProgramiv, gl::GetProgramInfoLog);
            gl::DeleteProgram(id);
            return Err(BurnError::Failed(format!("program did not link: {log}")));
        }
        Ok(Program { id })
    }
}

type GetIv = unsafe fn(u32, u32, *mut i32);
type GetLog = unsafe fn(u32, i32, *mut i32, *mut gl::types::GLchar);

unsafe fn info_log(object: u32, get_iv: GetIv, get_log: GetLog) -> String {
    unsafe {
        let mut len = 0;
        get_iv(object, gl::INFO_LOG_LENGTH, &mut len);
        let mut buf = vec![0u8; len.max(1) as usize];
        get_log(object, len, std::ptr::null_mut(), buf.as_mut_ptr().cast());
        String::from_utf8_lossy(&buf).trim_end_matches('\0').trim().to_string()
    }
}

struct Buffers {
    list: Vec<(u32, u32)>,
    bytes: u64,
    held_back: bool,
}

impl Buffers {
    /// Chunks of `chunk_bytes` until `total` is reached, the driver runs out, or `keep` turns a
    /// freshly allocated chunk down; at least one.
    unsafe fn allocate(
        total: u64,
        chunk_bytes: u64,
        mut keep: impl FnMut(u32, u32) -> bool,
    ) -> Result<Self, BurnError> {
        let mut buffers = Self {
            list: Vec::new(),
            bytes: 0,
            held_back: false,
        };
        unsafe {
            while gl::GetError() != gl::NO_ERROR {}
            while buffers.bytes < total {
                let size = chunk_bytes.min(total - buffers.bytes) & !3;
                let mut id = 0;
                gl::GenBuffers(1, &mut id);
                gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, id);
                gl::BufferData(
                    gl::SHADER_STORAGE_BUFFER,
                    size as isize,
                    std::ptr::null(),
                    gl::DYNAMIC_COPY,
                );
                if gl::GetError() != gl::NO_ERROR {
                    gl::DeleteBuffers(1, &id);
                    break;
                }
                if !keep(id, (size / 4) as u32) {
                    gl::DeleteBuffers(1, &id);
                    buffers.held_back = true;
                    break;
                }
                buffers.list.push((id, (size / 4) as u32));
                buffers.bytes += size;
            }
        }
        if buffers.list.is_empty() {
            let why = if buffers.held_back {
                "MemAvailable is already at its reserve for"
            } else {
                "the driver would not allocate even"
            };
            return Err(BurnError::Unsupported(format!("{why} {} MB", chunk_bytes >> 20)));
        }
        Ok(buffers)
    }
}

impl Drop for Buffers {
    fn drop(&mut self) {
        for &(id, _) in &self.list {
            unsafe { gl::DeleteBuffers(1, &id) }
        }
    }
}

struct RenderTarget {
    fbo: u32,
    texture: u32,
    vao: u32,
}

impl RenderTarget {
    unsafe fn new(size: i32) -> Result<Self, BurnError> {
        unsafe {
            let mut target = Self {
                fbo: 0,
                texture: 0,
                vao: 0,
            };
            gl::GenTextures(1, &mut target.texture);
            gl::BindTexture(gl::TEXTURE_2D, target.texture);
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA8, size, size);
            gl::GenFramebuffers(1, &mut target.fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, target.fbo);
            gl::FramebufferTexture2D(
                gl::FRAMEBUFFER,
                gl::COLOR_ATTACHMENT0,
                gl::TEXTURE_2D,
                target.texture,
                0,
            );
            gl::GenVertexArrays(1, &mut target.vao);
            let status = gl::CheckFramebufferStatus(gl::FRAMEBUFFER);
            if status != gl::FRAMEBUFFER_COMPLETE {
                return Err(BurnError::Failed(format!(
                    "RGBA8 framebuffer incomplete: {status:#06x}"
                )));
            }
            Ok(target)
        }
    }
}

impl Drop for RenderTarget {
    fn drop(&mut self) {
        unsafe {
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            gl::DeleteFramebuffers(1, &self.fbo);
            gl::DeleteTextures(1, &self.texture);
            gl::DeleteVertexArrays(1, &self.vao);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn versions_parse_for_both_apis() {
        assert_eq!(parse_version("OpenGL ES 3.1 V6.4.3.p2.336687"), (true, 3, 1));
        assert_eq!(parse_version("4.5 (Core Profile) Mesa 24.0.5"), (false, 4, 5));
        assert_eq!(parse_version("OpenGL ES 3.2 Mesa 24.0.5"), (true, 3, 2));
    }
}
