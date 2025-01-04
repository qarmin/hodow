// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboCompletenessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. See the ES2 file for why the format
// tables are transcribed entry for entry.

use std::sync::Arc;

use crate::gls::fbo_completeness_tests::{
    self as fboc, BuildCtx, FboCompletenessCase, FboSetup, FbocContext, MultiColorAtts,
};
use crate::gls::fbo_util::{
    Attachment, COLOR_RENDERABLE, Checker, CheckerState, DEPTH_RENDERABLE, FboBuilder, FormatDb, FormatEntry,
    FormatExtEntry, Image, ImageFormat, RENDERBUFFER_VALID, REQUIRED_RENDERABLE, STENCIL_RENDERABLE, TEXTURE_VALID,
};
use crate::glu::{Context, TestCaseGroup};
use crate::glw::{self, GLenum, GLsizei, GLuint};
use crate::tcu::TestError;

const fn sized(format: GLenum) -> ImageFormat {
    ImageFormat::sized(format)
}

const fn unsized_format(format: GLenum, unsized_type: GLenum) -> ImageFormat {
    ImageFormat::unsized_format(format, unsized_type)
}

// GLES3, 4.4.4: "An internal format is color-renderable if it is one of the formats from
// table 3.12 noted as color-renderable..."
const ES3_COLOR_RENDERABLES: &[ImageFormat] = &[
    sized(glw::GL_R8),
    sized(glw::GL_RG8),
    sized(glw::GL_RGB8),
    sized(glw::GL_RGB565),
    sized(glw::GL_RGBA4),
    sized(glw::GL_RGB5_A1),
    sized(glw::GL_RGBA8),
    sized(glw::GL_RGB10_A2),
    sized(glw::GL_RGB10_A2UI),
    sized(glw::GL_SRGB8_ALPHA8),
    sized(glw::GL_R8I),
    sized(glw::GL_R8UI),
    sized(glw::GL_R16I),
    sized(glw::GL_R16UI),
    sized(glw::GL_R32I),
    sized(glw::GL_R32UI),
    sized(glw::GL_RG8I),
    sized(glw::GL_RG8UI),
    sized(glw::GL_RG16I),
    sized(glw::GL_RG16UI),
    sized(glw::GL_RG32I),
    sized(glw::GL_RG32UI),
    sized(glw::GL_RGBA8I),
    sized(glw::GL_RGBA8UI),
    sized(glw::GL_RGBA16I),
    sized(glw::GL_RGBA16UI),
    sized(glw::GL_RGBA32I),
    sized(glw::GL_RGBA32UI),
];

// "...or if it is unsized format RGBA or RGB." See Table 3.3 in GLES3.
const ES3_UNSIZED_COLOR_RENDERABLES: &[ImageFormat] = &[
    unsized_format(glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
    unsized_format(glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_4_4_4_4),
    unsized_format(glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_5_5_1),
    unsized_format(glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
    unsized_format(glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_6_5),
];

// GLES3, 4.4.4: "An internal format is depth-renderable if it is one of the formats from
// table 3.13."
const ES3_DEPTH_RENDERABLES: &[ImageFormat] = &[
    sized(glw::GL_DEPTH_COMPONENT16),
    sized(glw::GL_DEPTH_COMPONENT24),
    sized(glw::GL_DEPTH_COMPONENT32F),
    sized(glw::GL_DEPTH24_STENCIL8),
    sized(glw::GL_DEPTH32F_STENCIL8),
];

// GLES3, 4.4.4: "An internal format is stencil-renderable if it is STENCIL_INDEX8..."
const ES3_STENCIL_RBO_RENDERABLES: &[ImageFormat] = &[sized(glw::GL_STENCIL_INDEX8)];

// "...or one of the formats from table 3.13 whose base internal format is DEPTH_STENCIL."
const ES3_STENCIL_RENDERABLES: &[ImageFormat] = &[sized(glw::GL_DEPTH24_STENCIL8), sized(glw::GL_DEPTH32F_STENCIL8)];

const ES3_TEXTURE_FLOAT_FORMATS: &[ImageFormat] = &[
    sized(glw::GL_RGBA32F),
    sized(glw::GL_RGBA16F),
    sized(glw::GL_R11F_G11F_B10F),
    sized(glw::GL_RG32F),
    sized(glw::GL_RG16F),
    sized(glw::GL_R32F),
    sized(glw::GL_R16F),
    sized(glw::GL_RGBA16F),
    sized(glw::GL_RGB16F),
    sized(glw::GL_RG16F),
    sized(glw::GL_R16F),
];

const ES3_NOT_RENDERABLE_TEXTURE_FORMATS: &[ImageFormat] = &[
    sized(glw::GL_R8_SNORM),
    sized(glw::GL_RG8_SNORM),
    sized(glw::GL_RGB8_SNORM),
    sized(glw::GL_RGBA8_SNORM),
    sized(glw::GL_RGB9_E5),
    sized(glw::GL_SRGB8),
    sized(glw::GL_RGB8I),
    sized(glw::GL_RGB16I),
    sized(glw::GL_RGB32I),
    sized(glw::GL_RGB8UI),
    sized(glw::GL_RGB16UI),
    sized(glw::GL_RGB32UI),
];

static ES3_FORMATS: &[FormatEntry] = &[
    // Renderbuffers don't support unsized formats.
    FormatEntry {
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | TEXTURE_VALID,
        formats: ES3_UNSIZED_COLOR_RENDERABLES,
    },
    FormatEntry {
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID | TEXTURE_VALID,
        formats: ES3_COLOR_RENDERABLES,
    },
    FormatEntry {
        flags: REQUIRED_RENDERABLE | DEPTH_RENDERABLE | RENDERBUFFER_VALID | TEXTURE_VALID,
        formats: ES3_DEPTH_RENDERABLES,
    },
    FormatEntry {
        flags: REQUIRED_RENDERABLE | STENCIL_RENDERABLE | RENDERBUFFER_VALID,
        formats: ES3_STENCIL_RBO_RENDERABLES,
    },
    FormatEntry {
        flags: REQUIRED_RENDERABLE | STENCIL_RENDERABLE | RENDERBUFFER_VALID | TEXTURE_VALID,
        formats: ES3_STENCIL_RENDERABLES,
    },
    FormatEntry {
        flags: TEXTURE_VALID,
        formats: ES3_NOT_RENDERABLE_TEXTURE_FORMATS,
    },
    // These are not color-renderable in vanilla ES3, but they must be marked valid for
    // textures, since EXT_color_buffer_(half_)float brings in color-renderability and
    // only renderbuffer-validity.
    FormatEntry {
        flags: TEXTURE_VALID,
        formats: ES3_TEXTURE_FLOAT_FORMATS,
    },
];

// GL_EXT_color_buffer_float
const EXT_COLOR_BUFFER_FLOAT_FORMATS: &[ImageFormat] = &[
    sized(glw::GL_RGBA32F),
    sized(glw::GL_RGBA16F),
    sized(glw::GL_R11F_G11F_B10F),
    sized(glw::GL_RG32F),
    sized(glw::GL_RG16F),
    sized(glw::GL_R32F),
    sized(glw::GL_R16F),
];

// GL_QCOM_render_shared_exponent
const QCOM_RENDER_SHARED_EXPONENT: &[ImageFormat] = &[sized(glw::GL_RGB9_E5)];

// GL_OES_texture_stencil8
const EXT_OES_TEXTURE_STENCIL8: &[ImageFormat] = &[sized(glw::GL_STENCIL_INDEX8)];

// GL_EXT_render_snorm
const EXT_RENDER_SNORM: &[ImageFormat] = &[
    sized(glw::GL_R8_SNORM),
    sized(glw::GL_RG8_SNORM),
    sized(glw::GL_RGBA8_SNORM),
];

static ES3_EXT_FORMATS: &[FormatExtEntry] = &[
    // These are already texture-valid in ES3; the extension just adds RBO support and
    // makes them color-renderable.
    FormatExtEntry {
        extensions: "GL_EXT_color_buffer_float",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID,
        formats: EXT_COLOR_BUFFER_FLOAT_FORMATS,
    },
    // The es3 RBO tests actually cover the first two requirements - kept here for
    // completeness.
    FormatExtEntry {
        extensions: "GL_OES_texture_stencil8",
        flags: REQUIRED_RENDERABLE | STENCIL_RENDERABLE | TEXTURE_VALID,
        formats: EXT_OES_TEXTURE_STENCIL8,
    },
    FormatExtEntry {
        extensions: "GL_EXT_render_snorm",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | TEXTURE_VALID | RENDERBUFFER_VALID,
        formats: EXT_RENDER_SNORM,
    },
    // RGB9_E5 is already texture-valid in ES3; the extension just adds RBO support and
    // makes it color-renderable.
    FormatExtEntry {
        extensions: "GL_QCOM_render_shared_exponent",
        flags: REQUIRED_RENDERABLE | COLOR_RENDERABLE | RENDERBUFFER_VALID | TEXTURE_VALID,
        formats: QCOM_RENDER_SHARED_EXPONENT,
    },
];

/// `ES3Checker`
#[derive(Default)]
struct Es3Checker {
    /// The common number of samples of images.
    num_samples: Option<GLsizei>,
    /// The common image for depth and stencil attachments.
    depth_stencil: Option<(GLuint, GLenum, ImageFormat)>,
}

impl Checker for Es3Checker {
    fn check(
        &mut self,
        state: &mut CheckerState,
        context: &Context,
        formats: &FormatDb,
        att_point: GLenum,
        att: &Attachment,
        image: &Image,
    ) {
        let img_samples = image.num_samples();

        match self.num_samples {
            None => self.num_samples = Some(img_samples),
            Some(num_samples) => {
                // GLES3: "The value of RENDERBUFFER_SAMPLES is the same for all attached
                // renderbuffers and, if the attached images are a mix of renderbuffers
                // and textures, the value of RENDERBUFFER_SAMPLES is zero."
                //
                // On creating a renderbuffer: "If _samples_ is zero, then
                // RENDERBUFFER_SAMPLES is set to zero. Otherwise [...] the resulting
                // value for RENDERBUFFER_SAMPLES is guaranteed to be greater than or
                // equal to _samples_ and no more than the next larger sample count
                // supported by the implementation."

                // Either all attachments are zero-sample renderbuffers and/or textures,
                // or none of them are.
                if (num_samples == 0) != (img_samples == 0) {
                    state.add_fbo_status(glw::GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE);
                }

                // If the attachments requested a different number of samples, the
                // implementation is allowed to report this as incomplete. However, it is
                // also possible that despite the different requests, the implementation
                // allocated the same number of samples to both, so reporting the
                // framebuffer as complete is also legal.
                if num_samples != img_samples {
                    state.add_potential_fbo_status(glw::GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE);
                }
            }
        }

        if att_point == glw::GL_DEPTH_ATTACHMENT || att_point == glw::GL_STENCIL_ATTACHMENT {
            match self.depth_stencil {
                None => self.depth_stencil = Some((att.image_name(), att.attachment_type(), image.internal_format())),
                Some((image_name, att_type, format)) => {
                    if image_name != att.image_name() || att_type != att.attachment_type() {
                        // "Depth and stencil attachments, if present, are the same image."
                        if !context
                            .context_info
                            .is_extension_supported("GL_EXT_separate_depth_stencil")
                        {
                            state.add_fbo_status(glw::GL_FRAMEBUFFER_UNSUPPORTED);
                        }

                        // "The combination of internal formats of the attached images
                        // does not violate an implementation-dependent set of
                        // restrictions."
                        let depth_format = if att_point == glw::GL_DEPTH_ATTACHMENT {
                            image.internal_format()
                        } else {
                            format
                        };
                        let stencil_format = if att_point == glw::GL_STENCIL_ATTACHMENT {
                            image.internal_format()
                        } else {
                            format
                        };

                        if formats.format_info(depth_format) & STENCIL_RENDERABLE != 0 {
                            state.add_potential_fbo_status(glw::GL_FRAMEBUFFER_UNSUPPORTED);
                        }
                        if formats.format_info(stencil_format) & DEPTH_RENDERABLE != 0 {
                            state.add_potential_fbo_status(glw::GL_FRAMEBUFFER_UNSUPPORTED);
                        }
                    }
                }
            }
        }
    }
}

fn make_checker() -> Box<dyn Checker> {
    Box::<Es3Checker>::default()
}

/// `NumLayersTest`
struct NumLayersTest {
    /// `GL_TEXTURE_3D` or `GL_TEXTURE_2D_ARRAY`.
    texture_kind: GLenum,
    num_layers: GLsizei,
    attachment_layer: GLsizei,
}

impl NumLayersTest {
    /// `NumLayersParams::getName`
    fn name(&self) -> String {
        let kind = if self.texture_kind == glw::GL_TEXTURE_3D {
            "3d"
        } else {
            "2darr"
        };
        format!("{kind}_{}_{}", self.num_layers, self.attachment_layer)
    }
}

impl FboSetup for NumLayersTest {
    fn build(&self, bc: &BuildCtx, builder: &mut FboBuilder) -> Result<(), TestError> {
        let target = glw::GL_COLOR_ATTACHMENT0;
        let internal_format = bc.default_format(target, glw::GL_TEXTURE)?;

        let tex_cfg = match self.texture_kind {
            glw::GL_TEXTURE_3D => Image::Texture3D {
                internal_format,
                width: 64,
                height: 64,
                num_levels: 1,
                num_layers: self.num_layers,
            },
            _ => Image::Texture2DArray {
                internal_format,
                width: 64,
                height: 64,
                num_levels: 1,
                num_layers: self.num_layers,
            },
        };

        let tex = builder.gl_create_texture(tex_cfg);
        builder.gl_attach(
            target,
            Some(Attachment::TextureLayer {
                image_name: tex,
                level: 0,
                layer: self.attachment_layer,
            }),
        );

        Ok(())
    }
}

/// `NumSamplesParams`: `>= 0` is a renderbuffer with N samples.
const SAMPLES_NONE: GLsizei = -2;
const SAMPLES_TEXTURE: GLsizei = -1;

/// `NumSamplesTest`
struct NumSamplesTest {
    num_samples: [GLsizei; 3],
}

impl NumSamplesTest {
    /// `NumSamplesParams::getName`
    fn name(&self) -> String {
        self.num_samples
            .iter()
            .map(|ns| match *ns {
                SAMPLES_NONE => "none".to_string(),
                SAMPLES_TEXTURE => "tex".to_string(),
                ns => format!("rbo{ns}"),
            })
            .collect::<Vec<_>>()
            .join("_")
    }
}

impl FboSetup for NumSamplesTest {
    fn build(&self, bc: &BuildCtx, builder: &mut FboBuilder) -> Result<(), TestError> {
        const TARGETS: [GLenum; 3] = [
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_COLOR_ATTACHMENT1,
            glw::GL_DEPTH_ATTACHMENT,
        ];
        // Non-integer formats for each attachment type.
        const FORMATS: [GLenum; 3] = [glw::GL_RGBA8, glw::GL_RGB565, glw::GL_DEPTH_COMPONENT24];

        for i in 0..TARGETS.len() {
            let target = TARGETS[i];
            let fmt = ImageFormat::sized(FORMATS[i]);
            let ns = self.num_samples[i];

            if ns == SAMPLES_NONE {
                continue;
            }

            if ns == SAMPLES_TEXTURE {
                bc.attach_target_to_new(target, glw::GL_TEXTURE, fmt, 64, 64, builder)?;
            } else {
                let rbo = builder.gl_create_rbo(Image::Renderbuffer {
                    internal_format: fmt,
                    width: 64,
                    height: 64,
                    num_samples: ns,
                });
                // Implementations do not necessarily support sample sizes greater than 1.
                if builder.error() == glw::GL_INVALID_OPERATION {
                    return Err(TestError::NotSupported("Unsupported number of samples".to_string()));
                }
                builder.gl_attach(target, Some(Attachment::Renderbuffer { image_name: rbo }));
            }
        }

        Ok(())
    }
}

/// `TestGroup::init`
pub fn create_tests() -> TestCaseGroup {
    let fboc = Arc::new(FbocContext::new(
        &[ES3_FORMATS],
        &[fboc::ES_EXT_FORMATS, ES3_EXT_FORMATS],
        // Vanilla ES3 has multiple color attachments.
        MultiColorAtts::Core,
        make_checker,
    ));

    let mut group = TestCaseGroup::new("completeness");
    group.add_child(fboc::create_renderable_tests(&fboc));
    group.add_child(fboc::create_attachment_tests(&fboc));
    group.add_child(fboc::create_size_tests(&fboc));

    let mut layer_tests = TestCaseGroup::new("layer");
    // textureKind, numLayers, attachmentLayer
    const LAYER_PARAMS: [(GLenum, GLsizei, GLsizei); 8] = [
        (glw::GL_TEXTURE_2D_ARRAY, 1, 0),
        (glw::GL_TEXTURE_2D_ARRAY, 1, 3),
        (glw::GL_TEXTURE_2D_ARRAY, 4, 3),
        (glw::GL_TEXTURE_2D_ARRAY, 4, 15),
        (glw::GL_TEXTURE_3D, 1, 0),
        (glw::GL_TEXTURE_3D, 1, 15),
        (glw::GL_TEXTURE_3D, 4, 15),
        (glw::GL_TEXTURE_3D, 64, 15),
    ];
    for (texture_kind, num_layers, attachment_layer) in LAYER_PARAMS {
        let test = NumLayersTest {
            texture_kind,
            num_layers,
            attachment_layer,
        };
        layer_tests.add_child(FboCompletenessCase::boxed(test.name(), &fboc, test));
    }
    group.add_child(layer_tests);

    let mut sample_tests = TestCaseGroup::new("samples");
    const SAMPLES_PARAMS: [[GLsizei; 3]; 13] = [
        [0, SAMPLES_NONE, SAMPLES_NONE],
        [1, SAMPLES_NONE, SAMPLES_NONE],
        [2, SAMPLES_NONE, SAMPLES_NONE],
        [0, SAMPLES_TEXTURE, SAMPLES_NONE],
        [1, SAMPLES_TEXTURE, SAMPLES_NONE],
        [2, SAMPLES_TEXTURE, SAMPLES_NONE],
        [2, 1, SAMPLES_NONE],
        [2, 2, SAMPLES_NONE],
        [0, 0, SAMPLES_TEXTURE],
        [1, 2, 0],
        [2, 2, 0],
        [1, 1, 1],
        [1, 2, 4],
    ];
    for num_samples in SAMPLES_PARAMS {
        let test = NumSamplesTest { num_samples };
        sample_tests.add_child(FboCompletenessCase::boxed(test.name(), &fboc, test));
    }
    group.add_child(sample_tests);

    group
}
