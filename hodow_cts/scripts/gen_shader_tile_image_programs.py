#!/usr/bin/env python3
"""Writes the GLSL of dEQP-VK.rasterization.shader_tile_image and its manifest.

`vktShaderTileImageTests.cpp` builds the vertex, fragment and compute shader of a case from its TestParam with string
concatenation (`addVS`, `getColorTestTypeFS`, `getHelperClassTestTypeFS`, `getSampleMaskTypeFS`, `getDepthTestTypeFS`,
`getStencilTestTypeFS`, `addCS`) and `tcu::StringTemplate`. This reproduces that, with the template parameters filled in, for every
case `createShaderTileImageTestVariations` registers, and lists each as one manifest case named
`tile_<coherent>_<test type>_<samples>_<draws>_<patches>_<format>` which the Rust side finds in `ALL_SHARED_PROGRAM` by that name
(src/vkt/tests/rasterization/shader_tile_image_tests.rs). Identical shader texts share one file.

Run from hodow_cts/:  python3 scripts/gen_shader_tile_image_programs.py   (then `just cts-shaders`)
"""
import hashlib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "shader_tile_image"
MANIFEST = ROOT / "shaders" / "manifest" / "shader_tile_image.toml"

# The registration order of `formats`: (name, channel class, bits of the second channel, used channels, has depth, has stencil).
# Classes: unorm, snorm (the fixed point ones), uint, sint, float.
FORMATS = [
    ("r5g6b5_unorm_pack16", "unorm", 6, 3, False, False),
    ("r8g8_unorm", "unorm", 8, 2, False, False),
    ("r8g8_snorm", "snorm", 8, 2, False, False),
    ("r8g8_uint", "uint", 8, 2, False, False),
    ("r8g8_sint", "sint", 8, 2, False, False),
    ("r8g8b8a8_unorm", "unorm", 8, 4, False, False),
    ("r8g8b8a8_snorm", "snorm", 8, 4, False, False),
    ("r8g8b8a8_uint", "uint", 8, 4, False, False),
    ("r8g8b8a8_sint", "sint", 8, 4, False, False),
    ("r8g8b8a8_srgb", "unorm", 8, 4, False, False),
    ("a8b8g8r8_unorm_pack32", "unorm", 8, 4, False, False),
    ("a8b8g8r8_snorm_pack32", "snorm", 8, 4, False, False),
    ("a8b8g8r8_uint_pack32", "uint", 8, 4, False, False),
    ("a8b8g8r8_sint_pack32", "sint", 8, 4, False, False),
    ("a8b8g8r8_srgb_pack32", "unorm", 8, 4, False, False),
    ("b8g8r8a8_unorm", "unorm", 8, 4, False, False),
    ("b8g8r8a8_srgb", "unorm", 8, 4, False, False),
    ("a2r10g10b10_unorm_pack32", "unorm", 10, 4, False, False),
    ("a2b10g10r10_unorm_pack32", "unorm", 10, 4, False, False),
    ("a2b10g10r10_uint_pack32", "uint", 10, 4, False, False),
    ("r16g16_unorm", "unorm", 16, 2, False, False),
    ("r16g16_snorm", "snorm", 16, 2, False, False),
    ("r16g16_uint", "uint", 16, 2, False, False),
    ("r16g16_sint", "sint", 16, 2, False, False),
    ("r16g16_sfloat", "float", 16, 2, False, False),
    ("r16g16b16a16_unorm", "unorm", 16, 4, False, False),
    ("r16g16b16a16_snorm", "snorm", 16, 4, False, False),
    ("r16g16b16a16_uint", "uint", 16, 4, False, False),
    ("r16g16b16a16_sint", "sint", 16, 4, False, False),
    ("r16g16b16a16_sfloat", "float", 16, 4, False, False),
    ("r32g32_uint", "uint", 32, 2, False, False),
    ("r32g32_sint", "sint", 32, 2, False, False),
    ("r32g32_sfloat", "float", 32, 2, False, False),
    ("r32g32b32a32_uint", "uint", 32, 4, False, False),
    ("r32g32b32a32_sint", "sint", 32, 4, False, False),
    ("r32g32b32a32_sfloat", "float", 32, 4, False, False),
    ("r10x6g10x6b10x6a10x6_unorm_4pack16", "unorm", 10, 4, False, False),
    ("d16_unorm", None, 0, 0, True, False),
    ("x8_d24_unorm_pack32", None, 0, 0, True, False),
    ("d32_sfloat", None, 0, 0, True, False),
    ("s8_uint", None, 0, 0, False, True),
    ("d16_unorm_s8_uint", None, 0, 0, True, True),
    ("d24_unorm_s8_uint", None, 0, 0, True, True),
    ("d32_sfloat_s8_uint", None, 0, 0, True, True),
]
FORMAT_BY_NAME = {f[0]: f for f in FORMATS}
DEFAULT_COLOR_FORMAT = "r32g32b32a32_uint"

K_IMAGE_SIZE = 4
K_MULTI_DRAW = 3
K_MULTI_PATCH = 3
K_MRT = 2

TEST_TYPES = [
    ("color", "Color"),
    ("mrt", "MultiRenderTarget"),
    ("mrt_dynamic_index", "MultiRenderTargetDynamicIndex"),
    ("msaa_sample_mask", "MsaaSampleMask"),
    ("helper_class_color", "HelperClassColor"),
    ("helper_class_depth", "HelperClassDepth"),
    ("helper_class_stencil", "HelperClassStencil"),
    ("depth", "Depth"),
    ("stencil", "Stencil"),
]
SAMPLE_COUNTS = [1, 2, 4, 8, 16, 32]


def is_helper(test_type):
    return test_type in ("HelperClassColor", "HelperClassDepth", "HelperClassStencil")


def is_normalized(cls):
    return cls in ("unorm", "snorm")


def attachment_count(test_type):
    return K_MRT if test_type in ("MultiRenderTargetDynamicIndex", "MultiRenderTarget") or is_helper(test_type) else 1


def vertex_count_per_patch(test_type):
    return 3 if test_type == "MsaaSampleMask" else 6


def draw_count(test_type, multi_draw):
    return 2 if is_helper(test_type) else (K_MULTI_DRAW if multi_draw else 1)


def patches_per_draw(multi_patch):
    return K_MULTI_PATCH if multi_patch else 1


def fmt_float(value):
    """`std::ostream << float`: six significant digits, like %g."""
    return "%g" % value


def amplifier_of(cls, bits):
    if cls == "snorm":
        return float(1 << (bits - 1))
    return float((1 << bits) - 1)


def add_overhead(total_patch_count):
    return (
        "{\n"
        f"    uint overheadLoop = uint(gl_FragCoord.x) * uint({total_patch_count} + 1);\n"
        f"    zero = patchIndex / ({total_patch_count} + 1);\n"
        "    for(uint index = 0u; index < overheadLoop; index++)\n"
        "    {\n"
        "        zero = uint(sin(float(zero)));\n"
        "    }\n"
        "}\n"
    )


class Case:
    def __init__(self, coherent, test_type, samples, multi_draw, multi_patch, color_format, ds_format, name):
        self.coherent = coherent
        self.test_type = test_type
        self.samples = samples
        self.multi_draw = multi_draw
        self.multi_patch = multi_patch
        self.color_format = color_format
        self.ds_format = ds_format
        self.name = name
        _, self.cls, self.bits_y, self.channels, _, _ = FORMAT_BY_NAME[color_format]
        self.total_patch_count = draw_count(test_type, multi_draw) * patches_per_draw(multi_patch)

    def vec_name(self):
        prefix = {"uint": "uvec", "sint": "ivec"}.get(self.cls, "vec")
        return f"{prefix}{self.channels}"

    def basic_type(self):
        return {"uint": "uint", "sint": "int"}.get(self.cls, "float")

    def tile_image_type(self):
        return {"uint": "uattachmentEXT", "sint": "iattachmentEXT"}.get(self.cls, "attachmentEXT")


def vertex_shader(case):
    return (
        "#version 450 core\n"
        "precision highp float;\n"
        "precision highp int;\n"
        "layout(location = 0) in highp vec2 v_position;\n"
        "layout(location = 0) flat out uint patchIndex;"
        "layout( push_constant ) uniform ConstBlock\n"
        "{\n"
        "    highp uint drawIndex;\n"
        "};\n"
        "void main ()\n"
        "{\n"
        f"    uint localPatchIndex = uint(gl_VertexIndex) / {vertex_count_per_patch(case.test_type)} + 1;\n"
        f"    uint patchCountPerDraw = {patches_per_draw(case.multi_patch)};\n"
        "    uint globalPatchIndex = drawIndex * patchCountPerDraw + localPatchIndex;\n"
        "    patchIndex = globalPatchIndex;\n"
        f"    gl_Position = vec4(v_position, {'%f' % (1.0 / case.total_patch_count)} * globalPatchIndex, 1);\n"
        "}\n"
    )


PREAMBLE = (
    "#version 450 core\n"
    "#extension GL_EXT_shader_tile_image : require\n"
    "precision highp float;\n"
    "precision highp int;\n"
    "layout( push_constant ) uniform ConstBlock\n"
    "{\n"
    "    highp uint drawIndex;\n"
    "};\n"
)


def color_fs(case):
    count = attachment_count(case.test_type)
    mrt_dynamic = case.test_type == "MultiRenderTargetDynamicIndex"
    multi_sample = case.samples != 1
    normalized = is_normalized(case.cls)
    s = PREAMBLE + "layout( location = 0 ) flat in uint patchIndex;\n"
    if not case.coherent:
        s += "layout( non_coherent_color_attachment_readEXT ) in;\n"
    if mrt_dynamic:
        s += f"layout( location = 0 ) tileImageEXT highp {case.tile_image_type()} colorIn[{count}];\n"
    else:
        for i in range(count):
            s += f"layout( location = {i}) tileImageEXT highp {case.tile_image_type()} colorIn{i};\n"
    for i in range(count):
        s += f"layout( location = {i} ) out highp {case.vec_name()} out{i};\n"
    s += f"void main()\n{{\n    uint zero = 0;\n    uvec2 previous[{count}];\n"
    amplifier = 1.0
    if normalized:
        amplifier = amplifier_of(case.cls, case.bits_y)
    for i in range(count):
        input_image = f"colorIn[{i}]" if mrt_dynamic else f"colorIn{i}"
        func_params = f"({input_image}, gl_SampleID)" if multi_sample else f"({input_image})"
        if normalized:
            s += f"    previous[{i}] = uvec2(round((colorAttachmentReadEXT{func_params} * {fmt_float(amplifier)}).xy));\n"
        else:
            s += f"    previous[{i}] = uvec2(round((colorAttachmentReadEXT{func_params}).xy));\n"
    s += add_overhead(case.total_patch_count)
    inv_amplifier = 1.0 / amplifier
    for i in range(count):
        s += (
            f"    if (previous[{i}].x == 0 && patchIndex == 1)\n"
            "    {\n"
            f"        out{i}.x = 0;\n"
            f"        out{i}.y = {case.basic_type()}(patchIndex + zero + gl_SampleID + {i});\n"
            "    }\n"
            f"    else if (previous[{i}].x == 0 && (previous[{i}].y + 1) == (patchIndex + gl_SampleID + {i}))\n"
            "    {\n"
            f"        out{i}.x = 0;\n"
            f"        out{i}.y = {case.basic_type()}(previous[{i}].y + 1 + zero);\n"
            "    }\n"
            "    else\n"
            "    {\n"
            f"        out{i}.x = 1;\n"
            f"        out{i}.y = {case.basic_type()}(previous[{i}].y);\n"
            "    }\n"
        )
        if normalized:
            s += f"    out{i}.y *= {fmt_float(inv_amplifier)};\n"
    s += "}\n"
    return s


def helper_class_fs(case):
    depth_test = case.test_type == "HelperClassDepth"
    stencil_test = case.test_type == "HelperClassStencil"
    s = PREAMBLE + "layout( location = 0 ) flat in uint patchIndex;\n"
    if not case.coherent:
        s += "layout( non_coherent_color_attachment_readEXT ) in;\n"
        if depth_test:
            s += "layout( non_coherent_depth_attachment_readEXT ) in;\n"
        if stencil_test:
            s += "layout( non_coherent_stencil_attachment_readEXT ) in;\n"
    s += f"layout(location = 0) tileImageEXT highp {case.tile_image_type()} colorIn0;\n"
    s += f"layout(location = 1) tileImageEXT highp {case.tile_image_type()} colorIn1;\n"
    s += f"layout(location = 0) out highp {case.vec_name()} out0;\n"
    s += f"layout(location = 1) out highp {case.vec_name()} out1;\n"
    s += "void main()\n{\n    uint zero = 0;\n    uvec2 previous;\n"
    if depth_test:
        s += f" uint scalingFactor = {case.total_patch_count};\n"
        s += "    previous.x = uint(round(colorAttachmentReadEXT(colorIn0).x));\n"
        s += "    previous.y = uint(round(depthAttachmentReadEXT() * scalingFactor));\n"
    elif stencil_test:
        s += "    previous.x = uint(round(colorAttachmentReadEXT(colorIn0).x));\n"
        s += "    previous.y = uint(stencilAttachmentReadEXT());\n"
    else:
        s += "    previous = uvec2(round((colorAttachmentReadEXT(colorIn0)).xy));\n"
    s += (
        "    uint err = 0;\n"
        "    uint dx = 0;\n"
        "    uint dy = 0;\n"
        "    if (patchIndex != 1)"
        "    {\n"
        "        dx = uint(round(abs(dFdxFine(previous.y))));\n"
        "        dy = uint(round(abs(dFdyFine(previous.y))));\n"
        "        uint err = 0;\n"
        "        if ((dx != 0 && dx != patchIndex - 1) || (dy != 0 && dy != patchIndex - 1))\n"
        "        {\n"
        "            err = 1;\n"
        "        }\n"
        "    }\n"
    )
    s += add_overhead(case.total_patch_count)
    bt = case.basic_type()
    s += (
        "    if (patchIndex == 1 && err != 1)\n"
        "    {\n"
        "        out0.x = 0;\n"
        f"        out0.y = {bt}(patchIndex);\n"
        "        out1.x = 0;\n"
        "        out1.y = 0;\n"
        "    }\n"
        "    else if (previous.x == 0 && err != 1 && ((previous.y + 1) == patchIndex || previous.y == 0))\n"
        "    {\n"
        "        out0.x = 0;\n"
        "        out0.y = 0;\n"
        "        out1.x = 0;\n"
        f"        out1.y = {bt}(max(dx, dy) + 1);\n"
        "    }\n"
        "    else\n"
        "    {\n"
        "        out0.x = 1;\n"
        f"        out0.y = {bt}(previous.y);\n"
        "        out1.x = 1;\n"
        f"        out1.y = {bt}(previous.x);\n"
        "    }\n"
    )
    s += "}\n"
    return s


def sample_mask_fs(case):
    sample_count = case.samples
    normalized = is_normalized(case.cls)
    amplifier = 1
    if normalized:
        amplifier = int(amplifier_of(case.cls, case.bits_y))
    s = PREAMBLE
    if not case.coherent:
        s += "layout( non_coherent_color_attachment_readEXT ) in;\n"
    s += (
        "layout( location = 0 ) flat in uint patchIndex;\n"
        f"layout( location = 0 ) tileImageEXT highp {case.tile_image_type()} colorIn0;\n"
        f"layout( location = 0 ) out highp {case.vec_name()} out0;\n"
        "\n"
        "void main()\n"
        "{\n"
        "    uint zero = 0;\n"
        "    uint previous = 0;\n"
        "    bool error = false;\n"
        f"    for (int i = 0; i < {sample_count}; ++i)\n"
        "    {\n"
        "        if (((gl_SampleMaskIn[0] >> i) & 0x1) == 0x1)\n"
        "        {\n"
        f"            uvec2 previousSample = uvec2(round(colorAttachmentReadEXT(colorIn0, i) * {amplifier})).xy;\n"
        "            if (previousSample.x != 0)\n"
        "            {\n"
        "                error = true;\n"
        "                break;"
        "            }\n"
        "            if (previous == 0)\n"
        "            {\n"
        "                previous = previousSample.y;\n"
        "            }\n"
        "\n"
        "            if ((patchIndex != 1 && previousSample.y == 0) || previous != previousSample.y)\n"
        "            {\n"
        "                error = true;\n"
        "                break;\n"
        "            }\n"
        "        }\n"
        "    }\n"
        "\n"
    )
    s += add_overhead(case.total_patch_count)
    s += (
        "    if (!error && (previous + 1 == patchIndex))\n"
        "    {\n"
        "        out0.x = 0;\n"
        f"        out0.y = {case.basic_type()}(previous + 1 + zero);\n"
        "    }\n"
        "    else\n"
        "    {\n"
        "        out0.x = 1;\n"
        f"        out0.y = {case.basic_type()}(previous);\n"
        "    }\n"
    )
    if normalized:
        s += f"    out0.y *= {fmt_float(1.0 / float(amplifier))};\n"
    s += "}\n"
    return s


def depth_fs(case):
    multi_sample = case.samples != 1
    depth_params = "(gl_SampleID)" if multi_sample else "()"
    color_params = "(colorIn0, gl_SampleID)" if multi_sample else "(colorIn0)"
    s = PREAMBLE
    if not case.coherent:
        s += "layout( non_coherent_depth_attachment_readEXT ) in;\n"
        s += "layout( non_coherent_color_attachment_readEXT ) in;\n"
    s += (
        "layout( location = 0 ) flat in uint patchIndex;\n"
        f"layout( location = 0 ) tileImageEXT highp {case.tile_image_type()} colorIn0;\n"
        f"layout( location = 0 ) out highp {case.vec_name()} out0;\n"
        "\n"
        "void main()\n"
        "{\n"
        "    uint zero = 0;\n"
        f" uint scalingFactor = {case.total_patch_count};\n"
    )
    if multi_sample:
        s += f" scalingFactor += {case.samples};\n"
    s += f"    uint previousDepth = uint(round(depthAttachmentReadEXT{depth_params} * scalingFactor));\n"
    s += f"    {case.vec_name()} previous = {case.vec_name()}(round(colorAttachmentReadEXT{color_params}));\n"
    s += add_overhead(case.total_patch_count)
    s += (
        "    if (previous.x == 0 && patchIndex == 1)\n"
        "    {\n"
        "        out0.x = 0;\n"
        "        out0.y = (1u + zero + gl_SampleID);\n"
        "    }\n"
        "    else if (previous.x == 0 && (previous.y + 1) == (patchIndex + gl_SampleID) && (previousDepth + 1) == (patchIndex + gl_SampleID))\n"
        "    {\n"
        "        out0.x = 0;\n"
        f"        out0.y = {case.basic_type()}(previousDepth + 1 + zero);\n"
        "    }\n"
        "    else\n"
        "    {\n"
        "        out0.x = 1;\n"
        f"        out0.y = {case.basic_type()}(previousDepth);\n"
        "    }\n"
    )
    if multi_sample:
        s += " gl_FragDepth = float(out0.y) / scalingFactor;\n"
    s += "}\n"
    return s


def stencil_fs(case):
    multi_sample = case.samples != 1
    stencil_params = "(gl_SampleID)" if multi_sample else "()"
    color_params = "(colorIn0, gl_SampleID)" if multi_sample else "(colorIn0)"
    s = PREAMBLE
    if not case.coherent:
        s += "layout( non_coherent_stencil_attachment_readEXT ) in;\n"
        s += "layout( non_coherent_color_attachment_readEXT ) in;\n"
    s += (
        "layout( location = 0 ) flat in uint patchIndex;\n"
        f"layout( location = 0 ) tileImageEXT highp {case.tile_image_type()} colorIn0;\n"
        f"layout( location = 0 ) out highp {case.vec_name()} out0;\n"
        "\n"
        "void main()\n"
        "{\n"
        "    uint zero = 0;\n"
        f"    uint previousStencil = uint(round(stencilAttachmentReadEXT{stencil_params} ));\n"
        f"    {case.vec_name()} previous = {case.vec_name()}(round(colorAttachmentReadEXT{color_params}));\n"
    )
    s += add_overhead(case.total_patch_count)
    s += (
        "    if (previous.x == 0 && (previous.y + 1) == patchIndex && (previousStencil + 1) == patchIndex)\n"
        "    {\n"
        "        out0.x = 0;\n"
        f"        out0.y = {case.basic_type()}(previousStencil + 1 + zero);\n"
        "    }\n"
        "    else\n"
        "    {\n"
        "        out0.x = 1;\n"
        f"        out0.y = {case.basic_type()}(previousStencil);\n"
        "    }\n"
        "}\n"
    )
    return s


def fragment_shader(case):
    if case.test_type in ("Color", "MultiRenderTarget", "MultiRenderTargetDynamicIndex"):
        return color_fs(case)
    if is_helper(case.test_type):
        return helper_class_fs(case)
    if case.test_type == "MsaaSampleMask":
        return sample_mask_fs(case)
    if case.test_type == "Depth":
        return depth_fs(case)
    return stencil_fs(case)


def compute_shader(case):
    sample_count = case.samples
    prefix = "texture2DMS" if sample_count > 1 else "texture2D"
    sampler = {"uint": "u" + prefix, "sint": "i" + prefix}.get(case.cls, prefix)
    normalized = is_normalized(case.cls)
    amplifier = 1
    if normalized:
        amplifier = int(amplifier_of(case.cls, case.bits_y))
    s = (
        "#version 450 core\n"
        "#extension GL_EXT_samplerless_texture_functions : enable\n"
        "precision highp float;\n"
        "precision highp int;\n"
        f"layout(set = 0, binding = 0) uniform {sampler} colorTex;\n"
        "layout(set = 0, binding = 1, std430) buffer Block0 { uvec2 values[]; } colorbuf;\n"
        "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
        "void main()\n"
        "{\n"
        f"    for (uint i = 0u; i < {sample_count}u; ++i) {{\n"
        f"        uint idx = ((gl_GlobalInvocationID.y * {K_IMAGE_SIZE}u) + gl_GlobalInvocationID.x) * {sample_count}u + i;\n"
    )
    if normalized:
        s += f"        colorbuf.values[idx].y = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).y * {amplifier}));\n"
        s += "        colorbuf.values[idx].x = uint(round(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).x));\n"
    else:
        s += "        colorbuf.values[idx] = uvec2(round(vec2(texelFetch(colorTex, ivec2(gl_GlobalInvocationID.xy), int(i)).xy)));\n"
    s += "    }\n}\n"
    return s


def cases():
    """`createShaderTileImageTestVariations`, in its order."""
    for coherent, coherent_name in ((True, "coherent"), (False, "non_coherent")):
        for type_name, test_type in TEST_TYPES:
            for samples in SAMPLE_COUNTS:
                if test_type == "MsaaSampleMask" and samples == 1:
                    continue
                if is_helper(test_type) and samples != 1:
                    continue
                for multi_draw, draw_name in ((False, "single_draw"), (True, "multi_draws")):
                    if is_helper(test_type) and multi_draw:
                        continue
                    for multi_patch, patch_name in ((False, "single_patch"), (True, "multi_patches")):
                        if not coherent and multi_patch:
                            continue
                        if is_helper(test_type) and multi_patch:
                            continue
                        for name, cls, bits_y, channels, has_depth, has_stencil in FORMATS:
                            color_format, ds_format = DEFAULT_COLOR_FORMAT, "d32_sfloat_s8_uint"
                            if test_type in ("Depth", "HelperClassDepth"):
                                if not has_depth:
                                    continue
                                ds_format = name
                            elif test_type in ("Stencil", "HelperClassStencil"):
                                if not has_stencil:
                                    continue
                                ds_format = name
                            else:
                                if has_depth or has_stencil:
                                    continue
                                if is_helper(test_type) and is_normalized(cls):
                                    continue
                                max_result = draw_count(test_type, multi_draw) * patches_per_draw(multi_patch) * attachment_count(test_type) + samples
                                if (1 << (bits_y - 1)) <= max_result:
                                    continue
                                color_format = name
                            path = f"{coherent_name}_{type_name}_samples_{samples}_{draw_name}_{patch_name}_{name}"
                            yield Case(coherent, test_type, samples, multi_draw, multi_patch, color_format, ds_format, "tile_" + path)


def write_shader(text, extension):
    digest = hashlib.sha1(text.encode()).hexdigest()[:16]
    relative = f"shader_tile_image/{digest}.{extension}"
    path = ROOT / "shaders" / "src" / relative
    if not path.exists():
        path.write_text(text)
    return relative


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for dEQP-VK.rasterization.shader_tile_image.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_shader_tile_image_programs.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/rasterization/vktShaderTileImageTests.cpp"',
        'rust_module = "rasterization/shader_tile_image_tests"',
        "",
    ]
    count = 0
    for case in cases():
        vert = write_shader(vertex_shader(case), "vert")
        frag = write_shader(fragment_shader(case), "frag")
        comp = write_shader(compute_shader(case), "comp")
        out += [
            "[[case]]",
            f'name = "{case.name}"',
            f'rust_const = "{case.name.upper()}"',
            'rust_type = "SharedProgram"',
            "programs = [",
            f'    {{ name = "vert", template = "{vert}", stage = "vert" }},',
            f'    {{ name = "frag", template = "{frag}", stage = "frag" }},',
            f'    {{ name = "comp", template = "{comp}", stage = "comp" }},',
            "]",
            "",
        ]
        count += 1
    MANIFEST.write_text("\n".join(out))
    print(count, "cases")


if __name__ == "__main__":
    main()
