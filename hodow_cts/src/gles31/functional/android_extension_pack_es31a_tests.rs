// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fAndroidExtensionPackES31ATests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::generated::shader_library as lib;
use crate::gls::shader_library::create_group;
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `ExtensionPackTestCase::init` - every case in the group needs the pack itself.
fn check_pack_supported(context: &Context) -> Result<(), TestError> {
    if context
        .context_info
        .is_extension_supported("GL_ANDROID_extension_pack_es31a")
    {
        Ok(())
    } else {
        Err(TestError::NotSupported(
            "Test requires GL_ANDROID_extension_pack_es31a extension".to_string(),
        ))
    }
}

/// `ImplementationLimitCase`
struct ImplementationLimitCase {
    name: &'static str,
    target: GLenum,
    limit: GLint,
}

impl TestCase for ImplementationLimitCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_pack_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut result: GLint = -1;

        log::debug!("Querying {:#x}, expecting at least {}", self.target, self.limit);
        // SAFETY: a single-integer query writing into one GLint.
        unsafe { gl.get_integerv(self.target, &mut result) };
        glu::expect_no_error(gl, "implementation limit query failed")?;

        if result < self.limit {
            log::debug!("// ERROR: Got {result}, expected at least {}", self.limit);
            return Ok(TestStatus::fail("Too low implementation limit"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `SubExtensionCase`
struct SubExtensionCase {
    name: String,
    extension: &'static str,
}

impl TestCase for SubExtensionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_pack_supported(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        log::debug!("Verifying that extension \"{}\" is supported.", self.extension);

        if context.context_info.is_extension_supported(self.extension) {
            Ok(TestStatus::pass("Pass"))
        } else {
            log::debug!("Error, extension is not supported.");
            Ok(TestStatus::fail("Required extension not supported"))
        }
    }
}

/// `genExtensionTestName` - the extension name without its `GL_` prefix, lowercased.
fn gen_extension_test_name(extension: &str) -> String {
    debug_assert!(extension.starts_with("GL_"));
    extension[3..].to_lowercase()
}

const LIMITS: &[(&str, GLenum, GLint)] = &[
    (
        "max_fragment_atomic_counter_buffers",
        glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS,
        1,
    ),
    ("max_fragment_atomic_counters", glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS, 8),
    ("max_fragment_image_uniforms", glw::GL_MAX_FRAGMENT_IMAGE_UNIFORMS, 4),
    (
        "max_fragment_shader_storage_blocks",
        glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS,
        4,
    ),
];

const SUB_EXTENSIONS: &[&str] = &[
    "GL_KHR_debug",
    "GL_KHR_texture_compression_astc_ldr",
    "GL_KHR_blend_equation_advanced",
    "GL_OES_sample_shading",
    "GL_OES_sample_variables",
    "GL_OES_shader_image_atomic",
    "GL_OES_shader_multisample_interpolation",
    "GL_OES_texture_stencil8",
    "GL_OES_texture_storage_multisample_2d_array",
    "GL_EXT_copy_image",
    "GL_EXT_draw_buffers_indexed",
    "GL_EXT_geometry_shader",
    "GL_EXT_gpu_shader5",
    "GL_EXT_primitive_bounding_box",
    "GL_EXT_shader_io_blocks",
    "GL_EXT_tessellation_shader",
    "GL_EXT_texture_border_clamp",
    "GL_EXT_texture_buffer",
    "GL_EXT_texture_cube_map_array",
    "GL_EXT_texture_sRGB_decode",
];

/// `AndroidExtensionPackES31ATests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("android_extension_pack");

    // .limits
    {
        let mut sub = TestCaseGroup::new("limits");
        for &(name, target, limit) in LIMITS {
            sub.add_child(Box::new(ImplementationLimitCase { name, target, limit }) as Box<dyn TestCase>);
        }
        group.add_child(sub);
    }

    // .extensions
    {
        let mut sub = TestCaseGroup::new("extensions");
        for &extension in SUB_EXTENSIONS {
            sub.add_child(Box::new(SubExtensionCase {
                name: gen_extension_test_name(extension),
                extension,
            }) as Box<dyn TestCase>);
        }
        group.add_child(sub);
    }

    // .shaders
    {
        let mut sub = TestCaseGroup::new("shaders");
        sub.add_child(create_group("es31", &lib::es31_android_extension_pack::ROOT));
        sub.add_child(create_group("es32", &lib::es32_android_extension_pack::ROOT));
        group.add_child(sub);
    }

    group
}
