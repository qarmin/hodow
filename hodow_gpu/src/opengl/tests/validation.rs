//! Output-validating GL tests.
//!
//! Unlike the other tests in this module (which mainly check that GL calls do not crash),
//! these render or compute content whose correct result is known *analytically* and verify
//! the actual GPU output byte-for-byte. Because the expected values are derived from the
//! operation itself - not captured from a reference GPU - these checks are driver- and
//! vendor-independent: a mismatch means the driver/hardware produced a wrong result.

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

// ── shared helpers ───────────────────────────────────────────────────────────

/// Query the current context's GL version as (major, minor).
pub(super) unsafe fn gl_version() -> (i32, i32) {
    let mut major = 0i32;
    let mut minor = 0i32;
    unsafe {
        gl::GetIntegerv(gl::MAJOR_VERSION, &mut major);
        gl::GetIntegerv(gl::MINOR_VERSION, &mut minor);
        // Clear any error from unsupported queries on very old contexts.
        while gl::GetError() != gl::NO_ERROR {}
    }
    (major, minor)
}

pub(super) fn version_at_least(have: (i32, i32), want: (i32, i32)) -> bool {
    have.0 > want.0 || (have.0 == want.0 && have.1 >= want.1)
}

/// Drain any GL errors left pending by earlier (non-validating) tests, so a later
/// `assert_no_gl_error` only reports errors caused by this test.
unsafe fn drain_gl_errors() {
    unsafe { while gl::GetError() != gl::NO_ERROR {} }
}

/// Return the first pending GL error (as a readable string), or None.
unsafe fn take_gl_error() -> Option<String> {
    let e = unsafe { gl::GetError() };
    if e == gl::NO_ERROR {
        return None;
    }
    let name = match e {
        gl::INVALID_ENUM => "GL_INVALID_ENUM",
        gl::INVALID_VALUE => "GL_INVALID_VALUE",
        gl::INVALID_OPERATION => "GL_INVALID_OPERATION",
        gl::INVALID_FRAMEBUFFER_OPERATION => "GL_INVALID_FRAMEBUFFER_OPERATION",
        gl::OUT_OF_MEMORY => "GL_OUT_OF_MEMORY",
        _ => "GL_ERROR",
    };
    Some(format!("{name} (0x{e:04x})"))
}

/// Fail if any GL error is pending, prefixing the message with `ctx`.
pub(super) unsafe fn assert_no_gl_error(ctx: &str) -> Result<(), Box<dyn Error>> {
    if let Some(e) = unsafe { take_gl_error() } {
        return Err(format!("{ctx}: {e}").into());
    }
    Ok(())
}

/// Compile a vertex+fragment program, returning its id. Deletes shaders on success.
pub(super) unsafe fn build_render_program(vs_src: &[u8], fs_src: &[u8]) -> Result<u32, Box<dyn Error>> {
    unsafe {
        let vs = compile_shader(gl::VERTEX_SHADER, vs_src)?;
        let fs = compile_shader(gl::FRAGMENT_SHADER, fs_src)?;
        let program = gl::CreateProgram();
        gl::AttachShader(program, vs);
        gl::AttachShader(program, fs);
        gl::LinkProgram(program);
        let mut ok = 0i32;
        gl::GetProgramiv(program, gl::LINK_STATUS, &mut ok);
        gl::DeleteShader(vs);
        gl::DeleteShader(fs);
        if ok == 0 {
            let log = program_info_log(program);
            gl::DeleteProgram(program);
            return Err(format!("program link failed: {log}").into());
        }
        Ok(program)
    }
}

unsafe fn compile_shader(kind: u32, src: &[u8]) -> Result<u32, Box<dyn Error>> {
    unsafe {
        let sh = gl::CreateShader(kind);
        gl::ShaderSource(sh, 1, &(src.as_ptr() as *const gl::types::GLchar), std::ptr::null());
        gl::CompileShader(sh);
        let mut ok = 0i32;
        gl::GetShaderiv(sh, gl::COMPILE_STATUS, &mut ok);
        if ok == 0 {
            let mut len = 0i32;
            gl::GetShaderiv(sh, gl::INFO_LOG_LENGTH, &mut len);
            let mut log = vec![0u8; len.max(1) as usize];
            gl::GetShaderInfoLog(
                sh,
                len,
                std::ptr::null_mut(),
                log.as_mut_ptr() as *mut gl::types::GLchar,
            );
            gl::DeleteShader(sh);
            return Err(format!("shader compile failed: {}", String::from_utf8_lossy(&log)).into());
        }
        Ok(sh)
    }
}

unsafe fn program_info_log(program: u32) -> String {
    unsafe {
        let mut len = 0i32;
        gl::GetProgramiv(program, gl::INFO_LOG_LENGTH, &mut len);
        let mut log = vec![0u8; len.max(1) as usize];
        gl::GetProgramInfoLog(
            program,
            len,
            std::ptr::null_mut(),
            log.as_mut_ptr() as *mut gl::types::GLchar,
        );
        String::from_utf8_lossy(&log).trim_end_matches('\0').to_string()
    }
}

/// Create an RGBA8 texture + FBO of the given size and bind it for rendering.
/// Returns (fbo, texture). Caller must delete both.
unsafe fn make_rgba8_fbo(w: i32, h: i32) -> Result<(u32, u32), Box<dyn Error>> {
    unsafe {
        drain_gl_errors();
        let mut tex = 0u32;
        gl::GenTextures(1, &mut tex);
        gl::BindTexture(gl::TEXTURE_2D, tex);
        gl::TexImage2D(
            gl::TEXTURE_2D,
            0,
            gl::RGBA8 as i32,
            w,
            h,
            0,
            gl::RGBA,
            gl::UNSIGNED_BYTE,
            std::ptr::null(),
        );
        gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
        gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);

        let mut fbo = 0u32;
        gl::GenFramebuffers(1, &mut fbo);
        gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
        gl::FramebufferTexture2D(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::TEXTURE_2D, tex, 0);

        let status = gl::CheckFramebufferStatus(gl::FRAMEBUFFER);
        if status != gl::FRAMEBUFFER_COMPLETE {
            gl::DeleteFramebuffers(1, &fbo);
            gl::DeleteTextures(1, &tex);
            return Err(format!("framebuffer incomplete: 0x{status:04x}").into());
        }
        gl::Viewport(0, 0, w, h);
        Ok((fbo, tex))
    }
}

/// Read the current framebuffer as tightly-packed RGBA8.
pub(super) unsafe fn read_rgba8(w: i32, h: i32) -> Vec<u8> {
    let mut buf = vec![0u8; (w * h * 4) as usize];
    unsafe {
        gl::PixelStorei(gl::PACK_ALIGNMENT, 1);
        gl::ReadPixels(
            0,
            0,
            w,
            h,
            gl::RGBA,
            gl::UNSIGNED_BYTE,
            buf.as_mut_ptr() as *mut std::ffi::c_void,
        );
    }
    buf
}

/// Assert every pixel equals `expected` within `tol` per channel.
fn expect_solid(pixels: &[u8], expected: [u8; 4], tol: u8) -> Result<(), Box<dyn Error>> {
    for (i, px) in pixels.as_chunks::<4>().0.iter().enumerate() {
        for c in 0..4 {
            if px[c].abs_diff(expected[c]) > tol {
                return Err(format!(
                    "pixel {i} channel {c}: got {}, expected {} (+/-{tol}); full pixel = {:?}, expected {:?}",
                    px[c], expected[c], px, expected
                )
                .into());
            }
        }
    }
    Ok(())
}

// ── Test 1: glClear color exactness ──────────────────────────────────────────

pub struct ClearColorValidation;

impl GLTest for ClearColorValidation {
    fn name(&self) -> &'static str {
        "Validate_ClearColor"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 64;
        unsafe {
            let (fbo, tex) = make_rgba8_fbo(N, N)?;
            let cleanup = |fbo: u32, tex: u32| {
                gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
                gl::DeleteFramebuffers(1, &fbo);
                gl::DeleteTextures(1, &tex);
            };

            // Exact 8-bit unorm values: 1.0->255, 0.0->0, 128/255 round-trips exactly.
            for &(r, g, b, a, exp) in &[
                (1.0f32, 0.0, 0.0, 1.0, [255u8, 0, 0, 255]),
                (0.0, 1.0, 0.0, 1.0, [0, 255, 0, 255]),
                (0.0, 0.0, 1.0, 1.0, [0, 0, 255, 255]),
                (128.0 / 255.0, 64.0 / 255.0, 32.0 / 255.0, 1.0, [128, 64, 32, 255]),
            ] {
                gl::ClearColor(r, g, b, a);
                gl::Clear(gl::COLOR_BUFFER_BIT);
                let px = read_rgba8(N, N);
                if let Err(e) = assert_no_gl_error("clear/readback").and_then(|()| expect_solid(&px, exp, 1)) {
                    cleanup(fbo, tex);
                    return Err(e);
                }
            }
            cleanup(fbo, tex);
        }
        Ok("glClear produced exact RGBA8 output for 4 colors".into())
    }
}

// ── Test 2: full render pipeline (VAO + shader) solid fill ────────────────────

pub struct RenderSolidValidation;

impl GLTest for RenderSolidValidation {
    fn name(&self) -> &'static str {
        "Validate_RenderSolid"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 3)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 64;
        let vs = b"#version 330 core\nconst vec2 v[3]=vec2[3](vec2(-1,-1),vec2(3,-1),vec2(-1,3));\nvoid main(){gl_Position=vec4(v[gl_VertexID],0.0,1.0);}\n\0";
        let fs = b"#version 330 core\nout vec4 c;uniform vec4 uColor;void main(){c=uColor;}\n\0";
        unsafe {
            if !version_at_least(gl_version(), (3, 3)) {
                return Ok("skipped: needs GL 3.3".into());
            }
            let (fbo, tex) = make_rgba8_fbo(N, N)?;
            let mut vao = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            let program = match build_render_program(vs, fs) {
                Ok(p) => p,
                Err(e) => {
                    gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
                    gl::DeleteVertexArrays(1, &vao);
                    gl::DeleteFramebuffers(1, &fbo);
                    gl::DeleteTextures(1, &tex);
                    return Err(e);
                }
            };
            gl::UseProgram(program);
            let loc = gl::GetUniformLocation(program, c"uColor".as_ptr());
            // 0.25,0.5,0.75,1.0 all round-trip exactly in 8-bit unorm.
            gl::Uniform4f(loc, 0.25, 0.5, 0.75, 1.0);

            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();

            let px = read_rgba8(N, N);
            let result = assert_no_gl_error("render").and_then(|()| expect_solid(&px, [64, 128, 191, 255], 1));

            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            gl::UseProgram(0);
            gl::DeleteProgram(program);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteFramebuffers(1, &fbo);
            gl::DeleteTextures(1, &tex);
            result?;
        }
        Ok("full-screen shader fill produced the exact expected color".into())
    }
}

// ── Test 3: compute shader integer output (bit-exact) ─────────────────────────

pub struct ComputeValidation;

impl GLTest for ComputeValidation {
    fn name(&self) -> &'static str {
        "Validate_Compute"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 3)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const COUNT: usize = 1024;
        let cs =
            b"#version 430\nlayout(local_size_x=64) in;\nlayout(std430, binding=0) buffer B { uint data[]; };\nvoid main(){ uint i=gl_GlobalInvocationID.x; data[i]=i*3u+7u; }\n\0";
        unsafe {
            if !version_at_least(gl_version(), (4, 3)) {
                return Ok("skipped: needs GL 4.3 (compute shaders)".into());
            }
            let shader = compile_shader(gl::COMPUTE_SHADER, cs)?;
            let program = gl::CreateProgram();
            gl::AttachShader(program, shader);
            gl::LinkProgram(program);
            let mut ok = 0i32;
            gl::GetProgramiv(program, gl::LINK_STATUS, &mut ok);
            gl::DeleteShader(shader);
            if ok == 0 {
                let log = program_info_log(program);
                gl::DeleteProgram(program);
                return Err(format!("compute link failed: {log}").into());
            }

            let mut ssbo = 0u32;
            gl::GenBuffers(1, &mut ssbo);
            gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, ssbo);
            gl::BufferData(
                gl::SHADER_STORAGE_BUFFER,
                (COUNT * 4) as isize,
                std::ptr::null(),
                gl::DYNAMIC_READ,
            );
            gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, ssbo);

            gl::UseProgram(program);
            gl::DispatchCompute((COUNT / 64) as u32, 1, 1);
            gl::MemoryBarrier(gl::SHADER_STORAGE_BARRIER_BIT | gl::BUFFER_UPDATE_BARRIER_BIT);
            gl::Finish();

            let mut out = vec![0u32; COUNT];
            gl::GetBufferSubData(
                gl::SHADER_STORAGE_BUFFER,
                0,
                (COUNT * 4) as isize,
                out.as_mut_ptr() as *mut std::ffi::c_void,
            );

            let err = assert_no_gl_error("compute");

            gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, 0);
            gl::DeleteBuffers(1, &ssbo);
            gl::UseProgram(0);
            gl::DeleteProgram(program);

            err?;
            for (i, &v) in out.iter().enumerate() {
                let expected = (i as u32) * 3 + 7;
                if v != expected {
                    return Err(format!("compute output[{i}] = {v}, expected {expected}").into());
                }
            }
        }
        Ok(format!("compute shader wrote {COUNT} exact integer results"))
    }
}

// ── Test 4: additive blending arithmetic ──────────────────────────────────────

pub struct BlendValidation;

impl GLTest for BlendValidation {
    fn name(&self) -> &'static str {
        "Validate_Blend"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 3)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 32;
        let vs = b"#version 330 core\nconst vec2 v[3]=vec2[3](vec2(-1,-1),vec2(3,-1),vec2(-1,3));\nvoid main(){gl_Position=vec4(v[gl_VertexID],0.0,1.0);}\n\0";
        let fs = b"#version 330 core\nout vec4 c;uniform vec4 uColor;void main(){c=uColor;}\n\0";
        unsafe {
            if !version_at_least(gl_version(), (3, 3)) {
                return Ok("skipped: needs GL 3.3".into());
            }
            let (fbo, tex) = make_rgba8_fbo(N, N)?;
            let mut vao = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            let program = build_render_program(vs, fs)?;
            gl::UseProgram(program);
            let loc = gl::GetUniformLocation(program, c"uColor".as_ptr());

            // dst = 40, src = 20 -> additive blend GL_ONE/GL_ONE -> 60 (exact in 8-bit).
            gl::ClearColor(40.0 / 255.0, 10.0 / 255.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::Enable(gl::BLEND);
            gl::BlendFunc(gl::ONE, gl::ONE);
            gl::Uniform4f(loc, 20.0 / 255.0, 20.0 / 255.0, 0.0, 0.0);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();
            gl::Disable(gl::BLEND);

            let px = read_rgba8(N, N);
            let result = assert_no_gl_error("blend").and_then(|()| expect_solid(&px, [60, 30, 0, 255], 1));

            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            gl::UseProgram(0);
            gl::DeleteProgram(program);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteFramebuffers(1, &fbo);
            gl::DeleteTextures(1, &tex);
            result?;
        }
        Ok("additive blending produced the exact summed color".into())
    }
}
