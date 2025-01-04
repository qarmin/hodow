#!/usr/bin/env python3
"""Writes the GLSL variants of dEQP-VK.clipping and their manifest.

`vktClippingTests.cpp` builds the clip/cull distance shaders from a CaseDefinition with string concatenation, so every
(group, indexing, shader set, plane count, fragment read) combination is its own program set. This reproduces that
concatenation and lists every set as one manifest case named `<main group>__<shader group>__<case>` (no slash:
the name ends up in a file name), which the Rust side looks up through `ALL_SHARED_PROGRAM`.

Run from hodow_cts/:  python3 scripts/gen_clipping_programs.py   (then `just cts-shaders`)
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "clipping"
MANIFEST = ROOT / "shaders" / "manifest" / "clipping.toml"

RENDER_SIZE = 16
NUM_PATCH_CONTROL_POINTS = 3
MAX_CLIP_DISTANCES = 8
MAX_CULL_DISTANCES = 8
MAX_COMBINED = 8


def simple_vert(point_size):
    use = point_size > 0.0
    s = (
        "#version 450\n"
        "\n"
        "layout(location = 0) in vec4 v_position;\n"
        "\n"
        "out gl_PerVertex {\n"
        "    vec4  gl_Position;\n"
    )
    if use:
        s += "    float gl_PointSize;\n"
    s += "};\n\nvoid main (void)\n{\n    gl_Position = v_position;\n"
    if use:
        s += f"    gl_PointSize = {point_size:.1f};\n"
    s += "}\n"
    return s


SIMPLE_FRAG = (
    "#version 450\n"
    "\n"
    "layout(location = 0) out vec4 o_color;\n"
    "\n"
    "void main (void)\n"
    "{\n"
    "    o_color = vec4(1.0, gl_FragCoord.z, 0.0, 1.0);\n"
    "}\n"
)


def distance_programs(num_clip, num_cull, tess, geom, dynamic, read_frag):
    per_vertex = "gl_PerVertex {\n    vec4  gl_Position;\n"
    if num_clip > 0:
        per_vertex += f"    float gl_ClipDistance[{num_clip}];\n"
    if num_cull > 0:
        per_vertex += f"    float gl_CullDistance[{num_cull}];\n"
    per_vertex += "}"

    out = {}

    # Vertex shader
    s = (
        "#version 450\n\n"
        "layout(location = 0) in  vec4 v_position;\n"
        "layout(location = 0) out vec4 out_color;\n\n"
        f"out {per_vertex};\n\n"
        "void main (void)\n{\n"
        "    gl_Position = v_position;\n"
        "    out_color   = vec4(1.0, 0.5 * (v_position.x + 1.0), 0.0, 1.0);\n\n"
        "    const int barNdx = gl_VertexIndex / 6;\n"
    )
    if dynamic:
        if num_clip > 0:
            s += f"    for (int i = 0; i < {num_clip}; ++i)\n        gl_ClipDistance[i] = (barNdx == i ? v_position.y : 0.0);\n"
        if num_cull > 0:
            s += f"    for (int i = 0; i < {num_cull}; ++i)\n"
            if not read_frag:
                s += "        gl_CullDistance[i] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;\n"
            elif tess or geom:
                s += "        gl_CullDistance[i] = 0.1f;\n"
            else:
                s += "        gl_CullDistance[i] = (gl_Position.y < 0) ? -0.5f : 0.5f;\n"
    else:
        for i in range(num_clip):
            s += f"    gl_ClipDistance[{i}] = (barNdx == {i} ? v_position.y : 0.0);\n"
        for i in range(num_cull):
            if not read_frag:
                s += f"    gl_CullDistance[{i}] = (gl_Position.x >= 0.75f) ? -0.5f : 0.5f;\n"
            elif tess or geom:
                s += f"    gl_CullDistance[{i}] = 0.1f;\n"
            else:
                s += f"    gl_CullDistance[{i}] = (gl_Position.y < 0) ? -0.5f : 0.5f;\n"
    s += "}\n"
    out["vert"] = s

    if tess:
        s = (
            "#version 450\n\n"
            f"layout(vertices = {NUM_PATCH_CONTROL_POINTS}) out;\n\n"
            "layout(location = 0) in  vec4 in_color[];\n"
            "layout(location = 0) out vec4 out_color[];\n\n"
            f"in {per_vertex} gl_in[gl_MaxPatchVertices];\n\n"
            f"out {per_vertex} gl_out[];\n\n"
            "void main (void)\n{\n"
            "    gl_TessLevelInner[0] = 1.0;\n"
            "    gl_TessLevelInner[1] = 1.0;\n\n"
            "    gl_TessLevelOuter[0] = 1.0;\n"
            "    gl_TessLevelOuter[1] = 1.0;\n"
            "    gl_TessLevelOuter[2] = 1.0;\n"
            "    gl_TessLevelOuter[3] = 1.0;\n\n"
            "    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;\n"
            "    out_color[gl_InvocationID]          = in_color[gl_InvocationID];\n\n"
        )
        if dynamic:
            if num_clip > 0:
                s += (
                    f"    for (int i = 0; i < {num_clip}; ++i)\n"
                    "        gl_out[gl_InvocationID].gl_ClipDistance[i] = gl_in[gl_InvocationID].gl_ClipDistance[i];\n"
                )
            if num_cull > 0:
                s += f"    for (int i = 0; i < {num_cull}; ++i)\n"
                s += "    {\n"
                if not read_frag:
                    s += "    gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;\n"
                else:
                    s += "        gl_out[gl_InvocationID].gl_CullDistance[i] = (gl_in[gl_InvocationID].gl_CullDistance[i] == 0.1f) ? "
                    s += "0.3f" if geom else "((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f)"
                    s += " : 0.2f;\n"
                s += "    }\n"
        else:
            for i in range(num_clip):
                s += f"    gl_out[gl_InvocationID].gl_ClipDistance[{i}] = gl_in[gl_InvocationID].gl_ClipDistance[{i}];\n"
            for i in range(num_cull):
                if not read_frag:
                    s += f"    gl_out[gl_InvocationID].gl_CullDistance[{i}] = (gl_in[gl_InvocationID].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;\n"
                else:
                    s += f"    gl_out[gl_InvocationID].gl_CullDistance[{i}] = (gl_in[gl_InvocationID].gl_CullDistance[{i}] == 0.1f) ? "
                    s += "0.3f" if geom else "((gl_in[gl_InvocationID].gl_Position.y < 0) ? -0.5f : 0.5f)"
                    s += " : 0.2f;\n"
        s += "}\n"
        out["tesc"] = s

        s = (
            "#version 450\n\n"
            "layout(triangles, equal_spacing, ccw) in;\n\n"
            "layout(location = 0) in  vec4 in_color[];\n"
            "layout(location = 0) out vec4 out_color;\n\n"
            f"in {per_vertex} gl_in[gl_MaxPatchVertices];\n\n"
            f"out {per_vertex};\n\n"
            "void main (void)\n{\n"
            "    vec3 px     = gl_TessCoord.x * gl_in[0].gl_Position.xyz;\n"
            "    vec3 py     = gl_TessCoord.y * gl_in[1].gl_Position.xyz;\n"
            "    vec3 pz     = gl_TessCoord.z * gl_in[2].gl_Position.xyz;\n"
            "    gl_Position = vec4(px + py + pz, 1.0);\n"
            "    out_color   = (in_color[0] + in_color[1] + in_color[2]) / 3.0;\n\n"
        )
        if dynamic:
            if num_clip > 0:
                s += (
                    f"    for (int i = 0; i < {num_clip}; ++i)\n"
                    "        gl_ClipDistance[i] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[i]\n"
                    "                           + gl_TessCoord.y * gl_in[1].gl_ClipDistance[i]\n"
                    "                           + gl_TessCoord.z * gl_in[2].gl_ClipDistance[i];\n"
                )
            if num_cull > 0:
                s += (
                    f"    for (int i = 0; i < {num_cull}; ++i)\n"
                    "        gl_CullDistance[i] = gl_TessCoord.x * gl_in[0].gl_CullDistance[i]\n"
                    "                           + gl_TessCoord.y * gl_in[1].gl_CullDistance[i]\n"
                    "                           + gl_TessCoord.z * gl_in[2].gl_CullDistance[i];\n"
                )
        else:
            for i in range(num_clip):
                s += (
                    f"    gl_ClipDistance[{i}] = gl_TessCoord.x * gl_in[0].gl_ClipDistance[{i}]\n"
                    f"                       + gl_TessCoord.y * gl_in[1].gl_ClipDistance[{i}]\n"
                    f"                       + gl_TessCoord.z * gl_in[2].gl_ClipDistance[{i}];\n"
                )
            for i in range(num_cull):
                s += (
                    f"    gl_CullDistance[{i}] = gl_TessCoord.x * gl_in[0].gl_CullDistance[{i}]\n"
                    f"                       + gl_TessCoord.y * gl_in[1].gl_CullDistance[{i}]\n"
                    f"                       + gl_TessCoord.z * gl_in[2].gl_CullDistance[{i}];\n"
                )
        s += "}\n"
        out["tese"] = s

    if geom:
        s = (
            "#version 450\n\n"
            "layout(triangles) in;\n"
            "layout(triangle_strip, max_vertices = 3) out;\n\n"
            "layout(location = 0) in  vec4 in_color[];\n"
            "layout(location = 0) out vec4 out_color;\n\n"
            f"in {per_vertex} gl_in[];\n\n"
            f"out {per_vertex};\n\n"
            "void main (void)\n{\n"
        )
        for v in range(3):
            if v > 0:
                s += "\n"
            s += f"    gl_Position = gl_in[{v}].gl_Position;\n    out_color   = in_color[{v}];\n"
            if dynamic:
                if num_clip > 0:
                    s += (
                        f"    for (int i = 0; i < {num_clip}; ++i)\n"
                        f"        gl_ClipDistance[i] = gl_in[{v}].gl_ClipDistance[i];\n"
                    )
                if num_cull > 0:
                    s += f"    for (int i = 0; i < {num_cull}; ++i)\n"
                    s += "    {\n"
                    if not read_frag:
                        s += f"    gl_CullDistance[i] = (gl_in[{v}].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;\n"
                    else:
                        s += f"        gl_CullDistance[i] = (gl_in[{v}].gl_CullDistance[i] == "
                        s += "0.3f" if tess else "0.1f"
                        s += f") ? ((gl_in[{v}].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;\n"
                    s += "    }\n"
            else:
                for i in range(num_clip):
                    s += f"    gl_ClipDistance[{i}] = gl_in[{v}].gl_ClipDistance[{i}];\n"
                for i in range(num_cull):
                    if not read_frag:
                        s += f"    gl_CullDistance[{i}] = (gl_in[{v}].gl_Position.x >= 0.75f) ? -0.5f : 0.5f;\n"
                    else:
                        s += f"        gl_CullDistance[{i}] = (gl_in[{v}].gl_CullDistance[{i}] == "
                        s += "0.3f" if tess else "0.1f"
                        s += f") ? ((gl_in[{v}].gl_Position.y < 0) ? -0.5f : 0.5f) : 0.4f;\n"
            s += "    EmitVertex();\n"
        s += "}\n"
        out["geom"] = s

    s = (
        "#version 450\n\n"
        "layout(location = 0) in flat vec4 in_color;\n"
        "layout(location = 0) out vec4 o_color;\n"
    )
    if read_frag:
        if num_clip > 0:
            s += f"in float gl_ClipDistance[{num_clip}];\n"
        if num_cull > 0:
            s += f"in float gl_CullDistance[{num_cull}];\n"
    s += "\nvoid main (void)\n{\n"
    if read_frag:
        s += "    o_color = vec4(in_color.r, "
        s += f"gl_ClipDistance[{num_clip // 2}], " if num_clip > 0 else "0.0, "
        s += f"gl_CullDistance[{num_cull // 2}], " if num_cull > 0 else "0.0, "
        s += " 1.0);\n"
    else:
        s += "    o_color = vec4(in_color.rgb + vec3(0.0, 0.0, 0.5), 1.0);\n"
    s += "}\n"
    out["frag"] = s
    return out


def complementarity_vert(n):
    last = n - 1
    s = (
        "#version 450\n\n"
        "layout(location = 0) in vec4 v_position;    // we are passing ClipDistance in w component\n\n"
        "out gl_PerVertex {\n"
        "    vec4  gl_Position;\n"
        f"    float gl_ClipDistance[{n}];\n"
        "};\n\n"
        "void main (void)\n{\n"
        "    gl_Position        = vec4(v_position.xyz, 1.0);\n"
    )
    for i in range(last):
        s += f"    gl_ClipDistance[{i}] = 0.0;\n"
    s += f"    gl_ClipDistance[{last}] = v_position.w;\n}}\n"
    return s


COMPLEMENTARITY_FRAG = (
    "#version 450\n\n"
    "layout(location = 0) out vec4 o_color;\n\n"
    "void main (void)\n{\n"
    "    o_color = vec4(1.0, 1.0, 1.0, 0.5);\n"
    "}\n"
)

CULL_VERT = (
    "#version 450\n"
    "layout(location = 0) in vec4 v_position;\n"
    "out gl_PerVertex {\n"
    "  vec4  gl_Position;\n"
    "  float gl_CullDistance[3];\n"
    "};\n"
    "void main (void)\n"
    "{\n"
    "  gl_Position = v_position;\n"
    "  gl_CullDistance[0] = 0.0 - float(gl_VertexIndex == 2);\n"
    "  gl_CullDistance[1] = 0.0 - float(gl_VertexIndex == 1);\n"
    "  gl_CullDistance[2] = 0.0 - float(gl_VertexIndex == 0);\n"
    "}\n"
)
CULL_FRAG = (
    "#version 450\n"
    "layout(location = 0) out vec4 o_color;\n"
    "void main (void)\n"
    "{\n"
    "  o_color = vec4(1.0, 0.0, 0.0, 1.0);\n"
    "}\n"
)


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    cases = []  # (const, name, [(program name, file name, stage)])

    def write(fname, text):
        (SRC / fname).write_text(text)

    write("simple.vert", simple_vert(0.0))
    write("simple_point.vert", simple_vert(1.0))
    write("point_size_large.vert", simple_vert(0.75 * RENDER_SIZE))
    write("simple.frag", SIMPLE_FRAG)
    cases.append(("SIMPLE", "simple", [("vert", "simple.vert", "vert"), ("frag", "simple.frag", "frag")]))
    cases.append(("SIMPLE_POINT", "simple_point", [("vert", "simple_point.vert", "vert"), ("frag", "simple.frag", "frag")]))
    cases.append(("POINT_SIZE_LARGE", "point_size_large", [("vert", "point_size_large.vert", "vert"), ("frag", "simple.frag", "frag")]))

    write("complementarity.frag", COMPLEMENTARITY_FRAG)
    for n in range(1, MAX_CLIP_DISTANCES + 1):
        write(f"complementarity_{n}.vert", complementarity_vert(n))
        cases.append((f"COMPLEMENTARITY_{n}", f"complementarity__{n}", [("vert", f"complementarity_{n}.vert", "vert"), ("frag", "complementarity.frag", "frag")]))

    write("cull_distance.vert", CULL_VERT)
    write("cull_distance.frag", CULL_FRAG)
    cases.append(("CULL_DISTANCE", "cull_distance", [("vert", "cull_distance.vert", "vert"), ("frag", "cull_distance.frag", "frag")]))

    count = 0
    for group_name, use_cull in (("clip_distance", False), ("clip_cull_distance", True)):
        for dynamic in (False, True):
            main_group = group_name + ("_dynamic_index" if dynamic else "")
            for shader_mask in range(4):
                tess = bool(shader_mask & 1)
                geom = bool(shader_mask & 2)
                shader_group = "vert" + ("_tess" if tess else "") + ("_geom" if geom else "")
                for num_clip in range(1, MAX_CLIP_DISTANCES + 1):
                    for read_name, read_frag in (("", False), ("_fragmentshader_read", True)):
                        num_cull = min(MAX_CULL_DISTANCES, MAX_COMBINED - num_clip) if use_cull else 0
                        case_name = str(num_clip) + (f"_{num_cull}" if num_cull > 0 else "") + read_name
                        progs = distance_programs(num_clip, num_cull, tess, geom, dynamic, read_frag)
                        const = f"CLIP_DISTANCE_{count:03d}"
                        count += 1
                        entries = []
                        for stage in ("vert", "tesc", "tese", "geom", "frag"):
                            if stage in progs:
                                fname = f"{const.lower()}.{stage}"
                                write(fname, progs[stage])
                                entries.append((stage, fname, stage))
                        cases.append((const, f"{main_group}__{shader_group}__{case_name}", entries))

    lines = [
        "# Shader manifest for dEQP-VK.clipping.*",
        "#",
        "# Generated by `scripts/gen_clipping_programs.py`, which also writes the GLSL next to the other shader templates.",
        "# `simple*` are the clip volume cases, `clip_distance*` the user defined plane cases (one per generated case,",
        "# named `<main group>__<shader group>__<case>` (no slash: the name ends up in a file name) so the Rust side finds it in ALL_SHARED_PROGRAM by that name).",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/clipping/vktClippingTests.cpp"',
        'rust_module = "clipping"',
        "",
    ]
    for const, name, progs in cases:
        lines.append("[[case]]")
        lines.append(f'name = "{name}"')
        lines.append(f'rust_const = "{const}"')
        lines.append('rust_type = "SharedProgram"')
        lines.append("programs = [")
        for pname, fname, stage in progs:
            lines.append(f'    {{ name = "{pname}", template = "clipping/{fname}", stage = "{stage}" }},')
        lines.append("]")
        lines.append("")
    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {len(cases)} cases")


if __name__ == "__main__":
    main()
