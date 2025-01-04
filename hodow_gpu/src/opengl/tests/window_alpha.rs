//! GL_VERSION: 3.3

use std::error::Error;

use super::validation::{assert_no_gl_error, build_render_program, gl_version, read_rgba8, version_at_least};
use crate::opengl::test_trait::{GLTest, GLVersion};

const SIZE: i32 = 32;
const TOLERANCE: u8 = 2;

/// Alpha written into the window's own framebuffer, as a compositor reads it.
///
/// A window surface with an alpha channel is composited with that alpha, so a toolkit that
/// leaves alpha below 1 in places it meant to be opaque shows the desktop through (czkawka
/// issue 2103: background transparent, text boxes white). Every case here has an analytic
/// result; the plain `glBlendFunc` case documents what an application that does not blend alpha
/// separately ends up with.
pub struct WindowAlphaTest;

struct BlendCase {
    label: &'static str,
    src: [f32; 4],
    funcs: [u32; 4],
    expected: [u8; 4],
}

const CASES: [BlendCase; 3] = [
    BlendCase {
        label: "premultiplied separate (ONE, 1-SRC_A | ONE, 1-SRC_A)",
        src: [0.25, 0.25, 0.25, 0.5],
        funcs: [gl::ONE, gl::ONE_MINUS_SRC_ALPHA, gl::ONE, gl::ONE_MINUS_SRC_ALPHA],
        expected: [64, 64, 64, 255],
    },
    BlendCase {
        label: "straight color, separate alpha (SRC_A, 1-SRC_A | ONE, 1-SRC_A)",
        src: [0.5, 0.5, 0.5, 0.5],
        funcs: [gl::SRC_ALPHA, gl::ONE_MINUS_SRC_ALPHA, gl::ONE, gl::ONE_MINUS_SRC_ALPHA],
        expected: [64, 64, 64, 255],
    },
    BlendCase {
        label: "plain glBlendFunc (SRC_A, 1-SRC_A) applied to alpha too",
        src: [0.5, 0.5, 0.5, 0.5],
        funcs: [
            gl::SRC_ALPHA,
            gl::ONE_MINUS_SRC_ALPHA,
            gl::SRC_ALPHA,
            gl::ONE_MINUS_SRC_ALPHA,
        ],
        expected: [64, 64, 64, 191],
    },
];

fn check(label: &str, pixels: &[u8], expected: [u8; 4]) -> Result<(), String> {
    let first = pixels.as_chunks::<4>().0.first().ok_or("empty readback")?;
    let uniform = pixels.as_chunks::<4>().0.iter().all(|px| px == first);
    let off = (0..4).any(|c| first[c].abs_diff(expected[c]) > TOLERANCE);
    if off || !uniform {
        return Err(format!(
            "{label}: got {first:?}{}, expected {expected:?} (+/-{TOLERANCE})",
            if uniform { "" } else { " (not uniform)" }
        ));
    }
    Ok(())
}

impl GLTest for WindowAlphaTest {
    fn name(&self) -> &'static str {
        "Validate_WindowAlpha"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(3, 3)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        let vs = b"#version 330 core\nconst vec2 v[3]=vec2[3](vec2(-1,-1),vec2(3,-1),vec2(-1,3));\nvoid main(){gl_Position=vec4(v[gl_VertexID],0.0,1.0);}\n\0";
        let fs = b"#version 330 core\nout vec4 c;uniform vec4 uColor;void main(){c=uColor;}\n\0";
        unsafe {
            if !version_at_least(gl_version(), (3, 3)) {
                return Ok("skipped: needs GL 3.3".into());
            }
            gl::BindFramebuffer(gl::FRAMEBUFFER, 0);
            if gl::CheckFramebufferStatus(gl::FRAMEBUFFER) != gl::FRAMEBUFFER_COMPLETE {
                return Ok("skipped: no window framebuffer (headless context)".into());
            }
            let mut alpha_bits = 0i32;
            gl::GetFramebufferAttachmentParameteriv(
                gl::FRAMEBUFFER,
                gl::BACK,
                gl::FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE,
                &mut alpha_bits,
            );
            if gl::GetError() != gl::NO_ERROR || alpha_bits == 0 {
                return Ok("skipped: the window framebuffer has no alpha channel".into());
            }

            let mut vao = 0u32;
            gl::GenVertexArrays(1, &mut vao);
            gl::BindVertexArray(vao);
            let program = build_render_program(vs, fs)?;
            gl::UseProgram(program);
            let loc = gl::GetUniformLocation(program, c"uColor".as_ptr());
            gl::Enable(gl::SCISSOR_TEST);
            gl::Scissor(0, 0, SIZE, SIZE);

            let mut failures = Vec::new();
            gl::ClearColor(0.5, 0.5, 0.5, 1.0);
            gl::Clear(gl::COLOR_BUFFER_BIT);
            if let Err(e) = check("opaque clear", &read_rgba8(SIZE, SIZE), [128, 128, 128, 255]) {
                failures.push(e);
            }

            gl::Enable(gl::BLEND);
            for case in &CASES {
                gl::ClearColor(0.0, 0.0, 0.0, 1.0);
                gl::Clear(gl::COLOR_BUFFER_BIT);
                gl::BlendFuncSeparate(case.funcs[0], case.funcs[1], case.funcs[2], case.funcs[3]);
                gl::Uniform4f(loc, case.src[0], case.src[1], case.src[2], case.src[3]);
                gl::DrawArrays(gl::TRIANGLES, 0, 3);
                gl::Finish();
                if let Err(e) = check(case.label, &read_rgba8(SIZE, SIZE), case.expected) {
                    failures.push(e);
                }
            }

            let gl_error = assert_no_gl_error("window alpha");
            gl::Disable(gl::BLEND);
            gl::Disable(gl::SCISSOR_TEST);
            gl::UseProgram(0);
            gl::DeleteProgram(program);
            gl::DeleteVertexArrays(1, &vao);
            gl_error?;
            if !failures.is_empty() {
                return Err(format!(
                    "window framebuffer has {alpha_bits} alpha bits; {}",
                    failures.join("; ")
                )
                .into());
            }
            Ok(format!(
                "window framebuffer has {alpha_bits} alpha bits; clear and {} blend setups give the expected alpha",
                CASES.len()
            ))
        }
    }
}
