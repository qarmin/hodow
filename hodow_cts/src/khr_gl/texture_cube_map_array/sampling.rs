// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArraySampling.cpp
//   external/openglcts/modules/glesext/texture_cube_map_array/esextcTextureCubeMapArraySampling.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop only: `isContextES` is false, so the tessellation evaluation program is never defined (upstream requires a pass-through control shader for it on ES only) and its cases are never run, exactly as upstream behaves on a desktop context. Upstream's compressed-format set (`m_compressed_formats`) is never filled in, so the compressed texture path, its resources header and the TGA dump are not ported. The GL object wrapper classes (bufferDefinition, textureDefinition, shaderDefinition, programDefinition, vertexArrayObjectDefinition) are `GlObject` guards deleting on drop.

use std::ffi::CString;

use super::TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::khr_gl::esext::{ExtParameters, LogType, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `contextTypeIsES` of the render context: the KHR-GL roots are desktop contexts.
const IS_CONTEXT_ES: bool = false;

const N_FACES: u32 = 6;
const N_POINTS_PER_FACE: usize = 9;
const GET_TYPE_API_STATUS_PROGRAM_RESOURCE: GLuint = 0x02;
const GET_TYPE_API_STATUS_UNIFORM: GLuint = 0x01;

const SHADER_CODE_PREAMBLE: &str = "${VERSION}\n${TEXTURE_CUBE_MAP_ARRAY_REQUIRE}\n\n";
const SHADER_PRECISION: &str = "precision highp float;\n";
const TESSELLATION_SHADER_EXTENSION: &str = "${TESSELLATION_SHADER_REQUIRE}\n";
const GEOMETRY_SHADER_EXTENSION: &str = "${GEOMETRY_SHADER_REQUIRE}\n";
const SAMPLER_NAME: &str = "sampler";
const IMAGE_NAME: &str = "image";

const COMPUTE_SHADER_BODY: &str = "void main()\n{\n    const int face_width         = 3;\n    const int face_height        = 3;\n    const int vertices_per_face  = face_width * face_height;\n    const int faces_per_layer    = 6;\n    const int layer_width        = faces_per_layer * face_width;\n    const int vertices_per_layer = vertices_per_face * faces_per_layer;\n\n    ivec2 image_coord            = ivec2(gl_WorkGroupID.xy);\n    ivec3 texture_size           = textureSize(sampler, 0);\n\n    int layer                    = image_coord.x / layer_width;\n    int layer_offset             = layer * layer_width;\n    int layer_index              = layer * vertices_per_layer;\n    int face                     = (image_coord.x - layer_offset) / face_width;\n    int face_offset              = face * face_width;\n    int face_index               = face * vertices_per_face;\n    int vertex                   = image_coord.x - layer_offset - face_offset;\n    int vertex_index             = layer_index + face_index + vertex + (face_height - image_coord.y - 1) * face_width;\n\n";
const COMPUTE_SHADER_LAYOUT: &str = "layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n";
const FRAGMENT_SHADER_PASS_THROUGH_BODY_CODE: &str = "void main()\n{\n    fs_out_color = fs_in_color;\n}\n";
const FRAGMENT_SHADER_SAMPLING_BODY_CODE: &str = "void main()\n{\n";
const GEOMETRY_SHADER_EMIT_VERTEX_CODE: &str = "    EmitVertex();\n}\n";
const GEOMETRY_SHADER_LAYOUT: &str = "layout(points)                 in;\nlayout(points, max_vertices=1) out;\n\n";
const GEOMETRY_SHADER_SAMPLING_BODY_CODE: &str = "void main()\n{\n    gl_Position = gl_in[0].gl_Position;\n";
const TESSELLATION_CONTROL_SHADER_LAYOUT: &str = "layout(vertices = 1) out;\n\n";
const TESSELLATION_CONTROL_SHADER_SAMPLING_BODY_CODE: &str = "void main()\n{\n    gl_TessLevelInner[0] = 1.0;\n    gl_TessLevelInner[1] = 1.0;\n    gl_TessLevelOuter[0] = 1.0;\n    gl_TessLevelOuter[1] = 1.0;\n    gl_TessLevelOuter[2] = 1.0;\n    gl_TessLevelOuter[3] = 1.0;\n    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n";
const TESSELLATION_EVALUATION_SHADER_LAYOUT: &str = "layout(isolines, point_mode) in;\n\n";
const TESSELLATION_EVALUATION_SHADER_PASS_THROUGH_BODY_CODE: &str =
    "void main()\n{\n    gl_Position = gl_in[0].gl_Position;\n    fs_in_color = tes_in_color[0];\n}\n";
const TESSELLATION_EVALUATION_SHADER_SAMPLING_BODY_CODE: &str =
    "void main()\n{\n    gl_Position = gl_in[0].gl_Position;\n";
const VERTEX_SHADER_BODY_CODE: &str = "void main()\n{\n    gl_PointSize = 1.0f;\n    gl_Position = vs_in_position;\n";

const VERTEX_SHADER_INPUT: &str = "vs_in_";
const VERTEX_SHADER_OUTPUT: &str = "vs_out_";
const TESSELLATION_CONTROL_SHADER_OUTPUT: &str = "tcs_out_";
const FRAGMENT_SHADER_INPUT: &str = "fs_in_color";
const FRAGMENT_SHADER_OUTPUT: &str = "fs_out_color";
const TESSELLATION_EVALUATION_SHADER_INPUT: &str = "tes_in_color";
const COMPUTE_SHADER_PARAM: &str = "cs_";
const COMPUTE_SHADER_COLOR: &str = "color";

/// `attributeId`
#[derive(Clone, Copy, PartialEq, Eq)]
enum AttributeId {
    Position,
    TextureCoordinates,
    TextureCoordinatesForGather,
    Lod,
    GradX,
    GradY,
    RefZ,
}

/// `samplerType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SamplerType {
    Float,
    Int,
    UInt,
    Depth,
    Stencil,
}

/// `samplingFunction`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SamplingFunction {
    Texture,
    TextureLod,
    TextureGrad,
    TextureGather,
}

/// `shaderType`; the discriminant indexes the per-function program table.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderType {
    Compute = 0,
    Fragment = 1,
    Geometry = 2,
    TessellationControl = 3,
    TessellationEvaluation = 4,
    Vertex = 5,
}

/// `attributeDefinition`
struct AttributeDefinition {
    name: &'static str,
    type_: &'static str,
    id: AttributeId,
    binding: GLuint,
}

static DEPTH_ATTRIBUTES: [AttributeDefinition; 1] = [AttributeDefinition {
    name: "refZ",
    type_: "float ",
    id: AttributeId::RefZ,
    binding: 1,
}];
static TEXTURE_ATTRIBUTES: [AttributeDefinition; 1] = [AttributeDefinition {
    name: "texture_coordinates",
    type_: "vec4 ",
    id: AttributeId::TextureCoordinates,
    binding: 0,
}];
static TEXTURE_LOD_ATTRIBUTES: [AttributeDefinition; 2] = [
    AttributeDefinition {
        name: "texture_coordinates",
        type_: "vec4 ",
        id: AttributeId::TextureCoordinates,
        binding: 0,
    },
    AttributeDefinition {
        name: "lod",
        type_: "float ",
        id: AttributeId::Lod,
        binding: 1,
    },
];
static TEXTURE_GRAD_ATTRIBUTES: [AttributeDefinition; 3] = [
    AttributeDefinition {
        name: "texture_coordinates",
        type_: "vec4 ",
        id: AttributeId::TextureCoordinates,
        binding: 0,
    },
    AttributeDefinition {
        name: "grad_x",
        type_: "vec3 ",
        id: AttributeId::GradX,
        binding: 1,
    },
    AttributeDefinition {
        name: "grad_y",
        type_: "vec3 ",
        id: AttributeId::GradY,
        binding: 2,
    },
];
static TEXTURE_GATHER_ATTRIBUTES: [AttributeDefinition; 1] = [AttributeDefinition {
    name: "texture_coordinates",
    type_: "vec4 ",
    id: AttributeId::TextureCoordinatesForGather,
    binding: 0,
}];
static POSITION_ATTRIBUTE: AttributeDefinition = AttributeDefinition {
    name: "position",
    type_: "vec4 ",
    id: AttributeId::Position,
    binding: 0,
};

/// `getAttributes(samplerType, ...)`
fn sampler_attributes(sampler_type: SamplerType) -> &'static [AttributeDefinition] {
    match sampler_type {
        SamplerType::Depth => &DEPTH_ATTRIBUTES,
        _ => &[],
    }
}

/// `getAttributes(samplingFunction, ...)`
fn function_attributes(sampling_function: SamplingFunction) -> &'static [AttributeDefinition] {
    match sampling_function {
        SamplingFunction::Texture => &TEXTURE_ATTRIBUTES,
        SamplingFunction::TextureLod => &TEXTURE_LOD_ATTRIBUTES,
        SamplingFunction::TextureGrad => &TEXTURE_GRAD_ATTRIBUTES,
        SamplingFunction::TextureGather => &TEXTURE_GATHER_ATTRIBUTES,
    }
}

/// The out parameters of `getColorType`
struct ColorType {
    color_type: &'static str,
    interpolation_type: &'static str,
    sampler_type: &'static str,
    image_type: &'static str,
    image_layout: &'static str,
    n_components: u32,
    is_shadow: bool,
}

/// `getColorType` (both overloads)
fn color_type(sampler_type: SamplerType) -> ColorType {
    match sampler_type {
        SamplerType::Float => ColorType {
            color_type: "vec4 ",
            interpolation_type: "",
            sampler_type: "samplerCubeArray ",
            image_type: "image2D ",
            image_layout: "rgba8",
            n_components: 4,
            is_shadow: false,
        },
        SamplerType::Int => ColorType {
            color_type: "ivec4 ",
            interpolation_type: "flat ",
            sampler_type: "isamplerCubeArray ",
            image_type: "iimage2D ",
            image_layout: "rgba32i",
            n_components: 4,
            is_shadow: false,
        },
        SamplerType::UInt => ColorType {
            color_type: "uvec4 ",
            interpolation_type: "flat ",
            sampler_type: "usamplerCubeArray ",
            image_type: "uimage2D ",
            image_layout: "rgba32ui",
            n_components: 4,
            is_shadow: false,
        },
        SamplerType::Depth => ColorType {
            color_type: "float ",
            interpolation_type: "",
            sampler_type: "samplerCubeArrayShadow ",
            image_type: "image2D ",
            image_layout: "rgba8",
            n_components: 1,
            is_shadow: true,
        },
        SamplerType::Stencil => ColorType {
            color_type: "uint ",
            interpolation_type: "flat ",
            sampler_type: "usamplerCubeArray ",
            image_type: "uimage2D ",
            image_layout: "r32ui",
            n_components: 1,
            is_shadow: false,
        },
    }
}

/// `var2str`: `prefixName[index]`
fn var2str(prefix: Option<&str>, name: &str, index: Option<&str>) -> String {
    let mut out = String::new();
    if let Some(prefix) = prefix {
        out.push_str(prefix);
    }
    out.push_str(name);
    if let Some(index) = index {
        out.push('[');
        out.push_str(index);
        out.push(']');
    }
    out
}

/// `isSamplerSupportedByFunction`
fn is_sampler_supported_by_function(sampler_type: SamplerType, sampling_function: SamplingFunction) -> bool {
    !(sampler_type == SamplerType::Depth
        && matches!(
            sampling_function,
            SamplingFunction::TextureLod | SamplingFunction::TextureGrad
        ))
}

/// `getSamplingFunctionCall`
#[allow(clippy::too_many_arguments)]
fn sampling_function_call(
    sampling_function: SamplingFunction,
    color_type: &str,
    n_components: u32,
    attribute_name_prefix: &str,
    attribute_index: Option<&str>,
    color_variable_name: &str,
    color_variable_index: Option<&str>,
    sampler_name: &str,
) -> String {
    let color = var2str(None, color_variable_name, color_variable_index);
    let attribute = |name: &str| var2str(Some(attribute_name_prefix), name, attribute_index);
    let suffix = if n_components == 1 { ").x;\n" } else { ");\n" };
    let mut stream = String::new();

    match sampling_function {
        SamplingFunction::Texture => {
            stream += &format!(
                "    {color} = texture({sampler_name}, {}{suffix}",
                attribute("texture_coordinates")
            );
        }
        SamplingFunction::TextureLod => {
            stream += &format!(
                "    {color} = textureLod({sampler_name}, {}, {}{suffix}",
                attribute("texture_coordinates"),
                attribute("lod")
            );
        }
        SamplingFunction::TextureGrad => {
            stream += &format!(
                "    {color} = textureGrad({sampler_name}, {}, {}, {}{suffix}",
                attribute("texture_coordinates"),
                attribute("grad_x"),
                attribute("grad_y")
            );
        }
        SamplingFunction::TextureGather => {
            if n_components == 4 {
                for i in 0..4 {
                    stream += &format!(
                        "    {color_type}component_{i} = textureGather({sampler_name}, {}, {i});\n",
                        attribute("texture_coordinates")
                    );
                }
                stream += &format!(
                    "    {color} = {color_type}(component_0.r, component_1.g, component_2.b, component_3.a);\n"
                );
            } else {
                stream += &format!(
                    "    {color} = textureGather({sampler_name}, {}).x;\n",
                    attribute("texture_coordinates")
                );
            }
        }
    }
    stream
}

/// `getShadowSamplingFunctionCall`; `textureGrad` (upstream throws NotSupported) is unreachable because `is_sampler_supported_by_function` keeps it out.
#[allow(clippy::too_many_arguments)]
fn shadow_sampling_function_call(
    sampling_function: SamplingFunction,
    color_type: &str,
    n_components: u32,
    attribute_name_prefix: &str,
    attribute_index: Option<&str>,
    color_variable_name: &str,
    color_variable_index: Option<&str>,
    sampler_name: &str,
) -> String {
    let color = var2str(None, color_variable_name, color_variable_index);
    let attribute = |name: &str| var2str(Some(attribute_name_prefix), name, attribute_index);
    let mut stream = String::new();

    match sampling_function {
        SamplingFunction::Texture => {
            stream += &format!(
                "    {color} = texture({sampler_name}, {}, {});\n",
                attribute("texture_coordinates"),
                attribute("refZ")
            );
        }
        SamplingFunction::TextureLod => {
            stream += &format!(
                "    {color} = textureLod({sampler_name}, {}, {}, {});\n",
                attribute("texture_coordinates"),
                attribute("lod"),
                attribute("refZ")
            );
        }
        SamplingFunction::TextureGrad => {
            unreachable!("textureGrad operation is not available for samplerCubeArrayShadow")
        }
        SamplingFunction::TextureGather => {
            if n_components == 4 {
                for i in 0..4 {
                    stream += &format!(
                        "    {color_type}component_{i} = textureGather({sampler_name}, {}, {});\n",
                        attribute("texture_coordinates"),
                        attribute("refZ")
                    );
                }
                stream += &format!(
                    "    {color} = {color_type}(component_0.r, component_1.g, component_2.b, component_3.a);\n"
                );
            } else {
                stream += &format!(
                    "    {color} = textureGather({sampler_name}, {}, {}).x;\n",
                    attribute("texture_coordinates"),
                    attribute("refZ")
                );
            }
        }
    }
    stream
}

/// The `is_shadow` split every `getSampling*ShaderCode` does
#[allow(clippy::too_many_arguments)]
fn sampling_code(
    sampling_function: SamplingFunction,
    info: &ColorType,
    attribute_name_prefix: &str,
    attribute_index: Option<&str>,
    color_variable_name: &str,
    color_variable_index: Option<&str>,
) -> String {
    if info.is_shadow {
        shadow_sampling_function_call(
            sampling_function,
            info.color_type,
            info.n_components,
            attribute_name_prefix,
            attribute_index,
            color_variable_name,
            color_variable_index,
            SAMPLER_NAME,
        )
    } else {
        sampling_function_call(
            sampling_function,
            info.color_type,
            info.n_components,
            attribute_name_prefix,
            attribute_index,
            color_variable_name,
            color_variable_index,
            SAMPLER_NAME,
        )
    }
}

/// Every attribute of the sampling function followed by every attribute of the sampler type
fn all_attributes(
    sampler_type: SamplerType,
    sampling_function: SamplingFunction,
) -> impl Iterator<Item = &'static AttributeDefinition> {
    function_attributes(sampling_function)
        .iter()
        .chain(sampler_attributes(sampler_type).iter())
}

/// `getPassThroughFragmentShaderCode`
fn pass_through_fragment_shader_code(sampler_type: SamplerType) -> String {
    let info = color_type(sampler_type);
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += SHADER_PRECISION;
    stream += "/* Pass through fragment shader */\n";
    stream += &format!(
        "{}in {}{FRAGMENT_SHADER_INPUT};\n\n",
        info.interpolation_type, info.color_type
    );
    stream += &format!(
        "layout(location = 0) out {}{FRAGMENT_SHADER_OUTPUT};\n\n",
        info.color_type
    );
    stream += FRAGMENT_SHADER_PASS_THROUGH_BODY_CODE;
    stream += "\n";
    stream
}

/// `getPassThroughTesselationControlShaderCode`
fn pass_through_tessellation_control_shader_code(
    sampler_type: SamplerType,
    sampling_function: SamplingFunction,
) -> String {
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += TESSELLATION_SHADER_EXTENSION;
    stream += SHADER_PRECISION;
    stream += "\n/* Passthrough tesselation control shader */\n";
    stream += TESSELLATION_CONTROL_SHADER_LAYOUT;
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!("in {}{VERTEX_SHADER_OUTPUT}{}[];\n", attribute.type_, attribute.name);
        stream += &format!(
            "out {}{TESSELLATION_CONTROL_SHADER_OUTPUT}{}[];\n",
            attribute.type_, attribute.name
        );
    }
    stream += TESSELLATION_CONTROL_SHADER_SAMPLING_BODY_CODE;
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!(
            "    {TESSELLATION_CONTROL_SHADER_OUTPUT}{0}[gl_InvocationID] = {VERTEX_SHADER_OUTPUT}{0}[gl_InvocationID];\n",
            attribute.name
        );
    }
    stream += "}\n\n";
    stream
}

/// `getPassThroughTesselationEvaluationShaderCode`
fn pass_through_tessellation_evaluation_shader_code(sampler_type: SamplerType) -> String {
    let info = color_type(sampler_type);
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += TESSELLATION_SHADER_EXTENSION;
    stream += SHADER_PRECISION;
    stream += "\n/* Pass through tesselation evaluation shader */\n";
    stream += TESSELLATION_EVALUATION_SHADER_LAYOUT;
    stream += &format!(
        "{}in {}{TESSELLATION_EVALUATION_SHADER_INPUT}[];\n\n",
        info.interpolation_type, info.color_type
    );
    stream += &format!(
        "{}out {}{FRAGMENT_SHADER_INPUT};\n\n",
        info.interpolation_type, info.color_type
    );
    stream += TESSELLATION_EVALUATION_SHADER_PASS_THROUGH_BODY_CODE;
    stream += "\n";
    stream
}

/// `getPassThroughVertexShaderCode`
fn pass_through_vertex_shader_code(sampler_type: SamplerType, sampling_function: SamplingFunction) -> String {
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += "/* Pass through vertex shader */\n";
    stream += SHADER_PRECISION;
    stream += &format!(
        "in {}{VERTEX_SHADER_INPUT}{};\n",
        POSITION_ATTRIBUTE.type_, POSITION_ATTRIBUTE.name
    );
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!("in {}{VERTEX_SHADER_INPUT}{};\n", attribute.type_, attribute.name);
    }
    stream += "\n";
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!("out {}{VERTEX_SHADER_OUTPUT}{};\n", attribute.type_, attribute.name);
    }
    stream += "\n";
    stream += VERTEX_SHADER_BODY_CODE;
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!(
            "    {VERTEX_SHADER_OUTPUT}{0} = {VERTEX_SHADER_INPUT}{0};\n",
            attribute.name
        );
    }
    stream += "}\n\n";
    stream
}

/// `getSamplingComputeShaderCode`
fn sampling_compute_shader_code(sampler_type: SamplerType, sampling_function: SamplingFunction) -> String {
    let info = color_type(sampler_type);
    let code = sampling_code(
        sampling_function,
        &info,
        COMPUTE_SHADER_PARAM,
        None,
        COMPUTE_SHADER_COLOR,
        None,
    );
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += SHADER_PRECISION;
    stream += "/* Sampling compute shader */\n";
    stream += &format!("uniform highp {}{SAMPLER_NAME};\n", info.sampler_type);
    stream += &format!(
        "layout({}) uniform writeonly highp {}{IMAGE_NAME};\n",
        info.image_layout, info.image_type
    );
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!(
            "layout(std430, binding={}) buffer {}\n",
            attribute.binding, attribute.name
        );
        stream += &format!("{{\n    {} {}_data[];\n}};\n", attribute.type_, attribute.name);
    }
    stream += COMPUTE_SHADER_LAYOUT;
    stream += "\n";
    stream += COMPUTE_SHADER_BODY;
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!(
            "    {}{COMPUTE_SHADER_PARAM}{1} = {1}_data[vertex_index];\n",
            attribute.type_, attribute.name
        );
    }
    stream += &format!("\n    {}{COMPUTE_SHADER_COLOR};\n", info.color_type);
    stream += &format!("\n{code}\n");
    stream += &format!("    imageStore({IMAGE_NAME}, image_coord, ");
    match info.n_components {
        1 => {
            if sampler_type == SamplerType::Depth {
                stream += &format!("vec4({COMPUTE_SHADER_COLOR})");
            } else if sampler_type == SamplerType::Stencil {
                stream += &format!("uvec4({COMPUTE_SHADER_COLOR})");
            }
        }
        _ => stream += COMPUTE_SHADER_COLOR,
    }
    stream += ");\n";
    stream += "}\n\n";
    stream
}

/// `getSamplingFragmentShaderCode`
fn sampling_fragment_shader_code(sampler_type: SamplerType, sampling_function: SamplingFunction) -> String {
    let info = color_type(sampler_type);
    let code = sampling_code(
        sampling_function,
        &info,
        VERTEX_SHADER_OUTPUT,
        None,
        FRAGMENT_SHADER_OUTPUT,
        None,
    );
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += SHADER_PRECISION;
    stream += "/* Sampling fragment shader */\n";
    stream += &format!("uniform highp {}{SAMPLER_NAME};\n\n", info.sampler_type);
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!("in {}{VERTEX_SHADER_OUTPUT}{};\n", attribute.type_, attribute.name);
    }
    stream += "\n";
    stream += &format!(
        "layout(location = 0) out {}{FRAGMENT_SHADER_OUTPUT};\n\n",
        info.color_type
    );
    stream += FRAGMENT_SHADER_SAMPLING_BODY_CODE;
    stream += &code;
    stream += "}\n\n";
    stream
}

/// `getSamplingGeometryShaderCode`
fn sampling_geometry_shader_code(sampler_type: SamplerType, sampling_function: SamplingFunction) -> String {
    let info = color_type(sampler_type);
    let code = sampling_code(
        sampling_function,
        &info,
        VERTEX_SHADER_OUTPUT,
        Some("0"),
        FRAGMENT_SHADER_INPUT,
        None,
    );
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += GEOMETRY_SHADER_EXTENSION;
    stream += SHADER_PRECISION;
    stream += "\n/* Sampling geometry shader */\n";
    stream += GEOMETRY_SHADER_LAYOUT;
    stream += &format!("uniform highp {}{SAMPLER_NAME};\n\n", info.sampler_type);
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!("in {}{VERTEX_SHADER_OUTPUT}{}[];\n", attribute.type_, attribute.name);
    }
    stream += "\n";
    stream += &format!(
        "{}out {}{FRAGMENT_SHADER_INPUT};\n\n",
        info.interpolation_type, info.color_type
    );
    stream += GEOMETRY_SHADER_SAMPLING_BODY_CODE;
    stream += &code;
    stream += GEOMETRY_SHADER_EMIT_VERTEX_CODE;
    stream += "\n";
    stream
}

/// `getSamplingTesselationControlShaderCode`
fn sampling_tessellation_control_shader_code(sampler_type: SamplerType, sampling_function: SamplingFunction) -> String {
    let info = color_type(sampler_type);
    let code = sampling_code(
        sampling_function,
        &info,
        VERTEX_SHADER_OUTPUT,
        Some("gl_InvocationID"),
        TESSELLATION_EVALUATION_SHADER_INPUT,
        Some("gl_InvocationID"),
    );
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += TESSELLATION_SHADER_EXTENSION;
    stream += SHADER_PRECISION;
    stream += "\n/* Sampling tesselation control shader */\n";
    stream += TESSELLATION_CONTROL_SHADER_LAYOUT;
    stream += &format!("uniform highp {}{SAMPLER_NAME};\n\n", info.sampler_type);
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!("in {}{VERTEX_SHADER_OUTPUT}{}[];\n", attribute.type_, attribute.name);
    }
    stream += "\n";
    stream += &format!(
        "{}out {}{TESSELLATION_EVALUATION_SHADER_INPUT}[];\n\n",
        info.interpolation_type, info.color_type
    );
    stream += TESSELLATION_CONTROL_SHADER_SAMPLING_BODY_CODE;
    stream += &code;
    stream += "}\n\n";
    stream
}

/// `getSamplingTesselationEvaluationShaderCode`
fn sampling_tessellation_evaluation_shader_code(
    sampler_type: SamplerType,
    sampling_function: SamplingFunction,
) -> String {
    let info = color_type(sampler_type);
    let prev_stage_output = if IS_CONTEXT_ES {
        TESSELLATION_CONTROL_SHADER_OUTPUT
    } else {
        VERTEX_SHADER_OUTPUT
    };
    let code = sampling_code(
        sampling_function,
        &info,
        prev_stage_output,
        Some("0"),
        FRAGMENT_SHADER_INPUT,
        None,
    );
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += TESSELLATION_SHADER_EXTENSION;
    stream += SHADER_PRECISION;
    stream += "\n/* Sampling tesselation evaluation shader */\n";
    stream += TESSELLATION_EVALUATION_SHADER_LAYOUT;
    stream += &format!("uniform highp {}{SAMPLER_NAME};\n\n", info.sampler_type);
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!("in {}{prev_stage_output}{}[];\n", attribute.type_, attribute.name);
    }
    stream += "\n";
    stream += &format!(
        "{}out {}{FRAGMENT_SHADER_INPUT};\n\n",
        info.interpolation_type, info.color_type
    );
    stream += TESSELLATION_EVALUATION_SHADER_SAMPLING_BODY_CODE;
    stream += &code;
    stream += "}\n\n";
    stream
}

/// `getSamplingVertexShaderCode`
fn sampling_vertex_shader_code(sampler_type: SamplerType, sampling_function: SamplingFunction) -> String {
    let info = color_type(sampler_type);
    let code = sampling_code(
        sampling_function,
        &info,
        VERTEX_SHADER_INPUT,
        None,
        FRAGMENT_SHADER_INPUT,
        None,
    );
    let mut stream = String::new();

    stream += SHADER_CODE_PREAMBLE;
    stream += SHADER_PRECISION;
    stream += "/* Sampling vertex shader */\n";
    stream += &format!("uniform highp {}{SAMPLER_NAME};\n\n", info.sampler_type);
    stream += &format!(
        "in {}{VERTEX_SHADER_INPUT}{};\n",
        POSITION_ATTRIBUTE.type_, POSITION_ATTRIBUTE.name
    );
    for attribute in all_attributes(sampler_type, sampling_function) {
        stream += &format!("in {}{VERTEX_SHADER_INPUT}{};\n", attribute.type_, attribute.name);
    }
    stream += "\n";
    stream += &format!(
        "{}out {}{FRAGMENT_SHADER_INPUT};\n\n",
        info.interpolation_type, info.color_type
    );
    stream += VERTEX_SHADER_BODY_CODE;
    stream += &code;
    stream += "}\n\n";
    stream
}

/// A component type of the result image
trait Component: Copy + PartialEq {
    const SIZE: usize;
    fn read(bytes: &[u8]) -> Self;
    fn from_i32(value: i32) -> Self;
}

impl Component for u8 {
    const SIZE: usize = 1;
    fn read(bytes: &[u8]) -> Self {
        bytes[0]
    }
    fn from_i32(value: i32) -> Self {
        value as u8
    }
}

impl Component for u32 {
    const SIZE: usize = 4;
    fn read(bytes: &[u8]) -> Self {
        u32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]])
    }
    fn from_i32(value: i32) -> Self {
        value as u32
    }
}

impl Component for i32 {
    const SIZE: usize = 4;
    fn read(bytes: &[u8]) -> Self {
        i32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]])
    }
    fn from_i32(value: i32) -> Self {
        value
    }
}

impl Component for f32 {
    const SIZE: usize = 4;
    fn read(bytes: &[u8]) -> Self {
        f32::from_ne_bytes([bytes[0], bytes[1], bytes[2], bytes[3]])
    }
    fn from_i32(value: i32) -> Self {
        value as f32
    }
}

/// `fillImage` + the `texSubImage3D` of `prepareDataForTexture`
#[allow(clippy::too_many_arguments)]
fn prepare_data_for_texture<T: Component>(
    gl: &glw::Functions,
    cube_face: i32,
    element_index: i32,
    mipmap_level: i32,
    texture_format: GLenum,
    texture_type: GLenum,
    texture_width: i32,
    texture_height: i32,
    components: &[T],
) -> Result<(), TestError> {
    let n_pixels = (texture_width * texture_height) as usize;
    let z_offset = element_index * 6 + cube_face;
    let mut texture_data: Vec<T> = Vec::with_capacity(n_pixels * components.len());

    for _ in 0..n_pixels {
        texture_data.extend_from_slice(components);
    }

    // SAFETY: `texture_data` holds width * height pixels of the format and type passed.
    unsafe {
        gl.tex_sub_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            mipmap_level,
            0,
            0,
            z_offset,
            texture_width,
            texture_height,
            1,
            texture_format,
            texture_type,
            texture_data.as_ptr().cast(),
        )
    };
    glu::expect_no_error(gl, "Failed to update texture data")
}

/// `getColorFloatComponents`
fn color_float_components(
    cube_face: i32,
    element_index: i32,
    mipmap_level: i32,
    n_elements: i32,
    n_mipmap_levels: i32,
) -> [f32; 4] {
    [
        (mipmap_level + 1) as f32 / n_mipmap_levels as f32,
        (cube_face + 1) as f32 / 6.0,
        (element_index + 1) as f32 / n_elements as f32,
        1.0 / 4.0,
    ]
}

/// `getColorIntComponents`
fn color_int_components<T: Component>(cube_face: i32, element_index: i32, mipmap_level: i32) -> [T; 4] {
    [
        T::from_i32(mipmap_level + 1),
        T::from_i32(cube_face + 1),
        T::from_i32(element_index + 1),
        T::from_i32(1),
    ]
}

/// `getDepthComponent`
fn depth_component(
    cube_face: i32,
    element_index: i32,
    mipmap_level: i32,
    n_elements: i32,
    n_mipmap_levels: i32,
) -> f32 {
    (mipmap_level + 1 + cube_face + 1 + element_index + 1) as f32 / (n_mipmap_levels + 6 + n_elements) as f32
}

/// `getStencilComponent`
fn stencil_component(
    cube_face: i32,
    element_index: i32,
    mipmap_level: i32,
    n_elements: i32,
    n_mipmap_levels: i32,
) -> u8 {
    ((mipmap_level + 1 + cube_face + 1 + element_index + 1) * 255 / (n_mipmap_levels + 6 + n_elements)) as u8
}

/// `getMipmapLevelCount`
fn mipmap_level_count(texture_width: i32, texture_height: i32) -> i32 {
    let mut size = texture_width.max(texture_height);
    let mut count = 1u8;

    while 1 < size {
        size /= 2;
        count += 1;
    }
    count as i32
}

/// `prepareTextureFace` and the `prepare*TextureFace` it switches to
#[allow(clippy::too_many_arguments)]
fn prepare_texture_face(
    gl: &glw::Functions,
    cube_face: i32,
    element_index: i32,
    mipmap_level: i32,
    n_elements: i32,
    n_mipmap_levels: i32,
    texture_format: GLenum,
    texture_type: GLenum,
    texture_width: i32,
    texture_height: i32,
) -> Result<(), TestError> {
    let not_implemented = || TestError::Fail("Not implemented case !".to_string());
    let (f, e, m) = (cube_face, element_index, mipmap_level);

    match (texture_format, texture_type) {
        (glw::GL_RGBA, glw::GL_UNSIGNED_BYTE) => prepare_data_for_texture(
            gl,
            f,
            e,
            m,
            texture_format,
            texture_type,
            texture_width,
            texture_height,
            &color_int_components::<u8>(f, e, m),
        ),
        (glw::GL_RGBA, glw::GL_FLOAT) => prepare_data_for_texture(
            gl,
            f,
            e,
            m,
            texture_format,
            texture_type,
            texture_width,
            texture_height,
            &color_float_components(f, e, m, n_elements, n_mipmap_levels),
        ),
        (glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT) => prepare_data_for_texture(
            gl,
            f,
            e,
            m,
            texture_format,
            texture_type,
            texture_width,
            texture_height,
            &color_int_components::<u32>(f, e, m),
        ),
        (glw::GL_RGBA_INTEGER, glw::GL_INT) => prepare_data_for_texture(
            gl,
            f,
            e,
            m,
            texture_format,
            texture_type,
            texture_width,
            texture_height,
            &color_int_components::<i32>(f, e, m),
        ),
        (glw::GL_DEPTH_COMPONENT, glw::GL_FLOAT) => prepare_data_for_texture(
            gl,
            f,
            e,
            m,
            texture_format,
            texture_type,
            texture_width,
            texture_height,
            &[depth_component(f, e, m, n_elements, n_mipmap_levels)],
        ),
        (glw::GL_STENCIL_INDEX, glw::GL_UNSIGNED_BYTE) => prepare_data_for_texture(
            gl,
            f,
            e,
            m,
            texture_format,
            texture_type,
            texture_width,
            texture_height,
            &[stencil_component(f, e, m, n_elements, n_mipmap_levels)],
        ),
        _ => Err(not_implemented()),
    }
}

/// `vectorSet4`
fn vector_set4(data: &mut [f32], index: usize, x: f32, y: f32, z: f32, w: f32) {
    data[4 * index..4 * index + 4].copy_from_slice(&[x, y, z, w]);
}

/// `vectorNormalize<3, 4>`
fn vector_normalize(data: &mut [f32], index: usize) {
    let components = &mut data[index * 4..index * 4 + 4];
    let mut sqr_length = 0.0f32;

    for component in &components[..3] {
        sqr_length += component * component;
    }
    let factor = 1.0f32 / sqr_length.sqrt();

    for component in &mut components[..3] {
        *component *= factor;
    }
}

/// `getRightNeighbour`
fn right_neighbour(texture_coordinates: &[f32], face: u32, offset: u32, width: u32, out: &mut [f32]) {
    let step = offset as f32 / width as f32;
    let (coord_x, coord_y, coord_z) = (texture_coordinates[0], texture_coordinates[1], texture_coordinates[2]);

    let (x, y, z) = match face {
        0 => (coord_x, coord_y - step, coord_z),
        1 => (coord_x, coord_y + step, coord_z),
        2 => (coord_x + step, coord_y, coord_z),
        3 => (coord_x - step, coord_y, coord_z),
        4 => (coord_x + step, coord_y, coord_z),
        5 => (coord_x - step, coord_y, coord_z),
        _ => return,
    };
    out[0] = x;
    out[1] = y;
    out[2] = z;
}

/// `getTopNeighbour`
fn top_neighbour(texture_coordinates: &[f32], face: u32, offset: u32, width: u32, out: &mut [f32]) {
    let step = offset as f32 / width as f32;
    let (coord_x, coord_y, coord_z) = (texture_coordinates[0], texture_coordinates[1], texture_coordinates[2]);

    let (x, y, z) = match face {
        0..=3 => (coord_x, coord_y, coord_z + step),
        4 => (coord_x, coord_y - step, coord_z),
        5 => (coord_x, coord_y + step, coord_z),
        _ => return,
    };
    out[0] = x;
    out[1] = y;
    out[2] = z;
}

/// `prepareGradXForFace` (`right == true`) and `prepareGradYForFace`
fn prepare_grad_for_face(grad: &mut [f32], face: u32, texture_coordinates: &[f32], width: u32, right: bool) {
    let neighbour: fn(&[f32], u32, u32, u32, &mut [f32]) = if right { right_neighbour } else { top_neighbour };

    for i in (0..N_POINTS_PER_FACE).step_by(2) {
        neighbour(&texture_coordinates[i * 4..], face, 1, width, &mut grad[i * 4..]);
    }
    for i in (1..N_POINTS_PER_FACE).step_by(2) {
        neighbour(
            &texture_coordinates[i * 4..],
            face,
            4 * width,
            width,
            &mut grad[i * 4..],
        );
    }
    for i in 0..N_POINTS_PER_FACE {
        for k in 0..3 {
            grad[i * 4 + k] -= texture_coordinates[i * 4 + k];
        }
    }
}

/// `prepareLodForFace`
fn prepare_lod_for_face(lods: &mut [f32], n_mipmap_levels: u32) {
    let base_level = 0.0f32;
    let top_level = (n_mipmap_levels - 1) as f32;

    for (i, lod) in lods.iter_mut().take(9).enumerate() {
        *lod = if i % 2 == 0 { base_level } else { top_level };
    }
}

/// `preparePositionForFace`
fn prepare_position_for_face(positions: &mut [f32], cube_face: u32, element_index: u32, n_layers: u32) {
    let x_offset_per_face = 3u32;
    let x_offset_for_face = (element_index * N_FACES + cube_face) * x_offset_per_face;

    let x_step = 2.0f32 / ((n_layers * 3) as f32);
    let x_mid_step = x_step / 2.0f32;
    let y_step = 2.0f32 / 3.0f32;
    let y_mid_step = y_step / 2.0f32;

    let x_left = -1.0f32 + x_mid_step + (x_offset_for_face as f32) * x_step;
    let x_middle = x_left + x_step;
    let x_right = x_middle + x_step;

    let y_top = 1.0f32 - y_mid_step;
    let y_middle = y_top - y_step;
    let y_bottom = y_middle - y_step;

    vector_set4(positions, 0, x_left, y_top, 0.0, 1.0);
    vector_set4(positions, 1, x_middle, y_top, 0.0, 1.0);
    vector_set4(positions, 2, x_right, y_top, 0.0, 1.0);
    vector_set4(positions, 3, x_left, y_middle, 0.0, 1.0);
    vector_set4(positions, 4, x_middle, y_middle, 0.0, 1.0);
    vector_set4(positions, 5, x_right, y_middle, 0.0, 1.0);
    vector_set4(positions, 6, x_left, y_bottom, 0.0, 1.0);
    vector_set4(positions, 7, x_middle, y_bottom, 0.0, 1.0);
    vector_set4(positions, 8, x_right, y_bottom, 0.0, 1.0);
}

/// `prepareRefZForFace`
fn prepare_ref_z_for_face(ref_zs: &mut [f32], n_mipmaps: u32, face: u32, layer: u32, n_layers: u32) {
    let expected_base_depth_value = depth_component(face as i32, layer as i32, 0, n_layers as i32, n_mipmaps as i32);
    let expected_top_depth_value = depth_component(
        face as i32,
        layer as i32,
        n_mipmaps as i32 - 1,
        n_layers as i32,
        n_mipmaps as i32,
    );

    let base_depth_step = expected_base_depth_value * 0.1f32;
    let top_depth_step = expected_top_depth_value * 0.1f32;

    ref_zs[0] = expected_base_depth_value - base_depth_step;
    ref_zs[1] = expected_top_depth_value;
    ref_zs[2] = expected_base_depth_value + base_depth_step;

    ref_zs[3] = expected_top_depth_value - top_depth_step;
    ref_zs[4] = expected_base_depth_value;
    ref_zs[5] = expected_top_depth_value + top_depth_step;

    ref_zs[6] = expected_base_depth_value - base_depth_step;
    ref_zs[7] = expected_top_depth_value;
    ref_zs[8] = expected_base_depth_value + base_depth_step;
}

/// `prepareTextureCoordinatesForFace` (`gather == false`) and `prepareTextureCoordinatesForGatherForFace`, which keeps one more texel away from the face border
fn prepare_texture_coordinates_for_face(
    data: &mut [f32],
    width: u32,
    height: u32,
    layer: f32,
    face: u32,
    gather: bool,
) {
    let x_step = 2.0f32 / width as f32;
    let y_step = 2.0f32 / height as f32;
    let x_mid_step = x_step / 2.0f32;
    let y_mid_step = y_step / 2.0f32;

    let (left, right, top, bottom) = if gather {
        (
            -1.0f32 + x_mid_step + x_step,
            1.0f32 - x_mid_step - x_step,
            1.0f32 - y_mid_step - y_step,
            -1.0f32 + y_mid_step + y_step,
        )
    } else {
        (
            -1.0f32 + x_mid_step,
            1.0f32 - x_mid_step,
            1.0f32 - y_mid_step,
            -1.0f32 + y_mid_step,
        )
    };
    let middle = 0.0f32;
    let negative = -1.0f32;
    let positive = 1.0f32;

    for index in 0..N_POINTS_PER_FACE {
        let column = [left, middle, right][index % 3];
        let row = [top, middle, bottom][index / 3];

        match face {
            0 => vector_set4(data, index, positive, column, row, layer),
            1 => vector_set4(data, index, negative, column, row, layer),
            2 => vector_set4(data, index, column, positive, row, layer),
            3 => vector_set4(data, index, column, negative, row, layer),
            4 => vector_set4(data, index, column, row, positive, layer),
            5 => vector_set4(data, index, column, row, negative, layer),
            _ => {}
        }
    }
    for index in 0..N_POINTS_PER_FACE {
        vector_normalize(data, index);
    }
}

/// The expected components of one result pixel of the face-sized `3 x 3` block for one sampling function family
#[derive(Clone, Copy)]
struct Expected {
    lod: bool,
    n_mipmap_levels: i32,
    n_layers: i32,
}

impl Expected {
    /// mip level the pixel samples: textureLod and textureGrad alternate base and top level
    fn mipmap_level(self, pixel_index: u32) -> i32 {
        if self.lod && pixel_index % 2 == 1 {
            self.n_mipmap_levels - 1
        } else {
            0
        }
    }
}

/// `verifyFace` + `verifyImage` + `verifyResultImage` with `Width = Height = 3`
fn verify_result_image<T: Component, const N: usize>(
    n_layers: u32,
    data: &[u8],
    expected: impl Fn(u32, u32, u32) -> [T; N],
) -> bool {
    const WIDTH: usize = 3;
    const HEIGHT: usize = 3;
    let n_total_faces = (n_layers * N_FACES) as usize;
    let data_size_of_line = n_total_faces * WIDTH * N;

    for face in 0..n_total_faces {
        let cube_face = (face % N_FACES as usize) as u32;
        let layer = (face / N_FACES as usize) as u32;
        let data_face_offset = N * WIDTH * face;

        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                let pixel = (y * WIDTH + x) as u32;
                let expected_components = expected(pixel, cube_face, layer);
                let data_pixel_offset = y * data_size_of_line + data_face_offset + x * N;

                for (component, expected_value) in expected_components.iter().enumerate() {
                    let offset = (data_pixel_offset + component) * T::SIZE;
                    if offset + T::SIZE > data.len() || T::read(&data[offset..]) != *expected_value {
                        return false;
                    }
                }
            }
        }
    }
    true
}

/// `formatDefinition`
#[derive(Clone)]
struct FormatDefinition {
    src_internal_format: GLenum,
    src_format: GLenum,
    src_type: GLenum,
    dst_internal_format: GLenum,
    dst_format: GLenum,
    dst_type: GLenum,
    sampler_type: SamplerType,
    name: &'static str,
}

/// `shaderConfiguration`
struct ShaderConfiguration {
    type_: ShaderType,
    primitive_type: GLenum,
    name: &'static str,
}

/// What a `GlObject` deletes on drop
#[derive(Clone, Copy)]
enum ObjectKind {
    Buffer,
    Texture,
    VertexArray,
    Shader,
    Program,
}

/// `bufferDefinition`, `textureDefinition`, `vertexArrayObjectDefinition`, `shaderDefinition` and `programDefinition` object ownership
struct GlObject<'a> {
    gl: &'a glw::Functions,
    kind: ObjectKind,
    id: GLuint,
}

impl<'a> GlObject<'a> {
    fn new(gl: &'a glw::Functions, kind: ObjectKind, id: GLuint) -> Self {
        Self { gl, kind, id }
    }
}

impl Drop for GlObject<'_> {
    fn drop(&mut self) {
        // SAFETY: deletes a name this test created, on the context that is still current.
        unsafe {
            match self.kind {
                ObjectKind::Buffer => self.gl.delete_buffers(1, &self.id),
                ObjectKind::Texture => self.gl.delete_textures(1, &self.id),
                ObjectKind::VertexArray => self.gl.delete_vertex_arrays(1, &self.id),
                ObjectKind::Shader => self.gl.delete_shader(self.id),
                ObjectKind::Program => self.gl.delete_program(self.id),
            }
        }
    }
}

/// `bufferDefinition::init`
fn new_buffer<'a>(gl: &'a glw::Functions, data: &[f32]) -> Result<GlObject<'a>, TestError> {
    let mut id: GLuint = 0;

    // SAFETY: buffer creation and upload from a live slice, on the current context.
    unsafe { gl.gen_buffers(1, &mut id) };
    let buffer = GlObject::new(gl, ObjectKind::Buffer, id);
    glu::expect_no_error(gl, "Failed to generate buffer.")?;
    // SAFETY: as above.
    unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, id) };
    glu::expect_no_error(gl, "Failed to bind buffer.")?;
    // SAFETY: `data` is `size_of_val` bytes.
    unsafe {
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(data) as glw::GLsizeiptr,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        )
    };
    glu::expect_no_error(gl, "Failed to update buffer's data.")?;
    // SAFETY: unbinds.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        gl.get_error();
    }
    Ok(buffer)
}

/// `bufferCollection`
struct BufferCollection<'a> {
    position: GlObject<'a>,
    texture_coordinate: GlObject<'a>,
    texture_coordinate_for_gather: GlObject<'a>,
    lod: GlObject<'a>,
    grad_x: GlObject<'a>,
    grad_y: GlObject<'a>,
    ref_z: GlObject<'a>,
}

impl<'a> BufferCollection<'a> {
    /// `bufferCollection::init`
    fn new(gl: &'a glw::Functions, resolution: [GLuint; 3]) -> Result<Self, TestError> {
        let [texture_width, texture_height, depth] = resolution;
        let n_layers = depth / N_FACES;
        let n_total_points = N_POINTS_PER_FACE * (N_FACES * n_layers) as usize;
        let n_mip_map_levels = mipmap_level_count(texture_width as i32, texture_height as i32) as u32;

        let mut position = vec![0.0f32; n_total_points * 4];
        let mut texture_coordinate = vec![0.0f32; n_total_points * 4];
        let mut texture_coordinate_for_gather = vec![0.0f32; n_total_points * 4];
        let mut lod = vec![0.0f32; n_total_points];
        let mut grad_x = vec![0.0f32; n_total_points * 4];
        let mut grad_y = vec![0.0f32; n_total_points * 4];
        let mut ref_z = vec![0.0f32; n_total_points];

        for layer in 0..n_layers {
            let layer_coordinate = layer as f32;

            for face in 0..N_FACES {
                let point = (layer * N_FACES + face) as usize * N_POINTS_PER_FACE;
                let (vec4, vec1) = (
                    point * 4..(point + N_POINTS_PER_FACE) * 4,
                    point..point + N_POINTS_PER_FACE,
                );

                prepare_position_for_face(&mut position[vec4.clone()], face, layer, n_layers * N_FACES);
                prepare_texture_coordinates_for_face(
                    &mut texture_coordinate[vec4.clone()],
                    texture_width,
                    texture_height,
                    layer_coordinate,
                    face,
                    false,
                );
                prepare_texture_coordinates_for_face(
                    &mut texture_coordinate_for_gather[vec4.clone()],
                    texture_width,
                    texture_height,
                    layer_coordinate,
                    face,
                    true,
                );
                prepare_lod_for_face(&mut lod[vec1.clone()], n_mip_map_levels);
                prepare_grad_for_face(
                    &mut grad_x[vec4.clone()],
                    face,
                    &texture_coordinate[vec4.clone()],
                    texture_width,
                    true,
                );
                prepare_grad_for_face(
                    &mut grad_y[vec4.clone()],
                    face,
                    &texture_coordinate[vec4.clone()],
                    texture_width,
                    false,
                );
                prepare_ref_z_for_face(&mut ref_z[vec1], n_mip_map_levels, face, layer, n_layers);
            }
        }

        Ok(Self {
            position: new_buffer(gl, &position)?,
            texture_coordinate: new_buffer(gl, &texture_coordinate)?,
            texture_coordinate_for_gather: new_buffer(gl, &texture_coordinate_for_gather)?,
            lod: new_buffer(gl, &lod)?,
            grad_x: new_buffer(gl, &grad_x)?,
            grad_y: new_buffer(gl, &grad_y)?,
            ref_z: new_buffer(gl, &ref_z)?,
        })
    }

    fn buffer(&self, id: AttributeId) -> &GlObject<'a> {
        match id {
            AttributeId::Position => &self.position,
            AttributeId::TextureCoordinates => &self.texture_coordinate,
            AttributeId::TextureCoordinatesForGather => &self.texture_coordinate_for_gather,
            AttributeId::Lod => &self.lod,
            AttributeId::GradX => &self.grad_x,
            AttributeId::GradY => &self.grad_y,
            AttributeId::RefZ => &self.ref_z,
        }
    }
}

/// `shaderDefinition`
struct ShaderDefinition<'a> {
    object: GlObject<'a>,
    source: String,
}

impl<'a> ShaderDefinition<'a> {
    /// `shaderDefinition::init`
    fn new(gl: &'a glw::Functions, base: &TestCaseBase, shader_stage: GLenum, source: &str) -> Result<Self, TestError> {
        let source = base.specialize_shader(&[source]);

        // SAFETY: object creation on the current context.
        let id = unsafe { gl.create_shader(shader_stage) };
        glu::expect_no_error(gl, "Failed to create shader")?;
        if id == 0 {
            return Err(TestError::InternalError(
                "glCreateShader returned invalid id".to_string(),
            ));
        }
        Ok(Self {
            object: GlObject::new(gl, ObjectKind::Shader, id),
            source,
        })
    }

    /// `shaderDefinition::compile`
    fn compile(&self) -> Result<bool, TestError> {
        let gl = self.object.gl;
        let mut compile_status: GLint = glw::GL_FALSE as GLint;
        let source = CString::new(self.source.as_str()).map_err(|e| TestError::InternalError(e.to_string()))?;
        let source_ptr = source.as_ptr();

        // SAFETY: one NUL terminated source string that outlives the call.
        unsafe { gl.shader_source(self.object.id, 1, &source_ptr, std::ptr::null()) };
        glu::expect_no_error(gl, "glShaderSource() call failed.")?;
        // SAFETY: compiles a shader this test created.
        unsafe { gl.compile_shader(self.object.id) };
        glu::expect_no_error(gl, "glCompileShader() call failed.")?;
        // SAFETY: writes one GLint.
        unsafe { gl.get_shaderiv(self.object.id, glw::GL_COMPILE_STATUS, &mut compile_status) };
        glu::expect_no_error(gl, "glGetShaderiv() call failed.")?;

        Ok(compile_status != glw::GL_FALSE as GLint)
    }
}

/// `shaderCollectionForSamplingRoutine`
struct FunctionShaders<'a> {
    pass_through_vertex: ShaderDefinition<'a>,
    pass_through_tessellation_control: Option<ShaderDefinition<'a>>,
    sampling_compute: ShaderDefinition<'a>,
    sampling_fragment: ShaderDefinition<'a>,
    sampling_geometry: Option<ShaderDefinition<'a>>,
    sampling_tessellation_control: Option<ShaderDefinition<'a>>,
    sampling_tessellation_evaluation: Option<ShaderDefinition<'a>>,
    sampling_vertex: ShaderDefinition<'a>,
}

/// `shaderCollectionForTextureFormat`: `per_function` has an entry per sampling function the format supports, `None` for the others
struct FormatShaders<'a> {
    pass_through_fragment: ShaderDefinition<'a>,
    pass_through_tessellation_evaluation: Option<ShaderDefinition<'a>>,
    per_function: Vec<Option<FunctionShaders<'a>>>,
}

/// `programDefinition`
struct ProgramDefinition<'a> {
    object: GlObject<'a>,
    shaders: Vec<(GLuint, String)>,
}

/// `programCollectionForFunction`: the program of each shader type, `None` for an invalid program id
type FunctionPrograms<'a> = [Option<ProgramDefinition<'a>>; 6];

/// `TextureCubeMapArraySamplingTest` (Test 1)
pub(super) struct Sampling {
    pub(super) ext_params: ExtParameters,
}

struct Runner<'a> {
    context: &'a Context,
    base: &'a TestCaseBase,
    formats: Vec<FormatDefinition>,
    functions: Vec<SamplingFunction>,
    mutabilities: [bool; 2],
    resolutions: [[GLuint; 3]; 4],
    shaders: Vec<ShaderConfiguration>,
    framebuffer_object_id: GLuint,
    compiled_shaders: u32,
    invalid_shaders: u32,
    linked_programs: u32,
    invalid_programs: u32,
    tested_cases: u32,
    failed_cases: u32,
    invalid_type_cases: u32,
}

impl<'a> Runner<'a> {
    fn new(context: &'a Context, base: &'a TestCaseBase) -> Self {
        let format = |src_internal_format, src_format, src_type, sampler_type, name| FormatDefinition {
            src_internal_format,
            src_format,
            src_type,
            dst_internal_format: src_internal_format,
            dst_format: src_format,
            dst_type: src_type,
            sampler_type,
            name,
        };
        let mut depth = format(
            glw::GL_DEPTH_COMPONENT32F,
            glw::GL_DEPTH_COMPONENT,
            glw::GL_FLOAT,
            SamplerType::Depth,
            "GL_DEPTH_COMPONENT32F",
        );
        depth.dst_internal_format = glw::GL_RGBA8;
        depth.dst_format = glw::GL_RGBA;
        depth.dst_type = glw::GL_UNSIGNED_BYTE;
        let mut stencil = format(
            glw::GL_STENCIL_INDEX8,
            glw::GL_STENCIL_INDEX,
            glw::GL_UNSIGNED_BYTE,
            SamplerType::Stencil,
            "GL_STENCIL_INDEX8",
        );
        stencil.dst_internal_format = glw::GL_R32UI;
        stencil.dst_format = glw::GL_RGBA_INTEGER;
        stencil.dst_type = glw::GL_UNSIGNED_INT;

        Self {
            context,
            base,
            formats: vec![
                format(
                    glw::GL_RGBA8,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    SamplerType::Float,
                    "GL_RGBA8",
                ),
                format(
                    glw::GL_RGBA32I,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_INT,
                    SamplerType::Int,
                    "GL_RGBA32I",
                ),
                format(
                    glw::GL_RGBA32UI,
                    glw::GL_RGBA_INTEGER,
                    glw::GL_UNSIGNED_INT,
                    SamplerType::UInt,
                    "GL_RGBA32UI",
                ),
                depth,
                stencil,
            ],
            functions: vec![
                SamplingFunction::Texture,
                SamplingFunction::TextureLod,
                SamplingFunction::TextureGrad,
                SamplingFunction::TextureGather,
            ],
            mutabilities: [true, false],
            resolutions: [[64, 64, 18], [117, 117, 6], [256, 256, 6], [173, 173, 12]],
            shaders: Vec::new(),
            framebuffer_object_id: 0,
            compiled_shaders: 0,
            invalid_shaders: 0,
            linked_programs: 0,
            invalid_programs: 0,
            tested_cases: 0,
            failed_cases: 0,
            invalid_type_cases: 0,
        }
    }

    /// `compile`
    fn compile(&mut self, shader: &ShaderDefinition<'_>) -> Result<(), TestError> {
        self.compiled_shaders += 1;
        if !shader.compile()? {
            self.invalid_shaders += 1;
            let info_log = self
                .base
                .get_info_log(self.context, LogType::Shader, shader.object.id)?;
            log::info!("Shader compilation failure:\n\n{info_log}");
            log::info!("Shader source:\n\n{}", shader.source);
        }
        Ok(())
    }

    /// `shaderCollectionForSamplingRoutine::init`
    fn function_shaders(
        &mut self,
        gl: &'a glw::Functions,
        sampler_type: SamplerType,
        function: SamplingFunction,
    ) -> Result<FunctionShaders<'a>, TestError> {
        let base = self.base;
        let tessellation = base.is_tessellation_shader_supported;
        let geometry = base.is_geometry_shader_extension_supported;
        let tokens = &base.gl_ext_tokens;

        let pass_through_vertex = ShaderDefinition::new(
            gl,
            base,
            glw::GL_VERTEX_SHADER,
            &pass_through_vertex_shader_code(sampler_type, function),
        )?;
        let sampling_compute = ShaderDefinition::new(
            gl,
            base,
            glw::GL_COMPUTE_SHADER,
            &sampling_compute_shader_code(sampler_type, function),
        )?;
        let sampling_fragment = ShaderDefinition::new(
            gl,
            base,
            glw::GL_FRAGMENT_SHADER,
            &sampling_fragment_shader_code(sampler_type, function),
        )?;
        let sampling_vertex = ShaderDefinition::new(
            gl,
            base,
            glw::GL_VERTEX_SHADER,
            &sampling_vertex_shader_code(sampler_type, function),
        )?;
        self.compile(&pass_through_vertex)?;
        self.compile(&sampling_compute)?;
        self.compile(&sampling_fragment)?;
        self.compile(&sampling_vertex)?;

        let (
            mut pass_through_tessellation_control,
            mut sampling_tessellation_control,
            mut sampling_tessellation_evaluation,
        ) = (None, None, None);
        if tessellation {
            let pass_through = ShaderDefinition::new(
                gl,
                base,
                tokens.tess_control_shader,
                &pass_through_tessellation_control_shader_code(sampler_type, function),
            )?;
            let control = ShaderDefinition::new(
                gl,
                base,
                tokens.tess_control_shader,
                &sampling_tessellation_control_shader_code(sampler_type, function),
            )?;
            let evaluation = ShaderDefinition::new(
                gl,
                base,
                tokens.tess_evaluation_shader,
                &sampling_tessellation_evaluation_shader_code(sampler_type, function),
            )?;
            self.compile(&pass_through)?;
            self.compile(&control)?;
            self.compile(&evaluation)?;
            pass_through_tessellation_control = Some(pass_through);
            sampling_tessellation_control = Some(control);
            sampling_tessellation_evaluation = Some(evaluation);
        }

        let mut sampling_geometry = None;
        if geometry {
            let shader = ShaderDefinition::new(
                gl,
                base,
                tokens.geometry_shader,
                &sampling_geometry_shader_code(sampler_type, function),
            )?;
            self.compile(&shader)?;
            sampling_geometry = Some(shader);
        }

        Ok(FunctionShaders {
            pass_through_vertex,
            pass_through_tessellation_control,
            sampling_compute,
            sampling_fragment,
            sampling_geometry,
            sampling_tessellation_control,
            sampling_tessellation_evaluation,
            sampling_vertex,
        })
    }

    /// `shaderCollectionForTextureFormat::init`
    fn format_shaders(
        &mut self,
        gl: &'a glw::Functions,
        sampler_type: SamplerType,
    ) -> Result<FormatShaders<'a>, TestError> {
        let base = self.base;

        let pass_through_fragment = ShaderDefinition::new(
            gl,
            base,
            glw::GL_FRAGMENT_SHADER,
            &pass_through_fragment_shader_code(sampler_type),
        )?;
        let mut pass_through_tessellation_evaluation = None;
        if base.is_tessellation_shader_supported {
            pass_through_tessellation_evaluation = Some(ShaderDefinition::new(
                gl,
                base,
                base.gl_ext_tokens.tess_evaluation_shader,
                &pass_through_tessellation_evaluation_shader_code(sampler_type),
            )?);
        }
        self.compile(&pass_through_fragment)?;
        if let Some(shader) = &pass_through_tessellation_evaluation {
            self.compile(shader)?;
        }

        let mut per_function = Vec::new();
        for function in self.functions.clone() {
            if is_sampler_supported_by_function(sampler_type, function) {
                per_function.push(Some(self.function_shaders(gl, sampler_type, function)?));
            } else {
                per_function.push(None);
            }
        }
        Ok(FormatShaders {
            pass_through_fragment,
            pass_through_tessellation_evaluation,
            per_function,
        })
    }

    /// `programDefinition::init` for one shader type: `None` when upstream would leave the program id invalid
    fn init_program(
        &self,
        gl: &'a glw::Functions,
        format: &FormatShaders<'_>,
        function: &FunctionShaders<'_>,
        shader_type: ShaderType,
    ) -> Result<Option<ProgramDefinition<'a>>, TestError> {
        let tessellation_control_for_evaluation = if IS_CONTEXT_ES {
            function.pass_through_tessellation_control.as_ref()
        } else {
            None
        };

        let shaders: Option<Vec<&ShaderDefinition<'_>>> = match shader_type {
            ShaderType::Compute => Some(vec![&function.sampling_compute]),
            ShaderType::Fragment => Some(vec![&function.sampling_fragment, &function.pass_through_vertex]),
            ShaderType::Geometry => function
                .sampling_geometry
                .as_ref()
                .map(|geometry| vec![&format.pass_through_fragment, geometry, &function.pass_through_vertex]),
            ShaderType::TessellationControl => match (
                &function.sampling_tessellation_control,
                &format.pass_through_tessellation_evaluation,
            ) {
                (Some(control), Some(evaluation)) => Some(vec![
                    &format.pass_through_fragment,
                    control,
                    evaluation,
                    &function.pass_through_vertex,
                ]),
                _ => None,
            },
            ShaderType::TessellationEvaluation => match (
                tessellation_control_for_evaluation,
                &function.sampling_tessellation_evaluation,
            ) {
                (Some(control), Some(evaluation)) => Some(vec![
                    &format.pass_through_fragment,
                    control,
                    evaluation,
                    &function.pass_through_vertex,
                ]),
                _ => None,
            },
            ShaderType::Vertex => Some(vec![&format.pass_through_fragment, &function.sampling_vertex]),
        };
        let Some(shaders) = shaders else { return Ok(None) };

        // SAFETY: object creation on the current context.
        let id = unsafe { gl.create_program() };
        glu::expect_no_error(gl, "Failed to create program")?;
        if id == 0 {
            return Err(TestError::InternalError(
                "glCreateProgram return invalid id".to_string(),
            ));
        }
        let shaders = shaders
            .into_iter()
            .map(|shader| (shader.object.id, shader.source.clone()))
            .collect();
        Ok(Some(ProgramDefinition {
            object: GlObject::new(gl, ObjectKind::Program, id),
            shaders,
        }))
    }

    /// `programDefinition::link` and `link`
    fn link(&mut self, program: &ProgramDefinition<'_>) -> Result<(), TestError> {
        let gl = self.context.gl();
        let id = program.object.id;

        self.linked_programs += 1;
        for (shader_id, _) in &program.shaders {
            // SAFETY: attaches shaders this test created.
            unsafe { gl.attach_shader(id, *shader_id) };
            glu::expect_no_error(gl, "glAttachShader() call failed.")?;
        }
        // SAFETY: links a program this test created.
        unsafe { gl.link_program(id) };
        glu::expect_no_error(gl, "glLinkProgram() call failed.")?;
        let mut link_status: GLint = glw::GL_FALSE as GLint;
        // SAFETY: writes one GLint.
        unsafe { gl.get_programiv(id, glw::GL_LINK_STATUS, &mut link_status) };
        glu::expect_no_error(gl, "glGetProgramiv() call failed.")?;

        if link_status == glw::GL_FALSE as GLint {
            self.invalid_programs += 1;
            let info_log = self.base.get_info_log(self.context, LogType::Program, id)?;
            log::info!("Program linking failure:\n\n{info_log}");
            Self::log_program(program);
        }
        Ok(())
    }

    /// `logProgram`
    fn log_program(program: &ProgramDefinition<'_>) {
        let mut message = format!("Program id: {}", program.object.id);
        for (_, source) in &program.shaders {
            message += &format!("\nShader:\n{source}");
        }
        log::info!("{message}");
    }

    /// `checkUniformAndResourceApi`
    fn check_uniform_and_resource_api(
        &self,
        program_id: GLuint,
        sampler_name: &str,
        sampler_type: SamplerType,
    ) -> Result<GLuint, TestError> {
        let gl = self.context.gl();
        let name = CString::new(sampler_name).map_err(|e| TestError::InternalError(e.to_string()))?;
        let name_ptr = name.as_ptr();
        let mut index_get_active_uniform: GLuint = glw::GL_INVALID_INDEX;
        let mut size: GLint = 0;
        let mut type_get_active_uniform: GLenum = 0;
        let mut type_get_program_resourceiv: GLint = 0;
        let props: GLenum = glw::GL_TYPE;
        let mut result: GLuint = 0;

        // SAFETY: one name in, one index out.
        unsafe { gl.get_uniform_indices(program_id, 1, &name_ptr, &mut index_get_active_uniform) };
        glu::expect_no_error(gl, "glGetUniformIndices")?;
        if index_get_active_uniform == glw::GL_INVALID_INDEX {
            return Err(TestError::InternalError(
                "glGetUniformIndices: GL_INVALID_INDEX".to_string(),
            ));
        }

        // SAFETY: bufSize 0 and a null name, as upstream.
        unsafe {
            gl.get_active_uniform(
                program_id,
                index_get_active_uniform,
                0,
                std::ptr::null_mut(),
                &mut size,
                &mut type_get_active_uniform,
                std::ptr::null_mut(),
            )
        };
        glu::expect_no_error(gl, "glGetActiveUniform")?;

        // SAFETY: a name lookup.
        let index_get_program_resourceiv =
            unsafe { gl.get_program_resource_index(program_id, glw::GL_UNIFORM, name_ptr) };
        glu::expect_no_error(gl, "glGetProgramResourceIndex")?;
        if index_get_program_resourceiv == glw::GL_INVALID_INDEX {
            return Err(TestError::InternalError(
                "glGetProgramResourceIndex: GL_INVALID_INDEX".to_string(),
            ));
        }

        // SAFETY: one property in, one value out.
        unsafe {
            gl.get_program_resourceiv(
                program_id,
                glw::GL_UNIFORM,
                index_get_program_resourceiv,
                1,
                &props,
                1,
                std::ptr::null_mut(),
                &mut type_get_program_resourceiv,
            )
        };
        glu::expect_no_error(gl, "glGetProgramResourceiv")?;

        let expected_type = match sampler_type {
            SamplerType::Float => glw::GL_SAMPLER_CUBE_MAP_ARRAY,
            SamplerType::Int => glw::GL_INT_SAMPLER_CUBE_MAP_ARRAY,
            SamplerType::UInt => glw::GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY,
            SamplerType::Depth => glw::GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW,
            SamplerType::Stencil => glw::GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY,
        };
        if expected_type != type_get_active_uniform {
            result |= GET_TYPE_API_STATUS_UNIFORM;
        }
        if expected_type != type_get_program_resourceiv as GLuint {
            result |= GET_TYPE_API_STATUS_PROGRAM_RESOURCE;
        }
        Ok(result)
    }

    /// `prepareTexture`; the texture is bound to `GL_TEXTURE_CUBE_MAP_ARRAY`
    fn prepare_texture(
        &self,
        texture: GLuint,
        format: &FormatDefinition,
        resolution: [GLuint; 3],
        mutability: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let [width, height, depth] = resolution;
        let n_elements = (depth / N_FACES) as i32;
        let n_mipmap_levels = mipmap_level_count(width as i32, height as i32);

        // SAFETY: binds a texture this test created.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, texture) };
        glu::expect_no_error(gl, "Failed to bind texture")?;

        if !mutability {
            // SAFETY: allocates storage for the bound texture.
            unsafe {
                gl.tex_storage_3d(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    n_mipmap_levels,
                    format.src_internal_format,
                    width as GLsizei,
                    height as GLsizei,
                    depth as GLsizei,
                )
            };
        } else {
            let (mut texture_width, mut texture_height) = (width as i32, height as i32);

            for mipmap_level in 0..n_mipmap_levels {
                // SAFETY: allocates a level without data.
                unsafe {
                    gl.tex_image_3d(
                        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                        mipmap_level,
                        format.src_internal_format as GLint,
                        texture_width,
                        texture_height,
                        depth as GLsizei,
                        0,
                        format.src_format,
                        format.src_type,
                        std::ptr::null(),
                    )
                };
                texture_width = (texture_width / 2).max(1);
                texture_height = (texture_height / 2).max(1);
            }
        }
        glu::expect_no_error(gl, "Failed to allocate storage for texture")?;

        let (mut texture_width, mut texture_height) = (width as i32, height as i32);
        for mipmap_level in 0..n_mipmap_levels {
            for element_index in 0..n_elements {
                for face in 0..N_FACES as i32 {
                    prepare_texture_face(
                        gl,
                        face,
                        element_index,
                        mipmap_level,
                        n_elements,
                        n_mipmap_levels,
                        format.src_format,
                        format.src_type,
                        texture_width,
                        texture_height,
                    )?;
                }
            }
            texture_width = (texture_width / 2).max(1);
            texture_height = (texture_height / 2).max(1);
        }

        if matches!(
            format.src_internal_format,
            glw::GL_RGBA32UI | glw::GL_RGBA32I | glw::GL_STENCIL_INDEX8 | glw::GL_DEPTH_COMPONENT32F
        ) {
            // SAFETY: parameters of the bound texture.
            unsafe {
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_MAG_FILTER,
                    glw::GL_NEAREST as GLint,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_MIN_FILTER,
                    glw::GL_NEAREST_MIPMAP_NEAREST as GLint,
                );
            }
        }
        Ok(())
    }

    /// `textureDefinition::setupSampler`
    fn setup_sampler(
        &self,
        texture: GLuint,
        texture_unit: GLuint,
        sampler_name: &str,
        program_id: GLuint,
        is_shadow: bool,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let name = CString::new(sampler_name).map_err(|e| TestError::InternalError(e.to_string()))?;

        // SAFETY: a name lookup.
        let sampler_location = unsafe { gl.get_uniform_location(program_id, name.as_ptr()) };
        // SAFETY: an error query.
        if sampler_location == -1 || glw::GL_NO_ERROR != unsafe { gl.get_error() } {
            return Ok(());
        }

        // SAFETY: binds a texture this test created.
        unsafe { gl.active_texture(glw::GL_TEXTURE0 + texture_unit) };
        glu::expect_no_error(gl, "Failed to activate texture unit")?;
        // SAFETY: as above.
        unsafe { gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, texture) };
        glu::expect_no_error(gl, "Failed to bind texture to GL_TEXTURE_CUBE_MAP_ARRAY_EXT")?;

        if is_shadow {
            // SAFETY: parameters of the bound texture.
            unsafe {
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_COMPARE_MODE,
                    glw::GL_COMPARE_REF_TO_TEXTURE as GLint,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                    glw::GL_TEXTURE_COMPARE_FUNC,
                    glw::GL_LESS as GLint,
                );
            }
        }
        // SAFETY: sets a uniform of the program in use.
        unsafe { gl.uniform_1i(sampler_location, texture_unit as GLint) };
        glu::expect_no_error(gl, "Failed to set sampler uniform")
    }

    /// `vertexArrayObjectDefinition::setupAttribute`
    fn setup_attribute(
        &self,
        attribute: &AttributeDefinition,
        buffers: &BufferCollection<'_>,
        program_id: GLuint,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();
        let attribute_name = CString::new(format!("{VERTEX_SHADER_INPUT}{}", attribute.name))
            .map_err(|e| TestError::InternalError(e.to_string()))?;
        let n_components = match attribute.id {
            AttributeId::Position
            | AttributeId::TextureCoordinates
            | AttributeId::TextureCoordinatesForGather
            | AttributeId::GradX
            | AttributeId::GradY => 4,
            AttributeId::Lod | AttributeId::RefZ => 1,
        };

        // SAFETY: a name lookup.
        let attribute_location = unsafe { gl.get_attrib_location(program_id, attribute_name.as_ptr()) };
        // SAFETY: an error query.
        if attribute_location == -1 || glw::GL_NO_ERROR != unsafe { gl.get_error() } {
            return Ok(());
        }

        // SAFETY: binds a buffer this test created and describes it as a float attribute.
        unsafe { gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffers.buffer(attribute.id).id) };
        glu::expect_no_error(gl, "Failed to bind buffer.")?;
        // SAFETY: as above.
        unsafe { gl.enable_vertex_attrib_array(attribute_location as GLuint) };
        glu::expect_no_error(gl, "Failed to enable attribute")?;
        // SAFETY: as above; the data comes from the bound buffer at offset 0.
        unsafe {
            gl.vertex_attrib_pointer(
                attribute_location as GLuint,
                n_components,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                std::ptr::null(),
            )
        };
        glu::expect_no_error(gl, "Failed to setup vertex attribute arrays")
    }

    /// `setupSharedStorageBuffers`
    fn setup_shared_storage_buffers(
        &self,
        sampler_type: SamplerType,
        function: SamplingFunction,
        buffers: &BufferCollection<'_>,
    ) -> Result<(), TestError> {
        let gl = self.context.gl();

        for attribute in all_attributes(sampler_type, function) {
            // SAFETY: binds a buffer this test created.
            unsafe {
                gl.bind_buffer_base(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    attribute.binding,
                    buffers.buffer(attribute.id).id,
                )
            };
            glu::expect_no_error(gl, "Failed to bind buffer.")?;
            glu::expect_no_error(gl, "Failed to setup shared storage block")?;
        }
        Ok(())
    }

    /// `draw`
    fn draw(&self, primitive_type: GLenum, n_vertices: GLuint, format: GLenum) -> Result<(), TestError> {
        let gl = self.context.gl();

        // SAFETY: a status query.
        let framebuffer_status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
        if framebuffer_status != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::InternalError("Framebuffer is incomplete".to_string()));
        }

        match format {
            glw::GL_RGBA32I => {
                let clear_value: [GLint; 4] = [255, 255, 255, 255];
                // SAFETY: four values for draw buffer 0.
                unsafe { gl.clear_bufferiv(glw::GL_COLOR, 0, clear_value.as_ptr()) };
                glu::expect_no_error(gl, "Failed glClearBufferiv call.")?;
            }
            glw::GL_RGBA32UI | glw::GL_R32UI => {
                let clear_value: [GLuint; 4] = [255, 255, 255, 255];
                // SAFETY: four values for draw buffer 0.
                unsafe { gl.clear_bufferuiv(glw::GL_COLOR, 0, clear_value.as_ptr()) };
                glu::expect_no_error(gl, "Failed glClearBufferuiv call.")?;
            }
            glw::GL_DEPTH_COMPONENT32F => {
                // SAFETY: sets clear state.
                unsafe { gl.clear_depthf(1.0) };
                glu::expect_no_error(gl, "Failed glClearDepthf call.")?;
            }
            glw::GL_STENCIL_INDEX8 => {
                // SAFETY: sets clear state.
                unsafe { gl.clear_stencil(1) };
                glu::expect_no_error(gl, "Failed glClearStencil call.")?;
            }
            _ => {
                // SAFETY: clears the draw framebuffer.
                unsafe { gl.clear_color(1.0, 1.0, 1.0, 1.0) };
                glu::expect_no_error(gl, "Failed glClearColor call.")?;
                // SAFETY: as above.
                unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };
                glu::expect_no_error(gl, "Failed glClear call.")?;
            }
        }

        // SAFETY: attributes come from buffers bound in the current VAO.
        unsafe { gl.draw_arrays(primitive_type, 0, n_vertices as GLsizei) };
        glu::expect_no_error(gl, "Failed glDrawArrays call.")
    }

    /// `verifyResult` and `verifyResultHelper`
    fn verify_result(
        &self,
        format: &FormatDefinition,
        resolution: [GLuint; 3],
        function: SamplingFunction,
        data: &[u8],
    ) -> bool {
        let n_mipmap_levels = mipmap_level_count(resolution[0] as i32, resolution[1] as i32);
        let n_layers = resolution[2] / N_FACES;
        let lod = matches!(function, SamplingFunction::TextureLod | SamplingFunction::TextureGrad);
        let expected = Expected {
            lod,
            n_mipmap_levels,
            n_layers: n_layers as i32,
        };
        let mip = |pixel: u32| expected.mipmap_level(pixel);

        match (format.src_format, format.src_type) {
            (glw::GL_RGBA, glw::GL_UNSIGNED_BYTE) => {
                verify_result_image::<u8, 4>(n_layers, data, |pixel, face, layer| {
                    color_int_components::<u8>(face as i32, layer as i32, mip(pixel))
                })
            }
            (glw::GL_RGBA, glw::GL_FLOAT) => verify_result_image::<f32, 4>(n_layers, data, |pixel, face, layer| {
                color_float_components(
                    face as i32,
                    layer as i32,
                    mip(pixel),
                    expected.n_layers,
                    n_mipmap_levels,
                )
            }),
            (glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_INT) => {
                verify_result_image::<u32, 4>(n_layers, data, |pixel, face, layer| {
                    color_int_components::<u32>(face as i32, layer as i32, mip(pixel))
                })
            }
            (glw::GL_RGBA_INTEGER, glw::GL_INT) => {
                verify_result_image::<i32, 4>(n_layers, data, |pixel, face, layer| {
                    color_int_components::<i32>(face as i32, layer as i32, mip(pixel))
                })
            }
            (glw::GL_DEPTH_COMPONENT, glw::GL_FLOAT) => {
                verify_result_image::<f32, 1>(n_layers, data, |pixel, _face, _layer| {
                    if lod {
                        [if pixel % 2 == 0 { 0.0 } else { 1.0 }]
                    } else {
                        [[1.0f32, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0][pixel as usize]]
                    }
                })
            }
            (glw::GL_STENCIL_INDEX, glw::GL_UNSIGNED_BYTE) => {
                verify_result_image::<u32, 1>(n_layers, data, |pixel, face, layer| {
                    [stencil_component(
                        face as i32,
                        layer as i32,
                        mip(pixel),
                        expected.n_layers,
                        n_mipmap_levels,
                    ) as u32]
                })
            }
            _ => false,
        }
    }

    /// The part of `testTexture` that sits in upstream's `try`: returns the image verdict and the type API status
    #[allow(clippy::too_many_arguments)]
    fn run_case(
        &self,
        format: &FormatDefinition,
        resolution: [GLuint; 3],
        texture: GLuint,
        function: SamplingFunction,
        shader: &ShaderConfiguration,
        program_id: GLuint,
        color_attachment: GLuint,
        buffers: &BufferCollection<'_>,
        result_image: &mut [u8],
    ) -> Result<(bool, GLuint), TestError> {
        let gl = self.context.gl();
        let image_width = 3 * resolution[2];
        let image_height = 3;

        // SAFETY: framebuffer binds and a program in use, all created by this test.
        unsafe {
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.framebuffer_object_id);
        }
        glu::expect_no_error(gl, "glBindFramebuffer")?;
        // SAFETY: as above.
        unsafe { gl.use_program(program_id) };
        glu::expect_no_error(gl, "Failed glUseProgram call.")?;

        self.setup_sampler(
            texture,
            0,
            SAMPLER_NAME,
            program_id,
            format.sampler_type == SamplerType::Depth,
        )?;

        if shader.type_ != ShaderType::Compute {
            let mut vao_id: GLuint = 0;
            // SAFETY: object creation on the current context.
            unsafe { gl.gen_vertex_arrays(1, &mut vao_id) };
            let _vao = GlObject::new(gl, ObjectKind::VertexArray, vao_id);
            glu::expect_no_error(gl, "Failed to generate VAO.")?;
            // SAFETY: binds the VAO just created.
            unsafe { gl.bind_vertex_array(vao_id) };
            glu::expect_no_error(gl, "Failed to bind VAO.")?;

            self.setup_attribute(&POSITION_ATTRIBUTE, buffers, program_id)?;
            for attribute in all_attributes(format.sampler_type, function) {
                self.setup_attribute(attribute, buffers, program_id)?;
            }
            self.draw(
                shader.primitive_type,
                image_width * image_height,
                format.dst_internal_format,
            )?;
        } else {
            self.setup_shared_storage_buffers(format.sampler_type, function, buffers)?;
            // SAFETY: a dispatch of the program in use.
            unsafe { gl.dispatch_compute(image_width, image_height, 1) };
            glu::expect_no_error(gl, "Failed glDispatchCompute call.")?;
        }

        // SAFETY: framebuffer binds, attachment and a read back into `result_image`, which holds `image_width * image_height` RGBA pixels of 4 bytes per component at most.
        unsafe {
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.framebuffer_object_id);
        }
        glu::expect_no_error(gl, "glBindFramebuffer")?;
        // SAFETY: as above.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, color_attachment);
            gl.framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                color_attachment,
                0,
            );
        }
        glu::expect_no_error(gl, "framebufferTexture2D")?;
        // SAFETY: a viewport.
        unsafe { gl.viewport(0, 0, 3 * resolution[2] as GLint, 3) };
        glu::expect_no_error(gl, "viewport")?;
        // SAFETY: a barrier.
        unsafe { gl.memory_barrier(glw::GL_PIXEL_BUFFER_BARRIER_BIT) };
        // SAFETY: see above for the size of `result_image`.
        unsafe {
            gl.read_pixels(
                0,
                0,
                image_width as GLsizei,
                image_height as GLsizei,
                format.dst_format,
                format.dst_type,
                result_image.as_mut_ptr().cast(),
            )
        };
        glu::expect_no_error(gl, "glReadPixels")?;

        let n_pixels = (image_width * image_height) as usize;

        // GL_DEPTH_COMPONENT is nominally R32F, but R32F is not renderable, so RGBA8 is used; convert the red channel back to R32F.
        if format.src_format == glw::GL_DEPTH_COMPONENT {
            for i in 0..n_pixels {
                let value = result_image[4 * i] as f32 / 255.0f32;
                result_image[4 * i..4 * i + 4].copy_from_slice(&value.to_ne_bytes());
            }
        }

        // GL_STENCIL_INDEX is nominally one-channel, but ReadPixels supports only RGBA formats; convert the RGBA image to R.
        if format.src_format == glw::GL_STENCIL_INDEX && format.dst_format == glw::GL_RGBA_INTEGER {
            for i in 0..n_pixels {
                let red = [
                    result_image[16 * i],
                    result_image[16 * i + 1],
                    result_image[16 * i + 2],
                    result_image[16 * i + 3],
                ];
                result_image[4 * i..4 * i + 4].copy_from_slice(&red);
            }
        }

        let get_type_api_status = self.check_uniform_and_resource_api(program_id, SAMPLER_NAME, format.sampler_type)?;
        let verification_result = self.verify_result(format, resolution, function, result_image);
        Ok((verification_result, get_type_api_status))
    }

    /// `testTexture`
    fn test_texture(
        &mut self,
        format: &FormatDefinition,
        mutability: bool,
        resolution: [GLuint; 3],
        texture: GLuint,
        programs: &[Option<FunctionPrograms<'_>>],
    ) -> Result<(), TestError> {
        let ctx: &'a Context = self.context;
        let gl = ctx.gl();
        let image_width = 3 * resolution[2];
        let image_height = 3;
        let mut result_image = vec![0u8; (image_width * image_height * 4) as usize * std::mem::size_of::<GLuint>()];
        let buffers = BufferCollection::new(gl, resolution)?;

        for (function_index, function) in self.functions.clone().into_iter().enumerate() {
            for shader_index in 0..self.shaders.len() {
                let (shader_type, primitive_type, shader_name) = {
                    let shader = &self.shaders[shader_index];
                    (shader.type_, shader.primitive_type, shader.name)
                };
                let Some(function_programs) = &programs[function_index] else {
                    continue;
                };
                let Some(program) = &function_programs[shader_type as usize] else {
                    continue;
                };
                let program_id = program.object.id;

                self.tested_cases += 1;

                let mut color_attachment_id: GLuint = 0;
                // SAFETY: object creation on the current context.
                unsafe { gl.gen_textures(1, &mut color_attachment_id) };
                let _color_attachment = GlObject::new(gl, ObjectKind::Texture, color_attachment_id);
                glu::expect_no_error(gl, "Failed to generate texture")?;

                if shader_type != ShaderType::Compute {
                    TestCaseBase::setup_framebuffer_with_texture_as_attachment(
                        ctx,
                        self.framebuffer_object_id,
                        color_attachment_id,
                        format.dst_internal_format,
                        image_width,
                        image_height,
                    )?;
                } else {
                    // SAFETY: allocates the result image and binds it for image stores.
                    unsafe {
                        gl.bind_texture(glw::GL_TEXTURE_2D, color_attachment_id);
                        gl.tex_storage_2d(
                            glw::GL_TEXTURE_2D,
                            1,
                            format.dst_internal_format,
                            image_width as GLsizei,
                            image_height as GLsizei,
                        );
                        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
                        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
                        gl.bind_image_texture(
                            0,
                            color_attachment_id,
                            0,
                            glw::GL_FALSE as glw::GLboolean,
                            0,
                            glw::GL_WRITE_ONLY,
                            format.dst_internal_format,
                        );
                    }
                    glu::expect_no_error(gl, "glBindImageTexture")?;
                }

                let configuration = ShaderConfiguration {
                    type_: shader_type,
                    primitive_type,
                    name: shader_name,
                };
                match self.run_case(
                    format,
                    resolution,
                    texture,
                    function,
                    &configuration,
                    program_id,
                    color_attachment_id,
                    &buffers,
                    &mut result_image,
                ) {
                    Ok((verification_result, get_type_api_status)) => {
                        if !verification_result || get_type_api_status != 0 {
                            log::info!("Invalid result");
                            if !verification_result {
                                log::info!("Invalid image");
                            }
                            if get_type_api_status & GET_TYPE_API_STATUS_UNIFORM != 0 {
                                log::info!("glGetActiveUniform returns wrong type for sampler");
                            }
                            if get_type_api_status & GET_TYPE_API_STATUS_PROGRAM_RESOURCE != 0 {
                                log::info!("glGetProgramResourceiv returns wrong type for sampler");
                            }
                            log::info!(
                                "Format: {}, Mutability: {}, Sampling shader: {}, Sampling function: {}, W: {}, H: {}",
                                format.name,
                                mutability as u32,
                                configuration.name,
                                function_name(function),
                                resolution[0],
                                resolution[1]
                            );
                            Self::log_program(program);

                            if !verification_result {
                                self.failed_cases += 1;
                            }
                            if get_type_api_status != 0 {
                                self.invalid_type_cases += 1;
                            }
                        }
                    }
                    Err(error) => {
                        log::info!("Exception during test execution: {error}");
                        log::info!(
                            "Format: {}, Mutability: {}, W: {}, H: {}",
                            format.name,
                            mutability as u32,
                            resolution[0],
                            resolution[1]
                        );
                        Self::log_program(program);
                        self.failed_cases += 1;
                    }
                }
            }
        }
        Ok(())
    }

    /// `testFormats` for one `(formats, resolutions)` set
    fn test_formats(&mut self) -> Result<(), TestError> {
        let ctx: &'a Context = self.context;
        let gl = ctx.gl();

        for format_index in 0..self.formats.len() {
            let sampler_type = self.formats[format_index].sampler_type;
            let format_shaders = self.format_shaders(gl, sampler_type)?;

            let mut programs: Vec<Option<FunctionPrograms<'_>>> = Vec::new();
            for function_shaders in &format_shaders.per_function {
                let Some(function_shaders) = function_shaders else {
                    programs.push(None);
                    continue;
                };
                let mut function_programs: FunctionPrograms<'_> = std::array::from_fn(|_| None);
                let mut shader_types = vec![ShaderType::Compute, ShaderType::Fragment, ShaderType::Vertex];
                if self.base.is_geometry_shader_extension_supported {
                    shader_types.push(ShaderType::Geometry);
                }
                if self.base.is_tessellation_shader_supported {
                    shader_types.push(ShaderType::TessellationControl);
                    shader_types.push(ShaderType::TessellationEvaluation);
                }
                for shader_type in shader_types {
                    let program = self.init_program(gl, &format_shaders, function_shaders, shader_type)?;
                    if let Some(program) = &program {
                        self.link(program)?;
                    } else {
                        self.linked_programs += 1;
                    }
                    function_programs[shader_type as usize] = program;
                }
                programs.push(Some(function_programs));
            }

            for mutability in self.mutabilities {
                for resolution in self.resolutions {
                    let mut texture_id: GLuint = 0;
                    // SAFETY: object creation on the current context.
                    unsafe { gl.gen_textures(1, &mut texture_id) };
                    let _texture = GlObject::new(gl, ObjectKind::Texture, texture_id);
                    glu::expect_no_error(gl, "Failed to generate texture")?;

                    let format = &self.formats[format_index];
                    let prepared = self.prepare_texture(texture_id, format, resolution, mutability);
                    if let Err(error) = prepared {
                        log::info!("Exception during texture creation: {error}");
                        log::info!(
                            "Format: {}, Mutability: {}, W: {}, H: {}",
                            format.name,
                            mutability as u32,
                            resolution[0],
                            resolution[1]
                        );
                        continue;
                    }

                    let format = self.formats[format_index].clone();
                    self.test_texture(&format, mutability, resolution, texture_id, &programs)?;
                }
            }
        }
        Ok(())
    }

    /// `iterate`
    fn run(&mut self) -> Result<bool, TestError> {
        let ctx: &'a Context = self.context;
        let gl = ctx.gl();
        let base = self.base;

        if !base.is_texture_cube_map_array_supported {
            return Err(TestError::NotSupported(
                TEXTURE_CUBE_MAP_ARRAY_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        self.shaders.push(ShaderConfiguration {
            type_: ShaderType::Compute,
            primitive_type: glw::GL_POINTS,
            name: "Compute",
        });
        self.shaders.push(ShaderConfiguration {
            type_: ShaderType::Fragment,
            primitive_type: glw::GL_POINTS,
            name: "Fragment",
        });
        self.shaders.push(ShaderConfiguration {
            type_: ShaderType::Vertex,
            primitive_type: glw::GL_POINTS,
            name: "Vertex",
        });
        if base.is_geometry_shader_extension_supported {
            self.shaders.push(ShaderConfiguration {
                type_: ShaderType::Geometry,
                primitive_type: glw::GL_POINTS,
                name: "Geometry",
            });
        }
        if base.is_tessellation_shader_supported {
            self.shaders.push(ShaderConfiguration {
                type_: ShaderType::TessellationControl,
                primitive_type: base.gl_ext_tokens.patches,
                name: "Tesselation_Control",
            });
            self.shaders.push(ShaderConfiguration {
                type_: ShaderType::TessellationEvaluation,
                primitive_type: base.gl_ext_tokens.patches,
                name: "Tesselation_Evaluation",
            });
        }

        // SAFETY: object creation and state on the current context.
        unsafe { gl.gen_framebuffers(1, &mut self.framebuffer_object_id) };
        if base.is_tessellation_shader_supported {
            // SAFETY: as above.
            unsafe { gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 1) };
        }
        // SAFETY: as above.
        unsafe {
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 1);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1);
        }

        let tested = self.test_formats();

        if base.is_tessellation_shader_supported {
            // SAFETY: restores state.
            unsafe { gl.patch_parameteri(base.gl_ext_tokens.patch_vertices, 3) };
        }
        // SAFETY: restores state and deletes the framebuffer this test created.
        unsafe {
            gl.pixel_storei(glw::GL_PACK_ALIGNMENT, 4);
            gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 4);
            gl.delete_framebuffers(1, &self.framebuffer_object_id);
        }
        self.framebuffer_object_id = 0;
        tested?;

        let passed = self.failed_cases == 0 && self.invalid_type_cases == 0;
        if !passed {
            log::info!("Test failed! Number of found errors: {}", self.failed_cases);
            log::info!("Invalid shaders: {}", self.invalid_shaders);
            log::info!("Invalid programs: {}", self.invalid_programs);
            log::info!(
                "glGetActiveUniform or glGetProgramResourceiv reported invalid type: {}",
                self.invalid_type_cases
            );
        }
        log::info!("Number of executed test cases: {}", self.tested_cases);
        log::info!("Total shaders: {}", self.compiled_shaders);
        log::info!("Total programs: {}", self.linked_programs);
        Ok(passed)
    }
}

fn function_name(function: SamplingFunction) -> &'static str {
    match function {
        SamplingFunction::Texture => "Texture",
        SamplingFunction::TextureLod => "TextureLod",
        SamplingFunction::TextureGrad => "TextureGrad",
        SamplingFunction::TextureGather => "TextureGather",
    }
}

impl TestCase for Sampling {
    fn name(&self) -> &str {
        "sampling"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut runner = Runner::new(context, &base);

        Ok(if runner.run()? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
