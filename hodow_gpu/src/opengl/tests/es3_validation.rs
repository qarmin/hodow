//! Validation tests written against OpenGL ES 3.0/3.1 rather than desktop GL.
//!
//! Every other test here targets desktop GL, which means on a GLES-only driver almost the whole
//! suite is skipped - an i.MX/Vivante GC2000+ ran 4 of 40. These use `#version 300 es`/`310 es`
//! and GLES-3 APIs only (no `glGetTexImage`, no `glGetBufferSubData`, no fixed function), so
//! they are the part of the suite that actually exercises such a device.
//!
//! Each one checks an analytically known result bit-exactly, the same standard as `validation.rs`
//! and the Vulkan compute check: every expected value follows from the operation itself, so a
//! mismatch means the driver computed the wrong answer. Values are chosen to round-trip exactly
//! in 8-bit unorm, so there is no tolerance to argue about.
//!
//! Desktop drivers accept these too, from GL 4.3 (`ARB_ES3_compatibility`) and GL 4.5
//! (`ARB_ES3_1_compatibility`) - `required_glsl_version` in the generated table encodes that, so
//! an older desktop context skips them instead of failing to compile them.

use std::error::Error;
use std::ffi::c_void;

use crate::opengl::test_trait::{GLTest, GLVersion};

unsafe fn take_gl_error() -> Option<String> {
    unsafe {
        let mut last = None;
        loop {
            let e = gl::GetError();
            if e == gl::NO_ERROR {
                return last;
            }
            last = Some(format!("0x{e:04x}"));
        }
    }
}

unsafe fn check(ctx: &str) -> Result<(), Box<dyn Error>> {
    match unsafe { take_gl_error() } {
        Some(e) => Err(format!("{ctx}: GL error {e}").into()),
        None => Ok(()),
    }
}

unsafe fn compile(kind: u32, src: &[u8]) -> Result<u32, Box<dyn Error>> {
    unsafe {
        let sh = gl::CreateShader(kind);
        let ptr = src.as_ptr() as *const gl::types::GLchar;
        let len = (src.len() - 1) as i32; // the sources below are NUL-terminated
        gl::ShaderSource(sh, 1, &ptr, &len);
        gl::CompileShader(sh);
        let mut ok = 0i32;
        gl::GetShaderiv(sh, gl::COMPILE_STATUS, &mut ok);
        if ok != 1 {
            let mut cap = 0i32;
            gl::GetShaderiv(sh, gl::INFO_LOG_LENGTH, &mut cap);
            let mut buf = vec![0u8; cap.max(1) as usize];
            let mut written = 0i32;
            gl::GetShaderInfoLog(sh, cap.max(1), &mut written, buf.as_mut_ptr() as *mut _);
            buf.truncate(written.max(0) as usize);
            gl::DeleteShader(sh);
            return Err(format!("shader compile failed: {}", String::from_utf8_lossy(&buf)).into());
        }
        Ok(sh)
    }
}

unsafe fn link(shaders: &[u32]) -> Result<u32, Box<dyn Error>> {
    unsafe {
        let program = gl::CreateProgram();
        for &s in shaders {
            gl::AttachShader(program, s);
        }
        gl::LinkProgram(program);
        for &s in shaders {
            gl::DetachShader(program, s);
            gl::DeleteShader(s);
        }
        let mut ok = 0i32;
        gl::GetProgramiv(program, gl::LINK_STATUS, &mut ok);
        if ok != 1 {
            let mut cap = 0i32;
            gl::GetProgramiv(program, gl::INFO_LOG_LENGTH, &mut cap);
            let mut buf = vec![0u8; cap.max(1) as usize];
            let mut written = 0i32;
            gl::GetProgramInfoLog(program, cap.max(1), &mut written, buf.as_mut_ptr() as *mut _);
            buf.truncate(written.max(0) as usize);
            gl::DeleteProgram(program);
            return Err(format!("program link failed: {}", String::from_utf8_lossy(&buf)).into());
        }
        Ok(program)
    }
}

/// An RGBA8 render target. GLES has no `glGetTexImage`, so everything is read back through
/// `glReadPixels` on a bound framebuffer - which is also what a real ES application does.
struct Target {
    fbo: u32,
    tex: u32,
    size: i32,
}

impl Target {
    unsafe fn new(size: i32) -> Result<Self, Box<dyn Error>> {
        unsafe {
            let mut tex = 0u32;
            gl::GenTextures(1, &mut tex);
            gl::BindTexture(gl::TEXTURE_2D, tex);
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA8, size, size);
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
            gl::Viewport(0, 0, size, size);
            Ok(Self { fbo, tex, size })
        }
    }

    unsafe fn read(&self) -> Vec<u8> {
        unsafe {
            let mut px = vec![0u8; (self.size * self.size * 4) as usize];
            gl::PixelStorei(gl::PACK_ALIGNMENT, 1);
            gl::ReadPixels(
                0,
                0,
                self.size,
                self.size,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                px.as_mut_ptr() as *mut c_void,
            );
            px
        }
    }
}

impl Drop for Target {
    fn drop(&mut self) {
        unsafe {
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            gl::DeleteFramebuffers(1, &self.fbo);
            gl::DeleteTextures(1, &self.tex);
        }
    }
}

fn expect_solid(px: &[u8], want: [u8; 4]) -> Result<(), Box<dyn Error>> {
    for (i, chunk) in px.as_chunks::<4>().0.iter().enumerate() {
        if *chunk != want {
            return Err(format!("pixel {i}: got {chunk:?}, expected {want:?}").into());
        }
    }
    Ok(())
}

/// A bound vertex array object. GLES 3 accepts the default VAO 0, a desktop core profile does
/// not - drawing without one there is `GL_INVALID_OPERATION`, so the buffer-less tests below
/// still need one to stay runnable on both.
struct Vao(u32);

impl Vao {
    unsafe fn new() -> Self {
        unsafe {
            let mut id = 0u32;
            gl::GenVertexArrays(1, &mut id);
            gl::BindVertexArray(id);
            Self(id)
        }
    }
}

impl Drop for Vao {
    fn drop(&mut self) {
        unsafe {
            gl::BindVertexArray(0);
            gl::DeleteVertexArrays(1, &self.0);
        }
    }
}

/// A vertex shader covering the whole viewport from `gl_VertexID` - no buffers, so a failure is
/// about the stage being tested and not about vertex upload.
const FULLSCREEN_VS: &[u8] = b"#version 300 es\nvoid main(){vec2 v[3];v[0]=vec2(-1.0,-1.0);v[1]=vec2(3.0,-1.0);v[2]=vec2(-1.0,3.0);gl_Position=vec4(v[gl_VertexID],0.0,1.0);}\n\0";

// ── ES30_Draw: the render pipeline produces the exact requested colour ────────

pub struct Es30DrawTest;

impl GLTest for Es30DrawTest {
    fn name(&self) -> &'static str {
        "ES30_Draw"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 64;
        // Written as n/255 so each channel lands on an 8-bit value exactly - no float->unorm
        // rounding is involved, and a mismatch cannot be argued away as a rounding mode.
        let fs = b"#version 300 es\nprecision highp float;uniform vec4 uColor;out vec4 c;void main(){c=uColor;}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            gl::Uniform4f(
                gl::GetUniformLocation(program, c"uColor".as_ptr()),
                64.0 / 255.0,
                128.0 / 255.0,
                192.0 / 255.0,
                1.0,
            );
            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();
            let px = target.read();
            gl::DeleteProgram(program);
            check("ES30_Draw")?;
            expect_solid(&px, [64, 128, 192, 255])?;
            Ok(format!("{N}x{N} solid fill exact through the ES 3.0 pipeline"))
        }
    }
}

// ── ES30_Blend: additive blending sums exactly ────────────────────────────────

pub struct Es30BlendTest;

impl GLTest for Es30BlendTest {
    fn name(&self) -> &'static str {
        "ES30_Blend"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 32;
        let fs = b"#version 300 es\nprecision highp float;uniform vec4 uColor;out vec4 c;void main(){c=uColor;}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            let loc = gl::GetUniformLocation(program, c"uColor".as_ptr());
            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::Enable(gl::BLEND);
            gl::BlendFunc(gl::ONE, gl::ONE);
            // Blending happens against the value already quantized into the RGBA8 target, so the
            // terms have to be exact 8-bit values themselves: 64 + 128 = 192, no rounding, no clamp.
            gl::Uniform4f(loc, 64.0 / 255.0, 64.0 / 255.0, 64.0 / 255.0, 0.0);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Uniform4f(loc, 128.0 / 255.0, 128.0 / 255.0, 128.0 / 255.0, 1.0);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();
            gl::Disable(gl::BLEND);
            let px = target.read();
            gl::DeleteProgram(program);
            check("ES30_Blend")?;
            expect_solid(&px, [192, 192, 192, 255])?;
            Ok("GL_ONE/GL_ONE blending summed 64+128 to exactly 192".into())
        }
    }
}

// ── ES30_Texture: a sampled texel comes back byte-identical ───────────────────

pub struct Es30TextureTest;

impl GLTest for Es30TextureTest {
    fn name(&self) -> &'static str {
        "ES30_Texture"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        let fs = b"#version 300 es\nprecision highp float;uniform sampler2D uTex;out vec4 c;void main(){c=texelFetch(uTex,ivec2(gl_FragCoord.xy),0);}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            // A per-texel pattern, so a driver that samples the wrong texel cannot pass by
            // accident the way a solid colour would let it.
            let mut src = vec![0u8; (N * N * 4) as usize];
            for (i, texel) in src.as_chunks_mut::<4>().0.iter_mut().enumerate() {
                texel.copy_from_slice(&[(i & 0xff) as u8, ((i * 7) & 0xff) as u8, ((i * 13) & 0xff) as u8, 255]);
            }
            let mut tex = 0u32;
            gl::GenTextures(1, &mut tex);
            gl::ActiveTexture(gl::TEXTURE0);
            gl::BindTexture(gl::TEXTURE_2D, tex);
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA8, N, N);
            gl::PixelStorei(gl::UNPACK_ALIGNMENT, 1);
            gl::TexSubImage2D(
                gl::TEXTURE_2D,
                0,
                0,
                0,
                N,
                N,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                src.as_ptr() as *const c_void,
            );
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);

            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            gl::Uniform1i(gl::GetUniformLocation(program, c"uTex".as_ptr()), 0);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();
            let px = target.read();
            gl::DeleteProgram(program);
            gl::DeleteTextures(1, &tex);
            check("ES30_Texture")?;
            if px != src {
                let bad = px
                    .as_chunks::<4>()
                    .0
                    .iter()
                    .zip(src.as_chunks::<4>().0)
                    .position(|(a, b)| a != b)
                    .unwrap_or(0);
                return Err(format!(
                    "texel {bad}: got {:?}, expected {:?}",
                    &px[bad * 4..bad * 4 + 4],
                    &src[bad * 4..bad * 4 + 4]
                )
                .into());
            }
            Ok(format!(
                "{N}x{N} RGBA8 texels round-tripped byte-identical through texelFetch"
            ))
        }
    }
}

// ── ES31_Compute: an SSBO filled by a compute shader, checked against the formula ──

pub struct Es31ComputeTest;

impl GLTest for Es31ComputeTest {
    fn name(&self) -> &'static str {
        "ES31_Compute"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 1)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const COUNT: usize = 1024;
        const LOCAL: usize = 64;
        // Same kernel as the Vulkan compute validation: the expected value follows from the
        // formula, so this compares the device against arithmetic and not against a reference.
        let cs =
            b"#version 310 es\nlayout(local_size_x=64) in;\nlayout(std430,binding=0) buffer B{uint data[];};\nvoid main(){uint i=gl_GlobalInvocationID.x;data[i]=i*3u+7u;}\n\0";
        unsafe {
            let program = link(&[compile(gl::COMPUTE_SHADER, cs)?])?;
            let mut ssbo = 0u32;
            gl::GenBuffers(1, &mut ssbo);
            gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, ssbo);
            let bytes = (COUNT * 4) as isize;
            gl::BufferData(gl::SHADER_STORAGE_BUFFER, bytes, std::ptr::null(), gl::DYNAMIC_COPY);
            gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, ssbo);
            gl::UseProgram(program);
            gl::DispatchCompute((COUNT / LOCAL) as u32, 1, 1);
            gl::MemoryBarrier(gl::BUFFER_UPDATE_BARRIER_BIT);

            // GLES has no glGetBufferSubData - a mapped range is the only way back.
            let ptr = gl::MapBufferRange(gl::SHADER_STORAGE_BUFFER, 0, bytes, gl::MAP_READ_BIT) as *const u32;
            if ptr.is_null() {
                gl::DeleteBuffers(1, &ssbo);
                gl::DeleteProgram(program);
                return Err("glMapBufferRange returned null".into());
            }
            let got = std::slice::from_raw_parts(ptr, COUNT).to_vec();
            gl::UnmapBuffer(gl::SHADER_STORAGE_BUFFER);
            gl::DeleteBuffers(1, &ssbo);
            gl::DeleteProgram(program);
            check("ES31_Compute")?;

            if let Some(i) = (0..COUNT).find(|&i| got[i] != (i as u32) * 3 + 7) {
                return Err(format!("element {i}: got {}, expected {}", got[i], (i as u32) * 3 + 7).into());
            }
            Ok(format!("{COUNT} compute results matched i*3+7 exactly"))
        }
    }
}

// ── ES30_VertexAttrib: attribute data survives the pipeline unchanged ─────────

pub struct Es30VertexAttribTest;

impl GLTest for Es30VertexAttribTest {
    fn name(&self) -> &'static str {
        "ES30_VertexAttrib"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 32;
        // `flat` interpolation: every fragment gets the provoking vertex's value verbatim, so
        // the expected output stays exact instead of depending on interpolation precision.
        let vs = b"#version 300 es\nlayout(location=0) in vec2 aPos;layout(location=1) in vec4 aColor;flat out vec4 vColor;void main(){vColor=aColor;gl_Position=vec4(aPos,0.0,1.0);}\n\0";
        let fs = b"#version 300 es\nprecision highp float;flat in vec4 vColor;out vec4 c;void main(){c=vColor;}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let program = link(&[compile(gl::VERTEX_SHADER, vs)?, compile(gl::FRAGMENT_SHADER, fs)?])?;

            #[rustfmt::skip]
            let verts: [f32; 18] = [
                -1.0, -1.0, 64.0 / 255.0, 128.0 / 255.0, 192.0 / 255.0, 1.0,
                 3.0, -1.0, 64.0 / 255.0, 128.0 / 255.0, 192.0 / 255.0, 1.0,
                -1.0,  3.0, 64.0 / 255.0, 128.0 / 255.0, 192.0 / 255.0, 1.0,
            ];
            let mut vao = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            let mut vbo = 0u32;
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                std::mem::size_of_val(&verts) as isize,
                verts.as_ptr() as *const c_void,
                gl::STATIC_DRAW,
            );
            let stride = 6 * std::mem::size_of::<f32>() as i32;
            gl::VertexAttribPointer(0, 2, gl::FLOAT, gl::FALSE, stride, std::ptr::null());
            gl::EnableVertexAttribArray(0);
            gl::VertexAttribPointer(
                1,
                4,
                gl::FLOAT,
                gl::FALSE,
                stride,
                (2 * std::mem::size_of::<f32>()) as *const c_void,
            );
            gl::EnableVertexAttribArray(1);

            gl::UseProgram(program);
            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();
            let px = target.read();
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteProgram(program);
            check("ES30_VertexAttrib")?;
            expect_solid(&px, [64, 128, 192, 255])?;
            Ok("vertex attributes reached the fragment stage unchanged".into())
        }
    }
}

// ── ES30_IntegerTexture: integer texels, where no unorm conversion exists at all ──

pub struct Es30IntegerTextureTest;

impl GLTest for Es30IntegerTextureTest {
    fn name(&self) -> &'static str {
        "ES30_IntegerTexture"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        // RGBA32UI removes the last place a driver could hide behind rounding: the values are
        // integers on the way in, through the sampler, and on the way out. `highp int` is
        // needed: a fragment shader's int defaults to mediump, which a driver may make 16 bits.
        let fs =
            b"#version 300 es\nprecision highp float;precision highp int;precision highp usampler2D;uniform usampler2D uTex;out uvec4 c;void main(){c=texelFetch(uTex,ivec2(gl_FragCoord.xy),0);}\n\0";
        unsafe {
            let mut src = vec![0u32; (N * N * 4) as usize];
            for (i, texel) in src.as_chunks_mut::<4>().0.iter_mut().enumerate() {
                let i = i as u32;
                *texel = [i, i.wrapping_mul(0x0101_0101), u32::MAX - i, i ^ 0xdead_beef];
            }
            let mut tex = 0u32;
            gl::GenTextures(1, &mut tex);
            gl::ActiveTexture(gl::TEXTURE0);
            gl::BindTexture(gl::TEXTURE_2D, tex);
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA32UI, N, N);
            gl::TexSubImage2D(
                gl::TEXTURE_2D,
                0,
                0,
                0,
                N,
                N,
                gl::RGBA_INTEGER,
                gl::UNSIGNED_INT,
                src.as_ptr() as *const c_void,
            );
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);

            let mut out_tex = 0u32;
            gl::GenTextures(1, &mut out_tex);
            gl::BindTexture(gl::TEXTURE_2D, out_tex);
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA32UI, N, N);
            let mut fbo = 0u32;
            gl::GenFramebuffers(1, &mut fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
            gl::FramebufferTexture2D(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::TEXTURE_2D, out_tex, 0);
            let cleanup = || {
                gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
                gl::DeleteFramebuffers(1, &fbo);
                gl::DeleteTextures(1, &out_tex);
                gl::DeleteTextures(1, &tex);
            };
            let status = gl::CheckFramebufferStatus(gl::FRAMEBUFFER);
            if status != gl::FRAMEBUFFER_COMPLETE {
                cleanup();
                return Err(format!("integer framebuffer incomplete: 0x{status:04x}").into());
            }
            gl::Viewport(0, 0, N, N);
            let _vao = Vao::new();
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            gl::Uniform1i(gl::GetUniformLocation(program, c"uTex".as_ptr()), 0);
            gl::BindTexture(gl::TEXTURE_2D, tex);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();

            let mut got = vec![0u32; src.len()];
            gl::ReadPixels(
                0,
                0,
                N,
                N,
                gl::RGBA_INTEGER,
                gl::UNSIGNED_INT,
                got.as_mut_ptr() as *mut c_void,
            );
            gl::DeleteProgram(program);
            cleanup();
            check("ES30_IntegerTexture")?;
            if let Some(i) = (0..got.len()).find(|&i| got[i] != src[i]) {
                return Err(format!("component {i}: got {}, expected {}", got[i], src[i]).into());
            }
            Ok(format!("{N}x{N} RGBA32UI texels survived sampling exactly"))
        }
    }
}

// ── ES30_TransformFeedback: the vertex stage's output captured and checked ────

pub struct Es30TransformFeedbackTest;

impl GLTest for Es30TransformFeedbackTest {
    fn name(&self) -> &'static str {
        "ES30_TransformFeedback"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const COUNT: usize = 256;
        // Integer arithmetic in the vertex stage, captured verbatim - no rasterizer, no
        // interpolation, so the comparison is against the formula and nothing else.
        let vs =
            b"#version 300 es\nflat out uint vOut;void main(){vOut=uint(gl_VertexID)*3u+7u;gl_Position=vec4(0.0);}\n\0";
        let fs = b"#version 300 es\nprecision highp float;out vec4 c;void main(){c=vec4(0.0);}\n\0";
        unsafe {
            let _vao = Vao::new();
            let vsh = compile(gl::VERTEX_SHADER, vs)?;
            let fsh = compile(gl::FRAGMENT_SHADER, fs)?;
            let program = gl::CreateProgram();
            gl::AttachShader(program, vsh);
            gl::AttachShader(program, fsh);
            // Must be declared before linking.
            let varying = c"vOut";
            let names = [varying.as_ptr()];
            gl::TransformFeedbackVaryings(program, 1, names.as_ptr(), gl::INTERLEAVED_ATTRIBS);
            gl::LinkProgram(program);
            gl::DeleteShader(vsh);
            gl::DeleteShader(fsh);
            let mut ok = 0i32;
            gl::GetProgramiv(program, gl::LINK_STATUS, &mut ok);
            if ok != 1 {
                gl::DeleteProgram(program);
                return Err("transform feedback program link failed".into());
            }

            let bytes = (COUNT * 4) as isize;
            let mut tfbo = 0u32;
            gl::GenBuffers(1, &mut tfbo);
            gl::BindBuffer(gl::TRANSFORM_FEEDBACK_BUFFER, tfbo);
            gl::BufferData(gl::TRANSFORM_FEEDBACK_BUFFER, bytes, std::ptr::null(), gl::STATIC_READ);
            gl::BindBufferBase(gl::TRANSFORM_FEEDBACK_BUFFER, 0, tfbo);

            gl::UseProgram(program);
            gl::Enable(gl::RASTERIZER_DISCARD);
            gl::BeginTransformFeedback(gl::POINTS);
            gl::DrawArrays(gl::POINTS, 0, COUNT as i32);
            gl::EndTransformFeedback();
            gl::Disable(gl::RASTERIZER_DISCARD);
            gl::MemoryBarrier(gl::TRANSFORM_FEEDBACK_BARRIER_BIT);

            let ptr = gl::MapBufferRange(gl::TRANSFORM_FEEDBACK_BUFFER, 0, bytes, gl::MAP_READ_BIT) as *const u32;
            if ptr.is_null() {
                gl::DeleteBuffers(1, &tfbo);
                gl::DeleteProgram(program);
                return Err("glMapBufferRange on the feedback buffer returned null".into());
            }
            let got = std::slice::from_raw_parts(ptr, COUNT).to_vec();
            gl::UnmapBuffer(gl::TRANSFORM_FEEDBACK_BUFFER);
            gl::DeleteBuffers(1, &tfbo);
            gl::DeleteProgram(program);
            check("ES30_TransformFeedback")?;
            if let Some(i) = (0..COUNT).find(|&i| got[i] != (i as u32) * 3 + 7) {
                return Err(format!("vertex {i}: captured {}, expected {}", got[i], (i as u32) * 3 + 7).into());
            }
            Ok(format!("{COUNT} captured vertices matched i*3+7 exactly"))
        }
    }
}

// ── ES30_UBO: std140 uniform data arrives unaltered ───────────────────────────

pub struct Es30UboTest;

impl GLTest for Es30UboTest {
    fn name(&self) -> &'static str {
        "ES30_UBO"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 8;
        // Four std140 vec4 slots; the shader picks one per channel, so a driver that mislays the
        // block layout produces a different colour rather than the same one by luck.
        let fs = b"#version 300 es\nprecision highp float;layout(std140) uniform Block{vec4 a;vec4 b;vec4 c;vec4 d;}u;out vec4 o;void main(){o=vec4(u.a.x,u.b.y,u.c.z,u.d.w);}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);

            let data: [f32; 16] = [
                64.0 / 255.0,
                0.0,
                0.0,
                0.0, //
                0.0,
                128.0 / 255.0,
                0.0,
                0.0, //
                0.0,
                0.0,
                192.0 / 255.0,
                0.0, //
                0.0,
                0.0,
                0.0,
                1.0,
            ];
            let mut ubo = 0u32;
            gl::GenBuffers(1, &mut ubo);
            gl::BindBuffer(gl::UNIFORM_BUFFER, ubo);
            gl::BufferData(
                gl::UNIFORM_BUFFER,
                std::mem::size_of_val(&data) as isize,
                data.as_ptr() as *const c_void,
                gl::STATIC_DRAW,
            );
            gl::BindBufferBase(gl::UNIFORM_BUFFER, 0, ubo);
            let index = gl::GetUniformBlockIndex(program, c"Block".as_ptr());
            if index == gl::INVALID_INDEX {
                gl::DeleteBuffers(1, &ubo);
                gl::DeleteProgram(program);
                return Err("uniform block 'Block' not found in the linked program".into());
            }
            gl::UniformBlockBinding(program, index, 0);

            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();
            let px = target.read();
            gl::DeleteBuffers(1, &ubo);
            gl::DeleteProgram(program);
            check("ES30_UBO")?;
            expect_solid(&px, [64, 128, 192, 255])?;
            Ok("std140 uniform block reached the shader with every slot intact".into())
        }
    }
}

// ── ES30_Scissor: the scissor rectangle is honoured to the pixel ──────────────

pub struct Es30ScissorTest;

impl GLTest for Es30ScissorTest {
    fn name(&self) -> &'static str {
        "ES30_Scissor"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        const X0: i32 = 3;
        const Y0: i32 = 5;
        const W: i32 = 7;
        const H: i32 = 4;
        unsafe {
            let target = Target::new(N)?;
            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::Enable(gl::SCISSOR_TEST);
            gl::Scissor(X0, Y0, W, H);
            gl::ClearColor(1.0, 1.0, 1.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::Disable(gl::SCISSOR_TEST);
            gl::Finish();
            let px = target.read();
            check("ES30_Scissor")?;
            // An off-by-one in either bound shows up as a wrong pixel, not as a wrong average.
            for y in 0..N {
                for x in 0..N {
                    let inside = (X0..X0 + W).contains(&x) && (Y0..Y0 + H).contains(&y);
                    let want: [u8; 4] = if inside { [255, 255, 255, 255] } else { [0, 0, 0, 255] };
                    let i = ((y * N + x) * 4) as usize;
                    if px[i..i + 4] != want {
                        return Err(format!(
                            "pixel ({x},{y}) inside={inside}: got {:?}, expected {want:?}",
                            &px[i..i + 4]
                        )
                        .into());
                    }
                }
            }
            Ok(format!("scissor rect {W}x{H} at ({X0},{Y0}) clipped exactly"))
        }
    }
}

// ── ES30_DepthTest: the nearer fragment wins, whichever order it is drawn in ──

pub struct Es30DepthTest;

impl GLTest for Es30DepthTest {
    fn name(&self) -> &'static str {
        "ES30_DepthTest"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        let vs =
            b"#version 300 es\nuniform float uZ;void main(){vec2 v[3];v[0]=vec2(-1.0,-1.0);v[1]=vec2(3.0,-1.0);v[2]=vec2(-1.0,3.0);gl_Position=vec4(v[gl_VertexID],uZ,1.0);}\n\0";
        let fs = b"#version 300 es\nprecision highp float;uniform vec4 uColor;out vec4 c;void main(){c=uColor;}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let mut depth = 0u32;
            gl::GenRenderbuffers(1, &mut depth);
            gl::BindRenderbuffer(gl::RENDERBUFFER, depth);
            gl::RenderbufferStorage(gl::RENDERBUFFER, gl::DEPTH_COMPONENT16, N, N);
            gl::FramebufferRenderbuffer(gl::FRAMEBUFFER, gl::DEPTH_ATTACHMENT, gl::RENDERBUFFER, depth);
            let status = gl::CheckFramebufferStatus(gl::FRAMEBUFFER);
            if status != gl::FRAMEBUFFER_COMPLETE {
                gl::DeleteRenderbuffers(1, &depth);
                return Err(format!("depth framebuffer incomplete: 0x{status:04x}").into());
            }
            let _vao = Vao::new();
            let program = link(&[compile(gl::VERTEX_SHADER, vs)?, compile(gl::FRAGMENT_SHADER, fs)?])?;
            gl::UseProgram(program);
            let z = gl::GetUniformLocation(program, c"uZ".as_ptr());
            let col = gl::GetUniformLocation(program, c"uColor".as_ptr());
            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::ClearDepthf(1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT | gl::DEPTH_BUFFER_BIT);
            gl::Enable(gl::DEPTH_TEST);
            gl::DepthFunc(gl::LESS);
            // Near first, then far: the far one must be rejected, which is the case a driver
            // with a broken depth compare passes by accident if drawn the other way round.
            gl::Uniform1f(z, -0.5);
            gl::Uniform4f(col, 64.0 / 255.0, 128.0 / 255.0, 192.0 / 255.0, 1.0);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Uniform1f(z, 0.5);
            gl::Uniform4f(col, 1.0, 0.0, 0.0, 1.0);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();
            gl::Disable(gl::DEPTH_TEST);
            let px = target.read();
            gl::DeleteProgram(program);
            gl::DeleteRenderbuffers(1, &depth);
            check("ES30_DepthTest")?;
            expect_solid(&px, [64, 128, 192, 255])?;
            Ok("GL_LESS depth test rejected the farther draw on every pixel".into())
        }
    }
}

// ── ES30_Instanced: gl_InstanceID reaches the shader, once per instance ───────

pub struct Es30InstancedTest;

impl GLTest for Es30InstancedTest {
    fn name(&self) -> &'static str {
        "ES30_Instanced"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        const INSTANCES: i32 = 4;
        // Each instance covers one horizontal band and writes its own index, so a wrong or
        // repeated gl_InstanceID lands in the wrong band instead of averaging out.
        let vs = b"#version 300 es\nflat out uint vId;void main(){float lo=-1.0+2.0*float(gl_InstanceID)/4.0;float hi=-1.0+2.0*float(gl_InstanceID+1)/4.0;vec2 v[6];v[0]=vec2(-1.0,lo);v[1]=vec2(1.0,lo);v[2]=vec2(-1.0,hi);v[3]=vec2(1.0,lo);v[4]=vec2(1.0,hi);v[5]=vec2(-1.0,hi);vId=uint(gl_InstanceID);gl_Position=vec4(v[gl_VertexID],0.0,1.0);}\n\0";
        let fs = b"#version 300 es\nprecision highp float;flat in uint vId;out vec4 c;void main(){c=vec4(float(vId*64u)/255.0,0.0,0.0,1.0);}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            let program = link(&[compile(gl::VERTEX_SHADER, vs)?, compile(gl::FRAGMENT_SHADER, fs)?])?;
            gl::UseProgram(program);
            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::DrawArraysInstanced(gl::TRIANGLES, 0, 6, INSTANCES);
            gl::Finish();
            let px = target.read();
            gl::DeleteProgram(program);
            check("ES30_Instanced")?;
            let band = N / INSTANCES;
            for y in 0..N {
                let want_r = ((y / band) * 64) as u8;
                let i = ((y * N) * 4) as usize;
                if px[i] != want_r {
                    return Err(format!("row {y} (band {}): got red {}, expected {want_r}", y / band, px[i]).into());
                }
            }
            Ok(format!("{INSTANCES} instances each wrote their own gl_InstanceID band"))
        }
    }
}

// ── ES30_ColorMask: a masked channel is left completely alone ─────────────────

pub struct Es30ColorMaskTest;

impl GLTest for Es30ColorMaskTest {
    fn name(&self) -> &'static str {
        "ES30_ColorMask"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        let fs = b"#version 300 es\nprecision highp float;uniform vec4 uColor;out vec4 c;void main(){c=uColor;}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            let loc = gl::GetUniformLocation(program, c"uColor".as_ptr());
            gl::ClearColor(0.0, 32.0 / 255.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            // Green is masked out, so it must still read back as the clear value while the other
            // channels take the new one.
            gl::ColorMask(gl::TRUE, gl::FALSE, gl::TRUE, gl::TRUE);
            gl::Uniform4f(loc, 64.0 / 255.0, 200.0 / 255.0, 192.0 / 255.0, 1.0);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();
            gl::ColorMask(gl::TRUE, gl::TRUE, gl::TRUE, gl::TRUE);
            let px = target.read();
            gl::DeleteProgram(program);
            check("ES30_ColorMask")?;
            expect_solid(&px, [64, 32, 192, 255])?;
            Ok("glColorMask kept the masked channel at its cleared value".into())
        }
    }
}

// ── ES30_Stencil: the stencil test admits exactly the pixels it should ────────

pub struct Es30StencilTest;

impl GLTest for Es30StencilTest {
    fn name(&self) -> &'static str {
        "ES30_Stencil"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        const W: i32 = 6;
        let fs = b"#version 300 es\nprecision highp float;uniform vec4 uColor;out vec4 c;void main(){c=uColor;}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let mut rb = 0u32;
            gl::GenRenderbuffers(1, &mut rb);
            gl::BindRenderbuffer(gl::RENDERBUFFER, rb);
            gl::RenderbufferStorage(gl::RENDERBUFFER, gl::STENCIL_INDEX8, N, N);
            gl::FramebufferRenderbuffer(gl::FRAMEBUFFER, gl::STENCIL_ATTACHMENT, gl::RENDERBUFFER, rb);
            let status = gl::CheckFramebufferStatus(gl::FRAMEBUFFER);
            if status != gl::FRAMEBUFFER_COMPLETE {
                gl::DeleteRenderbuffers(1, &rb);
                return Err(format!("stencil framebuffer incomplete: 0x{status:04x}").into());
            }
            let _vao = Vao::new();
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            let loc = gl::GetUniformLocation(program, c"uColor".as_ptr());
            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::ClearStencil(0);
            gl::Clear(gl::COLOR_BUFFER_BIT | gl::STENCIL_BUFFER_BIT);

            // Stamp stencil=1 into a scissored strip without touching colour, then draw
            // everywhere and let the stencil decide which pixels survive.
            gl::Enable(gl::STENCIL_TEST);
            gl::StencilFunc(gl::ALWAYS, 1, 0xff);
            gl::StencilOp(gl::KEEP, gl::KEEP, gl::REPLACE);
            gl::StencilMask(0xff);
            gl::ColorMask(gl::FALSE, gl::FALSE, gl::FALSE, gl::FALSE);
            gl::Enable(gl::SCISSOR_TEST);
            gl::Scissor(0, 0, W, N);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Disable(gl::SCISSOR_TEST);
            gl::ColorMask(gl::TRUE, gl::TRUE, gl::TRUE, gl::TRUE);

            gl::StencilFunc(gl::EQUAL, 1, 0xff);
            gl::StencilOp(gl::KEEP, gl::KEEP, gl::KEEP);
            gl::Uniform4f(loc, 64.0 / 255.0, 128.0 / 255.0, 192.0 / 255.0, 1.0);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();
            gl::Disable(gl::STENCIL_TEST);
            let px = target.read();
            gl::DeleteProgram(program);
            gl::DeleteRenderbuffers(1, &rb);
            check("ES30_Stencil")?;
            for y in 0..N {
                for x in 0..N {
                    let want: [u8; 4] = if x < W { [64, 128, 192, 255] } else { [0, 0, 0, 255] };
                    let i = ((y * N + x) * 4) as usize;
                    if px[i..i + 4] != want {
                        return Err(format!("pixel ({x},{y}): got {:?}, expected {want:?}", &px[i..i + 4]).into());
                    }
                }
            }
            Ok(format!("GL_EQUAL stencil admitted exactly the {W}-pixel stamped strip"))
        }
    }
}

// ── ES30_DrawElements: indices are followed in the order given ────────────────

pub struct Es30DrawElementsTest;

impl GLTest for Es30DrawElementsTest {
    fn name(&self) -> &'static str {
        "ES30_DrawElements"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        let vs = b"#version 300 es\nlayout(location=0) in vec2 aPos;layout(location=1) in float aShade;flat out float vShade;void main(){vShade=aShade;gl_Position=vec4(aPos,0.0,1.0);}\n\0";
        let fs = b"#version 300 es\nprecision highp float;flat in float vShade;out vec4 c;void main(){c=vec4(vShade,vShade,vShade,1.0);}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            let program = link(&[compile(gl::VERTEX_SHADER, vs)?, compile(gl::FRAGMENT_SHADER, fs)?])?;
            // Four corners; the index buffer picks the two triangles covering the whole quad, and
            // every vertex carries the same shade so a mis-indexed corner leaves a gap instead.
            #[rustfmt::skip]
            let verts: [f32; 12] = [
                -1.0, -1.0, 128.0 / 255.0,
                 1.0, -1.0, 128.0 / 255.0,
                 1.0,  1.0, 128.0 / 255.0,
                -1.0,  1.0, 128.0 / 255.0,
            ];
            let indices: [u16; 6] = [0, 1, 2, 0, 2, 3];
            let mut vbo = 0u32;
            let mut ibo = 0u32;
            gl::GenBuffers(1, &mut vbo);
            gl::BindBuffer(gl::ARRAY_BUFFER, vbo);
            gl::BufferData(
                gl::ARRAY_BUFFER,
                std::mem::size_of_val(&verts) as isize,
                verts.as_ptr() as *const c_void,
                gl::STATIC_DRAW,
            );
            gl::GenBuffers(1, &mut ibo);
            gl::BindBuffer(gl::ELEMENT_ARRAY_BUFFER, ibo);
            gl::BufferData(
                gl::ELEMENT_ARRAY_BUFFER,
                std::mem::size_of_val(&indices) as isize,
                indices.as_ptr() as *const c_void,
                gl::STATIC_DRAW,
            );
            let stride = 3 * std::mem::size_of::<f32>() as i32;
            gl::VertexAttribPointer(0, 2, gl::FLOAT, gl::FALSE, stride, std::ptr::null());
            gl::EnableVertexAttribArray(0);
            gl::VertexAttribPointer(
                1,
                1,
                gl::FLOAT,
                gl::FALSE,
                stride,
                (2 * std::mem::size_of::<f32>()) as *const c_void,
            );
            gl::EnableVertexAttribArray(1);

            gl::UseProgram(program);
            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            gl::DrawElements(gl::TRIANGLES, 6, gl::UNSIGNED_SHORT, std::ptr::null());
            gl::Finish();
            let px = target.read();
            gl::DeleteBuffers(1, &vbo);
            gl::DeleteBuffers(1, &ibo);
            gl::DeleteProgram(program);
            check("ES30_DrawElements")?;
            expect_solid(&px, [128, 128, 128, 255])?;
            Ok("indexed quad covered every pixel exactly once".into())
        }
    }
}

// ── ES30_MRT: each draw buffer receives its own value ─────────────────────────

pub struct Es30MrtTest;

impl GLTest for Es30MrtTest {
    fn name(&self) -> &'static str {
        "ES30_MRT"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 8;
        let fs = b"#version 300 es\nprecision highp float;layout(location=0) out vec4 o0;layout(location=1) out vec4 o1;void main(){o0=vec4(64.0/255.0,0.0,0.0,1.0);o1=vec4(0.0,192.0/255.0,0.0,1.0);}\n\0";
        unsafe {
            let mut tex = [0u32; 2];
            gl::GenTextures(2, tex.as_mut_ptr());
            let mut fbo = 0u32;
            gl::GenFramebuffers(1, &mut fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
            for (i, &t) in tex.iter().enumerate() {
                gl::BindTexture(gl::TEXTURE_2D, t);
                gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::RGBA8, N, N);
                gl::FramebufferTexture2D(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0 + i as u32, gl::TEXTURE_2D, t, 0);
            }
            let cleanup = || {
                gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
                gl::DeleteFramebuffers(1, &fbo);
                gl::DeleteTextures(2, tex.as_ptr());
            };
            let status = gl::CheckFramebufferStatus(gl::FRAMEBUFFER);
            if status != gl::FRAMEBUFFER_COMPLETE {
                cleanup();
                return Err(format!("MRT framebuffer incomplete: 0x{status:04x}").into());
            }
            let bufs = [gl::COLOR_ATTACHMENT0, gl::COLOR_ATTACHMENT1];
            gl::DrawBuffers(2, bufs.as_ptr());
            gl::Viewport(0, 0, N, N);
            let _vao = Vao::new();
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            gl::DrawArrays(gl::TRIANGLES, 0, 3);
            gl::Finish();

            let mut px = vec![0u8; (N * N * 4) as usize];
            gl::PixelStorei(gl::PACK_ALIGNMENT, 1);
            let mut results = Vec::new();
            for i in 0..2u32 {
                gl::ReadBuffer(gl::COLOR_ATTACHMENT0 + i);
                gl::ReadPixels(0, 0, N, N, gl::RGBA, gl::UNSIGNED_BYTE, px.as_mut_ptr() as *mut c_void);
                results.push(px.clone());
            }
            gl::DeleteProgram(program);
            cleanup();
            check("ES30_MRT")?;
            expect_solid(&results[0], [64, 0, 0, 255])?;
            expect_solid(&results[1], [0, 192, 0, 255])?;
            Ok("two draw buffers each received only their own fragment output".into())
        }
    }
}

// ── ES30_BlitFramebuffer: a same-size blit is a byte copy ─────────────────────

pub struct Es30BlitTest;

impl GLTest for Es30BlitTest {
    fn name(&self) -> &'static str {
        "ES30_Blit"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        unsafe {
            let src = Target::new(N)?;
            gl::ClearColor(64.0 / 255.0, 128.0 / 255.0, 192.0 / 255.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            let dst = Target::new(N)?;
            gl::ClearColor(0.0, 0.0, 0.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            // 1:1 and GL_NEAREST, so any difference is the blit itself and not filtering.
            gl::BindFramebuffer(gl::READ_FRAMEBUFFER, src.fbo);
            gl::BindFramebuffer(gl::DRAW_FRAMEBUFFER, dst.fbo);
            gl::BlitFramebuffer(0, 0, N, N, 0, 0, N, N, gl::COLOR_BUFFER_BIT, gl::NEAREST);
            gl::Finish();
            gl::BindFramebuffer(gl::FRAMEBUFFER, dst.fbo);
            let px = dst.read();
            check("ES30_Blit")?;
            expect_solid(&px, [64, 128, 192, 255])?;
            Ok(format!("{N}x{N} 1:1 blit copied every pixel unchanged"))
        }
    }
}

// ── ES30_TextureArray: layers stay distinct ───────────────────────────────────

pub struct Es30TextureArrayTest;

impl GLTest for Es30TextureArrayTest {
    fn name(&self) -> &'static str {
        "ES30_TextureArray"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 8;
        const LAYERS: i32 = 4;
        // Each layer is a flat colour; the shader picks one by uniform, so a driver that samples
        // the wrong slice returns another layer's colour instead of a blend.
        let fs = b"#version 300 es\nprecision highp float;precision highp sampler2DArray;uniform sampler2DArray uTex;uniform int uLayer;out vec4 c;void main(){c=texelFetch(uTex,ivec3(ivec2(gl_FragCoord.xy),uLayer),0);}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            let mut tex = 0u32;
            gl::GenTextures(1, &mut tex);
            gl::ActiveTexture(gl::TEXTURE0);
            gl::BindTexture(gl::TEXTURE_2D_ARRAY, tex);
            gl::TexStorage3D(gl::TEXTURE_2D_ARRAY, 1, gl::RGBA8, N, N, LAYERS);
            gl::PixelStorei(gl::UNPACK_ALIGNMENT, 1);
            for layer in 0..LAYERS {
                let v = (layer as u8 + 1) * 50;
                let plane = vec![[v, v, v, 255u8]; (N * N) as usize].concat();
                gl::TexSubImage3D(
                    gl::TEXTURE_2D_ARRAY,
                    0,
                    0,
                    0,
                    layer,
                    N,
                    N,
                    1,
                    gl::RGBA,
                    gl::UNSIGNED_BYTE,
                    plane.as_ptr() as *const c_void,
                );
            }
            gl::TexParameteri(gl::TEXTURE_2D_ARRAY, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_2D_ARRAY, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            gl::Uniform1i(gl::GetUniformLocation(program, c"uTex".as_ptr()), 0);
            let layer_loc = gl::GetUniformLocation(program, c"uLayer".as_ptr());
            for layer in 0..LAYERS {
                gl::Uniform1i(layer_loc, layer);
                gl::DrawArrays(gl::TRIANGLES, 0, 3);
                gl::Finish();
                let px = target.read();
                let v = (layer as u8 + 1) * 50;
                if let Err(e) = expect_solid(&px, [v, v, v, 255]) {
                    gl::DeleteProgram(program);
                    gl::DeleteTextures(1, &tex);
                    return Err(format!("layer {layer}: {e}").into());
                }
            }
            gl::DeleteProgram(program);
            gl::DeleteTextures(1, &tex);
            check("ES30_TextureArray")?;
            Ok(format!("{LAYERS} array layers each sampled back their own colour"))
        }
    }
}

// ── ES30_Texture3D: the same, in the third dimension ──────────────────────────

pub struct Es30Texture3DTest;

impl GLTest for Es30Texture3DTest {
    fn name(&self) -> &'static str {
        "ES30_Texture3D"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 8;
        const DEPTH: i32 = 4;
        let fs = b"#version 300 es\nprecision highp float;precision highp sampler3D;uniform sampler3D uTex;uniform int uSlice;out vec4 c;void main(){c=texelFetch(uTex,ivec3(ivec2(gl_FragCoord.xy),uSlice),0);}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            let mut tex = 0u32;
            gl::GenTextures(1, &mut tex);
            gl::ActiveTexture(gl::TEXTURE0);
            gl::BindTexture(gl::TEXTURE_3D, tex);
            gl::TexStorage3D(gl::TEXTURE_3D, 1, gl::RGBA8, N, N, DEPTH);
            gl::PixelStorei(gl::UNPACK_ALIGNMENT, 1);
            for z in 0..DEPTH {
                let v = (z as u8 + 1) * 60;
                let plane = vec![[v, v, v, 255u8]; (N * N) as usize].concat();
                gl::TexSubImage3D(
                    gl::TEXTURE_3D,
                    0,
                    0,
                    0,
                    z,
                    N,
                    N,
                    1,
                    gl::RGBA,
                    gl::UNSIGNED_BYTE,
                    plane.as_ptr() as *const c_void,
                );
            }
            gl::TexParameteri(gl::TEXTURE_3D, gl::TEXTURE_MIN_FILTER, gl::NEAREST as i32);
            gl::TexParameteri(gl::TEXTURE_3D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            gl::Uniform1i(gl::GetUniformLocation(program, c"uTex".as_ptr()), 0);
            let slice_loc = gl::GetUniformLocation(program, c"uSlice".as_ptr());
            for z in 0..DEPTH {
                gl::Uniform1i(slice_loc, z);
                gl::DrawArrays(gl::TRIANGLES, 0, 3);
                gl::Finish();
                let px = target.read();
                let v = (z as u8 + 1) * 60;
                if let Err(e) = expect_solid(&px, [v, v, v, 255]) {
                    gl::DeleteProgram(program);
                    gl::DeleteTextures(1, &tex);
                    return Err(format!("slice {z}: {e}").into());
                }
            }
            gl::DeleteProgram(program);
            gl::DeleteTextures(1, &tex);
            check("ES30_Texture3D")?;
            Ok(format!("{DEPTH} 3D slices each sampled back their own colour"))
        }
    }
}

// ── ES30_Mipmap: downsampling a flat image cannot change its colour ───────────

pub struct Es30MipmapTest;

impl GLTest for Es30MipmapTest {
    fn name(&self) -> &'static str {
        "ES30_Mipmap"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const SRC: i32 = 16;
        const N: i32 = 4;
        // Every texel of level 0 is the same, so whatever filter glGenerateMipmap uses, every
        // smaller level must hold that exact colour. A wrong value means the box filter is wrong,
        // not that the expectation was approximate.
        let fs = b"#version 300 es\nprecision highp float;uniform sampler2D uTex;uniform float uLod;out vec4 c;void main(){c=textureLod(uTex,vec2(0.5),uLod);}\n\0";
        unsafe {
            let target = Target::new(N)?;
            let _vao = Vao::new();
            let mut tex = 0u32;
            gl::GenTextures(1, &mut tex);
            gl::ActiveTexture(gl::TEXTURE0);
            gl::BindTexture(gl::TEXTURE_2D, tex);
            let levels = (SRC as f32).log2() as i32 + 1;
            gl::TexStorage2D(gl::TEXTURE_2D, levels, gl::RGBA8, SRC, SRC);
            gl::PixelStorei(gl::UNPACK_ALIGNMENT, 1);
            let flat = vec![[64u8, 128, 192, 255]; (SRC * SRC) as usize].concat();
            gl::TexSubImage2D(
                gl::TEXTURE_2D,
                0,
                0,
                0,
                SRC,
                SRC,
                gl::RGBA,
                gl::UNSIGNED_BYTE,
                flat.as_ptr() as *const c_void,
            );
            gl::TexParameteri(
                gl::TEXTURE_2D,
                gl::TEXTURE_MIN_FILTER,
                gl::NEAREST_MIPMAP_NEAREST as i32,
            );
            gl::TexParameteri(gl::TEXTURE_2D, gl::TEXTURE_MAG_FILTER, gl::NEAREST as i32);
            gl::GenerateMipmap(gl::TEXTURE_2D);
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            gl::Uniform1i(gl::GetUniformLocation(program, c"uTex".as_ptr()), 0);
            let lod = gl::GetUniformLocation(program, c"uLod".as_ptr());
            for level in 0..levels {
                gl::Uniform1f(lod, level as f32);
                gl::DrawArrays(gl::TRIANGLES, 0, 3);
                gl::Finish();
                let px = target.read();
                if let Err(e) = expect_solid(&px, [64, 128, 192, 255]) {
                    gl::DeleteProgram(program);
                    gl::DeleteTextures(1, &tex);
                    return Err(format!("mip level {level}: {e}").into());
                }
            }
            gl::DeleteProgram(program);
            gl::DeleteTextures(1, &tex);
            check("ES30_Mipmap")?;
            Ok(format!("all {levels} generated mip levels kept the flat source colour"))
        }
    }
}

// ── ES30_CopyBufferSubData: a device-side buffer copy is byte-exact ───────────

pub struct Es30CopyBufferTest;

impl GLTest for Es30CopyBufferTest {
    fn name(&self) -> &'static str {
        "ES30_CopyBuffer"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const COUNT: usize = 512;
        unsafe {
            let src: Vec<u32> = (0..COUNT as u32).map(|i| i.wrapping_mul(2_654_435_761)).collect();
            let bytes = (COUNT * 4) as isize;
            let mut bufs = [0u32; 2];
            gl::GenBuffers(2, bufs.as_mut_ptr());
            gl::BindBuffer(gl::COPY_READ_BUFFER, bufs[0]);
            gl::BufferData(
                gl::COPY_READ_BUFFER,
                bytes,
                src.as_ptr() as *const c_void,
                gl::STATIC_DRAW,
            );
            gl::BindBuffer(gl::COPY_WRITE_BUFFER, bufs[1]);
            gl::BufferData(gl::COPY_WRITE_BUFFER, bytes, std::ptr::null(), gl::STATIC_READ);
            gl::CopyBufferSubData(gl::COPY_READ_BUFFER, gl::COPY_WRITE_BUFFER, 0, 0, bytes);
            let ptr = gl::MapBufferRange(gl::COPY_WRITE_BUFFER, 0, bytes, gl::MAP_READ_BIT) as *const u32;
            if ptr.is_null() {
                gl::DeleteBuffers(2, bufs.as_ptr());
                return Err("glMapBufferRange on the copy target returned null".into());
            }
            let got = std::slice::from_raw_parts(ptr, COUNT).to_vec();
            gl::UnmapBuffer(gl::COPY_WRITE_BUFFER);
            gl::DeleteBuffers(2, bufs.as_ptr());
            check("ES30_CopyBuffer")?;
            if let Some(i) = (0..COUNT).find(|&i| got[i] != src[i]) {
                return Err(format!("word {i}: got {}, expected {}", got[i], src[i]).into());
            }
            Ok(format!("{COUNT} words copied between buffers byte-identically"))
        }
    }
}

// ── ES30_Sync: a fence signals once the work behind it is done ────────────────

pub struct Es30SyncTest;

impl GLTest for Es30SyncTest {
    fn name(&self) -> &'static str {
        "ES30_Sync"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 32;
        unsafe {
            let target = Target::new(N)?;
            gl::ClearColor(64.0 / 255.0, 128.0 / 255.0, 192.0 / 255.0, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            let sync = gl::FenceSync(gl::SYNC_GPU_COMMANDS_COMPLETE, 0);
            if sync.is_null() {
                return Err("glFenceSync returned null".into());
            }
            // A second is far beyond a screen clear; a timeout here means the fence never fired.
            let status = gl::ClientWaitSync(sync, gl::SYNC_FLUSH_COMMANDS_BIT, 1_000_000_000);
            gl::DeleteSync(sync);
            if status != gl::ALREADY_SIGNALED && status != gl::CONDITION_SATISFIED {
                return Err(format!("glClientWaitSync returned 0x{status:04x}, not a signalled status").into());
            }
            let px = target.read();
            check("ES30_Sync")?;
            // The point is ordering: after the fence signals the clear must already be visible.
            expect_solid(&px, [64, 128, 192, 255])?;
            Ok("the fence signalled and the work behind it was complete".into())
        }
    }
}

// ── ES30_OcclusionQuery: the query answers what was actually drawn ────────────

pub struct Es30OcclusionQueryTest;

impl GLTest for Es30OcclusionQueryTest {
    fn name(&self) -> &'static str {
        "ES30_OcclusionQuery"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 0)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        let fs = b"#version 300 es\nprecision highp float;out vec4 c;void main(){c=vec4(1.0);}\n\0";
        unsafe {
            let _target = Target::new(N)?;
            let _vao = Vao::new();
            let program = link(&[
                compile(gl::VERTEX_SHADER, FULLSCREEN_VS)?,
                compile(gl::FRAGMENT_SHADER, fs)?,
            ])?;
            gl::UseProgram(program);
            let mut query = 0u32;
            gl::GenQueries(1, &mut query);

            let measure = |draw: bool| -> u32 {
                gl::BeginQuery(gl::ANY_SAMPLES_PASSED, query);
                if draw {
                    gl::DrawArrays(gl::TRIANGLES, 0, 3);
                }
                gl::EndQuery(gl::ANY_SAMPLES_PASSED);
                gl::Finish();
                let mut result = 0u32;
                gl::GetQueryObjectuiv(query, gl::QUERY_RESULT, &mut result);
                result
            };
            // Both directions: a query stuck at either answer fails one of the two.
            let none = measure(false);
            let some = measure(true);
            gl::DeleteQueries(1, &query);
            gl::DeleteProgram(program);
            check("ES30_OcclusionQuery")?;
            if none != 0 {
                return Err(format!("query reported {none} samples with nothing drawn").into());
            }
            if some == 0 {
                return Err("query reported no samples after a fullscreen draw".into());
            }
            Ok("ANY_SAMPLES_PASSED answered 0 with no draw and non-zero with one".into())
        }
    }
}

// ── ES31_AtomicCounter: increments add up to exactly the invocation count ─────

pub struct Es31AtomicCounterTest;

impl GLTest for Es31AtomicCounterTest {
    fn name(&self) -> &'static str {
        "ES31_AtomicCounter"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 1)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const COUNT: u32 = 1024;
        const LOCAL: u32 = 64;
        // One increment per invocation: any lost update from a broken atomic shows up as a total
        // below COUNT, and any double-count as one above.
        let cs = b"#version 310 es\nlayout(local_size_x=64) in;\nlayout(binding=0,offset=0) uniform atomic_uint counter;\nvoid main(){atomicCounterIncrement(counter);}\n\0";
        unsafe {
            let program = link(&[compile(gl::COMPUTE_SHADER, cs)?])?;
            let mut buf = 0u32;
            gl::GenBuffers(1, &mut buf);
            gl::BindBuffer(gl::ATOMIC_COUNTER_BUFFER, buf);
            let zero = 0u32;
            gl::BufferData(
                gl::ATOMIC_COUNTER_BUFFER,
                4,
                &zero as *const u32 as *const c_void,
                gl::DYNAMIC_COPY,
            );
            gl::BindBufferBase(gl::ATOMIC_COUNTER_BUFFER, 0, buf);
            gl::UseProgram(program);
            gl::DispatchCompute(COUNT / LOCAL, 1, 1);
            gl::MemoryBarrier(gl::ATOMIC_COUNTER_BARRIER_BIT);
            let ptr = gl::MapBufferRange(gl::ATOMIC_COUNTER_BUFFER, 0, 4, gl::MAP_READ_BIT) as *const u32;
            if ptr.is_null() {
                gl::DeleteBuffers(1, &buf);
                gl::DeleteProgram(program);
                return Err("glMapBufferRange on the atomic counter returned null".into());
            }
            let total = *ptr;
            gl::UnmapBuffer(gl::ATOMIC_COUNTER_BUFFER);
            gl::DeleteBuffers(1, &buf);
            gl::DeleteProgram(program);
            check("ES31_AtomicCounter")?;
            if total != COUNT {
                return Err(format!("counter reached {total}, expected exactly {COUNT}").into());
            }
            Ok(format!(
                "{COUNT} invocations incremented the counter exactly {COUNT} times"
            ))
        }
    }
}

// ── ES31_ImageStore: a compute shader writing straight into an image ──────────

pub struct Es31ImageStoreTest;

impl GLTest for Es31ImageStoreTest {
    fn name(&self) -> &'static str {
        "ES31_ImageStore"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 1)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const N: i32 = 16;
        // r32ui is a required image format in ES 3.1, and integer storage means the readback is
        // compared against the formula with no conversion in between.
        let cs = b"#version 310 es\nlayout(local_size_x=8,local_size_y=8) in;\nlayout(r32ui,binding=0) uniform highp writeonly uimage2D img;\nvoid main(){ivec2 p=ivec2(gl_GlobalInvocationID.xy);imageStore(img,p,uvec4(uint(p.y*16+p.x)*3u+7u,0u,0u,0u));}\n\0";
        unsafe {
            let program = link(&[compile(gl::COMPUTE_SHADER, cs)?])?;
            let mut tex = 0u32;
            gl::GenTextures(1, &mut tex);
            gl::BindTexture(gl::TEXTURE_2D, tex);
            gl::TexStorage2D(gl::TEXTURE_2D, 1, gl::R32UI, N, N);
            gl::BindImageTexture(0, tex, 0, gl::FALSE, 0, gl::WRITE_ONLY, gl::R32UI);
            gl::UseProgram(program);
            gl::DispatchCompute((N / 8) as u32, (N / 8) as u32, 1);
            gl::MemoryBarrier(gl::TEXTURE_UPDATE_BARRIER_BIT | gl::SHADER_IMAGE_ACCESS_BARRIER_BIT);

            let mut fbo = 0u32;
            gl::GenFramebuffers(1, &mut fbo);
            gl::BindFramebuffer(gl::FRAMEBUFFER, fbo);
            gl::FramebufferTexture2D(gl::FRAMEBUFFER, gl::COLOR_ATTACHMENT0, gl::TEXTURE_2D, tex, 0);
            let cleanup = || {
                gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
                gl::DeleteFramebuffers(1, &fbo);
                gl::DeleteTextures(1, &tex);
                gl::DeleteProgram(program);
            };
            let status = gl::CheckFramebufferStatus(gl::FRAMEBUFFER);
            if status != gl::FRAMEBUFFER_COMPLETE {
                cleanup();
                return Err(format!("r32ui framebuffer incomplete: 0x{status:04x}").into());
            }
            let mut got = vec![0u32; (N * N) as usize];
            gl::ReadPixels(
                0,
                0,
                N,
                N,
                gl::RED_INTEGER,
                gl::UNSIGNED_INT,
                got.as_mut_ptr() as *mut c_void,
            );
            cleanup();
            check("ES31_ImageStore")?;
            if let Some(i) = (0..got.len()).find(|&i| got[i] != (i as u32) * 3 + 7) {
                return Err(format!("texel {i}: got {}, expected {}", got[i], (i as u32) * 3 + 7).into());
            }
            Ok(format!("{N}x{N} image stores matched i*3+7 exactly"))
        }
    }
}

// ── ES31_ComputeShared: shared memory and barrier produce a known reduction ───

pub struct Es31ComputeSharedTest;

impl GLTest for Es31ComputeSharedTest {
    fn name(&self) -> &'static str {
        "ES31_ComputeShared"
    }
    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 1)
    }
    fn run(&self) -> Result<String, Box<dyn Error>> {
        const GROUPS: u32 = 8;
        const LOCAL: u32 = 64;
        // Each group sums 0..63 through shared memory behind a barrier. A barrier that does not
        // actually synchronise gives a smaller or unstable sum, never the exact 2016.
        let cs = b"#version 310 es\nlayout(local_size_x=64) in;\nshared uint tmp[64];\nlayout(std430,binding=0) buffer B{uint out_[];};\nvoid main(){uint l=gl_LocalInvocationID.x;tmp[l]=l;barrier();if(l==0u){uint s=0u;for(uint i=0u;i<64u;i++){s+=tmp[i];}out_[gl_WorkGroupID.x]=s;}}\n\0";
        unsafe {
            let program = link(&[compile(gl::COMPUTE_SHADER, cs)?])?;
            let mut ssbo = 0u32;
            gl::GenBuffers(1, &mut ssbo);
            gl::BindBuffer(gl::SHADER_STORAGE_BUFFER, ssbo);
            let bytes = (GROUPS * 4) as isize;
            gl::BufferData(gl::SHADER_STORAGE_BUFFER, bytes, std::ptr::null(), gl::DYNAMIC_COPY);
            gl::BindBufferBase(gl::SHADER_STORAGE_BUFFER, 0, ssbo);
            gl::UseProgram(program);
            gl::DispatchCompute(GROUPS, 1, 1);
            gl::MemoryBarrier(gl::BUFFER_UPDATE_BARRIER_BIT);
            let ptr = gl::MapBufferRange(gl::SHADER_STORAGE_BUFFER, 0, bytes, gl::MAP_READ_BIT) as *const u32;
            if ptr.is_null() {
                gl::DeleteBuffers(1, &ssbo);
                gl::DeleteProgram(program);
                return Err("glMapBufferRange on the reduction buffer returned null".into());
            }
            let got = std::slice::from_raw_parts(ptr, GROUPS as usize).to_vec();
            gl::UnmapBuffer(gl::SHADER_STORAGE_BUFFER);
            gl::DeleteBuffers(1, &ssbo);
            gl::DeleteProgram(program);
            check("ES31_ComputeShared")?;
            let want = (LOCAL - 1) * LOCAL / 2;
            if let Some(i) = (0..GROUPS as usize).find(|&i| got[i] != want) {
                return Err(format!("workgroup {i}: summed to {}, expected {want}", got[i]).into());
            }
            Ok(format!(
                "{GROUPS} workgroups each reduced shared memory to exactly {want}"
            ))
        }
    }
}
