// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fImplementationLimitTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `LimitQuery` is a
// template per queried type, with a `query` and a `compare` specialisation each; here
// that is one enum, which keeps the four comparison rules that are *not* the plain
// `min <= reported` (boolean, range, and the two reverse ones) in one place instead of
// scattered over eight specialisations. The ES 2.0 module's port does the same.

use std::collections::BTreeSet;

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLint64, GLuint};
use crate::tcu::{TestOutcome, TestResult, TestStatus};

/// The minimum the specification requires, and how "at least this much" is judged.
///
/// `NegInt` and `Alignment` are upstream's two reverse comparisons: a negative texel
/// offset and a required alignment are both satisfied by a *smaller* reported value.
#[derive(Clone, Copy)]
enum Requirement {
    /// `GLint` - reported must be >= min.
    Int(GLint),
    /// `GLint64` - as `Int`, queried with `glGetInteger64v`.
    Int64(GLint64),
    /// `GLuint64` - as `Int64`, reported unsigned.
    Uint64(u64),
    /// `GLfloat` - reported must be >= min.
    Float(f32),
    /// `NegInt` - reverse comparison: reported must be <= min.
    NegInt(GLint),
    /// `AlignmentInt` - reverse comparison: a coarser alignment than required fails.
    Alignment(GLint),
    /// `Boolean` - only demanded when min is true.
    Boolean(bool),
    /// `FloatRange` - the reported range must contain [min, max].
    FloatRange(f32, f32),
}

impl Requirement {
    /// `QueryClassTraits<...>::s_errorDescription`
    fn error_description(self) -> &'static str {
        match self {
            Self::FloatRange(..) => "reported range does not contain the minimum required range!",
            Self::Alignment(..) => "reported alignment is larger than minimum required aligmnent!",
            _ => "reported value is less than minimum required value!",
        }
    }

    fn describe(self) -> String {
        match self {
            Self::Int(min) | Self::NegInt(min) | Self::Alignment(min) => format!("{min}"),
            Self::Int64(min) => format!("{min}"),
            Self::Uint64(min) => format!("{min}"),
            Self::Float(min) => format!("{min}"),
            Self::Boolean(min) => (if min { "GL_TRUE" } else { "GL_FALSE" }).to_string(),
            Self::FloatRange(min, max) => format!("{min}, {max}"),
        }
    }
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
                let mut value: GLint = -1;
                // SAFETY: every limit queried this way is a single integer.
                unsafe { gl.get_integerv(self.limit, &mut value) };
                (format!("{value}"), value >= min)
            }
            Requirement::NegInt(min) => {
                let mut value: GLint = -1;
                // SAFETY: as above.
                unsafe { gl.get_integerv(self.limit, &mut value) };
                (format!("{value}"), value <= min)
            }
            Requirement::Alignment(min) => {
                let mut value: GLint = -1;
                // SAFETY: as above.
                unsafe { gl.get_integerv(self.limit, &mut value) };
                (format!("{value}"), value <= min)
            }
            Requirement::Int64(min) => {
                let mut value: GLint64 = -1;
                // SAFETY: a single 64-bit integer.
                unsafe { gl.get_integer_64v(self.limit, &mut value) };
                (format!("{value}"), value >= min)
            }
            Requirement::Uint64(min) => {
                let mut value: GLint64 = 0;
                // SAFETY: as above; upstream reads the same query and reinterprets it.
                unsafe { gl.get_integer_64v(self.limit, &mut value) };
                let value = value as u64;
                (format!("{value}"), value >= min)
            }
            Requirement::Float(min) => {
                let mut value = -1.0f32;
                // SAFETY: a single float.
                unsafe { gl.get_floatv(self.limit, &mut value) };
                (format!("{value}"), value >= min)
            }
            Requirement::Boolean(min) => {
                let mut value = glw::FALSE;
                // SAFETY: a single boolean.
                unsafe { gl.get_booleanv(self.limit, &mut value) };
                let reported = value != glw::FALSE;
                (if reported { "GL_TRUE".to_string() } else { "GL_FALSE".to_string() }, !min || reported)
            }
            Requirement::FloatRange(min, max) => {
                let mut value = [-1.0f32; 2];
                // SAFETY: both range limits below write two floats.
                unsafe { gl.get_floatv(self.limit, value.as_mut_ptr()) };
                (format!("{}, {}", value[0], value[1]), value[0] <= min && max <= value[1])
            }
        };

        glu::expect_no_error(gl, "Query failed")?;

        log::info!("Reported: {reported}");
        log::info!("Minimum required: {}", self.required.describe());
        if !ok {
            log::warn!("FAIL: {}", self.required.error_description());
        }

        Ok(if ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::new(TestResult::Fail, "Requirement not satisfied")
        })
    }
}

/// `s_requiredCompressedTexFormats`
const S_REQUIRED_COMPRESSED_TEX_FORMATS: &[GLenum] = &[
    glw::GL_COMPRESSED_R11_EAC,
    glw::GL_COMPRESSED_SIGNED_R11_EAC,
    glw::GL_COMPRESSED_RG11_EAC,
    glw::GL_COMPRESSED_SIGNED_RG11_EAC,
    glw::GL_COMPRESSED_RGB8_ETC2,
    glw::GL_COMPRESSED_SRGB8_ETC2,
    glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2,
    glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2,
    glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
    glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,
];

struct CompressedTextureFormatsQueryCase;

impl TestCase for CompressedTextureFormatsQueryCase {
    fn name(&self) -> &str {
        "compressed_texture_formats"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut num_formats: GLint = 0;
        // SAFETY: a single integer.
        unsafe { gl.get_integerv(glw::GL_NUM_COMPRESSED_TEXTURE_FORMATS, &mut num_formats) };
        let mut formats = vec![0i32; num_formats.max(0) as usize];
        let mut all_formats_ok = true;

        if num_formats > 0 {
            // SAFETY: the destination holds exactly as many integers as the count query
            // just answered with.
            unsafe { gl.get_integerv(glw::GL_COMPRESSED_TEXTURE_FORMATS, formats.as_mut_ptr()) };
        }

        glu::expect_no_error(gl, "Query failed")?;

        // Log formats.
        log::info!("Reported:");
        for fmt in &formats {
            log::info!("{fmt:#x}");
        }

        // Check that all required formats are in list.
        {
            let format_set: BTreeSet<GLint> = formats.iter().copied().collect();

            for &fmt in S_REQUIRED_COMPRESSED_TEX_FORMATS {
                let found = format_set.contains(&(fmt as GLint));

                if !found {
                    log::warn!("ERROR: {fmt:#x} is missing!");
                    all_formats_ok = false;
                }
            }
        }

        Ok(if all_formats_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::new(TestResult::Fail, "Requirement not satisfied")
        })
    }
}

/// `queryExtensionsNonIndexed`
fn query_extensions_non_indexed(gl: &glw::Functions) -> Vec<String> {
    // SAFETY: `glGetString(GL_EXTENSIONS)` is a NUL-terminated string owned by GL and
    // valid for the context's lifetime.
    let extension_str = unsafe { glw::string_from(gl.get_string(glw::GL_EXTENSIONS)) };
    extension_str.split(' ').filter(|s| !s.is_empty()).map(str::to_string).collect()
}

/// `queryExtensionsIndexed`
fn query_extensions_indexed(gl: &glw::Functions) -> Result<Vec<String>, crate::tcu::TestError> {
    let mut num_extensions: GLint = 0;
    // SAFETY: a single integer.
    unsafe { gl.get_integerv(glw::GL_NUM_EXTENSIONS, &mut num_extensions) };
    glu::expect_no_error(gl, "GL_NUM_EXTENSIONS query failed")?;

    let mut extensions = Vec::with_capacity(num_extensions.max(0) as usize);
    for ndx in 0..num_extensions.max(0) {
        // SAFETY: the index is below the count GL just reported, and the returned
        // string is GL's own.
        extensions.push(unsafe { glw::string_from(gl.get_stringi(glw::GL_EXTENSIONS, ndx as GLuint)) });
    }

    glu::expect_no_error(gl, "glGetStringi(GL_EXTENSIONS) failed")?;

    Ok(extensions)
}

/// `compareExtensionLists`
fn compare_extension_lists(a: &[String], b: &[String]) -> bool {
    if a.len() != b.len() {
        return false;
    }

    let exts_in_b: BTreeSet<&String> = b.iter().collect();
    a.iter().all(|i| exts_in_b.contains(i))
}

struct ExtensionQueryCase;

impl TestCase for ExtensionQueryCase {
    fn name(&self) -> &str {
        "extensions"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let non_indexed_exts = query_extensions_non_indexed(gl);
        let indexed_exts = query_extensions_indexed(gl)?;
        let is_ok = compare_extension_lists(&non_indexed_exts, &indexed_exts);

        log::info!("Extensions as reported by glGetStringi(GL_EXTENSIONS):");
        for ext in &indexed_exts {
            log::info!("{ext}");
        }

        if !is_ok {
            log::info!("Extensions as reported by glGetString(GL_EXTENSIONS):");
            for ext in &non_indexed_exts {
                log::info!("{ext}");
            }

            log::warn!("ERROR: Extension lists do not match!");
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::new(TestResult::Fail, "Invalid extension list")
        })
    }
}

/// `LIMIT_CASE`
fn limit_case(group: &mut TestCaseGroup, name: &'static str, limit: GLenum, required: Requirement) {
    group.add_child(Box::new(LimitQueryCase { name, limit, required }) as Box<dyn TestCase>);
}

/// `ImplementationLimitTests::init` - upstream's `LIMIT_CASE` table, verbatim,
/// including which limits it deliberately leaves out (`GL_MAX_VIEWPORT_DIMS`,
/// `GL_PROGRAM_BINARY_FORMATS`, `GL_SHADER_BINARY_FORMATS`, the shader precision
/// formats and the version strings).
pub fn create_tests() -> TestCaseGroup {
    const MIN_VERTEX_UNIFORM_BLOCKS: GLint = 12;
    const MIN_VERTEX_UNIFORM_COMPONENTS: GLint = 1024;

    const MIN_FRAGMENT_UNIFORM_BLOCKS: GLint = 12;
    const MIN_FRAGMENT_UNIFORM_COMPONENTS: GLint = 896;

    const MIN_UNIFORM_BLOCK_SIZE: GLint = 16384;
    const MIN_COMBINED_VERTEX_UNIFORM_COMPONENTS: GLint = (MIN_VERTEX_UNIFORM_BLOCKS * MIN_UNIFORM_BLOCK_SIZE) / 4 + MIN_VERTEX_UNIFORM_COMPONENTS;
    const MIN_COMBINED_FRAGMENT_UNIFORM_COMPONENTS: GLint = (MIN_FRAGMENT_UNIFORM_BLOCKS * MIN_UNIFORM_BLOCK_SIZE) / 4 + MIN_FRAGMENT_UNIFORM_COMPONENTS;

    let mut group = TestCaseGroup::new("implementation_limits");

    limit_case(&mut group, "max_element_index", glw::GL_MAX_ELEMENT_INDEX, Requirement::Int64((1 << 24) - 1));
    limit_case(&mut group, "subpixel_bits", glw::GL_SUBPIXEL_BITS, Requirement::Int(4));
    limit_case(&mut group, "max_3d_texture_size", glw::GL_MAX_3D_TEXTURE_SIZE, Requirement::Int(256));
    limit_case(&mut group, "max_texture_size", glw::GL_MAX_TEXTURE_SIZE, Requirement::Int(2048));
    limit_case(&mut group, "max_array_texture_layers", glw::GL_MAX_ARRAY_TEXTURE_LAYERS, Requirement::Int(256));
    limit_case(&mut group, "max_texture_lod_bias", glw::GL_MAX_TEXTURE_LOD_BIAS, Requirement::Float(2.0));
    limit_case(&mut group, "max_cube_map_texture_size", glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE, Requirement::Int(2048));
    limit_case(&mut group, "max_renderbuffer_size", glw::GL_MAX_RENDERBUFFER_SIZE, Requirement::Int(2048));
    limit_case(&mut group, "max_draw_buffers", glw::GL_MAX_DRAW_BUFFERS, Requirement::Int(4));
    limit_case(&mut group, "max_color_attachments", glw::GL_MAX_COLOR_ATTACHMENTS, Requirement::Int(4));
    // GL_MAX_VIEWPORT_DIMS
    limit_case(&mut group, "aliased_point_size_range", glw::GL_ALIASED_POINT_SIZE_RANGE, Requirement::FloatRange(1.0, 1.0));
    limit_case(&mut group, "aliased_line_width_range", glw::GL_ALIASED_LINE_WIDTH_RANGE, Requirement::FloatRange(1.0, 1.0));
    limit_case(&mut group, "max_elements_indices", glw::GL_MAX_ELEMENTS_INDICES, Requirement::Int(0));
    limit_case(&mut group, "max_elements_vertices", glw::GL_MAX_ELEMENTS_VERTICES, Requirement::Int(0));
    limit_case(
        &mut group,
        "num_compressed_texture_formats",
        glw::GL_NUM_COMPRESSED_TEXTURE_FORMATS,
        Requirement::Int(S_REQUIRED_COMPRESSED_TEX_FORMATS.len() as GLint),
    );
    group.add_child(Box::new(CompressedTextureFormatsQueryCase) as Box<dyn TestCase>); // GL_COMPRESSED_TEXTURE_FORMATS
    // GL_PROGRAM_BINARY_FORMATS
    limit_case(&mut group, "num_program_binary_formats", glw::GL_NUM_PROGRAM_BINARY_FORMATS, Requirement::Int(0));
    // GL_SHADER_BINARY_FORMATS
    limit_case(&mut group, "num_shader_binary_formats", glw::GL_NUM_SHADER_BINARY_FORMATS, Requirement::Int(0));
    limit_case(&mut group, "shader_compiler", glw::GL_SHADER_COMPILER, Requirement::Boolean(true));
    // Shader data type ranges & precisions
    limit_case(&mut group, "max_server_wait_timeout", glw::GL_MAX_SERVER_WAIT_TIMEOUT, Requirement::Uint64(0));

    // Version and extension support
    group.add_child(Box::new(ExtensionQueryCase) as Box<dyn TestCase>); // GL_EXTENSIONS + consistency validation
    limit_case(&mut group, "num_extensions", glw::GL_NUM_EXTENSIONS, Requirement::Int(0));
    limit_case(&mut group, "major_version", glw::GL_MAJOR_VERSION, Requirement::Int(3));
    limit_case(&mut group, "minor_version", glw::GL_MINOR_VERSION, Requirement::Int(0));
    // GL_RENDERER
    // GL_SHADING_LANGUAGE_VERSION
    // GL_VENDOR
    // GL_VERSION

    // Vertex shader limits
    limit_case(&mut group, "max_vertex_attribs", glw::GL_MAX_VERTEX_ATTRIBS, Requirement::Int(16));
    limit_case(
        &mut group,
        "max_vertex_uniform_components",
        glw::GL_MAX_VERTEX_UNIFORM_COMPONENTS,
        Requirement::Int(MIN_VERTEX_UNIFORM_COMPONENTS),
    );
    limit_case(
        &mut group,
        "max_vertex_uniform_vectors",
        glw::GL_MAX_VERTEX_UNIFORM_VECTORS,
        Requirement::Int(MIN_VERTEX_UNIFORM_COMPONENTS / 4),
    );
    limit_case(
        &mut group,
        "max_vertex_uniform_blocks",
        glw::GL_MAX_VERTEX_UNIFORM_BLOCKS,
        Requirement::Int(MIN_VERTEX_UNIFORM_BLOCKS),
    );
    limit_case(&mut group, "max_vertex_output_components", glw::GL_MAX_VERTEX_OUTPUT_COMPONENTS, Requirement::Int(64));
    limit_case(&mut group, "max_vertex_texture_image_units", glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS, Requirement::Int(16));

    // Fragment shader limits
    limit_case(
        &mut group,
        "max_fragment_uniform_components",
        glw::GL_MAX_FRAGMENT_UNIFORM_COMPONENTS,
        Requirement::Int(MIN_FRAGMENT_UNIFORM_COMPONENTS),
    );
    limit_case(
        &mut group,
        "max_fragment_uniform_vectors",
        glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS,
        Requirement::Int(MIN_FRAGMENT_UNIFORM_COMPONENTS / 4),
    );
    limit_case(
        &mut group,
        "max_fragment_uniform_blocks",
        glw::GL_MAX_FRAGMENT_UNIFORM_BLOCKS,
        Requirement::Int(MIN_FRAGMENT_UNIFORM_BLOCKS),
    );
    limit_case(&mut group, "max_fragment_input_components", glw::GL_MAX_FRAGMENT_INPUT_COMPONENTS, Requirement::Int(60));
    limit_case(&mut group, "max_texture_image_units", glw::GL_MAX_TEXTURE_IMAGE_UNITS, Requirement::Int(16));
    limit_case(&mut group, "min_program_texel_offset", glw::GL_MIN_PROGRAM_TEXEL_OFFSET, Requirement::NegInt(-8));
    limit_case(&mut group, "max_program_texel_offset", glw::GL_MAX_PROGRAM_TEXEL_OFFSET, Requirement::Int(7));

    // Aggregate shader limits
    limit_case(&mut group, "max_uniform_buffer_bindings", glw::GL_MAX_UNIFORM_BUFFER_BINDINGS, Requirement::Int(24));
    limit_case(
        &mut group,
        "max_uniform_block_size",
        glw::GL_MAX_UNIFORM_BLOCK_SIZE,
        Requirement::Int64(MIN_UNIFORM_BLOCK_SIZE as GLint64),
    );
    limit_case(
        &mut group,
        "uniform_buffer_offset_alignment",
        glw::GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT,
        Requirement::Alignment(256),
    );
    limit_case(&mut group, "max_combined_uniform_blocks", glw::GL_MAX_COMBINED_UNIFORM_BLOCKS, Requirement::Int(24));
    limit_case(
        &mut group,
        "max_combined_vertex_uniform_components",
        glw::GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS,
        Requirement::Int64(MIN_COMBINED_VERTEX_UNIFORM_COMPONENTS as GLint64),
    );
    limit_case(
        &mut group,
        "max_combined_fragment_uniform_components",
        glw::GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS,
        Requirement::Int64(MIN_COMBINED_FRAGMENT_UNIFORM_COMPONENTS as GLint64),
    );
    limit_case(&mut group, "max_varying_components", glw::GL_MAX_VARYING_COMPONENTS, Requirement::Int(60));
    limit_case(&mut group, "max_varying_vectors", glw::GL_MAX_VARYING_VECTORS, Requirement::Int(15));
    limit_case(
        &mut group,
        "max_combined_texture_image_units",
        glw::GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
        Requirement::Int(32),
    );

    // Transform feedback limits
    limit_case(
        &mut group,
        "max_transform_feedback_interleaved_components",
        glw::GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS,
        Requirement::Int(64),
    );
    limit_case(
        &mut group,
        "max_transform_feedback_separate_attribs",
        glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS,
        Requirement::Int(4),
    );
    limit_case(
        &mut group,
        "max_transform_feedback_separate_components",
        glw::GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS,
        Requirement::Int(4),
    );

    group
}
