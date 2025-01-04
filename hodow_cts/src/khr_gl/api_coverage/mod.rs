// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcApiCoverageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream parses `CoverageGL<ver>.test` out of the data archive with an XML parser and asks `gluStrUtil.inl` for the name of every enum; both are generated into `generated/khr_api_coverage.rs` by `scripts/gen_khr_api_coverage.py` (the `.test` files in the same order, the name functions as one sorted (value, name) table, which is what `getEnumNames`'s union over all of them amounts to). A function the verifier has no test for is logged and passes, as upstream does for names missing from `funcs_map` and for its "not implemented yet" stubs; `run_func` lists the ones that have a body. The per-function tests live in `functions_gl*.rs`, one file per version that introduced them, in upstream's order.

use std::ffi::CString;

use crate::generated::khr_api_coverage::{self as data, Config};
use crate::glu::{self, Context, ContextType, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{StringTemplate, TestError, TestOutcome, TestStatus};

mod functions_gl30;
mod functions_gl30_fbo;
mod functions_gl30_feedback;
mod functions_gl30_objects;
mod functions_gl30_params;
mod functions_gl30_shaders;
mod functions_gl30_state;
mod functions_gl30_uniforms;
mod functions_gl30_vertex;
mod functions_gl31;
mod functions_gl32;
mod functions_gl33;
mod functions_gl40;

const VERT_SHADER: &str = "${VERSION}\n    out vec3 texCoords;\n    in vec2 inPosition;\n    in vec3 inTexCoord;\n    void main() {\n        gl_Position = vec4(inPosition.x, inPosition.y, 0.0,1.0);\n        texCoords = inTexCoord;\n    }\n    ";

const FRAG_SHADER: &str = "${VERSION}\n    ${PRECISION}\n    uniform sampler2D tex0;\n    in vec3 texCoords;\n    out vec4 frag_color;\n    void main() {\n        frag_color = texture(tex0, texCoords.xy);\n    }\n    ";

const VERSION_NAMES: [&str; 17] = [
    "GL_VERSION_1_1",
    "GL_VERSION_1_2",
    "GL_VERSION_1_3",
    "GL_VERSION_1_4",
    "GL_VERSION_1_5",
    "GL_VERSION_2_0",
    "GL_VERSION_2_1",
    "GL_VERSION_3_0",
    "GL_VERSION_3_1",
    "GL_VERSION_3_2",
    "GL_VERSION_3_3",
    "GL_VERSION_4_0",
    "GL_VERSION_4_1",
    "GL_VERSION_4_2",
    "GL_VERSION_4_3",
    "GL_VERSION_4_4",
    "GL_VERSION_4_5",
];

/// `glw::Functions` and the context, which every per-function test needs (`m_context` upstream).
struct Coverage<'a> {
    context: &'a Context,
    gl: &'a glw::Functions,
}

/// The `.test` file `init` picks: the newest one the context supports.
fn config_for(context_type: ContextType) -> Option<&'static Config> {
    if context_type.supports_core(4, 3) {
        Some(&data::CONFIG_GL43)
    } else if context_type.supports_core(4, 0) {
        Some(&data::CONFIG_GL40)
    } else if context_type.supports_core(3, 3) {
        Some(&data::CONFIG_GL33)
    } else if context_type.supports_core(3, 2) {
        Some(&data::CONFIG_GL32)
    } else if context_type.supports_core(3, 1) {
        Some(&data::CONFIG_GL31)
    } else if context_type.supports_core(3, 0) {
        Some(&data::CONFIG_GL30)
    } else {
        None
    }
}

/// `isNameWithinBitfield`'s `Bitfield::toStream`, rendered to a string (the `|` joined names of the set bits, then what is left in hex).
fn bitfield_string(table: &[(u64, &str)], value: u64) -> String {
    let mut bits_left = value;
    let mut out = String::new();
    for (bit, name) in table {
        if bit & bits_left != 0 {
            if bits_left != value {
                out.push('|');
            }
            out.push_str(name);
            bits_left ^= bit;
        }
    }
    if bits_left != 0 {
        if bits_left != value {
            out.push('|');
        }
        out.push_str(&format!("0x{bits_left:04x}"));
    }
    out
}

/// `isNameWithinBitfield`
fn is_name_within_bitfield(name: &str, e: u32) -> bool {
    // The name functions take an `int` and widen it to 64 bits.
    let value = e as i32 as i64 as u64;
    data::BITFIELDS
        .iter()
        .any(|table| bitfield_string(table, value).contains(name))
}

/// `getEnumNames`, the part of it `verifyEnum` reads.
fn enum_names(e: u32) -> Vec<&'static str> {
    let first = data::ENUM_NAMES.partition_point(|(value, _)| *value < e);
    data::ENUM_NAMES[first..]
        .iter()
        .take_while(|(value, _)| *value == e)
        .map(|(_, name)| *name)
        .collect()
}

/// `sscanf(text, "%x", ...)` as far as the data files need it: an optional 0x prefix and hex digits, truncated to 32 bits.
fn scan_hex(text: &str) -> Option<u64> {
    let digits = text.trim();
    let digits = digits
        .strip_prefix("0x")
        .or_else(|| digits.strip_prefix("0X"))
        .unwrap_or(digits);
    let end = digits.find(|c: char| !c.is_ascii_hexdigit()).unwrap_or(digits.len());
    if end == 0 {
        return None;
    }
    u64::from_str_radix(&digits[..end], 16).ok()
}

/// `ApiCoverageTestCase::verifyEnum`
fn verify_enum(name: &str, value: &str) -> bool {
    let mut enum_expected: u32 = !0;
    let mut compare_value = false;

    if value.contains("GL_") {
        match value {
            "GL_DRAW_FRAMEBUFFER_BINDING" => enum_expected = glw::GL_DRAW_FRAMEBUFFER_BINDING,
            "GL_MAX_VARYING_COMPONENTS" => enum_expected = glw::GL_MAX_VARYING_COMPONENTS,
            "GL_VERTEX_PROGRAM_POINT_SIZE" => enum_expected = glw::GL_VERTEX_PROGRAM_POINT_SIZE,
            _ => {}
        }
        compare_value = true;
    } else if let Some(parsed) = scan_hex(value) {
        enum_expected = parsed as u32;
    }

    if name.ends_with("_BIT") {
        return is_name_within_bitfield(name, enum_expected);
    }

    if name == "GL_INVALID_INDEX" {
        return enum_expected == glw::GL_INVALID_INDEX;
    }
    if name == "GL_TIMEOUT_IGNORED" {
        return scan_hex(value) == Some(glw::GL_TIMEOUT_IGNORED);
    }

    let mut names = enum_names(enum_expected);
    if enum_expected == 1 {
        names.extend(VERSION_NAMES);
    }

    if compare_value {
        names.contains(&value)
    } else {
        names.contains(&name)
    }
}

impl Coverage<'_> {
    /// `tcu_fail_msg`
    fn fail_msg(&self, test: &str, message: &str) {
        log::info!("ApiCoverageTestCase::{test}: {message}");
    }

    /// `createDefaultProgram`: -1 when the program could not be made.
    fn create_default_program(&self, mode: i32) -> Result<glw::GLint, TestError> {
        let gl = self.gl;
        let spec = [
            (
                "VERSION",
                self.context.context_type().glsl_version().declaration().to_string(),
            ),
            ("PRECISION", String::new()),
            ("EXTENSION", String::new()),
        ];
        let vert_shader = StringTemplate::new(VERT_SHADER).specialize(&spec)?;
        let frag_shader = StringTemplate::new(FRAG_SHADER).specialize(&spec)?;

        // SAFETY: every pointer handed to GL below is a live NUL-terminated string or a local the call writes one value to.
        unsafe {
            let mut status: glw::GLint = 0;
            let vertex_shader = gl.create_shader(glw::GL_VERTEX_SHADER);
            glu::expect_no_error(gl, "createShader")?;

            let fragment_shader = gl.create_shader(glw::GL_FRAGMENT_SHADER);
            glu::expect_no_error(gl, "createShader")?;

            let vert_src = CString::new(vert_shader.as_str()).expect("shader source has no NUL");
            let vert_ptr = vert_src.as_ptr();
            gl.shader_source(vertex_shader, 1, &vert_ptr, std::ptr::null());
            glu::expect_no_error(gl, "shaderSource")?;
            gl.compile_shader(vertex_shader);
            glu::expect_no_error(gl, "compileShader")?;
            gl.get_shaderiv(vertex_shader, glw::GL_COMPILE_STATUS, &mut status);
            glu::expect_no_error(gl, "getShaderiv")?;
            if status == glw::GL_FALSE as glw::GLint {
                let mut info_log_length: glw::GLint = 0;
                gl.get_shaderiv(vertex_shader, glw::GL_INFO_LOG_LENGTH, &mut info_log_length);

                let mut info_log_buf = vec![0 as glw::GLchar; info_log_length.max(0) as usize + 1];
                gl.get_shader_info_log(
                    vertex_shader,
                    info_log_buf.len() as glw::GLsizei,
                    std::ptr::null_mut(),
                    info_log_buf.as_mut_ptr(),
                );

                log::info!(
                    "{vert_shader} compilation should succed. Info Log:\n{}",
                    cstr_lossy(&info_log_buf)
                );

                gl.delete_shader(vertex_shader);

                return Ok(-1);
            }

            let frag_src = CString::new(frag_shader.as_str()).expect("shader source has no NUL");
            let frag_ptr = frag_src.as_ptr();
            gl.shader_source(fragment_shader, 1, &frag_ptr, std::ptr::null());
            glu::expect_no_error(gl, "shaderSource")?;
            gl.compile_shader(fragment_shader);
            glu::expect_no_error(gl, "compileShader")?;
            gl.get_shaderiv(fragment_shader, glw::GL_COMPILE_STATUS, &mut status);
            glu::expect_no_error(gl, "getShaderiv")?;
            if status == glw::GL_FALSE as glw::GLint {
                let mut info_log_length: glw::GLint = 0;
                gl.get_shaderiv(fragment_shader, glw::GL_INFO_LOG_LENGTH, &mut info_log_length);

                let mut info_log_buf = vec![0 as glw::GLchar; info_log_length.max(0) as usize + 1];
                gl.get_shader_info_log(
                    fragment_shader,
                    info_log_buf.len() as glw::GLsizei,
                    std::ptr::null_mut(),
                    info_log_buf.as_mut_ptr(),
                );

                log::info!(
                    "{frag_shader} compilation should succed. Info Log:\n{}",
                    cstr_lossy(&info_log_buf)
                );

                gl.delete_shader(fragment_shader);
                return Ok(-1);
            }

            let program = gl.create_program();
            glu::expect_no_error(gl, "createProgram")?;
            gl.attach_shader(program, vertex_shader);
            glu::expect_no_error(gl, "attachShader")?;
            gl.attach_shader(program, fragment_shader);
            glu::expect_no_error(gl, "attachShader")?;
            gl.delete_shader(vertex_shader);
            glu::expect_no_error(gl, "deleteShader")?;
            gl.delete_shader(fragment_shader);
            glu::expect_no_error(gl, "deleteShader")?;
            gl.bind_attrib_location(program, 0, c"inPosition".as_ptr());
            glu::expect_no_error(gl, "bindAttribLocation")?;
            gl.bind_attrib_location(program, 1, c"inTexCoord".as_ptr());
            glu::expect_no_error(gl, "bindAttribLocation")?;

            if mode != 0 {
                let ptex = c"texCoords".as_ptr();
                gl.transform_feedback_varyings(program, 1, &ptex, glw::GL_SEPARATE_ATTRIBS);
                glu::expect_no_error(gl, "transformFeedbackVaryings")?;
            }

            gl.link_program(program);
            glu::expect_no_error(gl, "linkProgram")?;
            gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status);
            glu::expect_no_error(gl, "getProgramiv")?;
            if status == 0 {
                return Ok(-1);
            }

            gl.use_program(program);
            glu::expect_no_error(gl, "useProgram")?;

            Ok(program as glw::GLint)
        }
    }

    /// `verifyFunc`
    fn verify_func(&self, name: &str) -> Result<bool, TestError> {
        match self.run_func(name) {
            Some(result) => result,
            None => {
                log::info!("Function coverage test not supported : {name}");
                Ok(true)
            }
        }
    }

    /// `funcs_map`: the tests with a body of their own (the rest of upstream's map points at "not implemented yet" stubs that pass).
    fn run_func(&self, name: &str) -> Option<Result<bool, TestError>> {
        self.run_func_gl30(name)
            .or_else(|| self.run_func_gl31(name))
            .or_else(|| self.run_func_gl32(name))
            .or_else(|| self.run_func_gl33(name))
            .or_else(|| self.run_func_gl40(name))
    }
}

/// A NUL-terminated GL log buffer as text.
fn cstr_lossy(buf: &[glw::GLchar]) -> String {
    let bytes: Vec<u8> = buf.iter().take_while(|&&c| c != 0).map(|&c| c as u8).collect();
    String::from_utf8_lossy(&bytes).into_owned()
}

/// `ApiCoverageTestCase`
struct ApiCoverageTestCase;

impl TestCase for ApiCoverageTestCase {
    fn name(&self) -> &str {
        "coverage"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if config_for(context.context_type()).is_none() {
            log::info!("API coverage test not supported.\n");
            return Err(TestError::NotSupported("API coverage test not supported".to_string()));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let config = config_for(context.context_type())
            .ok_or_else(|| TestError::NotSupported("API coverage test not supported".to_string()))?;
        let coverage = Coverage {
            context,
            gl: context.gl(),
        };
        let mut ret = true;

        for (name, value) in config.enums {
            if !verify_enum(name, value) {
                ret = false;
                log::info!("Enum verification failed :{name} : {value}");
            }
        }
        for name in config.funcs {
            if !coverage.verify_func(name)? {
                ret = false;
                log::info!("Function verification failed :{name}");
            }
        }

        Ok(if ret {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `ApiCoverageTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("api");
    group.add_child(Box::new(ApiCoverageTestCase) as Box<dyn TestCase>);
    group
}
