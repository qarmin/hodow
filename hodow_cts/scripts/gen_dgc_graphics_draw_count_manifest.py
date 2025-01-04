#!/usr/bin/env python3
"""Writes the shaders and the manifest of dEQP-VK.dgc.ext.graphics.draw_count (`initDrawCountPrograms` of
vktDGCGraphicsDrawCountTestsExt.cpp), one program set per (execution set, checkDrawParams). A pure text generator: no glslang, no cargo."""

from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "shaders" / "manifest" / "dgc_graphics_draw_count.toml"
SRC_DIR = ROOT / "shaders" / "src" / "dgc"

IO_SIZES = [8, 12, 16, 20]
LOCATION_OFFSET = 5
MAX_INSTANCE_INDEX = 255


def programs_of(use_execution_set, check):
    shader_variants = len(IO_SIZES) if use_execution_set else 1

    vert_bindings_decl = ""
    frag_bindings_decl = ""
    push_constant_decl = ""
    next_frag_binding = 0
    if use_execution_set:
        for i, size in enumerate(IO_SIZES):
            vert_bindings_decl += (
                f"layout (set=0, binding={i}, std430) readonly buffer Buffer{i} {{ int values[{size}]; }} buffer{i};\n"
            )
        frag_bindings_decl += f"layout (set=1, binding={next_frag_binding}, std430) readonly buffer ExpectedAccum {{ int values[]; }} ea;\n"
        next_frag_binding += 1
    if check:
        frag_bindings_decl += f"layout (set=1, binding={next_frag_binding}, std430) readonly buffer ExpectedDrawParams {{ ivec4 values[]; }} edp;\n"
        next_frag_binding += 1
    if use_execution_set or check:
        push_constant_decl += "layout (push_constant, std430) uniform PushConstantBlock { uvec2 dim; } pc;\n"

    progs = []
    for i in range(shader_variants):
        io_var_count = IO_SIZES[i] if use_execution_set else 0
        suffix = str(i) if use_execution_set else ""
        out_vars_decl = in_vars_decl = out_vars_write = in_vars_read = ""
        for j in range(io_var_count):
            location = j + LOCATION_OFFSET
            out_vars_decl += f"layout (location={location}) out flat int iovar{j};\n"
            in_vars_decl += f"layout (location={location}) in flat int iovar{j};\n"
            out_vars_write += f"    iovar{j} = buffer{i}.values[{j}];\n"
            in_vars_read += f"    accum += iovar{j};\n"

        vert = (
            "#version 460\n"
            "layout (location=0) in vec4 inPos;\n"
            "layout (location=1) in vec4 inExtraData;\n"
            "layout (location=0) out flat int outInstanceIndex;\n"
            + ("layout (location=1) out flat int drawIndex;\n" if check else "")
            + "\n"
            + ("layout (location=2) out flat int baseVertex;\n" if check else "")
            + "\n"
            + ("layout (location=3) out flat int baseInstance;\n" if check else "")
            + "\n"
            + vert_bindings_decl
            + "\n"
            + out_vars_decl
            + "\n"
            "out gl_PerVertex {\n"
            "    vec4  gl_Position;\n"
            "    float gl_PointSize;\n"
            "    float gl_ClipDistance[1];\n"
            "    float gl_CullDistance[1];\n"
            "};\n"
            "void main (void) {\n"
            "    gl_Position = inPos;\n"
            "    gl_PointSize = 1.0;\n"
            "    gl_ClipDistance[0] = inExtraData.x;\n"
            "    gl_CullDistance[0] = inExtraData.y;\n"
            "    outInstanceIndex = gl_InstanceIndex;\n"
            + ("    drawIndex = gl_DrawID;\n" if check else "")
            + ("    baseVertex = gl_BaseVertex;\n" if check else "")
            + ("    baseInstance = gl_BaseInstance;\n" if check else "")
            + out_vars_write
            + "}\n"
        )

        pixel_idx_needed = use_execution_set or check
        frag = (
            "#version 460\n"
            "layout (location=0) in flat int inInstanceIndex;\n"
            + ("layout (location=1) in flat int drawIndex;\n" if check else "")
            + ("layout (location=2) in flat int baseVertex;\n" if check else "")
            + ("layout (location=3) in flat int baseInstance;\n" if check else "")
            + "layout (location=0) out vec4 outColor;\n"
            "\n"
            + frag_bindings_decl
            + push_constant_decl
            + "\n"
            + in_vars_decl
            + "\n"
            "void main (void) {\n"
            + (
                "    const uint pixelIdx = uint(gl_FragCoord.y) * pc.dim.x + uint(gl_FragCoord.x);\n"
                if pixel_idx_needed
                else ""
            )
            + ("    int accum = 0;\n" if use_execution_set else "")
            + in_vars_read
            + f"    const float red   = float(inInstanceIndex) / {MAX_INSTANCE_INDEX}.0;\n"
            "    const float green = "
            + ("((accum == ea.values[pixelIdx]) ? 0.0 : 1.0)" if use_execution_set else "0.0")
            + ";\n"
            "    bool blueOK = true;\n"
            + ("    blueOK = (blueOK && (drawIndex == edp.values[pixelIdx].x));\n" if check else "")
            + ("    blueOK = (blueOK && (baseVertex == edp.values[pixelIdx].y));\n" if check else "")
            + ("    blueOK = (blueOK && (baseInstance == edp.values[pixelIdx].z));\n" if check else "")
            + "    const float blue  = (blueOK ? 1.0 : 0.0);\n"
            "    outColor = vec4(red, green, blue, 1.0);\n"
            "}\n"
        )
        progs.append((f"vert{suffix}", "vert", vert))
        progs.append((f"frag{suffix}", "frag", frag))
    return progs


HEADER = """# Shader manifest for dEQP-VK.dgc.ext.graphics.draw_count
#
# @generated by hodow_cts/scripts/gen_dgc_graphics_draw_count_manifest.py - do not hand-edit.

upstream_source = "external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsDrawCountTestsExt.cpp"
rust_module = "dgc/graphics_draw_count_tests"
"""


def main():
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    out = [HEADER]
    for use_execution_set in (False, True):
        for check in (False, True):
            key = f"draw_count_{'es' if use_execution_set else 'noes'}_{'dp' if check else 'nodp'}"
            files = programs_of(use_execution_set, check)
            for name, stage, text in files:
                (SRC_DIR / f"{key}_{name}.{stage}").write_text(text)
            entries = ", ".join(
                f'{{ name = "{name}", template = "dgc/{key}_{name}.{stage}", stage = "{stage}" }}' for name, stage, _ in files
            )
            out.append(
                f"""
[[case]]
name = "{key}"
rust_const = "{key.upper()}"
rust_type = "SharedProgram"
programs = [ {entries} ]
"""
            )
    MANIFEST.write_text("".join(out))
    print(f"wrote {MANIFEST}")


if __name__ == "__main__":
    main()
