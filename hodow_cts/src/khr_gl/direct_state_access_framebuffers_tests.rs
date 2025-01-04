//! Port of the `Framebuffers` namespace of `gl4cDirectStateAccessFramebuffersAndRenderbuffersTests.cpp` (the Renderbuffers namespace is in `direct_state_access_tests`).

use std::ffi::CString;

use super::common_bugs_tests::Shader;
use super::direct_state_access_tests::{check_dsa_support, clean_errors, dsa_outcome};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};

const REFERENCE_COLOR: [glw::GLfloat; 4] = [0.25, 0.5, 0.75, 1.0];
const REFERENCE_DEPTH: glw::GLfloat = 0.5;
const REFERENCE_STENCIL: glw::GLint = 7;

fn max_color_attachments(gl: &glw::Functions) -> Result<glw::GLint, TestError> {
    let mut max_color_attachments: glw::GLint = 8;
    // SAFETY: writes one integer to the live local.
    unsafe { gl.get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments) };
    glu::expect_no_error(gl, "glGetIntegerv has failed")?;
    Ok(max_color_attachments)
}

fn get_integer(gl: &glw::Functions, pname: glw::GLenum) -> Result<glw::GLint, TestError> {
    let mut value: glw::GLint = 1024;
    // SAFETY: writes one integer to the live local.
    unsafe { gl.get_integerv(pname, &mut value) };
    glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
    Ok(value)
}

fn clear_reference(gl: &glw::Functions) {
    // SAFETY: plain state changes and a clear of the bound framebuffer.
    unsafe {
        gl.clear_color(
            REFERENCE_COLOR[0],
            REFERENCE_COLOR[1],
            REFERENCE_COLOR[2],
            REFERENCE_COLOR[3],
        );
        gl.clear_depth(REFERENCE_DEPTH as glw::GLdouble);
        gl.clear_stencil(REFERENCE_STENCIL);
        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
    }
}

fn reset_clear_values(gl: &glw::Functions) {
    // SAFETY: plain state changes.
    unsafe {
        gl.clear_color(0.0, 0.0, 0.0, 0.0);
        gl.clear_depth(1.0);
        gl.clear_stencil(0);
    }
}

/// `SubTestContent` of the texture attachment tests: `what` is the already formatted description of the attachment under test.
fn check_attachment_content(gl: &glw::Functions, internalformat: glw::GLenum, what: &str) -> Result<bool, TestError> {
    if internalformat == glw::GL_RGBA8 {
        let mut color = [0.0 as glw::GLfloat; 4];
        // SAFETY: the array holds one RGBA float pixel.
        unsafe { gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, color.as_mut_ptr().cast()) };
        glu::expect_no_error(gl, "glReadPixels has failed")?;
        for i in 0..4 {
            if (REFERENCE_COLOR[i] - color[i]).abs() > 0.0625 {
                log::info!(
                    "{what}. The color content of the framebuffer was [{}, {}, {}, {}], but [{}, {}, {}, {}] was expected.",
                    color[0],
                    color[1],
                    color[2],
                    color[3],
                    REFERENCE_COLOR[0],
                    REFERENCE_COLOR[1],
                    REFERENCE_COLOR[2],
                    REFERENCE_COLOR[3]
                );
                return Ok(false);
            }
        }
    }

    if internalformat == glw::GL_DEPTH_COMPONENT24 || internalformat == glw::GL_DEPTH24_STENCIL8 {
        let mut depth: glw::GLfloat = 0.0;
        // SAFETY: writes one float to the live local.
        unsafe {
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_FLOAT,
                (&mut depth as *mut glw::GLfloat).cast(),
            )
        };
        glu::expect_no_error(gl, "glReadPixels has failed")?;
        if (REFERENCE_DEPTH - depth).abs() > 0.0625 {
            log::info!(
                "{what}. The depth content of the framebuffer was [{depth}], but [{REFERENCE_DEPTH}] was expected."
            );
            return Ok(false);
        }
    }

    if internalformat == glw::GL_STENCIL_INDEX8 || internalformat == glw::GL_DEPTH24_STENCIL8 {
        let mut stencil: glw::GLint = 0;
        // SAFETY: writes one integer to the live local.
        unsafe {
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_STENCIL_INDEX,
                glw::GL_INT,
                (&mut stencil as *mut glw::GLint).cast(),
            )
        };
        glu::expect_no_error(gl, "glReadPixels has failed")?;
        if REFERENCE_STENCIL != stencil {
            log::info!(
                "{what}. The stencil content of the framebuffer was [{stencil}], but [{REFERENCE_STENCIL}] was expected."
            );
            return Ok(false);
        }
    }
    Ok(true)
}

fn log_status_failure(status: glw::GLenum, what: &str) -> bool {
    if status != glw::GL_FRAMEBUFFER_COMPLETE {
        log::info!("Named Framebuffer test failed because of framebuffer status {status:#x}: {what}.");
        return false;
    }
    true
}

// ------------------------------------------------------------------------------------------------------------------

/// `Framebuffers::CreationTest`
struct FramebuffersCreationTest;

impl TestCase for FramebuffersCreationTest {
    fn name(&self) -> &str {
        "framebuffers_creation"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const COUNT: usize = 2;
        let gl = context.gl();
        let mut framebuffers_legacy = [0 as glw::GLuint; COUNT];
        let mut framebuffers_dsa = [0 as glw::GLuint; COUNT];

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: COUNT names are written to the live array.
            unsafe { gl.gen_framebuffers(COUNT as glw::GLsizei, framebuffers_legacy.as_mut_ptr()) };
            glu::expect_no_error(gl, "glGenFramebuffers has failed")?;

            for framebuffer in &framebuffers_legacy {
                // SAFETY: plain query.
                if unsafe { gl.is_framebuffer(*framebuffer) } != 0 {
                    is_ok = false;
                    log::info!("GenFramebuffers has created default objects, but it should create only a names.");
                }
            }

            // SAFETY: COUNT names are written to the live array.
            unsafe { gl.create_framebuffers(COUNT as glw::GLsizei, framebuffers_dsa.as_mut_ptr()) };
            glu::expect_no_error(gl, "glCreateFramebuffers has failed")?;

            for framebuffer in &framebuffers_dsa {
                // SAFETY: plain query.
                if unsafe { gl.is_framebuffer(*framebuffer) } == 0 {
                    is_ok = false;
                    log::info!("CreateFramebuffers has not created default objects.");
                }
            }
            Ok(is_ok)
        });

        for framebuffer in framebuffers_legacy.iter().chain(&framebuffers_dsa) {
            if *framebuffer != 0 {
                // SAFETY: deletes a name generated above.
                unsafe { gl.delete_framebuffers(1, framebuffer) };
            }
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// The `m_fbo`/`m_rbo`/`m_to` members of the attachment tests with their `Clean`.
#[derive(Default)]
struct AttachmentObjects {
    fbo: glw::GLuint,
    rbo: glw::GLuint,
    to: glw::GLuint,
}

impl AttachmentObjects {
    fn clean(&mut self, gl: &glw::Functions) {
        // SAFETY: deletes names created by the test.
        unsafe {
            if self.fbo != 0 {
                gl.delete_framebuffers(1, &self.fbo);
                self.fbo = 0;
            }
            if self.rbo != 0 {
                gl.delete_renderbuffers(1, &self.rbo);
                self.rbo = 0;
            }
            if self.to != 0 {
                gl.delete_textures(1, &self.to);
                self.to = 0;
            }
        }
        reset_clear_values(gl);
        clean_errors(gl);
    }
}

/// `Framebuffers::RenderbufferAttachmentTest`
struct FramebuffersRenderbufferAttachmentTest;

impl FramebuffersRenderbufferAttachmentTest {
    fn test(
        gl: &glw::Functions,
        objects: &mut AttachmentObjects,
        attachment: glw::GLenum,
        internalformat: glw::GLenum,
    ) -> Result<bool, TestError> {
        // SAFETY: names are written to live fields and then used as C++ does.
        unsafe {
            gl.gen_renderbuffers(1, &mut objects.rbo);
            glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbo);
            glu::expect_no_error(gl, "glBindRenderbuffer has failed")?;
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internalformat, 1, 1);
            glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
            glu::expect_no_error(gl, "glBindRenderbuffer has failed")?;

            gl.create_framebuffers(1, &mut objects.fbo);
            glu::expect_no_error(gl, "glCreateFramebuffers has failed")?;

            gl.named_framebuffer_renderbuffer(objects.fbo, attachment, glw::GL_RENDERBUFFER, objects.rbo);
            let error = gl.get_error();
            if error != glw::GL_NO_ERROR {
                log::info!(
                    "NamedFramebufferRenderbuffer for attachment {attachment:#x} failed with error value {}.",
                    glw::error_name(error)
                );
                return Ok(false);
            }

            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo);
            glu::expect_no_error(gl, "glBindFramebuffer has failed")?;

            let status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
            if status != glw::GL_FRAMEBUFFER_COMPLETE {
                log::info!(
                    "Named Framebuffer Renderbuffer Attachment test failed because of framebuffer status {status:#x} with renderbuffer set up as attachment {attachment:#x}."
                );
                return Ok(false);
            }
        }
        Ok(true)
    }
}

impl TestCase for FramebuffersRenderbufferAttachmentTest {
    fn name(&self) -> &str {
        "framebuffers_renderbuffer_attachment"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = AttachmentObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            for i in 0..max_color_attachments(gl)? {
                is_ok &= Self::test(gl, &mut objects, glw::GL_COLOR_ATTACHMENT0 + i as u32, glw::GL_RGBA8)?;
                objects.clean(gl);
            }
            is_ok &= Self::test(gl, &mut objects, glw::GL_DEPTH_ATTACHMENT, glw::GL_DEPTH_COMPONENT24)?;
            objects.clean(gl);
            is_ok &= Self::test(gl, &mut objects, glw::GL_STENCIL_ATTACHMENT, glw::GL_STENCIL_INDEX8)?;
            objects.clean(gl);
            is_ok &= Self::test(
                gl,
                &mut objects,
                glw::GL_DEPTH_STENCIL_ATTACHMENT,
                glw::GL_DEPTH24_STENCIL8,
            )?;
            objects.clean(gl);
            Ok(is_ok)
        });
        objects.clean(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `Framebuffers::TextureAttachmentTest`
struct FramebuffersTextureAttachmentTest;

impl FramebuffersTextureAttachmentTest {
    const TARGETS: [glw::GLenum; 4] = [
        glw::GL_TEXTURE_RECTANGLE,
        glw::GL_TEXTURE_2D,
        glw::GL_TEXTURE_2D_MULTISAMPLE,
        glw::GL_TEXTURE_CUBE_MAP,
    ];

    fn max_texture_levels(gl: &glw::Functions, texture_target: glw::GLenum) -> Result<glw::GLuint, TestError> {
        match texture_target {
            glw::GL_TEXTURE_RECTANGLE | glw::GL_TEXTURE_2D_MULTISAMPLE => Ok(1),
            glw::GL_TEXTURE_2D => Ok((get_integer(gl, glw::GL_MAX_TEXTURE_SIZE)? as f64).ln() as glw::GLuint),
            glw::GL_TEXTURE_CUBE_MAP => {
                Ok((get_integer(gl, glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)? as f64).ln() as glw::GLuint)
            }
            _ => Err(TestError::Fail("unexpected texture target".to_string())),
        }
    }

    fn test(
        gl: &glw::Functions,
        objects: &mut AttachmentObjects,
        attachment: glw::GLenum,
        is_color_attachment: bool,
        texture_target: glw::GLenum,
        internalformat: glw::GLenum,
        levels: glw::GLuint,
    ) -> Result<bool, TestError> {
        let size = (1u32 << levels) as glw::GLsizei;
        // SAFETY: names are written to live fields and then used as C++ does.
        unsafe {
            gl.gen_textures(1, &mut objects.to);
            glu::expect_no_error(gl, "glGenTextures has failed")?;
            gl.bind_texture(texture_target, objects.to);
            glu::expect_no_error(gl, "glBindTexture has failed")?;

            if texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE {
                gl.tex_storage_2d_multisample(texture_target, 1, internalformat, size, size, glw::FALSE);
            } else {
                gl.tex_storage_2d(texture_target, levels as glw::GLsizei, internalformat, size, size);
            }
            glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;

            gl.bind_texture(texture_target, 0);
            glu::expect_no_error(gl, "glBindRenderbuffer has failed")?;

            gl.create_framebuffers(1, &mut objects.fbo);
            glu::expect_no_error(gl, "glCreateFramebuffers has failed")?;

            for i in 0..levels {
                gl.named_framebuffer_texture(objects.fbo, attachment, objects.to, i as glw::GLint);
                let error = gl.get_error();
                if error != glw::GL_NO_ERROR {
                    log::info!(
                        "NamedFramebufferTexture for attachment {attachment:#x} of texture target {texture_target:#x} and texture level {i} of texture with {levels} levels failed with error value {}.",
                        glw::error_name(error)
                    );
                }

                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;

                if is_color_attachment {
                    gl.draw_buffer(attachment);
                    glu::expect_no_error(gl, "glDrawBuffer has failed")?;
                    gl.read_buffer(attachment);
                    glu::expect_no_error(gl, "glReadBuffer has failed")?;
                }

                let status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
                log_status_failure(
                    status,
                    &format!(
                        "texture target {texture_target:#x} set up as attachment {attachment:#x} and texture level {i} of texture with {levels} levels"
                    ),
                );

                if texture_target != glw::GL_TEXTURE_2D_MULTISAMPLE {
                    clear_reference(gl);
                    let what = format!(
                        "Named Framebuffer Texture Layer Attachment test failed with texture target {texture_target:#x} set up as attachment {attachment:#x} and texture level {i} of texture with {levels} levels"
                    );
                    if !check_attachment_content(gl, internalformat, &what)? {
                        return Ok(false);
                    }
                }

                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
            }
        }
        Ok(true)
    }
}

impl TestCase for FramebuffersTextureAttachmentTest {
    fn name(&self) -> &str {
        "framebuffers_texture_attachment"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = AttachmentObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let max_color_attachments = max_color_attachments(gl)?;

            for target in Self::TARGETS {
                for j in 1..=Self::max_texture_levels(gl, target)? {
                    for k in 0..max_color_attachments {
                        is_ok &= Self::test(
                            gl,
                            &mut objects,
                            glw::GL_COLOR_ATTACHMENT0 + k as u32,
                            true,
                            target,
                            glw::GL_RGBA8,
                            j,
                        )?;
                        objects.clean(gl);
                    }
                    is_ok &= Self::test(
                        gl,
                        &mut objects,
                        glw::GL_DEPTH_ATTACHMENT,
                        false,
                        target,
                        glw::GL_DEPTH_COMPONENT24,
                        j,
                    )?;
                    objects.clean(gl);
                    is_ok &= Self::test(
                        gl,
                        &mut objects,
                        glw::GL_STENCIL_ATTACHMENT,
                        false,
                        target,
                        glw::GL_STENCIL_INDEX8,
                        j,
                    )?;
                    objects.clean(gl);
                    is_ok &= Self::test(
                        gl,
                        &mut objects,
                        glw::GL_DEPTH_STENCIL_ATTACHMENT,
                        false,
                        target,
                        glw::GL_DEPTH24_STENCIL8,
                        j,
                    )?;
                    objects.clean(gl);
                }
            }
            Ok(is_ok)
        });
        objects.clean(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `Framebuffers::TextureLayerAttachmentTest`
struct FramebuffersTextureLayerAttachmentTest;

impl FramebuffersTextureLayerAttachmentTest {
    const TARGETS: [glw::GLenum; 4] = [
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        glw::GL_TEXTURE_2D_ARRAY,
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        glw::GL_TEXTURE_3D,
    ];

    fn max_texture_levels(gl: &glw::Functions, texture_target: glw::GLenum) -> Result<glw::GLuint, TestError> {
        match texture_target {
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => Ok(1),
            glw::GL_TEXTURE_2D_ARRAY => Ok((get_integer(gl, glw::GL_MAX_TEXTURE_SIZE)? as f64).ln() as glw::GLuint),
            glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
                Ok((get_integer(gl, glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE)? as f64).ln() as glw::GLuint)
            }
            glw::GL_TEXTURE_3D => Ok((get_integer(gl, glw::GL_MAX_3D_TEXTURE_SIZE)? as f64).ln() as glw::GLuint),
            _ => Err(TestError::Fail("unexpected texture target".to_string())),
        }
    }

    fn max_texture_layers(gl: &glw::Functions, texture_target: glw::GLenum) -> Result<glw::GLuint, TestError> {
        match texture_target {
            glw::GL_TEXTURE_3D => Ok(get_integer(gl, glw::GL_MAX_3D_TEXTURE_SIZE)? as glw::GLuint),
            glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY | glw::GL_TEXTURE_2D_ARRAY => {
                Ok(get_integer(gl, glw::GL_MAX_ARRAY_TEXTURE_LAYERS)? as glw::GLuint)
            }
            glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
                Ok((get_integer(gl, glw::GL_MAX_ARRAY_TEXTURE_LAYERS)? / 6 * 6) as glw::GLuint)
            }
            _ => Err(TestError::Fail("unexpected texture target".to_string())),
        }
    }

    fn test(
        gl: &glw::Functions,
        objects: &mut AttachmentObjects,
        attachment: glw::GLenum,
        is_color_attachment: bool,
        texture_target: glw::GLenum,
        internalformat: glw::GLenum,
        levels: glw::GLuint,
        layers: glw::GLint,
    ) -> Result<bool, TestError> {
        let size = (1u32 << levels) as glw::GLsizei;
        let mut layers = std::cmp::max(1, (layers as u64 / (1u64 << (2 * (levels - 1) as u64))) as glw::GLint);
        if texture_target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
            layers = std::cmp::max(6, (layers / 6) * 6);
        }

        // SAFETY: names are written to live fields and then used as C++ does.
        unsafe {
            gl.gen_textures(1, &mut objects.to);
            glu::expect_no_error(gl, "glGenTextures has failed")?;
            gl.bind_texture(texture_target, objects.to);
            glu::expect_no_error(gl, "glBindTexture has failed")?;

            if texture_target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY {
                gl.tex_storage_3d_multisample(texture_target, 1, internalformat, size, size, layers, glw::FALSE);
            } else {
                gl.tex_storage_3d(
                    texture_target,
                    levels as glw::GLsizei,
                    internalformat,
                    size,
                    size,
                    layers,
                );
            }
            glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;

            gl.bind_texture(texture_target, 0);
            glu::expect_no_error(gl, "glBindRenderbuffer has failed")?;

            gl.create_framebuffers(1, &mut objects.fbo);
            glu::expect_no_error(gl, "glCreateFramebuffers has failed")?;

            for i in 0..levels {
                let mut j: glw::GLuint = 0;
                let mut k: glw::GLuint = 1;

                let layers_at_level = (if texture_target == glw::GL_TEXTURE_3D {
                    std::cmp::min(layers, layers / (1i32 << i))
                } else {
                    layers
                }) as glw::GLuint;

                // Only layers with Fibonacci number index are tested to reduce the test time.
                while j < layers_at_level {
                    gl.named_framebuffer_texture_layer(
                        objects.fbo,
                        attachment,
                        objects.to,
                        i as glw::GLint,
                        j as glw::GLint,
                    );
                    let error = gl.get_error();
                    if error != glw::GL_NO_ERROR {
                        log::info!(
                            "NamedFramebufferTextureLayer for attachment {attachment:#x} of texture target {texture_target:#x} at level {i} and at layer {j} where texture has {levels} levels and {layers} layers failed with error value {}.",
                            glw::error_name(error)
                        );
                        return Ok(false);
                    }

                    gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo);
                    glu::expect_no_error(gl, "glBindFramebuffer has failed")?;

                    if is_color_attachment {
                        gl.draw_buffer(attachment);
                        glu::expect_no_error(gl, "glDrawBuffer has failed")?;
                        gl.read_buffer(attachment);
                        glu::expect_no_error(gl, "glReadBuffer has failed")?;
                    }

                    let status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
                    if !log_status_failure(
                        status,
                        &format!(
                            "texture target {texture_target:#x} set up as attachment {attachment:#x} and texture level {i} and texture layer {j} of texture with {levels} levels and {layers} layers"
                        ),
                    ) {
                        return Ok(false);
                    }

                    if texture_target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY {
                        clear_reference(gl);
                        let what = format!(
                            "Named Framebuffer Texture Layer Attachment test failed with texture target {texture_target:#x} set up as attachment {attachment:#x} and texture level {i} and texture layer {j} of texture with {levels} levels and {layers} layers"
                        );
                        if !check_attachment_content(gl, internalformat, &what)? {
                            return Ok(false);
                        }
                    }

                    gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                    glu::expect_no_error(gl, "glBindFramebuffer has failed")?;

                    let l = j;
                    j += k;
                    k = l;
                }
            }
        }
        Ok(true)
    }
}

impl TestCase for FramebuffersTextureLayerAttachmentTest {
    fn name(&self) -> &str {
        "framebuffers_texture_layer_attachment"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = AttachmentObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let max_color_attachments = max_color_attachments(gl)?;

            for target in Self::TARGETS {
                let layers_counts = [
                    if target == glw::GL_TEXTURE_CUBE_MAP_ARRAY { 6 } else { 1 },
                    192,
                    Self::max_texture_layers(gl, target)?,
                ];

                for j in 1..=Self::max_texture_levels(gl, target)? {
                    for layers in layers_counts {
                        let layers = layers as glw::GLint;
                        for l in 0..max_color_attachments {
                            is_ok &= Self::test(
                                gl,
                                &mut objects,
                                glw::GL_COLOR_ATTACHMENT0 + l as u32,
                                true,
                                target,
                                glw::GL_RGBA8,
                                j,
                                layers,
                            )?;
                            objects.clean(gl);
                        }

                        if target != glw::GL_TEXTURE_3D {
                            is_ok &= Self::test(
                                gl,
                                &mut objects,
                                glw::GL_DEPTH_ATTACHMENT,
                                false,
                                target,
                                glw::GL_DEPTH_COMPONENT24,
                                j,
                                layers,
                            )?;
                            objects.clean(gl);
                            is_ok &= Self::test(
                                gl,
                                &mut objects,
                                glw::GL_DEPTH_STENCIL_ATTACHMENT,
                                false,
                                target,
                                glw::GL_DEPTH24_STENCIL8,
                                j,
                                layers,
                            )?;
                            objects.clean(gl);
                            is_ok &= Self::test(
                                gl,
                                &mut objects,
                                glw::GL_STENCIL_ATTACHMENT,
                                false,
                                target,
                                glw::GL_STENCIL_INDEX8,
                                j,
                                layers,
                            )?;
                            objects.clean(gl);
                        }
                    }
                }
            }
            Ok(is_ok)
        });
        objects.clean(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// The framebuffer with one renderbuffer per colour attachment that `DrawReadBufferTest`, `DrawBuffersTest` and the invalidate tests build the same way.
#[derive(Default)]
struct ColorAttachmentsFramebuffer {
    framebuffer: glw::GLuint,
    renderbuffers: Vec<glw::GLuint>,
}

impl ColorAttachmentsFramebuffer {
    fn setup(
        &mut self,
        gl: &glw::Functions,
        max_color_attachments: glw::GLint,
        internalformat: glw::GLenum,
        size: glw::GLsizei,
    ) -> Result<(), TestError> {
        // SAFETY: names are written to live storage and then used as C++ does.
        unsafe {
            gl.gen_framebuffers(1, &mut self.framebuffer);
            glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.framebuffer);
            glu::expect_no_error(gl, "glBindFramebuffers has failed")?;

            self.renderbuffers = vec![0; max_color_attachments as usize];
            gl.gen_renderbuffers(max_color_attachments, self.renderbuffers.as_mut_ptr());
            glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;

            for (i, renderbuffer) in self.renderbuffers.iter().enumerate() {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, *renderbuffer);
                glu::expect_no_error(gl, "glBindRenderbuffer has failed")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internalformat, size, size);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0 + i as u32,
                    glw::GL_RENDERBUFFER,
                    *renderbuffer,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
            }

            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                log::info!("Framebuffer was incomplete.");
                return Err(TestError::Fail("incomplete framebuffer".to_string()));
            }
        }
        Ok(())
    }

    fn clean(&mut self, gl: &glw::Functions) {
        // SAFETY: deletes names created by `setup`.
        unsafe {
            if self.framebuffer != 0 {
                gl.delete_framebuffers(1, &self.framebuffer);
                self.framebuffer = 0;
            }
            for renderbuffer in self.renderbuffers.drain(..) {
                if renderbuffer != 0 {
                    gl.delete_renderbuffers(1, &renderbuffer);
                }
            }
            gl.clear_color(0.0, 0.0, 0.0, 0.0);
        }
        clean_errors(gl);
    }
}

fn read_color(gl: &glw::Functions) -> Result<[glw::GLfloat; 4], TestError> {
    let mut rgba = [-1.0 as glw::GLfloat; 4];
    // SAFETY: the array holds one RGBA float pixel.
    unsafe { gl.read_pixels(0, 0, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, rgba.as_mut_ptr().cast()) };
    glu::expect_no_error(gl, "glReadPixels has failed")?;
    Ok(rgba)
}

/// `Framebuffers::DrawReadBufferTest`
struct FramebuffersDrawReadBufferTest;

impl TestCase for FramebuffersDrawReadBufferTest {
    fn name(&self) -> &str {
        "framebuffers_read_draw_buffer"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = ColorAttachmentsFramebuffer::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let max_color_attachments = max_color_attachments(gl)?;
            objects.setup(gl, max_color_attachments, glw::GL_RGBA32F, 1)?;
            let framebuffer = objects.framebuffer;

            for i in 0..max_color_attachments {
                let value = i as f32 / max_color_attachments as f32;
                // SAFETY: plain state changes and a clear of the bound framebuffer.
                unsafe {
                    gl.clear_color(value, value, value, value);
                    glu::expect_no_error(gl, "glClearColor has failed")?;
                    gl.named_framebuffer_draw_buffer(framebuffer, glw::GL_COLOR_ATTACHMENT0 + i as u32);
                    let error = gl.get_error();
                    if error != glw::GL_NO_ERROR {
                        log::info!(
                            "NamedFramebufferDrawBuffer generated {} error with GL_COLOR_ATTACHMENT{i}. Test fails.",
                            glw::error_name(error)
                        );
                        is_ok = false;
                    }
                    gl.clear(glw::GL_COLOR_BUFFER_BIT);
                    glu::expect_no_error(gl, "glClear has failed")?;
                }
            }

            for i in 0..max_color_attachments {
                // SAFETY: plain state change.
                unsafe { gl.named_framebuffer_read_buffer(framebuffer, glw::GL_COLOR_ATTACHMENT0 + i as u32) };
                // SAFETY: plain state query.
                let error = unsafe { gl.get_error() };
                if error != glw::GL_NO_ERROR {
                    log::info!(
                        "NamedFramebufferReadBuffer generated {} error with GL_COLOR_ATTACHMENT{i}. Test fails.",
                        glw::error_name(error)
                    );
                    is_ok = false;
                }

                let rgba = read_color(gl)?;
                let expected_value = i as f32 / max_color_attachments as f32;
                for component in rgba {
                    if (expected_value - component).abs() > 0.0001 {
                        log::info!(
                            "Named Framebuffer Draw And Read Buffer failed because resulting color value was [{}, {}, {}, {}] but [{expected_value}, {expected_value}, {expected_value}, {expected_value}] was expected.",
                            rgba[0],
                            rgba[1],
                            rgba[2],
                            rgba[3]
                        );
                        is_ok = false;
                        break;
                    }
                }
            }

            // SAFETY: plain state changes.
            unsafe { gl.named_framebuffer_draw_buffer(framebuffer, glw::GL_NONE) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_NO_ERROR {
                log::info!(
                    "NamedFramebufferDrawBuffer generated {} error with GL_NONE. Test fails.",
                    glw::error_name(error)
                );
                is_ok = false;
            }
            // SAFETY: plain state change.
            unsafe { gl.named_framebuffer_read_buffer(framebuffer, glw::GL_NONE) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_NO_ERROR {
                log::info!(
                    "NamedFramebufferReadBuffer generated {} error with GL_NONE. Test fails.",
                    glw::error_name(error)
                );
                is_ok = false;
            }
            Ok(is_ok)
        });
        objects.clean(gl);
        outcome
    }
}

/// `Framebuffers::DrawBuffersTest`
struct FramebuffersDrawBuffersTest;

impl FramebuffersDrawBuffersTest {
    const RGBA: [glw::GLfloat; 4] = [0.0, 0.25, 0.5, 0.75];
}

impl TestCase for FramebuffersDrawBuffersTest {
    fn name(&self) -> &str {
        "framebuffers_draw_buffers"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = ColorAttachmentsFramebuffer::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let max_color_attachments = max_color_attachments(gl)?;
            let color_attachments: Vec<glw::GLenum> = (0..max_color_attachments as u32)
                .map(|i| glw::GL_COLOR_ATTACHMENT0 + i)
                .collect();
            objects.setup(gl, max_color_attachments, glw::GL_RGBA32F, 1)?;
            let framebuffer = objects.framebuffer;

            // SAFETY: the array holds max_color_attachments enums.
            unsafe {
                gl.named_framebuffer_draw_buffers(framebuffer, max_color_attachments, color_attachments.as_ptr())
            };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_NO_ERROR {
                log::info!(
                    "NamedFramebufferDrawBuffers generated {} error. Test fails.",
                    glw::error_name(error)
                );
                is_ok = false;
            }

            for _ in 0..max_color_attachments {
                // SAFETY: plain state change and a clear of the bound framebuffer.
                unsafe {
                    gl.clear_color(Self::RGBA[0], Self::RGBA[1], Self::RGBA[2], Self::RGBA[3]);
                    glu::expect_no_error(gl, "glClearColor has failed")?;
                    gl.clear(glw::GL_COLOR_BUFFER_BIT);
                    glu::expect_no_error(gl, "glClear has failed")?;
                }
            }

            for i in 0..max_color_attachments {
                // SAFETY: plain state change.
                unsafe { gl.read_buffer(glw::GL_COLOR_ATTACHMENT0 + i as u32) };
                glu::expect_no_error(gl, "glReadBuffer has failed")?;

                let rgba = read_color(gl)?;
                for j in 0..4 {
                    if (Self::RGBA[j] - rgba[j]).abs() > 0.0001 {
                        log::info!(
                            "Named Framebuffer Draw Buffers test have failed because resulting color value was [{}, {}, {}, {}] but [{}, {}, {}, {}] had been expected.",
                            rgba[0],
                            rgba[1],
                            rgba[2],
                            rgba[3],
                            Self::RGBA[0],
                            Self::RGBA[1],
                            Self::RGBA[2],
                            Self::RGBA[3]
                        );
                        is_ok = false;
                        break;
                    }
                }
            }

            let none_bufs: glw::GLenum = glw::GL_NONE;
            // SAFETY: one enum is passed.
            unsafe { gl.named_framebuffer_draw_buffers(framebuffer, 1, &none_bufs) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_NO_ERROR {
                log::info!(
                    "NamedFramebufferDrawBuffers generated {} error with GL_NONE. Test fails.",
                    glw::error_name(error)
                );
                is_ok = false;
            }
            Ok(is_ok)
        });
        objects.clean(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `InvalidateDataTest` and `InvalidateSubDataTest` differ only in the call and the renderbuffer size.
#[derive(Clone, Copy, PartialEq)]
enum InvalidateKind {
    Data,
    SubData,
}

struct FramebuffersInvalidateTest(InvalidateKind);

impl FramebuffersInvalidateTest {
    const DEFAULT_ATTACHMENTS: [glw::GLenum; 3] = [glw::GL_COLOR, glw::GL_DEPTH, glw::GL_STENCIL];

    fn invalidate(&self, gl: &glw::Functions, framebuffer: glw::GLuint, attachments: &[glw::GLenum]) {
        // SAFETY: the pointer and count describe the slice.
        unsafe {
            match self.0 {
                InvalidateKind::Data => gl.invalidate_named_framebuffer_data(
                    framebuffer,
                    attachments.len() as glw::GLsizei,
                    attachments.as_ptr(),
                ),
                InvalidateKind::SubData => gl.invalidate_named_framebuffer_sub_data(
                    framebuffer,
                    attachments.len() as glw::GLsizei,
                    attachments.as_ptr(),
                    if framebuffer == 0 { 0 } else { 1 },
                    if framebuffer == 0 { 0 } else { 1 },
                    if framebuffer == 0 { 1 } else { 2 },
                    if framebuffer == 0 { 1 } else { 2 },
                ),
            }
        }
    }

    fn check_error_and_log(gl: &glw::Functions, attachments: &[glw::GLenum]) -> bool {
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            let names: Vec<String> = attachments
                .iter()
                .map(|attachment| format!("{attachment:#x}"))
                .collect();
            log::info!(
                "{} error for following attachments [{}]. Test fails.",
                glw::error_name(error),
                names.join(", ")
            );
            return false;
        }
        true
    }
}

impl TestCase for FramebuffersInvalidateTest {
    fn name(&self) -> &str {
        match self.0 {
            InvalidateKind::Data => "framebuffers_invalidate_data",
            InvalidateKind::SubData => "framebuffers_invalidate_subdata",
        }
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = ColorAttachmentsFramebuffer::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let max_color_attachments = max_color_attachments(gl)?;
            let color_attachments: Vec<glw::GLenum> = (0..max_color_attachments as u32)
                .map(|i| glw::GL_COLOR_ATTACHMENT0 + i)
                .collect();

            self.invalidate(gl, 0, &Self::DEFAULT_ATTACHMENTS);
            is_ok &= Self::check_error_and_log(gl, &Self::DEFAULT_ATTACHMENTS);
            for attachment in &Self::DEFAULT_ATTACHMENTS {
                self.invalidate(gl, 0, std::slice::from_ref(attachment));
                is_ok &= Self::check_error_and_log(gl, std::slice::from_ref(attachment));
            }

            let size = if self.0 == InvalidateKind::Data { 1 } else { 4 };
            objects.setup(gl, max_color_attachments, glw::GL_RGBA32F, size)?;
            let framebuffer = objects.framebuffer;

            self.invalidate(gl, framebuffer, &color_attachments);
            is_ok &= Self::check_error_and_log(gl, &color_attachments);
            for attachment in &color_attachments {
                self.invalidate(gl, framebuffer, std::slice::from_ref(attachment));
                is_ok &= Self::check_error_and_log(gl, std::slice::from_ref(attachment));
            }
            Ok(is_ok)
        });
        objects.clean(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// The `ClearColor<T>`/`Format<T>`/`Type<T>`/`Compare<T>` specialisations of `Framebuffers::ClearTest`.
trait ClearValue: Copy + Default + PartialEq {
    const FORMAT: glw::GLenum;
    const TYPE: glw::GLenum;

    fn clear_named_framebuffer(
        gl: &glw::Functions,
        fbo: glw::GLuint,
        buffer: glw::GLenum,
        drawbuffer: glw::GLint,
        value: Self,
    );

    fn compare(first: Self, second: Self) -> bool {
        first == second
    }
}

impl ClearValue for glw::GLfloat {
    const FORMAT: glw::GLenum = glw::GL_RED;
    const TYPE: glw::GLenum = glw::GL_FLOAT;

    fn clear_named_framebuffer(
        gl: &glw::Functions,
        fbo: glw::GLuint,
        buffer: glw::GLenum,
        drawbuffer: glw::GLint,
        value: Self,
    ) {
        let value_vector = [value, 0.0, 0.0, 0.0];
        // SAFETY: the vector holds four floats.
        unsafe { gl.clear_named_framebufferfv(fbo, buffer, drawbuffer, value_vector.as_ptr()) };
    }

    fn compare(first: Self, second: Self) -> bool {
        (first - second).abs() < 1.0 / 64.0
    }
}

impl ClearValue for glw::GLint {
    const FORMAT: glw::GLenum = glw::GL_RED_INTEGER;
    const TYPE: glw::GLenum = glw::GL_INT;

    fn clear_named_framebuffer(
        gl: &glw::Functions,
        fbo: glw::GLuint,
        buffer: glw::GLenum,
        drawbuffer: glw::GLint,
        value: Self,
    ) {
        let value_vector = [value, 0, 0, 0];
        // SAFETY: the vector holds four integers.
        unsafe { gl.clear_named_framebufferiv(fbo, buffer, drawbuffer, value_vector.as_ptr()) };
    }
}

impl ClearValue for glw::GLuint {
    const FORMAT: glw::GLenum = glw::GL_RED_INTEGER;
    const TYPE: glw::GLenum = glw::GL_UNSIGNED_INT;

    fn clear_named_framebuffer(
        gl: &glw::Functions,
        fbo: glw::GLuint,
        buffer: glw::GLenum,
        drawbuffer: glw::GLint,
        value: Self,
    ) {
        let value_vector = [value, 0, 0, 0];
        // SAFETY: the vector holds four unsigned integers.
        unsafe { gl.clear_named_framebufferuiv(fbo, buffer, drawbuffer, value_vector.as_ptr()) };
    }
}

/// `Framebuffers::ClearTest`
struct FramebuffersClearTest;

#[derive(Default)]
struct ClearObjects {
    fbo: glw::GLuint,
    renderbuffers: Vec<glw::GLuint>,
}

impl ClearObjects {
    fn prepare_framebuffer(
        &mut self,
        gl: &glw::Functions,
        buffer: glw::GLenum,
        internalformat: glw::GLenum,
    ) -> Result<(), TestError> {
        if self.fbo != 0 || !self.renderbuffers.is_empty() {
            return Err(TestError::Fail("framebuffer already prepared".to_string()));
        }

        // SAFETY: names are written to live storage and then used as C++ does.
        unsafe {
            gl.gen_framebuffers(1, &mut self.fbo);
            glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo);
            glu::expect_no_error(gl, "glBindFramebuffers has failed")?;

            if buffer == glw::GL_COLOR {
                let mut max_color_attachments: glw::GLint = 8;
                gl.get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments);
                glu::expect_no_error(gl, "glGetIntegerv has failed")?;

                self.renderbuffers = vec![0; max_color_attachments as usize];
                gl.gen_renderbuffers(max_color_attachments, self.renderbuffers.as_mut_ptr());
                glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;

                for (i, renderbuffer) in self.renderbuffers.iter().enumerate() {
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, *renderbuffer);
                    glu::expect_no_error(gl, "glBindRenderbuffer has failed")?;
                    gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internalformat, 1, 1);
                    glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0 + i as u32,
                        glw::GL_RENDERBUFFER,
                        *renderbuffer,
                    );
                    glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                }
            }

            if buffer == glw::GL_DEPTH_STENCIL {
                self.renderbuffers = vec![0; 1];
                gl.gen_renderbuffers(1, self.renderbuffers.as_mut_ptr());
                glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, self.renderbuffers[0]);
                glu::expect_no_error(gl, "glBindRenderbuffer has failed")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internalformat, 1, 1);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_STENCIL_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    self.renderbuffers[0],
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
            }

            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                log::info!("Framebuffer was incomplete.");
                return Err(TestError::Fail("incomplete framebuffer".to_string()));
            }
        }
        Ok(())
    }

    fn clean(&mut self, gl: &glw::Functions) {
        // SAFETY: deletes names created by `prepare_framebuffer`.
        unsafe {
            if self.fbo != 0 {
                gl.delete_framebuffers(1, &self.fbo);
                self.fbo = 0;
            }
            if !self.renderbuffers.is_empty() {
                gl.delete_renderbuffers(self.renderbuffers.len() as glw::GLsizei, self.renderbuffers.as_ptr());
                self.renderbuffers.clear();
            }
        }
        clean_errors(gl);
    }

    fn test_clear_color<T: ClearValue>(
        &self,
        gl: &glw::Functions,
        buffer: glw::GLenum,
        attachment: glw::GLenum,
        value: T,
    ) -> Result<bool, TestError> {
        // SAFETY: plain state change.
        unsafe { gl.draw_buffer(attachment) };
        glu::expect_no_error(gl, "glDrawBuffer has failed")?;

        T::clear_named_framebuffer(gl, self.fbo, buffer, 0, value);
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "ClearNamedFramebuffer generated {} error. Test fails.",
                glw::error_name(error)
            );
            return Ok(false);
        }

        let mut pixel = T::default();
        // SAFETY: plain state change, then one pixel of T is written to the live local.
        unsafe {
            gl.read_buffer(attachment);
            glu::expect_no_error(gl, "glReadBuffer has failed")?;
            gl.read_pixels(0, 0, 1, 1, T::FORMAT, T::TYPE, (&mut pixel as *mut T).cast());
        }
        glu::expect_no_error(gl, "glReadPixel has failed")?;

        if T::compare(pixel, value) {
            return Ok(true);
        }
        log::info!(
            "ClearNamedFramebuffer did not clear the colour attachment of the framebuffer to the requested value."
        );
        Ok(false)
    }

    fn test_clear_depth_and_stencil(
        &self,
        gl: &glw::Functions,
        depth: glw::GLfloat,
        stencil: glw::GLint,
    ) -> Result<bool, TestError> {
        // SAFETY: plain state change.
        unsafe { gl.clear_named_framebufferfi(self.fbo, glw::GL_DEPTH_STENCIL, 0, depth, stencil) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "ClearNamedFramebufferfi generated {} error. Test fails.",
                glw::error_name(error)
            );
            return Ok(false);
        }

        let mut the_depth: glw::GLfloat = 0.0;
        let mut the_stencil: glw::GLint = 0;
        // SAFETY: one value is written to each live local.
        unsafe {
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_FLOAT,
                (&mut the_depth as *mut glw::GLfloat).cast(),
            );
            glu::expect_no_error(gl, "glReadPixel has failed")?;
            gl.read_pixels(
                0,
                0,
                1,
                1,
                glw::GL_STENCIL_INDEX,
                glw::GL_INT,
                (&mut the_stencil as *mut glw::GLint).cast(),
            );
            glu::expect_no_error(gl, "glReadPixel has failed")?;
        }

        // The `||` is upstream's (it makes this check almost vacuous).
        if glw::GLfloat::compare(the_depth, depth) || glw::GLint::compare(the_stencil, stencil) {
            return Ok(true);
        }
        log::info!("ClearNamedFramebufferfi did not cleared depth/stencil attachment of the framebuffer.");
        Ok(true)
    }
}

impl TestCase for FramebuffersClearTest {
    fn name(&self) -> &str {
        "framebuffers_clear"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = ClearObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            objects.prepare_framebuffer(gl, glw::GL_COLOR, glw::GL_R8)?;
            for i in 0..objects.renderbuffers.len() as u32 {
                is_ok &=
                    objects.test_clear_color::<glw::GLfloat>(gl, glw::GL_COLOR, glw::GL_COLOR_ATTACHMENT0 + i, 0.5)?;
            }
            objects.clean(gl);

            objects.prepare_framebuffer(gl, glw::GL_COLOR, glw::GL_R32F)?;
            for i in 0..objects.renderbuffers.len() as u32 {
                is_ok &=
                    objects.test_clear_color::<glw::GLfloat>(gl, glw::GL_COLOR, glw::GL_COLOR_ATTACHMENT0 + i, 0.5)?;
            }
            objects.clean(gl);

            objects.prepare_framebuffer(gl, glw::GL_COLOR, glw::GL_R8I)?;
            for i in 0..objects.renderbuffers.len() as u32 {
                is_ok &=
                    objects.test_clear_color::<glw::GLint>(gl, glw::GL_COLOR, glw::GL_COLOR_ATTACHMENT0 + i, -16)?;
            }
            objects.clean(gl);

            objects.prepare_framebuffer(gl, glw::GL_COLOR, glw::GL_R8UI)?;
            for i in 0..objects.renderbuffers.len() as u32 {
                is_ok &=
                    objects.test_clear_color::<glw::GLuint>(gl, glw::GL_COLOR, glw::GL_COLOR_ATTACHMENT0 + i, 16)?;
            }
            objects.clean(gl);

            objects.prepare_framebuffer(gl, glw::GL_DEPTH_STENCIL, glw::GL_DEPTH24_STENCIL8)?;
            is_ok &= objects.test_clear_depth_and_stencil(gl, 1.0, 1)?;
            objects.clean(gl);
            Ok(is_ok)
        });
        objects.clean(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `Framebuffers::BlitTest`
struct FramebuffersBlitTest;

#[derive(Default)]
struct BlitObjects {
    fbo_src: glw::GLuint,
    rbo_color_src: glw::GLuint,
    rbo_depth_stencil_src: glw::GLuint,
    fbo_dst: glw::GLuint,
    rbo_color_dst: glw::GLuint,
    rbo_depth_stencil_dst: glw::GLuint,
}

impl BlitObjects {
    /// One half of `PrepareFramebuffers`: the same sequence for the source (2x2) and the destination (3x2).
    fn prepare_one(
        gl: &glw::Functions,
        fbo: &mut glw::GLuint,
        rbo_color: &mut glw::GLuint,
        rbo_depth_stencil: &mut glw::GLuint,
        width: glw::GLsizei,
    ) -> Result<(), TestError> {
        // SAFETY: names are written to live fields and then used as C++ does.
        unsafe {
            gl.gen_framebuffers(1, fbo);
            glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, *fbo);
            glu::expect_no_error(gl, "glBindFramebuffers has failed")?;

            gl.gen_renderbuffers(1, rbo_color);
            glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, *rbo_color);
            glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, width, 2);
            glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                *rbo_color,
            );
            glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;

            gl.gen_renderbuffers(1, rbo_depth_stencil);
            glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, *rbo_depth_stencil);
            glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, width, 2);
            glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                *rbo_depth_stencil,
            );
            glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;

            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                log::info!("Framebuffer was incomplete.");
                return Err(TestError::Fail("incomplete framebuffer".to_string()));
            }
        }
        Ok(())
    }

    fn prepare_framebuffers(&mut self, gl: &glw::Functions) -> Result<(), TestError> {
        Self::prepare_one(
            gl,
            &mut self.fbo_src,
            &mut self.rbo_color_src,
            &mut self.rbo_depth_stencil_src,
            2,
        )?;
        Self::prepare_one(
            gl,
            &mut self.fbo_dst,
            &mut self.rbo_color_dst,
            &mut self.rbo_depth_stencil_dst,
            3,
        )
    }

    fn clean(&mut self, gl: &glw::Functions) {
        // SAFETY: deletes names created by `prepare_framebuffers`.
        unsafe {
            for fbo in [&mut self.fbo_src, &mut self.fbo_dst] {
                if *fbo != 0 {
                    gl.delete_framebuffers(1, fbo);
                    *fbo = 0;
                }
            }
            for rbo in [
                &mut self.rbo_color_src,
                &mut self.rbo_color_dst,
                &mut self.rbo_depth_stencil_src,
                &mut self.rbo_depth_stencil_dst,
            ] {
                if *rbo != 0 {
                    gl.delete_renderbuffers(1, rbo);
                    *rbo = 0;
                }
            }
        }
        clean_errors(gl);
    }

    fn check_error_and_log(gl: &glw::Functions) -> bool {
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "BlitNamedFramebuffer unexpectedly generated {} error.",
                glw::error_name(error)
            );
            return false;
        }
        true
    }

    fn clear_framebuffer(
        gl: &glw::Functions,
        red: glw::GLfloat,
        green: glw::GLfloat,
        blue: glw::GLfloat,
        depth: glw::GLfloat,
        stencil: glw::GLint,
    ) -> Result<(), TestError> {
        // SAFETY: plain state changes and a clear of the bound framebuffer.
        unsafe {
            gl.clear_color(red, green, blue, 1.0);
            glu::expect_no_error(gl, "glClearColor has failed")?;
            gl.clear_depth(depth as glw::GLdouble);
            glu::expect_no_error(gl, "glClearColor has failed")?;
            gl.clear_stencil(stencil);
            glu::expect_no_error(gl, "glClearColor has failed")?;
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            glu::expect_no_error(gl, "glClearColor has failed")?;
        }
        Ok(())
    }

    fn check_color(gl: &glw::Functions) -> Result<bool, TestError> {
        const REFERENCE: [[[glw::GLfloat; 4]; 3]; 2] = [
            [[1.0, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0], [0.0, 0.0, 1.0, 1.0]],
            [[1.0, 1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0]],
        ];
        let mut color = [[[0.0 as glw::GLfloat; 4]; 3]; 2];
        // SAFETY: the array holds 3x2 RGBA float pixels.
        unsafe { gl.read_pixels(0, 0, 3, 2, glw::GL_RGBA, glw::GL_FLOAT, color.as_mut_ptr().cast()) };
        glu::expect_no_error(gl, "glReadPixels has failed")?;
        for j in 0..2 {
            for i in 0..3 {
                for k in 0..4 {
                    if (REFERENCE[j][i][k] - color[j][i][k]).abs() > 1.0 / 64.0 {
                        log::info!(
                            "Blitted framebuffer color buffer contains {color:?}, but {REFERENCE:?} was expected."
                        );
                        return Ok(false);
                    }
                }
            }
        }
        Ok(true)
    }

    fn check_depth(gl: &glw::Functions) -> Result<bool, TestError> {
        const REFERENCE: [[glw::GLfloat; 3]; 2] = [[0.5, 0.25, 0.125], [0.0625, 0.0625, 0.0625]];
        let mut depth = [[0.0 as glw::GLfloat; 3]; 2];
        // SAFETY: the array holds 3x2 float depth values.
        unsafe {
            gl.read_pixels(
                0,
                0,
                3,
                2,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_FLOAT,
                depth.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glReadPixels has failed")?;
        for j in 0..2 {
            for i in 0..3 {
                if (REFERENCE[j][i] - depth[j][i]).abs() > 1.0 / 64.0 {
                    log::info!("Blitted framebuffer depth buffer contains {depth:?}, but {REFERENCE:?} was expected.");
                    return Ok(false);
                }
            }
        }
        Ok(true)
    }

    fn check_stencil(gl: &glw::Functions) -> Result<bool, TestError> {
        const REFERENCE: [[glw::GLint; 3]; 2] = [[1, 2, 3], [4, 4, 4]];
        let mut stencil = [[0 as glw::GLint; 3]; 2];
        // SAFETY: the array holds 3x2 integer stencil values.
        unsafe {
            gl.read_pixels(
                0,
                0,
                3,
                2,
                glw::GL_STENCIL_INDEX,
                glw::GL_INT,
                stencil.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glReadPixels has failed")?;
        for j in 0..2 {
            for i in 0..3 {
                if REFERENCE[j][i] != stencil[j][i] {
                    log::info!(
                        "Blitted framebuffer stencil buffer contains {stencil:?}, but {REFERENCE:?} was expected."
                    );
                    return Ok(false);
                }
            }
        }
        Ok(true)
    }

    fn test(&self, gl: &glw::Functions) -> Result<bool, TestError> {
        const ALL: glw::GLbitfield = glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;
        const DEPTH_STENCIL: glw::GLbitfield = glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;
        let (src, dst) = (self.fbo_src, self.fbo_dst);

        // SAFETY: plain state change.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, src) };
        glu::expect_no_error(gl, "glBindFramebuffer has failed")?;

        Self::clear_framebuffer(gl, 1.0, 0.0, 0.0, 0.5, 1)?;
        // SAFETY: the blits only touch the framebuffers created by the test.
        unsafe { gl.blit_named_framebuffer(src, dst, 0, 0, 1, 1, 0, 0, 1, 1, ALL, glw::GL_NEAREST) };
        if !Self::check_error_and_log(gl) {
            return Ok(false);
        }

        Self::clear_framebuffer(gl, 0.0, 1.0, 0.0, 0.25, 2)?;
        // SAFETY: as above.
        unsafe {
            gl.blit_named_framebuffer(
                src,
                dst,
                0,
                0,
                1,
                1,
                1,
                0,
                2,
                1,
                glw::GL_COLOR_BUFFER_BIT,
                glw::GL_LINEAR,
            );
            gl.blit_named_framebuffer(src, dst, 0, 0, 1, 1, 1, 0, 2, 1, DEPTH_STENCIL, glw::GL_NEAREST);
        }
        if !Self::check_error_and_log(gl) {
            return Ok(false);
        }

        Self::clear_framebuffer(gl, 0.0, 0.0, 1.0, 0.125, 3)?;
        // SAFETY: as above.
        unsafe { gl.blit_named_framebuffer(src, dst, 0, 0, 2, 2, 2, 0, 3, 1, ALL, glw::GL_NEAREST) };
        if !Self::check_error_and_log(gl) {
            return Ok(false);
        }

        Self::clear_framebuffer(gl, 1.0, 1.0, 0.0, 0.0625, 4)?;
        // SAFETY: as above.
        unsafe { gl.blit_named_framebuffer(src, dst, 0, 0, 1, 1, 0, 1, 3, 2, ALL, glw::GL_NEAREST) };
        if !Self::check_error_and_log(gl) {
            return Ok(false);
        }

        // SAFETY: plain state change.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, dst) };
        glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
        Ok(Self::check_color(gl)? && Self::check_depth(gl)? && Self::check_stencil(gl)?)
    }
}

impl TestCase for FramebuffersBlitTest {
    fn name(&self) -> &str {
        "framebuffers_blit"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = BlitObjects::default();

        let outcome = dsa_outcome(|| {
            objects.prepare_framebuffers(gl)?;
            objects.test(gl)
        });
        objects.clean(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

#[derive(Default)]
struct StatusCaseObjects {
    fbo: glw::GLuint,
    rbos: [glw::GLuint; 2],
    tos: [glw::GLuint; 2],
}

/// The shape shared by the five `CheckStatusTest` cases: build an incomplete framebuffer, unbind it, expect `expected` from `glCheckNamedFramebufferStatus`.
fn check_status_case(
    gl: &glw::Functions,
    expected: glw::GLenum,
    expected_name: &str,
    delete_fbo_as_renderbuffer: bool,
    setup: impl FnOnce(&glw::Functions, &mut StatusCaseObjects) -> Result<(), TestError>,
) -> Result<bool, TestError> {
    let mut objects = StatusCaseObjects::default();
    let mut is_ok = true;

    let result = (|| {
        // SAFETY: the name is written to the live field.
        unsafe {
            gl.gen_framebuffers(1, &mut objects.fbo);
            glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo);
            glu::expect_no_error(gl, "glBindFramebuffers has failed")?;
        }
        setup(gl, &mut objects)?;
        // SAFETY: plain state change and query.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            glu::expect_no_error(gl, "glBindFramebuffers has failed")?;
            let status = gl.check_named_framebuffer_status(objects.fbo, glw::GL_FRAMEBUFFER);
            if status != expected {
                log::info!(
                    "CheckNamedFramebufferStatus did not return {expected_name} value. Value {status:#x} was returned."
                );
                is_ok = false;
            }
        }
        Ok::<(), TestError>(())
    })();

    // SAFETY: deletes names created above.
    unsafe {
        if objects.fbo != 0 {
            if delete_fbo_as_renderbuffer {
                gl.delete_renderbuffers(1, &objects.fbo);
            } else {
                gl.delete_framebuffers(1, &objects.fbo);
            }
        }
        for rbo in &objects.rbos {
            if *rbo != 0 {
                gl.delete_renderbuffers(1, rbo);
            }
        }
        for to in &objects.tos {
            if *to != 0 {
                gl.delete_textures(1, to);
            }
        }
    }
    result?;
    clean_errors(gl);
    Ok(is_ok)
}

/// `Framebuffers::CheckStatusTest`
struct FramebuffersCheckStatusTest;

impl FramebuffersCheckStatusTest {
    fn incomplete_attachment(gl: &glw::Functions) -> Result<bool, TestError> {
        check_status_case(
            gl,
            glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT,
            "FRAMEBUFFER_INCOMPLETE_ATTACHMENT",
            false,
            |gl, objects| {
                // SAFETY: names are written to live fields and then used as C++ does.
                unsafe {
                    gl.gen_renderbuffers(1, &mut objects.rbos[0]);
                    glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbos[0]);
                    glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_RENDERBUFFER,
                        objects.rbos[0],
                    );
                    glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                }
                Ok(())
            },
        )
    }

    /// Upstream deletes the framebuffer with `glDeleteRenderbuffers` here.
    fn missing_attachment(gl: &glw::Functions) -> Result<bool, TestError> {
        check_status_case(
            gl,
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT,
            "FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT",
            true,
            |_, _| Ok(()),
        )
    }

    fn incomplete_multisample_renderbuffer(gl: &glw::Functions) -> Result<bool, TestError> {
        check_status_case(
            gl,
            glw::GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE,
            "FRAMEBUFFER_INCOMPLETE_MULTISAMPLE",
            false,
            |gl, objects| {
                // SAFETY: names are written to live fields and then used as C++ does.
                unsafe {
                    gl.gen_renderbuffers(2, objects.rbos.as_mut_ptr());
                    glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbos[0]);
                    glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
                    gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 1, glw::GL_R8, 1, 1);
                    glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_RENDERBUFFER,
                        objects.rbos[0],
                    );
                    glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbos[1]);
                    glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
                    gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 2, glw::GL_R8, 1, 1);
                    glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT1,
                        glw::GL_RENDERBUFFER,
                        objects.rbos[1],
                    );
                    glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                }
                Ok(())
            },
        )
    }

    fn incomplete_multisample_texture(gl: &glw::Functions) -> Result<bool, TestError> {
        check_status_case(
            gl,
            glw::GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE,
            "FRAMEBUFFER_INCOMPLETE_MULTISAMPLE",
            false,
            |gl, objects| {
                // SAFETY: names are written to live fields and then used as C++ does.
                unsafe {
                    gl.gen_textures(2, objects.tos.as_mut_ptr());
                    glu::expect_no_error(gl, "glGenTextures has failed")?;
                    gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, objects.tos[0]);
                    glu::expect_no_error(gl, "glBindTexture has failed")?;
                    gl.tex_storage_2d_multisample(glw::GL_TEXTURE_2D_MULTISAMPLE, 2, glw::GL_R8, 1, 1, glw::FALSE);
                    glu::expect_no_error(gl, "glTexStorage2DMultisample has failed")?;
                    gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, objects.tos[0], 0);
                    glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                    gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, objects.tos[1]);
                    glu::expect_no_error(gl, "glBindTexture has failed")?;
                    gl.tex_storage_2d_multisample(glw::GL_TEXTURE_2D_MULTISAMPLE, 4, glw::GL_R8, 1, 1, glw::TRUE);
                    glu::expect_no_error(gl, "glTexStorage2DMultisample has failed")?;
                    gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT1, objects.tos[1], 0);
                    glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                    gl.gen_renderbuffers(1, &mut objects.rbos[0]);
                    glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbos[0]);
                    glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
                    gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 1, glw::GL_R8, 1, 1);
                    glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT2,
                        glw::GL_RENDERBUFFER,
                        objects.rbos[0],
                    );
                    glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                }
                Ok(())
            },
        )
    }

    fn incomplete_layer_targets(gl: &glw::Functions) -> Result<bool, TestError> {
        check_status_case(
            gl,
            glw::GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS,
            "FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS",
            false,
            |gl, objects| {
                // SAFETY: names are written to live fields and then used as C++ does.
                unsafe {
                    gl.gen_textures(2, objects.tos.as_mut_ptr());
                    glu::expect_no_error(gl, "glGenTextures has failed")?;
                    gl.bind_texture(glw::GL_TEXTURE_3D, objects.tos[0]);
                    glu::expect_no_error(gl, "glBindTexture has failed")?;
                    gl.tex_storage_3d(glw::GL_TEXTURE_3D, 1, glw::GL_R8, 2, 2, 2);
                    glu::expect_no_error(gl, "glTexStorage2DMultisample has failed")?;
                    gl.framebuffer_texture_3d(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_TEXTURE_3D,
                        objects.tos[0],
                        0,
                        0,
                    );
                    glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                    gl.bind_texture(glw::GL_TEXTURE_2D, objects.tos[1]);
                    glu::expect_no_error(gl, "glBindTexture has failed")?;
                    gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R8, 1, 1);
                    glu::expect_no_error(gl, "glTexStorage2DMultisample has failed")?;
                    gl.framebuffer_texture_2d(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT1,
                        glw::GL_TEXTURE_2D,
                        objects.tos[1],
                        0,
                    );
                    glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                }
                Ok(())
            },
        )
    }
}

impl TestCase for FramebuffersCheckStatusTest {
    fn name(&self) -> &str {
        "framebuffers_check_status"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut maybe_ok = true;

        // The first two cases are obligatory; the others are optional because the specification does not say a framebuffer is incomplete when any of its conditions is not met.
        let result = (|| {
            let mut is_ok = Self::incomplete_attachment(gl)?;
            is_ok &= Self::missing_attachment(gl)?;
            maybe_ok &= Self::incomplete_multisample_renderbuffer(gl)?;
            maybe_ok &= Self::incomplete_multisample_texture(gl)?;
            maybe_ok &= Self::incomplete_layer_targets(gl)?;
            Ok::<bool, TestError>(is_ok)
        })();
        clean_errors(gl);

        Ok(match result {
            Ok(true) if maybe_ok => TestStatus::pass("Pass"),
            Ok(true) => TestStatus::new(TestResult::CompatibilityWarning, "Pass with Compatibility Warning"),
            Ok(false) => TestStatus::fail("Fail"),
            Err(_) => TestStatus::new(TestResult::InternalError, "Error"),
        })
    }
}

// ------------------------------------------------------------------------------------------------------------------

fn first_unused_name(is_name: impl Fn(glw::GLuint) -> bool) -> glw::GLuint {
    let mut name: glw::GLuint = 0;
    loop {
        name += 1;
        if !is_name(name) {
            return name;
        }
    }
}

/// `Framebuffers::CreationErrorsTest`
struct FramebuffersCreationErrorsTest;

impl TestCase for FramebuffersCreationErrorsTest {
    fn name(&self) -> &str {
        "framebuffers_creation_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut is_ok = true;
        let mut framebuffer: glw::GLuint = 0;

        // SAFETY: a negative count is the error this call is expected to generate; nothing is written.
        unsafe { gl.create_framebuffers(-1, &mut framebuffer) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_INVALID_VALUE {
            log::info!(
                "CreateFramebuffers generated {} error when called with negative number of framebuffers, but GL_INVALID_VALUE was expected.",
                glw::error_name(error)
            );
            is_ok = false;
        }

        if framebuffer != 0 {
            // SAFETY: deletes a name the driver wrote despite the error.
            unsafe { gl.delete_framebuffers(1, &framebuffer) };
        }
        clean_errors(gl);

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// The first value above `GL_COLOR_ATTACHMENT0 + MAX_COLOR_ATTACHMENTS` is invalid for colour; this is the one that is no attachment at all (`m_attachment_invalid`).
fn invalid_attachment() -> glw::GLenum {
    let mut attachment: glw::GLenum = 0;
    loop {
        attachment += 1;
        if attachment != glw::GL_DEPTH_ATTACHMENT
            && attachment != glw::GL_STENCIL_ATTACHMENT
            && attachment != glw::GL_DEPTH_STENCIL_ATTACHMENT
        {
            return attachment;
        }
    }
}

/// `Framebuffers::RenderbufferAttachmentErrorsTest`
struct FramebuffersRenderbufferAttachmentErrorsTest;

#[derive(Default)]
struct RenderbufferAttachmentErrorsObjects {
    fbo_valid: glw::GLuint,
    rbo_valid: glw::GLuint,
}

impl FramebuffersRenderbufferAttachmentErrorsTest {
    fn expect_error(
        gl: &glw::Functions,
        expected_error: glw::GLenum,
        framebuffer: bool,
        attachment: bool,
        color_attachment: bool,
        renderbuffertarget: bool,
        renderbuffer: bool,
    ) -> bool {
        let mut is_ok = true;
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if expected_error != error {
            log::info!(
                "NamedFramebufferRenderbuffer called with {} framebuffer, {}{} attachment, {} renderbuffer target, {} renderbuffer was expected to generate {}, but {} was observed.",
                if framebuffer { "valid" } else { "invalid" },
                if attachment { "valid" } else { "invalid" },
                if color_attachment { " color" } else { "" },
                if renderbuffertarget { "valid" } else { "invalid" },
                if renderbuffer { "valid" } else { "invalid" },
                glw::error_name(expected_error),
                glw::error_name(error)
            );
            is_ok = false;
        }
        clean_errors(gl);
        is_ok
    }
}

impl TestCase for FramebuffersRenderbufferAttachmentErrorsTest {
    fn name(&self) -> &str {
        "framebuffers_renderbuffer_attachment_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = RenderbufferAttachmentErrorsObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // PrepareObjects
            // SAFETY: names are written to live fields and then used as C++ does.
            unsafe {
                gl.gen_framebuffers(1, &mut objects.fbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.gen_renderbuffers(1, &mut objects.rbo_valid);
                glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
            }
            let fbo_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_framebuffer(name) };
                is_name != 0
            });
            let rbo_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_renderbuffer(name) };
                is_name != 0
            });
            let color_attachment_invalid = glw::GL_COLOR_ATTACHMENT0 + max_color_attachments(gl)? as u32;
            let attachment_invalid = invalid_attachment();
            let renderbuffer_target_invalid = glw::GL_RENDERBUFFER + 1;
            let (fbo_valid, rbo_valid) = (objects.fbo_valid, objects.rbo_valid);

            // SAFETY: every call below is expected to fail validation.
            unsafe {
                gl.named_framebuffer_renderbuffer(
                    fbo_invalid,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    rbo_valid,
                );
                is_ok &= Self::expect_error(gl, glw::GL_INVALID_OPERATION, false, true, false, true, true);
                gl.named_framebuffer_renderbuffer(fbo_valid, color_attachment_invalid, glw::GL_RENDERBUFFER, rbo_valid);
                is_ok &= Self::expect_error(gl, glw::GL_INVALID_OPERATION, true, false, true, true, true);
                gl.named_framebuffer_renderbuffer(fbo_valid, attachment_invalid, glw::GL_RENDERBUFFER, rbo_valid);
                is_ok &= Self::expect_error(gl, glw::GL_INVALID_ENUM, true, false, false, true, true);
                gl.named_framebuffer_renderbuffer(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT0,
                    renderbuffer_target_invalid,
                    rbo_valid,
                );
                is_ok &= Self::expect_error(gl, glw::GL_INVALID_ENUM, true, true, false, false, true);
                gl.named_framebuffer_renderbuffer(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    rbo_invalid,
                );
                is_ok &= Self::expect_error(gl, glw::GL_INVALID_OPERATION, true, true, false, true, false);
            }
            Ok(is_ok)
        });

        // SAFETY: deletes the names created above.
        unsafe {
            if objects.fbo_valid != 0 {
                gl.delete_framebuffers(1, &objects.fbo_valid);
            }
            if objects.rbo_valid != 0 {
                gl.delete_renderbuffers(1, &objects.rbo_valid);
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Framebuffers::TextureAttachmentErrorsTest`
struct FramebuffersTextureAttachmentErrorsTest;

#[derive(Default)]
struct TextureAttachmentErrorsObjects {
    fbo_valid: glw::GLuint,
    to_valid: glw::GLuint,
    to_3d_valid: glw::GLuint,
    to_array_valid: glw::GLuint,
    to_cubearray_valid: glw::GLuint,
    tbo_valid: glw::GLuint,
    to_layer_invalid: glw::GLuint,
}

impl FramebuffersTextureAttachmentErrorsTest {
    #[allow(clippy::too_many_arguments)]
    fn expect_error(
        gl: &glw::Functions,
        expected_error: glw::GLenum,
        function_name: &str,
        framebuffer: bool,
        attachment: bool,
        color_attachment: bool,
        texture: bool,
        level: bool,
        texture_type: &str,
        layer: bool,
    ) -> bool {
        let mut is_ok = true;
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if expected_error != error {
            log::info!(
                "{function_name} called with {} framebuffer, {}{} attachment, {}{texture_type} texture, {} level{} was expected to generate {}, but {} was observed.",
                if framebuffer { "valid" } else { "invalid" },
                if attachment { "valid" } else { "invalid" },
                if color_attachment { " color" } else { "" },
                if texture { "valid " } else { "invalid " },
                if level { "valid" } else { "invalid" },
                if layer { "" } else { ", with invalid layer number" },
                glw::error_name(expected_error),
                glw::error_name(error)
            );
            is_ok = false;
        }
        clean_errors(gl);
        is_ok
    }
}

impl TestCase for FramebuffersTextureAttachmentErrorsTest {
    fn name(&self) -> &str {
        "framebuffers_texture_attachment_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = TextureAttachmentErrorsObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // PrepareObjects
            // SAFETY: names are written to live fields and then used as C++ does.
            unsafe {
                gl.gen_framebuffers(1, &mut o.fbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, o.fbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.gen_textures(1, &mut o.to_valid);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_2D, o.to_valid);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.gen_textures(1, &mut o.tbo_valid);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_BUFFER, o.tbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.gen_textures(1, &mut o.to_3d_valid);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_3D, o.to_3d_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.gen_textures(1, &mut o.to_array_valid);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, o.to_array_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.gen_textures(1, &mut o.to_cubearray_valid);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, o.to_cubearray_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.gen_textures(1, &mut o.to_layer_invalid);
                glu::expect_no_error(gl, "glGenTextures has failed")?;
                gl.bind_texture(glw::GL_TEXTURE_RECTANGLE, o.to_layer_invalid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
            }
            let fbo_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_framebuffer(name) };
                is_name != 0
            });
            let to_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_texture(name) };
                is_name != 0
            });
            let color_attachment_invalid = glw::GL_COLOR_ATTACHMENT0 + max_color_attachments(gl)? as u32;
            let attachment_invalid = invalid_attachment();

            let mut max_3d_texture_size: glw::GLint = 2048;
            let mut max_array_texture_layers: glw::GLint = 2048;
            let mut max_cube_map_texture_size: glw::GLint = 16384;
            let mut max_3d_texture_depth: glw::GLint = 2048;
            // SAFETY: each query writes one integer to a live local.
            unsafe {
                gl.get_integerv(glw::GL_MAX_3D_TEXTURE_SIZE, &mut max_3d_texture_size);
                gl.get_integerv(glw::GL_MAX_ARRAY_TEXTURE_LAYERS, &mut max_array_texture_layers);
                gl.get_integerv(glw::GL_MAX_CUBE_MAP_TEXTURE_SIZE, &mut max_cube_map_texture_size);
                if context.context_info.is_extension_supported("GL_NV_deep_texture3D") {
                    gl.get_integerv(glw::GL_MAX_DEEP_3D_TEXTURE_DEPTH_NV, &mut max_3d_texture_depth);
                } else {
                    max_3d_texture_depth = max_3d_texture_size;
                }
            }
            glu::expect_no_error(gl, "glGetIntegerv has failed")?;
            let level_invalid: glw::GLint = -1;

            let (fbo_valid, to_valid, tbo_valid, to_3d_valid, to_array_valid, to_cubearray_valid, to_layer_invalid) = (
                o.fbo_valid,
                o.to_valid,
                o.tbo_valid,
                o.to_3d_valid,
                o.to_array_valid,
                o.to_cubearray_valid,
                o.to_layer_invalid,
            );
            const TEXTURE: &str = "NamedFramebufferTexture";
            const LAYER: &str = "NamedFramebufferTextureLayer";

            // SAFETY: every call below is expected to fail validation.
            unsafe {
                gl.named_framebuffer_texture(fbo_invalid, glw::GL_COLOR_ATTACHMENT0, to_valid, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    TEXTURE,
                    false,
                    true,
                    false,
                    true,
                    true,
                    "",
                    true,
                );
                gl.named_framebuffer_texture(fbo_valid, color_attachment_invalid, to_valid, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    TEXTURE,
                    true,
                    false,
                    true,
                    true,
                    true,
                    "",
                    true,
                );
                gl.named_framebuffer_texture(fbo_valid, attachment_invalid, to_valid, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    TEXTURE,
                    true,
                    false,
                    false,
                    true,
                    true,
                    "",
                    true,
                );
                gl.named_framebuffer_texture(fbo_valid, glw::GL_COLOR_ATTACHMENT0, to_invalid, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    TEXTURE,
                    true,
                    true,
                    false,
                    false,
                    true,
                    "",
                    true,
                );
                gl.named_framebuffer_texture(fbo_valid, glw::GL_COLOR_ATTACHMENT0, to_valid, level_invalid);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    TEXTURE,
                    true,
                    true,
                    false,
                    true,
                    false,
                    "",
                    true,
                );
                gl.named_framebuffer_texture(fbo_valid, glw::GL_COLOR_ATTACHMENT0, tbo_valid, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    TEXTURE,
                    true,
                    true,
                    false,
                    true,
                    true,
                    "buffer",
                    true,
                );

                gl.named_framebuffer_texture_layer(fbo_invalid, glw::GL_COLOR_ATTACHMENT0, to_array_valid, 0, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    LAYER,
                    false,
                    true,
                    false,
                    true,
                    true,
                    "",
                    true,
                );
                gl.named_framebuffer_texture_layer(fbo_valid, color_attachment_invalid, to_array_valid, 0, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    LAYER,
                    true,
                    false,
                    true,
                    true,
                    true,
                    "",
                    true,
                );
                gl.named_framebuffer_texture_layer(fbo_valid, attachment_invalid, to_array_valid, 0, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    LAYER,
                    true,
                    false,
                    false,
                    true,
                    true,
                    "",
                    true,
                );
                gl.named_framebuffer_texture_layer(fbo_valid, glw::GL_COLOR_ATTACHMENT0, to_invalid, 0, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    LAYER,
                    true,
                    true,
                    false,
                    false,
                    true,
                    "",
                    true,
                );
                gl.named_framebuffer_texture_layer(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT0,
                    to_array_valid,
                    level_invalid,
                    0,
                );
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    LAYER,
                    true,
                    true,
                    false,
                    true,
                    false,
                    "",
                    true,
                );
                gl.named_framebuffer_texture_layer(fbo_valid, glw::GL_COLOR_ATTACHMENT0, tbo_valid, 0, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    LAYER,
                    true,
                    true,
                    false,
                    true,
                    true,
                    "buffer",
                    true,
                );

                gl.named_framebuffer_texture_layer(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT0,
                    to_3d_valid,
                    0,
                    max_3d_texture_depth,
                );
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    LAYER,
                    true,
                    true,
                    false,
                    true,
                    true,
                    "3D texture",
                    false,
                );
                gl.named_framebuffer_texture_layer(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT0,
                    to_array_valid,
                    0,
                    max_array_texture_layers,
                );
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    LAYER,
                    true,
                    true,
                    false,
                    true,
                    true,
                    "array",
                    false,
                );
                gl.named_framebuffer_texture_layer(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT0,
                    to_cubearray_valid,
                    0,
                    max_cube_map_texture_size,
                );
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    LAYER,
                    true,
                    true,
                    false,
                    true,
                    true,
                    "cuba map array",
                    false,
                );
                gl.named_framebuffer_texture_layer(fbo_valid, glw::GL_COLOR_ATTACHMENT0, to_layer_invalid, 0, 0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    LAYER,
                    true,
                    true,
                    false,
                    false,
                    true,
                    "rectangle",
                    true,
                );
            }
            Ok(is_ok)
        });

        // SAFETY: deletes the names created above.
        unsafe {
            if o.fbo_valid != 0 {
                gl.delete_framebuffers(1, &o.fbo_valid);
            }
            for to in [
                o.to_valid,
                o.tbo_valid,
                o.to_3d_valid,
                o.to_array_valid,
                o.to_cubearray_valid,
                o.to_layer_invalid,
            ] {
                if to != 0 {
                    gl.delete_textures(1, &to);
                }
            }
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `Framebuffers::DrawReadBuffersErrorsTest`
struct FramebuffersDrawReadBuffersErrorsTest;

impl FramebuffersDrawReadBuffersErrorsTest {
    fn expect_error(gl: &glw::Functions, expected_error: glw::GLenum, function: &str, conditions: &str) -> bool {
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        let is_ok = error == expected_error;
        if !is_ok {
            log::info!(
                "{function} was expected to generate {}, but {} was observed instead when {conditions}",
                glw::error_name(expected_error),
                glw::error_name(error)
            );
        }
        clean_errors(gl);
        is_ok
    }

    /// First value that is none of the draw/read buffer tokens (`m_attachment_invalid`).
    fn invalid_attachment(max_color_attachments: glw::GLint) -> glw::GLenum {
        let mut attachment: glw::GLenum = 0;
        loop {
            attachment += 1;
            let is_token = matches!(
                attachment,
                glw::GL_NONE
                    | glw::GL_FRONT_LEFT
                    | glw::GL_FRONT_RIGHT
                    | glw::GL_BACK_LEFT
                    | glw::GL_BACK_RIGHT
                    | glw::GL_FRONT
                    | glw::GL_BACK
                    | glw::GL_LEFT
                    | glw::GL_RIGHT
                    | glw::GL_FRONT_AND_BACK
            );
            let is_color_attachment =
                (0..max_color_attachments).any(|i| glw::GL_COLOR_ATTACHMENT0 + i as u32 == attachment);
            if !is_token && !is_color_attachment {
                return attachment;
            }
        }
    }
}

impl TestCase for FramebuffersDrawReadBuffersErrorsTest {
    fn name(&self) -> &str {
        "framebuffers_draw_read_buffers_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut fbo_valid: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // PrepareObjects
            // SAFETY: the name is written to the live local and then bound.
            unsafe {
                gl.gen_framebuffers(1, &mut fbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
            }
            let fbo_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_framebuffer(name) };
                is_name != 0
            });
            let mut max_color_attachments: glw::GLint = 8;
            // SAFETY: writes one integer to the live local.
            unsafe { gl.get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments) };
            let attachment_invalid = Self::invalid_attachment(max_color_attachments);
            let attachments_invalid: [glw::GLenum; 2] = [glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT0];
            let attachments_back_invalid: [glw::GLenum; 2] = [glw::GL_BACK_LEFT, glw::GL_BACK];
            let mut max_draw_buffers: glw::GLint = 8;
            // SAFETY: writes one integer to the live local.
            unsafe { gl.get_integerv(glw::GL_MAX_DRAW_BUFFERS, &mut max_draw_buffers) };
            let attachments_too_many_count = max_draw_buffers + 1;
            let mut attachments_too_many = vec![glw::GL_NONE; attachments_too_many_count as usize];
            attachments_too_many[0] = glw::GL_COLOR_ATTACHMENT0;

            let attachment_color = glw::GL_COLOR_ATTACHMENT0;
            let attachment_back_left = glw::GL_BACK_LEFT;
            let attachment_right = glw::GL_RIGHT;
            let attachment_left = glw::GL_LEFT;
            let attachment_front = glw::GL_FRONT;
            let attachment_front_and_back = glw::GL_FRONT_AND_BACK;

            // SAFETY: every call below is expected to fail validation; the pointers refer to live locals of the stated length.
            unsafe {
                gl.named_framebuffer_draw_buffer(fbo_invalid, attachment_color);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferDrawBuffer",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.named_framebuffer_draw_buffer(fbo_valid, attachment_invalid);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffer",
                    "buf is not an accepted value.",
                );
                gl.named_framebuffer_draw_buffer(fbo_valid, attachment_back_left);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferDrawBuffer",
                    "the GL is bound to a draw framebuffer object and the ith argument is a value other than COLOR_ATTACHMENTi or NONE.",
                );

                gl.named_framebuffer_draw_buffers(fbo_invalid, 1, &attachment_color);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferDrawBuffers",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.named_framebuffer_draw_buffers(fbo_valid, -1, &attachment_color);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "NamedFramebufferDrawBuffers",
                    "n is less than 0.",
                );
                gl.named_framebuffer_draw_buffers(fbo_valid, attachments_too_many_count, attachments_too_many.as_ptr());
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "NamedFramebufferDrawBuffers",
                    "n is greater than MAX_DRAW_BUFFERS.",
                );
                gl.named_framebuffer_draw_buffers(fbo_valid, 1, &attachment_invalid);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffers",
                    "one of the values in bufs is not an accepted value.",
                );
                gl.named_framebuffer_draw_buffers(fbo_valid, 2, attachments_invalid.as_ptr());
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferDrawBuffers",
                    "a symbolic constant other than GL_NONE appears more than once in bufs.",
                );

                gl.named_framebuffer_draw_buffers(fbo_valid, 1, &attachment_front);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffers",
                    "a framebuffer object is tested and a value in bufs is FRONT.",
                );
                gl.named_framebuffer_draw_buffers(fbo_valid, 1, &attachment_left);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffers",
                    "a framebuffer object is tested and a value in bufs is LEFT.",
                );
                gl.named_framebuffer_draw_buffers(fbo_valid, 1, &attachment_right);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffers",
                    "a framebuffer object is tested and a value in bufs is RIGHT.",
                );
                gl.named_framebuffer_draw_buffers(fbo_valid, 1, &attachment_front_and_back);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffers",
                    "a framebuffer object is tested and a value in bufs is FRONT_AND_BACK.",
                );
                gl.named_framebuffer_draw_buffers(0, 1, &attachment_front);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffers",
                    "a default framebuffer is tested and a value in bufs is FRONT.",
                );
                gl.named_framebuffer_draw_buffers(0, 1, &attachment_left);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffers",
                    "a default framebuffer is tested and a value in bufs is LEFT.",
                );
                gl.named_framebuffer_draw_buffers(0, 1, &attachment_right);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffers",
                    "a default framebuffer is tested and a value in bufs is RIGHT.",
                );
                gl.named_framebuffer_draw_buffers(0, 1, &attachment_front_and_back);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferDrawBuffers",
                    "a default framebuffer is tested and a value in bufs is FRONT_AND_BACK.",
                );

                gl.named_framebuffer_draw_buffers(0, 2, attachments_back_invalid.as_ptr());
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferDrawBuffers",
                    "any value in bufs is BACK, and n is not one.",
                );
                gl.named_framebuffer_draw_buffers(fbo_valid, 1, &attachment_back_left);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferDrawBuffers",
                    "the API call refers to a framebuffer object and one or more of the values in bufs is anything other than NONE or one of the COLOR_ATTACHMENTn tokens.",
                );
                gl.named_framebuffer_draw_buffers(0, 1, &attachment_color);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferDrawBuffers",
                    "the API call refers to the default framebuffer and one or more of the values in bufs is one of the COLOR_ATTACHMENTn tokens.",
                );

                gl.named_framebuffer_read_buffer(fbo_invalid, attachment_color);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferReadBuffer",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.named_framebuffer_read_buffer(fbo_valid, attachment_invalid);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "NamedFramebufferReadBuffer",
                    "src is not one of the accepted values (tables 17.4 and 17.5 of OpenGL 4.5 Core Profile Specification).",
                );
                gl.named_framebuffer_read_buffer(0, glw::GL_COLOR_ATTACHMENT0);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferReadBuffer",
                    "the default framebuffer is affected and src is a value (other than NONE) that does not indicate any of the color buffers allocated to the default framebuffer.",
                );
                gl.named_framebuffer_read_buffer(fbo_valid, attachment_front_and_back);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferReadBuffer",
                    "a framebuffer object is affected, and src is one of the  constants from table 17.4.",
                );
                gl.named_framebuffer_read_buffer(fbo_valid, glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as u32);
                is_ok &= Self::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "NamedFramebufferReadBuffer",
                    "a framebuffer object is affected, and src is one of the COLOR_ATTACHMENTm where mis greater than or equal to the value of MAX_COLOR_ATTACHMENTS.",
                );
            }
            Ok(is_ok)
        });

        if fbo_valid != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_framebuffers(1, &fbo_valid) };
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `Framebuffers::InvalidateDataAndSubDataErrorsTest` (registered as `invalidate_data_and_subdata_errors`, without the `framebuffers_` prefix)
struct FramebuffersInvalidateDataAndSubDataErrorsTest;

impl TestCase for FramebuffersInvalidateDataAndSubDataErrorsTest {
    fn name(&self) -> &str {
        "invalidate_data_and_subdata_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let (mut fbo_valid, mut rbo) = (0 as glw::GLuint, 0 as glw::GLuint);

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let expect_error = FramebuffersDrawReadBuffersErrorsTest::expect_error;

            // PrepareObjects
            let fbo_attachment_valid = glw::GL_COLOR_ATTACHMENT0;
            // SAFETY: names are written to live locals and then used as C++ does.
            unsafe {
                gl.gen_framebuffers(1, &mut fbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.gen_renderbuffers(1, &mut rbo);
                glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
                glu::expect_no_error(gl, "glBindRenderbuffer has failed")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 1, 1);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, fbo_attachment_valid, glw::GL_RENDERBUFFER, rbo);
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                    return Err(TestError::Fail("incomplete framebuffer".to_string()));
                }
            }
            let fbo_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_framebuffer(name) };
                is_name != 0
            });

            let mut fbo_attachment_invalid: glw::GLenum = 0;
            loop {
                if glw::GL_COLOR_ATTACHMENT0 < fbo_attachment_invalid {
                    return Err(TestError::Fail("no invalid attachment".to_string()));
                }
                fbo_attachment_invalid += 1;
                if matches!(
                    fbo_attachment_invalid,
                    glw::GL_DEPTH_ATTACHMENT | glw::GL_STENCIL_ATTACHMENT | glw::GL_DEPTH_STENCIL_ATTACHMENT
                ) {
                    continue;
                }
                break;
            }

            let color_attachment_invalid = glw::GL_COLOR_ATTACHMENT0 + max_color_attachments(gl)? as u32;

            let mut default_attachment_invalid: glw::GLenum = 0;
            loop {
                default_attachment_invalid += 1;
                if matches!(
                    default_attachment_invalid,
                    glw::GL_FRONT_LEFT
                        | glw::GL_FRONT_RIGHT
                        | glw::GL_BACK_LEFT
                        | glw::GL_BACK_RIGHT
                        | glw::GL_COLOR
                        | glw::GL_DEPTH
                        | glw::GL_STENCIL
                ) {
                    continue;
                }
                break;
            }

            // SAFETY: every call below is expected to fail validation; the pointers refer to live locals.
            unsafe {
                gl.invalidate_named_framebuffer_data(fbo_invalid, 1, &fbo_attachment_valid);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "InvalidateNamedFramebufferData",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.invalidate_named_framebuffer_data(fbo_valid, 1, &fbo_attachment_invalid);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "InvalidateNamedFramebufferData",
                    "any element of attachments is not one of the accepted values.",
                );
                gl.invalidate_named_framebuffer_data(fbo_valid, 1, &color_attachment_invalid);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "InvalidateNamedFramebufferData",
                    "an element of attachments is COLOR_ATTACHMENTm where m is greater than or equal to the value of MAX_COLOR_ATTACHMENTS.",
                );
                gl.invalidate_named_framebuffer_data(0, 1, &default_attachment_invalid);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "InvalidateNamedFramebufferData",
                    "the default framebuffer is affected, and any elements of attachments are not one of the accepted values.",
                );

                gl.invalidate_named_framebuffer_sub_data(fbo_invalid, 1, &fbo_attachment_valid, 0, 0, 1, 1);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "InvalidateNamedFramebufferSubData",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.invalidate_named_framebuffer_sub_data(fbo_valid, -1, &fbo_attachment_valid, 0, 0, 1, 1);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "InvalidateNamedFramebufferSubData",
                    "numAttachments is negative.",
                );
                gl.invalidate_named_framebuffer_sub_data(fbo_valid, 1, &fbo_attachment_valid, 0, 0, -1, 1);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "InvalidateNamedFramebufferSubData",
                    "width is negative.",
                );
                gl.invalidate_named_framebuffer_sub_data(fbo_valid, 1, &fbo_attachment_valid, 0, 0, 1, -1);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "InvalidateNamedFramebufferSubData",
                    "height is negative.",
                );
                gl.invalidate_named_framebuffer_sub_data(fbo_valid, 1, &fbo_attachment_invalid, 0, 0, 1, 1);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "InvalidateNamedFramebufferSubData",
                    "any element of attachments is not one of the accepted values.",
                );
                gl.invalidate_named_framebuffer_sub_data(fbo_valid, 1, &color_attachment_invalid, 0, 0, 1, 1);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "InvalidateNamedFramebufferSubData",
                    "an element of attachments is COLOR_ATTACHMENTm where m is greater than or equal to the value of MAX_COLOR_ATTACHMENTS.",
                );
                gl.invalidate_named_framebuffer_sub_data(0, 1, &default_attachment_invalid, 0, 0, 1, 1);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "InvalidateNamedFramebufferSubData",
                    "the default framebuffer is affected, and any elements of attachments are not one of the accepted values.",
                );
            }
            Ok(is_ok)
        });

        // SAFETY: deletes the names created above.
        unsafe {
            if fbo_valid != 0 {
                gl.delete_framebuffers(1, &fbo_valid);
            }
            if rbo != 0 {
                gl.delete_renderbuffers(1, &rbo);
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Framebuffers::ClearNamedFramebufferErrorsTest`
struct FramebuffersClearErrorsTest;

impl TestCase for FramebuffersClearErrorsTest {
    fn name(&self) -> &str {
        "framebuffers_clear_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let (mut fbo_valid, mut rbo_color, mut rbo_depth_stencil) =
            (0 as glw::GLuint, 0 as glw::GLuint, 0 as glw::GLuint);

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let expect_error = FramebuffersDrawReadBuffersErrorsTest::expect_error;

            // PrepareObjects
            // SAFETY: names are written to live locals and then used as C++ does.
            unsafe {
                gl.gen_framebuffers(1, &mut fbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.gen_renderbuffers(1, &mut rbo_color);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_color);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R8, 1, 1);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    rbo_color,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                gl.gen_renderbuffers(1, &mut rbo_depth_stencil);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_depth_stencil);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, 1, 1);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_STENCIL_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    rbo_depth_stencil,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
            }
            let fbo_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_framebuffer(name) };
                is_name != 0
            });

            let icolor = [0 as glw::GLint; 4];
            let ucolor = [0 as glw::GLuint; 4];
            let fcolor = [0 as glw::GLfloat; 4];

            // SAFETY: every call below is expected to fail validation; the pointers refer to live arrays of four values.
            unsafe {
                gl.clear_named_framebufferiv(fbo_invalid, glw::GL_COLOR, 0, icolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "ClearNamedFramebufferiv",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.clear_named_framebufferuiv(fbo_invalid, glw::GL_COLOR, 0, ucolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "ClearNamedFramebufferuiv",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.clear_named_framebufferfv(fbo_invalid, glw::GL_COLOR, 0, fcolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "ClearNamedFramebufferfv",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.clear_named_framebufferfi(fbo_invalid, glw::GL_DEPTH_STENCIL, 0, fcolor[0], icolor[0]);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "ClearNamedFramebufferfi",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );

                gl.clear_named_framebufferiv(fbo_valid, glw::GL_DEPTH, 0, icolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "ClearNamedFramebufferiv",
                    "buffer is not COLOR or STENCIL (it is DEPTH).",
                );
                gl.clear_named_framebufferuiv(fbo_valid, glw::GL_DEPTH, 0, ucolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "ClearNamedFramebufferuiv",
                    "buffer is not COLOR (it is DEPTH).",
                );
                gl.clear_named_framebufferfv(fbo_valid, glw::GL_STENCIL, 0, fcolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "ClearNamedFramebufferfv",
                    "buffer is not COLOR or DEPTH (it is STENCIL).",
                );
                gl.clear_named_framebufferfi(fbo_valid, glw::GL_COLOR, 0, fcolor[0], icolor[0]);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "ClearNamedFramebufferfi",
                    "buffer is not DEPTH_STENCIL.",
                );

                gl.clear_named_framebufferiv(fbo_valid, glw::GL_COLOR, -1, icolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "ClearNamedFramebufferiv",
                    "buffer is COLOR drawbuffer is negative, or greater than the value of MAX_DRAW_BUFFERS minus one.",
                );
                gl.clear_named_framebufferuiv(fbo_valid, glw::GL_COLOR, -1, ucolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "ClearNamedFramebufferuiv",
                    "buffer is COLOR drawbuffer is negative, or greater than the value of MAX_DRAW_BUFFERS minus one.",
                );

                gl.clear_named_framebufferiv(fbo_valid, glw::GL_STENCIL, 1, icolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "ClearNamedFramebufferiv",
                    "buffer is DEPTH, STENCIL or DEPTH_STENCIL and drawbuffer is not zero.",
                );
                gl.clear_named_framebufferfv(fbo_valid, glw::GL_DEPTH, 1, fcolor.as_ptr());
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "ClearNamedFramebufferfv",
                    "buffer is DEPTH, STENCIL or DEPTH_STENCIL and drawbuffer is not zero.",
                );
                gl.clear_named_framebufferfi(fbo_valid, glw::GL_DEPTH_STENCIL, 1, fcolor[0], icolor[0]);
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "ClearNamedFramebufferfi",
                    "buffer is DEPTH, STENCIL or DEPTH_STENCIL and drawbuffer is not zero.",
                );
            }
            Ok(is_ok)
        });

        // SAFETY: deletes the names created above.
        unsafe {
            if fbo_valid != 0 {
                gl.delete_framebuffers(1, &fbo_valid);
            }
            if rbo_color != 0 {
                gl.delete_renderbuffers(1, &rbo_color);
            }
            if rbo_depth_stencil != 0 {
                gl.delete_renderbuffers(1, &rbo_depth_stencil);
            }
        }
        clean_errors(gl);
        outcome
    }
}

/// `Framebuffers::CheckStatusErrorsTest`
struct FramebuffersCheckStatusErrorsTest;

impl TestCase for FramebuffersCheckStatusErrorsTest {
    fn name(&self) -> &str {
        "framebuffers_check_status_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut fbo_valid: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // PrepareObjects
            // SAFETY: the name is written to the live local and then bound.
            unsafe {
                gl.gen_framebuffers(1, &mut fbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
            }
            let mut target_invalid: glw::GLenum = 0;
            loop {
                target_invalid += 1;
                if target_invalid != glw::GL_FRAMEBUFFER
                    && target_invalid != glw::GL_READ_FRAMEBUFFER
                    && target_invalid != glw::GL_DRAW_FRAMEBUFFER
                {
                    break;
                }
            }
            let fbo_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_framebuffer(name) };
                is_name != 0
            });

            // SAFETY: both calls are expected to fail validation.
            unsafe {
                gl.check_named_framebuffer_status(fbo_valid, target_invalid);
                is_ok &= FramebuffersDrawReadBuffersErrorsTest::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "CheckNamedFramebufferStatus",
                    "target is not DRAW_FRAMEBUFFER, READ_FRAMEBUFFER or FRAMEBUFFER.",
                );
                gl.check_named_framebuffer_status(fbo_invalid, glw::GL_FRAMEBUFFER);
                is_ok &= FramebuffersDrawReadBuffersErrorsTest::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "CheckNamedFramebufferStatus",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
            }
            Ok(is_ok)
        });

        if fbo_valid != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_framebuffers(1, &fbo_valid) };
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// First value from 1 upwards that is none of `valid` (the `m_parameter_invalid` loops).
fn first_value_not_in(valid: &[glw::GLenum]) -> glw::GLenum {
    let mut value: glw::GLenum = 0;
    loop {
        value += 1;
        if !valid.contains(&value) {
            return value;
        }
    }
}

/// `Framebuffers::GetParameterErrorsTest`
struct FramebuffersGetParameterErrorsTest;

impl TestCase for FramebuffersGetParameterErrorsTest {
    fn name(&self) -> &str {
        "framebuffers_get_parameter_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut fbo_valid: glw::GLuint = 0;

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // PrepareObjects
            // SAFETY: the name is written to the live local and then bound.
            unsafe {
                gl.gen_framebuffers(1, &mut fbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
            }
            let parameter_invalid = first_value_not_in(&[
                glw::GL_FRAMEBUFFER_DEFAULT_WIDTH,
                glw::GL_FRAMEBUFFER_DEFAULT_HEIGHT,
                glw::GL_FRAMEBUFFER_DEFAULT_LAYERS,
                glw::GL_FRAMEBUFFER_DEFAULT_SAMPLES,
                glw::GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS,
                glw::GL_DOUBLEBUFFER,
                glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT,
                glw::GL_IMPLEMENTATION_COLOR_READ_TYPE,
                glw::GL_SAMPLES,
                glw::GL_SAMPLE_BUFFERS,
                glw::GL_STEREO,
            ]);
            let fbo_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_framebuffer(name) };
                is_name != 0
            });

            let mut return_values_unused_storage = [0 as glw::GLint; 4];
            let storage = return_values_unused_storage.as_mut_ptr();
            // SAFETY: every call below is expected to fail validation; the pointer refers to a live array of four integers.
            unsafe {
                gl.get_named_framebuffer_parameteriv(fbo_invalid, glw::GL_SAMPLES, storage);
                is_ok &= FramebuffersDrawReadBuffersErrorsTest::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "GetNamedFramebufferParameteriv",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.get_named_framebuffer_parameteriv(fbo_valid, parameter_invalid, storage);
                is_ok &= FramebuffersDrawReadBuffersErrorsTest::expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "GetNamedFramebufferParameteriv",
                    "pname is not one of the accepted parameter names.",
                );
                gl.get_named_framebuffer_parameteriv(0, glw::GL_FRAMEBUFFER_DEFAULT_WIDTH, storage);
                is_ok &= FramebuffersDrawReadBuffersErrorsTest::expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "GetNamedFramebufferParameteriv",
                    "a default framebuffer is queried, and pname is not one of DOUBLEBUFFER, IMPLEMENTATION_COLOR_READ_FORMAT, IMPLEMENTATION_COLOR_READ_TYPE, SAMPLES, SAMPLE_BUFFERS or STEREO.",
                );
            }
            Ok(is_ok)
        });

        if fbo_valid != 0 {
            // SAFETY: deletes the name created above.
            unsafe { gl.delete_framebuffers(1, &fbo_valid) };
        }
        clean_errors(gl);
        outcome
    }
}

/// `Framebuffers::GetAttachmentParameterErrorsTest`
struct FramebuffersGetAttachmentParameterErrorsTest;

impl TestCase for FramebuffersGetAttachmentParameterErrorsTest {
    fn name(&self) -> &str {
        "framebuffers_get_attachment_parameter_errors"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let (mut fbo_valid, mut rbo_color, mut rbo_depth_stencil) =
            (0 as glw::GLuint, 0 as glw::GLuint, 0 as glw::GLuint);

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let expect_error = FramebuffersDrawReadBuffersErrorsTest::expect_error;

            // PrepareObjects
            // SAFETY: names are written to live locals and then used as C++ does.
            unsafe {
                gl.gen_framebuffers(1, &mut fbo_valid);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_valid);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.gen_renderbuffers(1, &mut rbo_color);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_color);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R8, 1, 1);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    rbo_color,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                gl.gen_renderbuffers(1, &mut rbo_depth_stencil);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo_depth_stencil);
                glu::expect_no_error(gl, "glBindFramebuffer has failed")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, 1, 1);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_STENCIL_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    rbo_depth_stencil,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
            }
            let max_color_attachments = max_color_attachments(gl)?;

            let mut attachment_invalid: glw::GLenum = 0;
            loop {
                let mut is_attachment = false;
                if attachment_invalid == glw::GL_DEPTH_ATTACHMENT
                    || attachment_invalid == glw::GL_STENCIL_ATTACHMENT
                    || attachment_invalid == glw::GL_DEPTH_STENCIL_ATTACHMENT
                {
                    attachment_invalid += 1;
                    is_attachment = true;
                }
                if glw::GL_COLOR_ATTACHMENT0 < attachment_invalid {
                    return Err(TestError::Fail("no invalid attachment".to_string()));
                }
                if !is_attachment {
                    break;
                }
            }

            let mut default_attachment_invalid: glw::GLenum = 0;
            let valid_values = [
                glw::GL_FRONT,
                glw::GL_FRONT_LEFT,
                glw::GL_FRONT_RIGHT,
                glw::GL_BACK,
                glw::GL_BACK_LEFT,
                glw::GL_BACK_RIGHT,
                glw::GL_DEPTH,
                glw::GL_STENCIL,
            ];
            while valid_values.contains(&default_attachment_invalid) {
                default_attachment_invalid += 1;
            }

            let parameter_invalid = first_value_not_in(&[
                glw::GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE,
                glw::GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE,
                glw::GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE,
                glw::GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE,
                glw::GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE,
                glw::GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE,
                glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING,
                glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
                glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
                glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE,
                glw::GL_FRAMEBUFFER_ATTACHMENT_LAYERED,
                glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER,
            ]);
            let _ = parameter_invalid;
            let fbo_invalid = first_unused_name(|name| {
                // SAFETY: plain query.
                let is_name = unsafe { gl.is_framebuffer(name) };
                is_name != 0
            });

            let mut return_values_unused_storage = [0 as glw::GLint; 4];
            let storage = return_values_unused_storage.as_mut_ptr();
            // SAFETY: every call below is expected to fail validation; the pointer refers to a live array of four integers.
            unsafe {
                gl.get_named_framebuffer_attachment_parameteriv(
                    fbo_invalid,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                    storage,
                );
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "GetNamedFramebufferAttachmentParameteriv",
                    "framebuffer is not zero or the name of an existing framebuffer object.",
                );
                gl.get_named_framebuffer_attachment_parameteriv(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
                    storage,
                );
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "GetNamedFramebufferAttachmentParameteriv",
                    "pname is not valid for the value of GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE, as described above.",
                );
                gl.get_named_framebuffer_attachment_parameteriv(
                    fbo_valid,
                    attachment_invalid,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                    storage,
                );
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "GetNamedFramebufferAttachmentParameteriv",
                    "attachment is not one of the accepted framebuffer attachment points, as described in specification.",
                );
                gl.get_named_framebuffer_attachment_parameteriv(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT1,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                    storage,
                );
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "GetNamedFramebufferAttachmentParameteriv",
                    "the value of FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE is GL_NONE and pname is not FRAMEBUFFER_ATTACHMENT_OBJECT_NAME or FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE.",
                );
                gl.get_named_framebuffer_attachment_parameteriv(
                    fbo_valid,
                    glw::GL_DEPTH_STENCIL_ATTACHMENT,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                    storage,
                );
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "GetNamedFramebufferAttachmentParameteriv",
                    "attachment is DEPTH_STENCIL_ATTACHMENT and pname is FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE.",
                );
                gl.get_named_framebuffer_attachment_parameteriv(
                    0,
                    default_attachment_invalid,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                    storage,
                );
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "GetNamedFramebufferAttachmentParameteriv",
                    "the default framebuffer is queried and attachment is not one the values FRONT, FRONT_LEFT, FRONT_RIGHT, BACK, BACK_LEFT, BACK_RIGHT, DEPTH, STENCIL.",
                );
                gl.get_named_framebuffer_attachment_parameteriv(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as u32,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                    storage,
                );
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "GetNamedFramebufferAttachmentParameteriv",
                    "a framebuffer object is bound to target and attachment is COLOR_ATTACHMENTm where m is equal to the value of MAX_COLOR_ATTACHMENTS.",
                );
                gl.get_named_framebuffer_attachment_parameteriv(
                    fbo_valid,
                    glw::GL_COLOR_ATTACHMENT0 + max_color_attachments as u32 + 1,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                    storage,
                );
                is_ok &= expect_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "GetNamedFramebufferAttachmentParameteriv",
                    "a framebuffer object is bound to target and attachment is COLOR_ATTACHMENTm where m is greater than the value of MAX_COLOR_ATTACHMENTS.",
                );
            }
            Ok(is_ok)
        });

        // SAFETY: deletes the names created above.
        unsafe {
            if fbo_valid != 0 {
                gl.delete_framebuffers(1, &fbo_valid);
            }
            if rbo_color != 0 {
                gl.delete_renderbuffers(1, &rbo_color);
            }
            if rbo_depth_stencil != 0 {
                gl.delete_renderbuffers(1, &rbo_depth_stencil);
            }
        }
        clean_errors(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `Framebuffers::GetParametersTest`
struct FramebuffersGetParametersTest;

impl FramebuffersGetParametersTest {
    const DEFAULT_PNAMES: [(glw::GLenum, &'static str); 6] = [
        (glw::GL_DOUBLEBUFFER, "GL_DOUBLEBUFFER"),
        (
            glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT,
            "GL_IMPLEMENTATION_COLOR_READ_FORMAT",
        ),
        (
            glw::GL_IMPLEMENTATION_COLOR_READ_TYPE,
            "GL_IMPLEMENTATION_COLOR_READ_TYPE",
        ),
        (glw::GL_SAMPLES, "GL_SAMPLES"),
        (glw::GL_SAMPLE_BUFFERS, "GL_SAMPLE_BUFFERS"),
        (glw::GL_STEREO, "GL_STEREO"),
    ];

    const CUSTOM_PNAMES: [(glw::GLenum, &'static str); 11] = [
        (glw::GL_DOUBLEBUFFER, "GL_DOUBLEBUFFER"),
        (
            glw::GL_IMPLEMENTATION_COLOR_READ_FORMAT,
            "GL_IMPLEMENTATION_COLOR_READ_FORMAT",
        ),
        (
            glw::GL_IMPLEMENTATION_COLOR_READ_TYPE,
            "GL_IMPLEMENTATION_COLOR_READ_TYPE",
        ),
        (glw::GL_SAMPLES, "GL_SAMPLES"),
        (glw::GL_SAMPLE_BUFFERS, "GL_SAMPLE_BUFFERS"),
        (glw::GL_STEREO, "GL_STEREO"),
        (glw::GL_FRAMEBUFFER_DEFAULT_WIDTH, "FRAMEBUFFER_DEFAULT_WIDTH"),
        (glw::GL_FRAMEBUFFER_DEFAULT_HEIGHT, "FRAMEBUFFER_DEFAULT_HEIGHT"),
        (glw::GL_FRAMEBUFFER_DEFAULT_LAYERS, "FRAMEBUFFER_DEFAULT_LAYERS"),
        (glw::GL_FRAMEBUFFER_DEFAULT_SAMPLES, "FRAMEBUFFER_DEFAULT_SAMPLES"),
        (
            glw::GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS,
            "FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS",
        ),
    ];

    /// `TestDefaultFramebuffer` and `TestCustomFramebuffer`: the legacy query against the bound framebuffer versus the named one.
    fn test_framebuffer(
        gl: &glw::Functions,
        framebuffer: glw::GLuint,
        pnames: &[(glw::GLenum, &str)],
    ) -> Result<bool, TestError> {
        let mut is_ok = true;
        for (pname, pname_string) in pnames {
            let mut parameter_legacy: glw::GLint = 0;
            let mut parameter_dsa: glw::GLint = 0;

            // SAFETY: each query writes one integer to a live local.
            unsafe { gl.get_framebuffer_parameteriv(glw::GL_FRAMEBUFFER, *pname, &mut parameter_legacy) };
            glu::expect_no_error(gl, "glGetFramebufferParameteriv has failed")?;

            // SAFETY: as above.
            unsafe { gl.get_named_framebuffer_parameteriv(framebuffer, *pname, &mut parameter_dsa) };
            // SAFETY: plain state query.
            let error = unsafe { gl.get_error() };
            if error != glw::GL_NO_ERROR {
                log::info!(
                    "GetNamedFramebufferParameteriv generated {} error when called with {pname_string}.",
                    glw::error_name(error)
                );
                is_ok = false;
                continue;
            }

            if parameter_legacy != parameter_dsa {
                log::info!(
                    "{parameter_legacy} was expected for {pname_string} parameter name of the framebuffer, but {parameter_dsa} was returned."
                );
                is_ok = false;
            }
        }
        Ok(is_ok)
    }
}

impl TestCase for FramebuffersGetParametersTest {
    fn name(&self) -> &str {
        "framebuffers_get_parameters"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = AttachmentObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;

            // SAFETY: plain state change.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
            glu::expect_no_error(gl, "glBindFramebuffers has failed")?;
            is_ok &= Self::test_framebuffer(gl, 0, &Self::DEFAULT_PNAMES)?;

            // PrepareFramebuffer
            // SAFETY: names are written to live fields and then used as C++ does.
            unsafe {
                gl.gen_framebuffers(1, &mut objects.fbo);
                glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, objects.fbo);
                glu::expect_no_error(gl, "glBindFramebuffers has failed")?;
                gl.gen_renderbuffers(1, &mut objects.rbo);
                glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, objects.rbo);
                glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_R8, 1, 2);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    objects.rbo,
                );
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
                if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                    log::info!("Framebuffer was incomplete.");
                    return Err(TestError::Fail("incomplete framebuffer".to_string()));
                }
            }
            is_ok &= Self::test_framebuffer(gl, objects.fbo, &Self::CUSTOM_PNAMES)?;
            Ok(is_ok)
        });
        objects.clean(gl);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

#[derive(Default)]
struct AttachmentParametersObjects {
    fbo: glw::GLuint,
    rbo: [glw::GLuint; 2],
    to: [glw::GLuint; 2],
}

/// `Framebuffers::GetAttachmentParametersTest`
struct FramebuffersGetAttachmentParametersTest;

impl FramebuffersGetAttachmentParametersTest {
    const COLOR_AND_SIZE_PNAMES: [(glw::GLenum, &'static str); 8] = [
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
            "GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING,
            "GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING",
        ),
    ];

    const RENDERBUFFER_PNAMES: [(glw::GLenum, &'static str); 9] = [
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            "GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
            "GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING,
            "GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING",
        ),
    ];

    const TEXTURE_PNAMES: [(glw::GLenum, &'static str); 13] = [
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME,
            "GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL,
            "GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE,
            "GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_LAYERED,
            "GL_FRAMEBUFFER_ATTACHMENT_LAYERED",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER,
            "GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE,
            "GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
            "GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE",
        ),
        (
            glw::GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING,
            "GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING",
        ),
    ];

    const DEFAULT_ATTACHMENTS: [(glw::GLenum, &'static str); 6] = [
        (glw::GL_FRONT_LEFT, "GL_FRONT_LEFT"),
        (glw::GL_FRONT_RIGHT, "GL_FRONT_RIGHT"),
        (glw::GL_BACK_LEFT, "GL_BACK_LEFT"),
        (glw::GL_BACK_RIGHT, "GL_BACK_RIGHT"),
        (glw::GL_DEPTH, "GL_DEPTH"),
        (glw::GL_STENCIL, "GL_STENCIL"),
    ];

    const OBJECT_ATTACHMENTS: [(glw::GLenum, &'static str); 5] = [
        (glw::GL_DEPTH_ATTACHMENT, "GL_DEPTH_ATTACHMENT"),
        (glw::GL_STENCIL_ATTACHMENT, "GL_STENCIL_ATTACHMENT"),
        (glw::GL_DEPTH_STENCIL_ATTACHMENT, "GL_DEPTH_STENCIL_ATTACHMENT"),
        (glw::GL_COLOR_ATTACHMENT0, "GL_COLOR_ATTACHMENT0"),
        (glw::GL_COLOR_ATTACHMENT1, "GL_COLOR_ATTACHMENT1"),
    ];

    fn query_pair(
        gl: &glw::Functions,
        framebuffer: glw::GLuint,
        attachment: glw::GLenum,
        pname: glw::GLenum,
    ) -> Result<(glw::GLint, Option<glw::GLenum>, glw::GLint), TestError> {
        let mut legacy: glw::GLint = 0;
        let mut dsa: glw::GLint = 0;
        // SAFETY: each query writes one integer to a live local.
        unsafe { gl.get_framebuffer_attachment_parameteriv(glw::GL_FRAMEBUFFER, attachment, pname, &mut legacy) };
        glu::expect_no_error(gl, "glGetFramebufferParameteriv has failed")?;
        // SAFETY: as above.
        unsafe { gl.get_named_framebuffer_attachment_parameteriv(framebuffer, attachment, pname, &mut dsa) };
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        Ok((legacy, if error != glw::GL_NO_ERROR { Some(error) } else { None }, dsa))
    }

    /// `TestDefaultFramebuffer`, `TestRenderbufferFramebuffer` and `TestTextureFramebuffer`: the legacy attachment query against the named one, for the object type and then for every optional pname when something is attached.
    fn test_framebuffer(
        gl: &glw::Functions,
        framebuffer: glw::GLuint,
        what: &str,
        attachments: &[(glw::GLenum, &str)],
        optional_pnames: &[(glw::GLenum, &str)],
        depth_stencil: bool,
    ) -> Result<bool, TestError> {
        let mut is_ok = true;
        for (attachment, attachment_string) in attachments {
            if *attachment == glw::GL_DEPTH_STENCIL_ATTACHMENT && !depth_stencil {
                continue;
            }

            let (parameter_legacy, error, parameter_dsa) =
                Self::query_pair(gl, framebuffer, *attachment, glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE)?;
            if let Some(error) = error {
                log::info!(
                    "{} error when called with GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE parameter name for {attachment_string} attachment of {what}.",
                    glw::error_name(error)
                );
                is_ok = false;
                continue;
            }
            if parameter_legacy != parameter_dsa {
                log::info!(
                    "{parameter_dsa}, but {parameter_legacy} was expected for GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE parameter name of {what}."
                );
                is_ok = false;
                continue;
            }

            if parameter_dsa != glw::GL_NONE as glw::GLint {
                for (pname, pname_string) in optional_pnames {
                    if *attachment == glw::GL_DEPTH_STENCIL_ATTACHMENT
                        && *pname == glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE
                    {
                        continue;
                    }

                    let (optional_legacy, error, optional_dsa) =
                        Self::query_pair(gl, framebuffer, *attachment, *pname)?;
                    if let Some(error) = error {
                        log::info!(
                            "{} error when called with {pname_string} parameter name for {attachment_string} attachment of {what}. The GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE was {parameter_dsa}.",
                            glw::error_name(error)
                        );
                        is_ok = false;
                        continue;
                    }
                    if optional_legacy != optional_dsa {
                        log::info!(
                            "{optional_dsa}, but {optional_legacy} was expected for {pname_string} parameter name for {attachment_string} attachment of {what}."
                        );
                        is_ok = false;
                        continue;
                    }
                }
            }
        }
        Ok(is_ok)
    }

    fn create_renderbuffer_framebuffer(
        gl: &glw::Functions,
        o: &mut AttachmentParametersObjects,
        depth: bool,
        stencil: bool,
    ) -> Result<(), TestError> {
        // SAFETY: names are written to live fields and then used as C++ does.
        unsafe {
            gl.gen_framebuffers(1, &mut o.fbo);
            glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, o.fbo);
            glu::expect_no_error(gl, "glBindFramebuffers has failed")?;
            gl.gen_renderbuffers(2, o.rbo.as_mut_ptr());
            glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, o.rbo[0]);
            glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 1, 2);
            glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                o.rbo[0],
            );
            glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;

            let second = match (depth, stencil) {
                (true, false) => Some((glw::GL_DEPTH_COMPONENT24, glw::GL_DEPTH_ATTACHMENT)),
                (false, true) => Some((glw::GL_STENCIL_INDEX8, glw::GL_STENCIL_ATTACHMENT)),
                (true, true) => Some((glw::GL_DEPTH24_STENCIL8, glw::GL_DEPTH_STENCIL_ATTACHMENT)),
                (false, false) => None,
            };
            if let Some((internalformat, attachment)) = second {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, o.rbo[1]);
                glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, internalformat, 1, 2);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_renderbuffer(glw::GL_FRAMEBUFFER, attachment, glw::GL_RENDERBUFFER, o.rbo[1]);
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
            }

            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                log::info!("Framebuffer was incomplete.");
                return Err(TestError::Fail("incomplete framebuffer".to_string()));
            }
        }
        Ok(())
    }

    fn create_texture_framebuffer(
        gl: &glw::Functions,
        o: &mut AttachmentParametersObjects,
        depth: bool,
        stencil: bool,
    ) -> Result<(), TestError> {
        // SAFETY: names are written to live fields and then used as C++ does.
        unsafe {
            gl.gen_framebuffers(1, &mut o.fbo);
            glu::expect_no_error(gl, "glGenFramebuffers has failed")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, o.fbo);
            glu::expect_no_error(gl, "glBindFramebuffers has failed")?;
            gl.gen_textures(2, o.to.as_mut_ptr());
            glu::expect_no_error(gl, "glGenRenderbuffers has failed")?;
            gl.bind_texture(glw::GL_TEXTURE_2D, o.to[0]);
            glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 1, 2);
            glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                o.to[0],
                0,
            );
            glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;

            let second = match (depth, stencil) {
                (true, false) => Some((glw::GL_DEPTH_COMPONENT24, glw::GL_DEPTH_ATTACHMENT)),
                (false, true) => Some((glw::GL_STENCIL_INDEX8, glw::GL_STENCIL_ATTACHMENT)),
                (true, true) => Some((glw::GL_DEPTH24_STENCIL8, glw::GL_DEPTH_STENCIL_ATTACHMENT)),
                (false, false) => None,
            };
            if let Some((internalformat, attachment)) = second {
                gl.bind_texture(glw::GL_TEXTURE_2D, o.to[1]);
                glu::expect_no_error(gl, "glBindRenderbuffers has failed")?;
                gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, internalformat, 1, 2);
                glu::expect_no_error(gl, "glRenderbufferStorage has failed")?;
                gl.framebuffer_texture_2d(glw::GL_FRAMEBUFFER, attachment, glw::GL_TEXTURE_2D, o.to[1], 0);
                glu::expect_no_error(gl, "glFramebufferRenderbuffer has failed")?;
            }

            if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                log::info!("Framebuffer was incomplete.");
                return Err(TestError::Fail("incomplete framebuffer".to_string()));
            }
        }
        Ok(())
    }

    fn clean(gl: &glw::Functions, o: &mut AttachmentParametersObjects) {
        // SAFETY: deletes names created by the test.
        unsafe {
            if o.fbo != 0 {
                gl.delete_framebuffers(1, &o.fbo);
                o.fbo = 0;
            }
            for rbo in &mut o.rbo {
                if *rbo != 0 {
                    gl.delete_renderbuffers(1, rbo);
                    *rbo = 0;
                }
            }
            for to in &mut o.to {
                if *to != 0 {
                    gl.delete_textures(1, to);
                    *to = 0;
                }
            }
        }
        clean_errors(gl);
    }
}

impl TestCase for FramebuffersGetAttachmentParametersTest {
    fn name(&self) -> &str {
        "framebuffers_get_attachment_parameters"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = AttachmentParametersObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            let renderbuffer = "renderbuffer framebuffer object";
            let texture = "texture framebuffer object";

            // SAFETY: plain state change.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };
            glu::expect_no_error(gl, "glBindFramebuffers has failed")?;
            is_ok &= Self::test_framebuffer(
                gl,
                0,
                "default framebuffer",
                &Self::DEFAULT_ATTACHMENTS,
                &Self::COLOR_AND_SIZE_PNAMES,
                false,
            )?;

            for (depth, stencil, depth_stencil) in [(true, false, false), (false, true, false), (true, true, true)] {
                Self::create_renderbuffer_framebuffer(gl, &mut objects, depth, stencil)?;
                is_ok &= Self::test_framebuffer(
                    gl,
                    objects.fbo,
                    renderbuffer,
                    &Self::OBJECT_ATTACHMENTS,
                    &Self::RENDERBUFFER_PNAMES,
                    depth_stencil,
                )?;
                Self::clean(gl, &mut objects);
            }
            for (depth, stencil, depth_stencil) in [(true, false, false), (false, true, false), (true, true, true)] {
                Self::create_texture_framebuffer(gl, &mut objects, depth, stencil)?;
                is_ok &= Self::test_framebuffer(
                    gl,
                    objects.fbo,
                    texture,
                    &Self::OBJECT_ATTACHMENTS,
                    &Self::TEXTURE_PNAMES,
                    depth_stencil,
                )?;
                Self::clean(gl, &mut objects);
            }
            Ok(is_ok)
        });
        Self::clean(gl, &mut objects);
        outcome
    }
}

// ------------------------------------------------------------------------------------------------------------------

/// `Framebuffers::FunctionalTest`
struct FramebuffersFunctionalTest;

#[derive(Default)]
struct FunctionalObjects {
    fbo_1st: glw::GLuint,
    fbo_2nd: glw::GLuint,
    rbo_color: glw::GLuint,
    rbo_depth_stencil: glw::GLuint,
    to_color: glw::GLuint,
    po: glw::GLuint,
    vao_stencil_pass_quad: glw::GLuint,
    vao_depth_pass_quad: glw::GLuint,
    vao_color_pass_quad: glw::GLuint,
    bo_stencil_pass_quad: glw::GLuint,
    bo_depth_pass_quad: glw::GLuint,
    bo_color_pass_quad: glw::GLuint,
}

impl FramebuffersFunctionalTest {
    const VERTEX_SHADER: &'static str =
        "#version 330\n\nin vec3 position;\n\nvoid main()\n{\n    gl_Position = vec4(position, 1.0);\n}\n";
    const FRAGMENT_SHADER: &'static str =
        "#version 330\n\nout vec4 color;\n\nvoid main()\n{\n    color = vec4(1.0);\n}\n";
    const STENCIL_PASS_QUAD: [glw::GLfloat; 12] = [-0.5, -0.5, 0.5, -0.5, 0.5, 0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 0.5];
    const DEPTH_PASS_QUAD: [glw::GLfloat; 12] = [-1.0, -1.0, 1.0, -1.0, 1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0];
    const COLOR_PASS_QUAD: [glw::GLfloat; 12] = [-1.0, -1.0, 0.0, -1.0, 1.0, 0.0, 1.0, -1.0, 0.0, 1.0, 1.0, 0.0];

    /// Upstream swallows every failure here and reports only `false`.
    fn prepare_first_framebuffer(gl: &glw::Functions, o: &mut FunctionalObjects) -> bool {
        let result = (|| -> Result<(), TestError> {
            // SAFETY: names are written to live fields and then used as C++ does.
            unsafe {
                gl.create_framebuffers(1, &mut o.fbo_1st);
                glu::expect_no_error(gl, "glCreateFramebuffers has failed")?;
                gl.create_renderbuffers(1, &mut o.rbo_color);
                gl.create_renderbuffers(1, &mut o.rbo_depth_stencil);
                glu::expect_no_error(gl, "glCreateRenderbuffers has failed")?;
                gl.named_renderbuffer_storage(o.rbo_color, glw::GL_R8, 8, 8);
                gl.named_renderbuffer_storage(o.rbo_depth_stencil, glw::GL_DEPTH24_STENCIL8, 8, 8);
                glu::expect_no_error(gl, "glNamedRenderbufferStorage has failed")?;
                gl.named_framebuffer_renderbuffer(
                    o.fbo_1st,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    o.rbo_color,
                );
                gl.named_framebuffer_renderbuffer(
                    o.fbo_1st,
                    glw::GL_DEPTH_STENCIL_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    o.rbo_depth_stencil,
                );
                glu::expect_no_error(gl, "glNamedFramebufferRenderbuffer has failed")?;
                if gl.check_named_framebuffer_status(o.fbo_1st, glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                    log::info!("First framebuffer was incomplete.");
                    return Err(TestError::Fail("incomplete framebuffer".to_string()));
                }
            }
            Ok(())
        })();
        result.is_ok()
    }

    fn prepare_second_framebuffer(gl: &glw::Functions, o: &mut FunctionalObjects) -> Result<bool, TestError> {
        // SAFETY: names are written to live fields and then used as C++ does.
        unsafe {
            gl.gen_textures(1, &mut o.to_color);
            glu::expect_no_error(gl, "glGenTextures has failed")?;
            gl.bind_texture(glw::GL_TEXTURE_2D, o.to_color);
            glu::expect_no_error(gl, "glBindTexture has failed")?;
            gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R8, 4, 3);
            glu::expect_no_error(gl, "glTexStorage2D has failed")?;
        }

        let result = (|| -> Result<(), TestError> {
            // SAFETY: names are written to live fields and then used as C++ does.
            unsafe {
                gl.create_framebuffers(1, &mut o.fbo_2nd);
                glu::expect_no_error(gl, "glCreateFramebuffers has failed")?;
                gl.named_framebuffer_texture(o.fbo_2nd, glw::GL_COLOR_ATTACHMENT0, o.to_color, 0);
                glu::expect_no_error(gl, "glNamedFramebufferTexture has failed")?;
                if gl.check_named_framebuffer_status(o.fbo_2nd, glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                    log::info!("Second framebuffer was incomplete.");
                    return Err(TestError::Fail("incomplete framebuffer".to_string()));
                }
            }
            Ok(())
        })();
        Ok(result.is_ok())
    }

    fn clear_framebuffers(gl: &glw::Functions, o: &FunctionalObjects) -> bool {
        let result = (|| -> Result<(), TestError> {
            let color_value = [0.0 as glw::GLfloat; 4];
            // SAFETY: the array holds four floats.
            unsafe {
                gl.clear_named_framebufferfv(o.fbo_1st, glw::GL_COLOR, 0, color_value.as_ptr());
                glu::expect_no_error(gl, "glClearNamedFramebufferfv has failed")?;
                gl.clear_named_framebufferfi(o.fbo_1st, glw::GL_DEPTH_STENCIL, 0, 0.0, 0);
                glu::expect_no_error(gl, "glClearNamedFramebufferfi has failed")?;
                gl.clear_named_framebufferfv(o.fbo_1st, glw::GL_COLOR, 0, color_value.as_ptr());
                glu::expect_no_error(gl, "glClearNamedFramebufferfv has failed")?;
            }
            Ok(())
        })();
        result.is_ok()
    }

    /// `PrepareProgram`: a failure leaves `po` at zero and is rethrown.
    fn prepare_program(gl: &glw::Functions, o: &mut FunctionalObjects) -> Result<(), TestError> {
        let result = (|| -> Result<(), TestError> {
            // SAFETY: plain object creation with a current context.
            o.po = unsafe { gl.create_program() };
            glu::expect_no_error(gl, "glCreateProgram call failed.")?;

            let mut shaders = Vec::new();
            for (source, shader_type) in [
                (Self::VERTEX_SHADER, glw::GL_VERTEX_SHADER),
                (Self::FRAGMENT_SHADER, glw::GL_FRAGMENT_SHADER),
            ] {
                let shader = Shader::new(gl, shader_type)?;
                // SAFETY: both objects are alive.
                unsafe { gl.attach_shader(o.po, shader.id) };
                glu::expect_no_error(gl, "glAttachShader call failed.")?;
                shader.source(&[source])?;
                if !shader.compile()? {
                    log::info!("Shader type {shader_type:#x} compilation failed. Shader source code:\n{source}");
                    return Err(TestError::Fail("shader compilation failed".to_string()));
                }
                shaders.push(shader);
            }

            // SAFETY: the program is alive.
            unsafe { gl.link_program(o.po) };
            glu::expect_no_error(gl, "glTransformFeedbackVaryings call failed.")?;
            let mut status = glw::GL_FALSE as glw::GLint;
            // SAFETY: writes one integer to the live local.
            unsafe { gl.get_programiv(o.po, glw::GL_LINK_STATUS, &mut status) };
            if status == glw::GL_TRUE as glw::GLint {
                for shader in &shaders {
                    // SAFETY: both objects are alive.
                    unsafe { gl.detach_shader(o.po, shader.id) };
                    glu::expect_no_error(gl, "glDetachShader call failed.")?;
                }
            } else {
                log::info!("Program linking failed.");
                return Err(TestError::Fail("program link failed".to_string()));
            }
            Ok(())
        })();

        if result.is_err() && o.po != 0 {
            // SAFETY: deletes the program created above.
            unsafe { gl.delete_program(o.po) };
            o.po = 0;
        }
        if o.po == 0 {
            return Err(TestError::Fail("no program".to_string()));
        }
        Ok(())
    }

    fn prepare_one_quad(
        gl: &glw::Functions,
        program_attribute: glw::GLuint,
        vao: &mut glw::GLuint,
        bo: &mut glw::GLuint,
        quad: &[glw::GLfloat; 12],
    ) -> Result<(), TestError> {
        // SAFETY: names are written to live fields; the buffer data is the live array.
        unsafe {
            gl.gen_vertex_arrays(1, vao);
            glu::expect_no_error(gl, "glGenVertexArrays call failed.")?;
            gl.bind_vertex_array(*vao);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            gl.gen_buffers(1, bo);
            glu::expect_no_error(gl, "glGenBuffers call failed.")?;
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, *bo);
            glu::expect_no_error(gl, "glBindBuffers call failed.")?;
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of_val(quad) as glw::GLsizeiptr,
                quad.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
            glu::expect_no_error(gl, "glBufferData call failed.")?;
            gl.vertex_attrib_pointer(program_attribute, 3, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            glu::expect_no_error(gl, "glVertexAttribPointer call failed.")?;
            gl.enable_vertex_attrib_array(program_attribute);
            glu::expect_no_error(gl, "glEnableVertexAttribArray call failed.")?;
        }
        Ok(())
    }

    fn prepare_buffers_and_vertex_arrays(gl: &glw::Functions, o: &mut FunctionalObjects) -> Result<(), TestError> {
        let attribute = CString::new("position").expect("no NUL in the name");
        // SAFETY: the name is a live NUL-terminated string.
        let program_attribute = unsafe { gl.get_attrib_location(o.po, attribute.as_ptr()) } as glw::GLuint;
        glu::expect_no_error(gl, "glGetAttribLocation call failed.")?;

        Self::prepare_one_quad(
            gl,
            program_attribute,
            &mut o.vao_stencil_pass_quad,
            &mut o.bo_stencil_pass_quad,
            &Self::STENCIL_PASS_QUAD,
        )?;
        Self::prepare_one_quad(
            gl,
            program_attribute,
            &mut o.vao_depth_pass_quad,
            &mut o.bo_depth_pass_quad,
            &Self::DEPTH_PASS_QUAD,
        )?;
        Self::prepare_one_quad(
            gl,
            program_attribute,
            &mut o.vao_color_pass_quad,
            &mut o.bo_color_pass_quad,
            &Self::COLOR_PASS_QUAD,
        )
    }

    fn draw_and_blit(gl: &glw::Functions, o: &FunctionalObjects) -> Result<bool, TestError> {
        // SAFETY: plain state changes and draws into the framebuffers created by the test.
        unsafe {
            gl.use_program(o.po);
            glu::expect_no_error(gl, "glUseProgram call failed.")?;
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, o.fbo_1st);
            glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
            gl.viewport(0, 0, 8, 8);
            glu::expect_no_error(gl, "glViewport call failed.")?;

            gl.bind_vertex_array(o.vao_stencil_pass_quad);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            gl.stencil_func(glw::GL_NEVER, 0, 0xff);
            glu::expect_no_error(gl, "glStencilFunc call failed.")?;
            gl.stencil_op(glw::GL_INCR, glw::GL_KEEP, glw::GL_KEEP);
            glu::expect_no_error(gl, "glStencilOp call failed.")?;
            gl.stencil_mask(0xff);
            glu::expect_no_error(gl, "glStencilMask call failed.")?;
            gl.color_mask(glw::FALSE, glw::FALSE, glw::FALSE, glw::FALSE);
            glu::expect_no_error(gl, "glColorMask call failed.")?;
            gl.depth_mask(glw::FALSE);
            glu::expect_no_error(gl, "glDepthMask call failed.")?;
            gl.enable(glw::GL_STENCIL_TEST);
            glu::expect_no_error(gl, "glEnable call failed.")?;
            gl.disable(glw::GL_DEPTH_TEST);
            glu::expect_no_error(gl, "glEnable call failed.")?;
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
            glu::expect_no_error(gl, "glDrawArrays call failed.")?;

            gl.bind_vertex_array(o.vao_depth_pass_quad);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            gl.stencil_func(glw::GL_ALWAYS, 0, 0xff);
            glu::expect_no_error(gl, "glStencilFunc call failed.")?;
            gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);
            glu::expect_no_error(gl, "glStencilOp call failed.")?;
            gl.stencil_mask(0xff);
            glu::expect_no_error(gl, "glStencilMask call failed.")?;
            gl.depth_func(glw::GL_ALWAYS);
            glu::expect_no_error(gl, "glDepthFunc call failed.")?;
            gl.disable(glw::GL_STENCIL_TEST);
            glu::expect_no_error(gl, "glDisable call failed.")?;
            gl.enable(glw::GL_DEPTH_TEST);
            glu::expect_no_error(gl, "glEnable call failed.")?;
            gl.depth_mask(glw::TRUE);
            glu::expect_no_error(gl, "glDepthMask call failed.")?;
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
            glu::expect_no_error(gl, "glDrawArrays call failed.")?;

            gl.bind_vertex_array(o.vao_color_pass_quad);
            glu::expect_no_error(gl, "glBindVertexArray call failed.")?;
            gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
            glu::expect_no_error(gl, "glColorMask call failed.")?;
            gl.stencil_func(glw::GL_EQUAL, 1, 0xff);
            glu::expect_no_error(gl, "glStencilFunc call failed.")?;
            gl.enable(glw::GL_STENCIL_TEST);
            glu::expect_no_error(gl, "glEnable call failed.")?;
            gl.enable(glw::GL_DEPTH_TEST);
            glu::expect_no_error(gl, "glEnable call failed.")?;
            gl.depth_func(glw::GL_GREATER);
            glu::expect_no_error(gl, "glDepthFunc call failed.")?;
            gl.depth_mask(glw::FALSE);
            glu::expect_no_error(gl, "glDepthMask call failed.")?;
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
            glu::expect_no_error(gl, "glDrawArrays call failed.")?;

            gl.blit_named_framebuffer(
                o.fbo_1st,
                o.fbo_2nd,
                0,
                0,
                8,
                8,
                0,
                0,
                4,
                3,
                glw::GL_COLOR_BUFFER_BIT,
                glw::GL_NEAREST,
            );
            if gl.get_error() != glw::GL_NO_ERROR {
                return Ok(false);
            }
        }
        Ok(true)
    }

    fn check_second_framebuffer_content(gl: &glw::Functions, o: &FunctionalObjects) -> Result<bool, TestError> {
        const REFERENCE_VALUES: [[glw::GLubyte; 4]; 3] = [[0, 0, 0, 0], [0, 0, 255, 0], [0, 0, 0, 0]];

        // SAFETY: plain state change.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, o.fbo_2nd) };
        glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;

        let mut framebuffer_values = [[0 as glw::GLubyte; 4]; 3];
        // SAFETY: the array holds 4x3 bytes.
        unsafe {
            gl.read_pixels(
                0,
                0,
                4,
                3,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                framebuffer_values.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glReadPixels call failed.")?;

        Ok(REFERENCE_VALUES == framebuffer_values)
    }

    fn clean(gl: &glw::Functions, o: &mut FunctionalObjects) {
        // SAFETY: deletes names created by the test; the vertex arrays are deleted with `glDeleteBuffers` as upstream does.
        unsafe {
            for fbo in [&mut o.fbo_1st, &mut o.fbo_2nd] {
                if *fbo != 0 {
                    gl.delete_framebuffers(1, fbo);
                    *fbo = 0;
                }
            }
            for rbo in [&mut o.rbo_color, &mut o.rbo_depth_stencil] {
                if *rbo != 0 {
                    gl.delete_renderbuffers(1, rbo);
                    *rbo = 0;
                }
            }
            if o.to_color != 0 {
                gl.delete_textures(1, &o.to_color);
                o.to_color = 0;
            }
            if o.po != 0 {
                gl.use_program(0);
                gl.delete_program(o.po);
                o.po = 0;
            }
            for name in [
                &mut o.vao_stencil_pass_quad,
                &mut o.vao_depth_pass_quad,
                &mut o.vao_color_pass_quad,
                &mut o.bo_stencil_pass_quad,
                &mut o.bo_depth_pass_quad,
                &mut o.bo_color_pass_quad,
            ] {
                if *name != 0 {
                    gl.delete_buffers(1, name);
                    *name = 0;
                }
            }

            gl.stencil_func(glw::GL_ALWAYS, 0, 0xff);
            gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);
            gl.stencil_mask(0xff);
            gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
            gl.depth_func(glw::GL_LESS);
            gl.depth_mask(glw::TRUE);
            gl.disable(glw::GL_STENCIL_TEST);
            gl.disable(glw::GL_DEPTH_TEST);
        }
        clean_errors(gl);
    }
}

impl TestCase for FramebuffersFunctionalTest {
    fn name(&self) -> &str {
        "framebuffers_renderbuffers_functional"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut objects = FunctionalObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            is_ok &= Self::prepare_first_framebuffer(gl, &mut objects);
            is_ok &= Self::prepare_second_framebuffer(gl, &mut objects)?;
            is_ok &= Self::clear_framebuffers(gl, &objects);
            Self::prepare_program(gl, &mut objects)?;
            Self::prepare_buffers_and_vertex_arrays(gl, &mut objects)?;
            is_ok &= Self::draw_and_blit(gl, &objects)?;
            is_ok &= Self::check_second_framebuffer_content(gl, &objects)?;
            Ok(is_ok)
        });
        Self::clean(gl, &mut objects);
        outcome
    }
}

/// The `Framebuffers` cases in upstream order, to be registered between `buffers_defaults` and `renderbuffers_creation`.
pub(super) fn add_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(FramebuffersCreationTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersRenderbufferAttachmentTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersTextureAttachmentTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersTextureLayerAttachmentTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersDrawReadBufferTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersDrawBuffersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersInvalidateTest(InvalidateKind::Data)) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersInvalidateTest(InvalidateKind::SubData)) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersClearTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersBlitTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersCheckStatusTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersGetParametersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersGetAttachmentParametersTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersCreationErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersRenderbufferAttachmentErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersTextureAttachmentErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersDrawReadBuffersErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersInvalidateDataAndSubDataErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersClearErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersCheckStatusErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersGetParameterErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersGetAttachmentParameterErrorsTest) as Box<dyn TestCase>);
    group.add_child(Box::new(FramebuffersFunctionalTest) as Box<dyn TestCase>);
}
