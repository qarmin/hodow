// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fImplementationLimitTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `LimitQuery` uses a
// template per queried type with a specialised `compare`; here that is one enum, which
// keeps the four comparison rules - including the two that are not `min <= reported` -
// in one place instead of four specialisations.

use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::tcu::{TestOutcome, TestResult, TestStatus};

/// The minimum the specification requires, and how "at least this much" is judged.
///
/// Two of these are not a plain lower bound, which is the whole reason upstream needs
/// the specialisations: a boolean requirement is only a requirement when it is `true`,
/// and a range must *contain* the required range rather than exceed it.
#[derive(Clone, Copy)]
enum Requirement {
    /// `GLint` - reported must be >= min.
    Int(i32),
    /// `Boolean` - only demanded when min is true.
    Boolean(bool),
    /// `FloatRange` - the reported range must contain [min, max].
    FloatRange(f32, f32),
}

struct LimitQueryCase {
    name: &'static str,
    limit: GLenum,
    required: Requirement,
}

impl TestCase for LimitQueryCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let (reported, ok) = match self.required {
            Requirement::Int(min) => {
                let mut value = -1;
                // SAFETY: every limit here is a single integer.
                unsafe { gl.get_integerv(self.limit, &mut value) };
                (format!("{value}"), value >= min)
            }
            Requirement::Boolean(min) => {
                let mut value = glw::FALSE;
                // SAFETY: a single boolean.
                unsafe { gl.get_booleanv(self.limit, &mut value) };
                let reported = value != glw::FALSE;
                (
                    if reported {
                        "GL_TRUE".to_string()
                    } else {
                        "GL_FALSE".to_string()
                    },
                    !min || reported,
                )
            }
            Requirement::FloatRange(min, max) => {
                let mut value = [-1.0f32; 2];
                // SAFETY: the two range limits below both write two floats.
                unsafe { gl.get_floatv(self.limit, value.as_mut_ptr()) };
                (
                    format!("{}, {}", value[0], value[1]),
                    value[0] <= min && max <= value[1],
                )
            }
        };

        crate::glu::expect_no_error(gl, "Query failed")?;

        log::info!("Reported: {reported}");
        log::info!("Minimum required: {}", self.required.describe());
        if !ok {
            log::warn!("FAIL: reported value is less than minimum required value!");
        }

        Ok(if ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::new(TestResult::Fail, "Requirement not satisfied")
        })
    }
}

impl Requirement {
    fn describe(self) -> String {
        match self {
            Self::Int(min) => format!("{min}"),
            Self::Boolean(min) => (if min { "GL_TRUE" } else { "GL_FALSE" }).to_string(),
            Self::FloatRange(min, max) => format!("{min}, {max}"),
        }
    }
}

/// `ImplementationLimitTests::init` - upstream's `LIMIT_CASE` table, verbatim,
/// including which limits it deliberately leaves out (`GL_MAX_VIEWPORT_DIMS`,
/// `GL_SAMPLE_BUFFERS`, `GL_SAMPLES`, the shader precision formats).
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("implementation_limits");

    let cases: &[(&'static str, GLenum, Requirement)] = &[
        ("subpixel_bits", glw::GL_SUBPIXEL_BITS, Requirement::Int(4)),
        ("max_texture_size", glw::GL_MAX_TEXTURE_SIZE, Requirement::Int(64)),
        (
            "max_cube_map_texture_size",
            glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE,
            Requirement::Int(16),
        ),
        (
            "aliased_point_size_range",
            glw::GL_ALIASED_POINT_SIZE_RANGE,
            Requirement::FloatRange(1.0, 1.0),
        ),
        (
            "aliased_line_width_range",
            glw::GL_ALIASED_LINE_WIDTH_RANGE,
            Requirement::FloatRange(1.0, 1.0),
        ),
        (
            "num_compressed_texture_formats",
            glw::GL_NUM_COMPRESSED_TEXTURE_FORMATS,
            Requirement::Int(0),
        ),
        (
            "num_shader_binary_formats",
            glw::GL_NUM_SHADER_BINARY_FORMATS,
            Requirement::Int(0),
        ),
        ("shader_compiler", glw::GL_SHADER_COMPILER, Requirement::Boolean(false)),
        ("max_vertex_attribs", glw::GL_MAX_VERTEX_ATTRIBS, Requirement::Int(8)),
        (
            "max_vertex_uniform_vectors",
            glw::GL_MAX_VERTEX_UNIFORM_VECTORS,
            Requirement::Int(128),
        ),
        ("max_varying_vectors", glw::GL_MAX_VARYING_VECTORS, Requirement::Int(8)),
        (
            "max_combined_texture_image_units",
            glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
            Requirement::Int(8),
        ),
        (
            "max_vertex_texture_image_units",
            glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
            Requirement::Int(0),
        ),
        (
            "max_texture_image_units",
            glw::GL_MAX_TEXTURE_IMAGE_UNITS,
            Requirement::Int(8),
        ),
        (
            "max_fragment_uniform_vectors",
            glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS,
            Requirement::Int(16),
        ),
        (
            "max_renderbuffer_size",
            glw::GL_MAX_RENDERBUFFER_SIZE,
            Requirement::Int(1),
        ),
    ];

    for (name, limit, required) in cases {
        group.add_child(Box::new(LimitQueryCase {
            name,
            limit: *limit,
            required: *required,
        }) as Box<dyn TestCase>);
    }

    group
}
