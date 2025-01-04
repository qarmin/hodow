#!/usr/bin/env python3
"""Writes the GLSL of dEQP-VK.glsl.builtin_var (shaderrender/vktShaderRenderBuiltinVarTests.cpp) and its manifest.

Covers `simple.fragcoord_xyz`, `simple.fragcoord_w` and the eight `input_variations` cases (the C++ `initPrograms` replayed here).

  * shaders/manifest/shader_render_builtin_var.toml and shaders/src/shader_render_builtin_var/

Run from hodow_cts/:  python3 scripts/gen_shader_render_builtin_var.py   (then `just cts-shaders`)
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "shader_render_builtin_var"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_render_builtin_var.toml"

POSITION_VERT = "#version 310 es\nlayout(location = 0) in highp vec4 a_position;\nvoid main (void)\n{\n       gl_Position = a_position;\n}\n"
FRAGCOORD_XYZ_FRAG = (
    "#version 310 es\nlayout(set=0, binding=0) uniform Scale { highp vec3 u_scale; };\nlayout(location = 0) out highp vec4 o_color;\n"
    "void main (void)\n{\n       o_color = vec4(gl_FragCoord.xyz * u_scale, 1.0);\n}\n"
)
FRAGCOORD_W_FRAG = "#version 310 es\nlayout(location = 0) out highp vec4 o_color;\nvoid main (void)\n{\n       o_color = vec4(0.0, 1.0 / gl_FragCoord.w - 1.0, 0.0, 1.0);\n}\n"

FRONTFACING_VERT = (
    "#version 310 es\n\nlayout(location = 0) in highp vec4 position;\nvoid main()\n{\ngl_Position = position;\ngl_PointSize = 1.0;\n}\n"
)
FRONTFACING_SIMPLE_FRAG = (
    "#version 310 es\n\nlayout(location = 0) out mediump vec4 color;\nvoid main()\n{\nif (gl_FrontFacing)\n    color = vec4(1.0, 0.0, 0.0, 1.0);\n"
    "else\n    color = vec4(0.0, 1.0, 0.0, 1.0);\n}\n"
)
FRONTFACING_UBO_FRAG = (
    "#version 310 es\n\nlayout(location = 0) out highp vec4 color;\nlayout(set = 0, binding = 0) uniform UboData {\n    highp float data;\n} ubo;\n"
    "void main()\n{\n    highp float c = (gl_FrontFacing ? 1.0 : -1.0) + ubo.data;\n    color = vec4(c);\n}\n"
)

BUILTIN, VARYING, CONSTANT = 1, 2, 4


def input_type_name(types):
    if types == 0:
        return "input_none"
    name = "input"
    if types & BUILTIN:
        name += "_builtin"
    if types & VARYING:
        name += "_varying"
    if types & CONSTANT:
        name += "_constant"
    return name


def input_variation_shaders(types):
    varying = types & VARYING
    vertex = (
        "#version 450\nlayout(location = 0) in highp vec4 a_position;\nout gl_PerVertex {\n    vec4 gl_Position;\n};\n"
        + ("layout(location = 1) in highp vec4 a_color;\nlayout(location = 0) out highp vec4 v_color;\n" if varying else "")
        + "void main (void)\n{\n    gl_Position = a_position;\n    "
        + ("v_color = a_color;\n" if varying else "")
        + "}\n"
    )
    fragment = (
        "#version 450\n"
        + ("layout(location = 0) in highp vec4 a_color;\n" if varying else "")
        + ("layout(push_constant) uniform PCBlock {\n  vec4 color;\n} pc;\n" if types & CONSTANT else "")
        + "layout(location = 0) out highp vec4 o_color;\nvoid main (void)\n{\n    o_color = vec4(0.1, 0.2, 0.3, 1.0);\n    "
        + ("if (gl_FrontFacing)\n" if types & BUILTIN else "")
        + "    "
        + ("o_color += vec4(a_color.xyz, 0.0);\n" if varying else "o_color += vec4(0.3, 0.2, 0.1, 0.0);\n")
        + "    "
        + ("o_color += pc.color;\n" if types & CONSTANT else "")
        + "}\n"
    )
    return vertex, fragment


POINTCOORD_VERT = (
    "#version 310 es\nlayout(location = 0) in highp vec3 a_position;\nvoid main (void)\n{\n    gl_Position = vec4(a_position.xy, 0.0, 1.0);\n"
    "    gl_PointSize = a_position.z;\n}\n"
)
POINTCOORD_FRAG = (
    "#version 310 es\nlayout(location = 0) out lowp vec4 o_color;\nvoid main (void)\n{\n    o_color = vec4(gl_PointCoord, 0.0, 1.0);\n}\n"
)
POINTCOORD_UNIFORM_FRAGMENT_FRAG = (
    "#version 310 es\nlayout(set=0, binding=0) uniform Scale { highp vec3 u_scale; };\nlayout(location = 0) out lowp vec4 o_color;\n"
    "void main (void)\n{\n    o_color = vec4(gl_PointCoord, 0.0, 1.0) * vec4(u_scale, 1.0);\n}\n"
)
POINTCOORD_UNIFORM_VERTEX_VERT = (
    "#version 310 es\nlayout(set=0, binding=0) uniform Scale { highp vec3 u_scale; };\nlayout(location = 0) in highp vec3 a_position;\n"
    "void main (void)\n{\n    gl_Position = vec4(a_position.xy, 0.0, 1.0) * vec4(u_scale, 1.0);\n    gl_PointSize = a_position.z;\n}\n"
)

FRAGDEPTH_SAMPLES = (1, 2, 4, 8, 16, 32, 64)
FRAGDEPTH_SIZE = 16


def fragdepth_programs(samples):
    vert1 = "#version 450\n\nlayout (location = 0) in vec4 position;\nvoid main()\n{\n    gl_Position = position;\n    gl_PointSize = 1.0;\n}\n"
    vert2 = (
        "#version 450\n\nlayout (location = 0) in vec4 position;\nlayout (location = 1) out vec2 texCoord;\nvoid main()\n{\n"
        "    gl_Position = position;\n    gl_PointSize = 1.0;\n    texCoord = position.xy/2 + vec2(0.5);\n}\n"
    )
    frag1 = (
        "#version 450\n\nlayout(location = 0) out mediump vec4 color;\nlayout (std140, set = 0, binding = 0) uniform control_buffer_t\n{\n"
        "    float data[256];\n} control_buffer;\nlayout (set = 0, binding = 1, rgba8ui) writeonly uniform uimage2D storageImage;\n"
        "float controlDepthValue;\nvoid recheck(float controlDepthValue)\n{\n    if (gl_FragDepth != controlDepthValue)\n        gl_FragDepth = 1.0;\n}\n"
        "void main()\n{\n"
        f"    const int numSamples = {samples};\n"
        f"    if (int(gl_FragCoord.x) == {FRAGDEPTH_SIZE // 4})\n        discard;\n"
        f"    highp int index =int(gl_FragCoord.y) * {FRAGDEPTH_SIZE} + int(gl_FragCoord.x);\n"
        "    controlDepthValue = control_buffer.data[index];\n    gl_FragDepth = controlDepthValue;\n    const int sampleNdx = int(gl_SampleID);\n"
        f"    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * {samples}, int(gl_FragCoord.y));\n"
        "    imageStore(storageImage, imageCoord, uvec4(1));\n    recheck(controlDepthValue);\n    color = vec4(1.0, 0.0, 0.0, 1.0);\n}\n"
    )
    ms = "MS" if samples != 1 else ""
    frag2 = (
        "#version 450\n\nlayout (location = 0) out mediump vec4 color;\nlayout (location = 1) in vec2 texCoord;\n"
        f"layout (binding = 0, set = 0) uniform sampler2D{ms} u_depthTex;\n"
        "layout (binding = 1, set = 0, r32f) writeonly uniform image2D u_outImage;\nvoid main (void)\n{\n"
        f"    const int numSamples = {samples};\n    const int sampleNdx = int(gl_SampleID);\n"
        f"    ivec2 renderSize = ivec2({FRAGDEPTH_SIZE},{FRAGDEPTH_SIZE});\n"
        "    ivec2 imageCoord = ivec2(int(texCoord.x * renderSize.x), int(texCoord.y * renderSize.y));\n"
        "    vec4 depthVal = texelFetch(u_depthTex, imageCoord, sampleNdx);\n"
        "    imageStore(u_outImage, ivec2(sampleNdx + int(texCoord.x * renderSize.x) * numSamples, int(texCoord.y * renderSize.y)), depthVal);\n"
        "    color = vec4(1.0, 0.0, 0.0, 1.0);\n}\n"
    )
    return (
        ("FragDepthVert", "vert", vert1),
        ("FragDepthFrag", "frag", frag1),
        ("FragDepthVertPass2", "vert", vert2),
        ("FragDepthFragPass2", "frag", frag2),
    )


def fragcoord_msaa_programs():
    """FragCoordMsaaVert/Frag of BuiltinFragCoordMsaaTestCase::initPrograms: one set per sample count with sample shading, and two without."""
    vert = "#version 450\n\nlayout (location = 0) in vec4 position;\nvoid main()\n{\n    gl_Position = position;\n}\n"
    entries = []
    for samples in FRAGDEPTH_SAMPLES:
        frag = (
            "#version 450\n\nlayout(location = 0) out mediump vec4 color;\nlayout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;\n"
            "void main()\n{\n    const int sampleNdx = int(gl_SampleID);\n"
            f"    ivec2 imageCoord = ivec2(sampleNdx + int(gl_FragCoord.x) * {samples}, int(gl_FragCoord.y));\n"
            "    imageStore(storageImage, imageCoord, gl_FragCoord);\n    color = vec4(1.0, 0.0, 0.0, 1.0);\n}\n"
        )
        entries.append((f"fragcoord_msaa_s{samples}", (("FragCoordMsaaVert", "vert", vert), ("FragCoordMsaaFrag", "frag", frag))))
    frag = (
        "#version 450\n\nlayout (location = 0) out mediump vec4 color;\nlayout (set = 0, binding = 0, rgba32f) writeonly uniform image2D storageImage;\n"
        "void main()\n{\n    ivec2 imageCoord = ivec2(int(gl_FragCoord.x), int(gl_FragCoord.y));\n"
        "    imageStore(storageImage, imageCoord, gl_FragCoord);\n    color = vec4(1.0, 0.0, 0.0, 1.0);\n}\n"
    )
    entries.append(("fragcoord_msaa_noshading", (("FragCoordMsaaVert", "vert", vert), ("FragCoordMsaaFrag", "frag", frag))))
    asm = "; SPIR - V\n; Version: 1.0\n; Generator: Khronos Glslang Reference Front End; 10\n; Bound: 36\n; Schema: 0\n" + "\n".join(
        [
            "OpCapability Shader",
            '%1 = OpExtInstImport "GLSL.std.450"',
            "OpMemoryModel Logical GLSL450",
            'OpEntryPoint Fragment %main "main" %gl_FragCoord %color',
            "OpExecutionMode %main OriginUpperLeft",
            "OpSource GLSL 450",
            'OpName %main "main"',
            'OpName %imageCoord "imageCoord"',
            'OpName %gl_FragCoord "gl_FragCoord"',
            'OpName %storageImage "storageImage"',
            'OpName %color "color"',
            "OpDecorate %gl_FragCoord BuiltIn FragCoord",
            "OpDecorate %gl_FragCoord Centroid",
            "OpDecorate %storageImage DescriptorSet 0",
            "OpDecorate %storageImage Binding 0",
            "OpDecorate %storageImage NonReadable",
            "OpDecorate %color RelaxedPrecision",
            "OpDecorate %color Location 0",
            "%void = OpTypeVoid",
            "%3 = OpTypeFunction %void",
            "%int = OpTypeInt 32 1",
            "%v2int = OpTypeVector %int 2",
            "%_ptr_Function_v2int = OpTypePointer Function %v2int",
            "%float = OpTypeFloat 32",
            "%v4float = OpTypeVector %float 4",
            "%_ptr_Input_v4float = OpTypePointer Input %v4float",
            "%gl_FragCoord = OpVariable %_ptr_Input_v4float Input",
            "%uint = OpTypeInt 32 0",
            "%uint_0 = OpConstant %uint 0",
            "%_ptr_Input_float = OpTypePointer Input %float",
            "%uint_1 = OpConstant %uint 1",
            "%25 = OpTypeImage %float 2D 0 0 0 2 Rgba32f",
            "%_ptr_UniformConstant_25 = OpTypePointer UniformConstant %25",
            "%storageImage = OpVariable %_ptr_UniformConstant_25 UniformConstant",
            "%_ptr_Output_v4float = OpTypePointer Output %v4float",
            "%color = OpVariable %_ptr_Output_v4float Output",
            "%float_1 = OpConstant %float 1",
            "%float_0 = OpConstant %float 0",
            "%35 = OpConstantComposite %v4float %float_1 %float_0 %float_0 %float_1",
            "%main = OpFunction %void None %3",
            "%5 = OpLabel",
            "%imageCoord = OpVariable %_ptr_Function_v2int Function",
            "%17 = OpAccessChain %_ptr_Input_float %gl_FragCoord %uint_0",
            "%18 = OpLoad %float %17",
            "%19 = OpConvertFToS %int %18",
            "%21 = OpAccessChain %_ptr_Input_float %gl_FragCoord %uint_1",
            "%22 = OpLoad %float %21",
            "%23 = OpConvertFToS %int %22",
            "%24 = OpCompositeConstruct %v2int %19 %23",
            "OpStore %imageCoord %24",
            "%28 = OpLoad %25 %storageImage",
            "%29 = OpLoad %v2int %imageCoord",
            "%30 = OpLoad %v4float %gl_FragCoord",
            "OpImageWrite %28 %29 %30",
            "OpStore %color %35",
            "OpReturn",
            "OpFunctionEnd",
        ]
    ) + "\n"
    entries.append(("fragcoord_msaa_centroid", (("FragCoordMsaaVert", "vert", vert), ("FragCoordMsaaFrag", "asm", asm))))
    return entries


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    cases = [("fragcoord_xyz", POSITION_VERT, FRAGCOORD_XYZ_FRAG), ("fragcoord_w", POSITION_VERT, FRAGCOORD_W_FRAG)]
    cases.append(("pointcoord_default", POINTCOORD_VERT, POINTCOORD_FRAG))
    cases.append(("pointcoord_uniform_frag", POINTCOORD_VERT, POINTCOORD_UNIFORM_FRAGMENT_FRAG))
    cases.append(("pointcoord_uniform_vert", POINTCOORD_UNIFORM_VERTEX_VERT, POINTCOORD_FRAG))
    cases.append(("frontfacing_simple", FRONTFACING_VERT, FRONTFACING_SIMPLE_FRAG))
    cases.append(("frontfacing_ubo", FRONTFACING_VERT, FRONTFACING_UBO_FRAG))
    for types in range(8):
        vertex, fragment = input_variation_shaders(types)
        cases.append((input_type_name(types), vertex, fragment))

    out = [
        "# Shader manifest for dEQP-VK.glsl.builtin_var (simple fragcoord and input_variations).",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_render_builtin_var.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderBuiltinVarTests.cpp"',
        'rust_module = "glsl/shader_render"',
        "",
    ]
    entries = [(name, (("vert", "vert", vertex), ("frag", "frag", fragment))) for name, vertex, fragment in cases]
    for samples in FRAGDEPTH_SAMPLES:
        entries.append((f"fragdepth_s{samples}", fragdepth_programs(samples)))
    entries += fragcoord_msaa_programs()
    for name, programs in entries:
        key = f"sr_builtin_var_{name}"
        out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
        for program_name, stage, source in programs:
            (SRC / f"{key}_{program_name}.{stage}").write_text(source)
            out.append(f'    {{ name = "{program_name}", template = "shader_render_builtin_var/{key}_{program_name}.{stage}", stage = "{stage}" }},')
        out += ["]", ""]
    MANIFEST.write_text("\n".join(out))
    print(len(cases), "cases")


if __name__ == "__main__":
    main()
