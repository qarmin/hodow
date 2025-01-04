#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.dgc.ext.graphics.misc.*_dynamic_a2c_* and *_dynamic_fsr_sample_shading_*
(DynamicA2CCase / DynamicFSRCase::initPrograms of vktDGCGraphicsMiscTestsExt.cpp). A pure text generator.

The debugPrintfEXT call of the fragment shaders upstream only logs and is left out (it needs the non-semantic info extension)."""

from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "shaders" / "manifest" / "dgc_ms.toml"
SRC_DIR = ROOT / "shaders" / "src" / "dgc"

SAMPLE_COUNT = 4
A2C_PIXELS = 2 * 2
A2C_FRAG_COLORS = [
    "0.0, 1.0, 1.0, 1.0",
    "1.0, 0.0, 1.0, 1.0",
    "1.0, 1.0, 0.0, 1.0",
    "1.0, 1.0, 1.0, 1.0",
]

VERT = (
    "#version 460\n"
    "layout (location=0) in vec4 inPos;\n"
    "void main (void) {\n"
    "    gl_Position = inPos;\n"
    "    gl_PointSize = 1.0;\n"
    "}\n"
)


def a2c_frag(color, sample_mask):
    mask = ""
    if sample_mask:
        mask = (
            "    const bool isTopLeftPixel = (gl_FragCoord.x < 1.0 && gl_FragCoord.y < 1.0);\n"
            "    gl_SampleMask[0] = (isTopLeftPixel ? 0 : 0xFF);\n"
        )
    return (
        "#version 460\n"
        "layout (location=0) out vec4 outColor;\n"
        "void main (void) {\n"
        f"{mask}    outColor = vec4({color});\n"
        "}\n"
    )


A2C_COMP = (
    "#version 460\n"
    "layout (set=0, binding=0) uniform sampler2DMS resImage;\n"
    "layout (set=0, binding=1) uniform sampler2DMS refImage;\n"
    f"layout (set=0, binding=2, std430) buffer OutputBlock {{ uint flags[{A2C_PIXELS * SAMPLE_COUNT}]; }} outBuffer;\n"
    f"layout (local_size_x={SAMPLE_COUNT}, local_size_y=1, local_size_z=1) in;\n"
    "void main (void) {\n"
    "    const ivec2 inCoords = ivec2(gl_WorkGroupID.xy);\n"
    "\n"
    "    const uint sampleCount = gl_WorkGroupSize.x;\n"
    "    const uint colCount = gl_NumWorkGroups.x;\n"
    "    const uint rowCount = gl_NumWorkGroups.y;\n"
    "    const uint col = gl_WorkGroupID.x;\n"
    "    const uint row = gl_WorkGroupID.y;\n"
    "    const uint sampleIdx = gl_LocalInvocationIndex;\n"
    "    const uint outIndex = row * colCount * sampleCount + col * sampleCount + sampleIdx;\n"
    "\n"
    "    const vec4 resColor = texelFetch(resImage, inCoords, int(sampleIdx));\n"
    "    const vec4 refColor = texelFetch(refImage, inCoords, int(sampleIdx));\n"
    "    const uint outValue = (resColor == refColor ? 1u : 0u);\n"
    "    outBuffer.flags[outIndex] = outValue;\n"
    "}\n"
)


def fsr_frag(force_sample_shading, sample_count):
    blue = f"(gl_SampleID + 1) / {sample_count}.0" if force_sample_shading else "0.0"
    return (
        "#version 460\n"
        "#extension GL_EXT_fragment_shading_rate : enable\n"
        "layout (location=0) out vec4 outColor;\n"
        "void main (void) {\n"
        "    const float red = (((gl_ShadingRateEXT & gl_ShadingRateFlag2VerticalPixelsEXT) != 0) ? 1.0 : 0.5);\n"
        "    const float green = (((gl_ShadingRateEXT & gl_ShadingRateFlag2HorizontalPixelsEXT) != 0) ? 1.0 : 0.5);\n"
        f"    const float blue = {blue};\n"
        "    outColor = vec4(red, green, blue, 1.0);\n"
        "}\n"
    )


def fsr_comp(multi_sample, sample_count):
    src_type = "sampler2DMS" if multi_sample else "sampler2D"
    load_extra = ", int(sampleIdx)" if multi_sample else ", 0"
    return (
        "#version 460\n"
        f"layout (set=0, binding=0) uniform {src_type} srcImage;\n"
        "layout (set=0, binding=1, rgba8) uniform image2D dstImage;\n"
        f"layout (local_size_x={sample_count}, local_size_y=1, local_size_z=1) in;\n"
        "void main (void) {\n"
        "    const ivec2 srcCoords = ivec2(gl_WorkGroupID.xy);\n"
        "\n"
        "    const uint sampleCount = gl_WorkGroupSize.x;\n"
        "    const uint srcCol = gl_WorkGroupID.x;\n"
        "    const uint srcRow = gl_WorkGroupID.y;\n"
        "    const uint sampleIdx = gl_LocalInvocationIndex;\n"
        "    const uint dstCol = srcCol * sampleCount + sampleIdx;\n"
        "    const uint dstRow = srcRow;\n"
        "\n"
        "    const ivec2 dstCoords = ivec2(dstCol, dstRow);\n"
        "\n"
        f"    const vec4 srcColor = texelFetch(srcImage, srcCoords{load_extra});\n"
        "    imageStore(dstImage, dstCoords, srcColor);\n"
        "}\n"
    )


def sample_id_frag(use_sample_id):
    y_coord = "gl_SampleID" if use_sample_id else "iFragCoord.x"
    return (
        "#version 460\n"
        "layout (location=0) out vec4 outColor;\n"
        "layout (rgba8, set=0, binding=0) uniform image2D img;\n"
        "void main(){\n"
        "    const vec4 geomColor = vec4(0.0, 0.0, 1.0, 1.0);\n"
        "    const ivec2 iFragCoord = ivec2(gl_FragCoord.xy);\n"
        f"    const int yCoord = {y_coord};\n"
        "    imageStore(img, ivec2(iFragCoord.x, yCoord), geomColor);\n"
        "    outColor = geomColor;\n"
        "}\n"
    )


SPARSE_VERT = (
    "#version 460\n"
    "layout (location=0) in vec4 inPos;\n"
    "void main (void) {\n"
    "    gl_Position = inPos;\n"
    "}\n"
)

SPARSE_FRAG = (
    "#version 460\n"
    "layout (location=0) out vec4 outColor;\n"
    "void main (void) {\n"
    "    outColor = vec4(0.0, 0.0, 1.0, 1.0);\n"
    "}\n"
)

ROBUST_VERT = (
    "#version 460\n"
    "layout (location=0) in vec2 inXY;\n"
    "layout (location=1) in float inZ;\n"
    "void main(void) {\n"
    "    gl_Position = vec4(inXY.xy, inZ, 1.0);\n"
    "    gl_PointSize = 1.0;\n"
    "}\n"
)

FILES = {"ms_robust_vert.vert": ROBUST_VERT, "ms_sparse_vert.vert": SPARSE_VERT, "ms_sparse_frag.frag": SPARSE_FRAG, "ms_vert.vert": VERT, "ms_sample_id_fragN.frag": sample_id_frag(False), "ms_sample_id_fragY.frag": sample_id_frag(True)}
CASES = []


def add_case(name, programs):
    entries = ", ".join(f'{{ name = "{n}", template = "dgc/{t}", stage = "{s}" }}' for n, t, s in programs)
    CASES.append(
        f'\n[[case]]\nname = "{name}"\nrust_const = "{name.upper()}"\nrust_type = "SharedProgram"\nprograms = [ {entries} ]\n'
    )


for suffix, mask in (("nomask", False), ("mask", True)):
    programs = [("vert", "ms_vert.vert", "vert")]
    for i, color in enumerate(A2C_FRAG_COLORS):
        file = f"ms_a2c_{suffix}_frag{i}.frag"
        FILES[file] = a2c_frag(color, mask)
        programs.append((f"frag{i}", file, "frag"))
    FILES["ms_a2c_comp.comp"] = A2C_COMP
    programs.append(("comp", "ms_a2c_comp.comp", "comp"))
    add_case(f"a2c_{suffix}", programs)

for suffix, multi_sample in (("ss", False), ("ms", True)):
    count = SAMPLE_COUNT if multi_sample else 1
    programs = [("vert", "ms_vert.vert", "vert")]
    for name, forced in (("fragN", False), ("fragY", True)):
        file = f"ms_fsr_{suffix}_{name}.frag"
        FILES[file] = fsr_frag(forced, count)
        programs.append((name, file, "frag"))
    file = f"ms_fsr_{suffix}_comp.comp"
    FILES[file] = fsr_comp(multi_sample, count)
    programs.append(("comp", file, "comp"))
    add_case(f"fsr_{suffix}", programs)

add_case(
    "sample_id",
    [
        ("vert", "ms_vert.vert", "vert"),
        ("fragN", "ms_sample_id_fragN.frag", "frag"),
        ("fragY", "ms_sample_id_fragY.frag", "frag"),
    ],
)

add_case("robust_vbo", [("vert", "ms_robust_vert.vert", "vert"), ("frag", "ms_sparse_frag.frag", "frag")])
add_case("sparse_vbo", [("vert", "ms_sparse_vert.vert", "vert"), ("frag", "ms_sparse_frag.frag", "frag")])

HEADER = """# Shader manifest for dEQP-VK.dgc.ext.graphics.misc.*_dynamic_a2c_*, *_dynamic_fsr_sample_shading_*, sample_id_state_*, sparse_vbo_token and robust_vbo
#
# @generated by hodow_cts/scripts/gen_dgc_ms_manifest.py - do not hand-edit.

upstream_source = "external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp"
rust_module = "dgc/graphics_misc_ms_tests"
"""


def main():
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for name, text in FILES.items():
        (SRC_DIR / name).write_text(text)
    MANIFEST.write_text(HEADER + "".join(CASES))
    print(f"wrote {MANIFEST}")


if __name__ == "__main__":
    main()
