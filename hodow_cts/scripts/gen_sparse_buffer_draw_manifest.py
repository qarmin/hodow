#!/usr/bin/env python3
"""Writes shaders/manifest/sparse_resources_buffer_draw.toml and its GLSL sources.

`initProgramsDrawWithBufferObject` (one fragment shader per flags and buffer type) and `initProgramsDrawGrid` (vertex_buffer, index_buffer and
indirect_buffer) of vktSparseResourcesBufferTests.cpp.
"""
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
SRC = CRATE / "shaders" / "src" / "sparse_resources" / "buffer_draw"
MANIFEST = CRATE / "shaders" / "manifest" / "sparse_resources_buffer_draw.toml"
RENDER_SIZE = 128

VERT_OBJECT = (
    "#version 450\n"
    "\n"
    "layout(location = 0) in vec4 in_position;\n"
    "\n"
    "out gl_PerVertex {\n"
    "    vec4 gl_Position;\n"
    "};\n"
    "\n"
    "void main(void)\n"
    "{\n"
    "    gl_Position = in_position;\n"
    "}\n"
)

VERT_GRID = (
    "#version 450\n"
    "\n"
    "layout(location = 0) in  vec4 in_position;\n"
    "layout(location = 0) out int  out_ndx;\n"
    "\n"
    "out gl_PerVertex {\n"
    "    vec4 gl_Position;\n"
    "};\n"
    "\n"
    "void main(void)\n"
    "{\n"
    "    gl_Position = in_position;\n"
    "    out_ndx     = gl_VertexIndex;\n"
    "}\n"
)

FRAG_GRID = (
    "#version 450\n"
    "\n"
    "layout(location = 0) flat in  int  in_ndx;\n"
    "layout(location = 0)      out vec4 o_color;\n"
    "\n"
    "void main(void)\n"
    "{\n"
    "    if (in_ndx % 2 == 0)\n"
    "        o_color = vec4(vec3(1.0), 1.0);\n"
    "    else\n"
    "        o_color = vec4(vec3(0.75), 1.0);\n"
    "}\n"
)


VERT_XFB = (
    "#version 450\n"
    "layout(location = 0) in vec4 in_position;\n"
    "layout(xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4, location = 0) out uint out_ndx;\n"
    "out gl_PerVertex {\n"
    "    vec4 gl_Position;\n"
    "};\n"
    "void main(void)\n"
    "{\n"
    "    gl_Position = in_position;\n"
    "    out_ndx     = gl_VertexIndex;\n"
    "}\n"
)

FRAG_XFB = (
    "#version 450\n"
    "layout(location = 0) out vec4 o_color;\n"
    "void main(void)\n"
    "{\n"
    "    o_color = vec4(1.0);\n"
    "}\n"
)

COMP_DISPATCH = (
    "#version 450\n"
    "layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
    "layout(binding = 0, std430) writeonly buffer Output\n"
    "{  uint r[]; };\n"
    "void main(void)\n"
    "{\n"
    "    r[gl_GlobalInvocationID.y] = 135 + gl_GlobalInvocationID.y;\n"
    "}\n"
)


def frag_object(aliased: bool, residency: bool, strict: bool, storage: bool) -> str:
    value_expr = "ivec4(3*(ndx % nonAliasedSize) ^ 127, 0, 0, 0)" if aliased else "ivec4(3*ndx ^ 127, 0, 0, 0)"
    buffer_type = "buffer" if storage else "uniform"
    layout = "std430" if storage else "std140"
    volatile = "volatile " if storage else ""
    s = (
        "#version 450\n"
        "\n"
        "layout(location = 0) out vec4 o_color;\n"
        "\n"
        "layout(constant_id = 1) const int dataSize  = 1;\n"
        "layout(constant_id = 2) const int chunkSize = 1;\n"
        "\n"
        f"layout(set = 0, binding = 0, {layout}) {buffer_type} SparseBuffer {{\n"
        f"    {volatile}ivec4 data[dataSize];\n"
        "} buff;\n"
        "\n"
        "void main(void)\n"
        "{\n"
        f"    const int fragNdx        = int(gl_FragCoord.x) + {RENDER_SIZE} * int(gl_FragCoord.y);\n"
        f"    const int pageSize       = {RENDER_SIZE} * {RENDER_SIZE};\n"
        "    const int numChunks      = dataSize / chunkSize;\n"
    )
    if aliased:
        s += "    const int nonAliasedSize = (numChunks > 1 ? dataSize - chunkSize : dataSize);\n"
    s += (
        "    bool      ok             = true;\n"
        "\n"
        "    for (int ndx = fragNdx; ndx < dataSize; ndx += pageSize)\n"
        "    {\n"
        "        ivec4 readData = buff.data[ndx];\n"
        "\n"
    )
    if storage:
        s += (
            "        // Write a new value based on index\n"
            "        ivec4 newData = ivec4(ndx * 2 + 1, ndx ^ 0x55, ndx, 1);\n"
            "        buff.data[ndx] = newData;\n"
            "        ivec4 verifyData = buff.data[ndx];\n"
            "\n"
        )
    verify_zero = " && (verifyData == ivec4(0))" if storage else ""
    verify_new = " && (verifyData == newData)" if storage else ""
    if residency and strict:
        s += (
            "        if (ndx >= chunkSize && ndx < 2 * chunkSize)\n"
            f"            ok = ok && (readData == ivec4(0)){verify_zero};\n"
            "        else\n"
            f"            ok = ok && (readData == {value_expr}){verify_new};\n"
        )
    elif residency:
        s += (
            "        if (ndx >= chunkSize && ndx < 2*chunkSize)\n"
            "            continue;\n"
            f"        ok = ok && (readData == {value_expr}){verify_new};\n"
        )
    else:
        s += f"        ok = ok && (readData == {value_expr}){verify_new};\n"
    s += (
        "    }\n"
        "\n"
        "    if (ok)\n"
        "        o_color = vec4(0.0, 1.0, 0.0, 1.0);\n"
        "    else\n"
        "        o_color = vec4(1.0, 0.0, 0.0, 1.0);\n"
        "}\n"
    )
    return s


def main() -> None:
    SRC.mkdir(parents=True, exist_ok=True)
    (SRC / "vert_object.vert").write_text(VERT_OBJECT)
    (SRC / "vert_grid.vert").write_text(VERT_GRID)
    (SRC / "frag_grid.frag").write_text(FRAG_GRID)
    out = [
        "# Shader manifest for dEQP-VK.sparse_resources.buffer.{ubo,ssbo.read_write,vertex_buffer,index_buffer,indirect_buffer}.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_sparse_buffer_draw_manifest.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferTests.cpp"',
        'rust_module = "sparse_resources/buffer_draw_tests"',
        "",
    ]
    cases = [
        ("ubo_sparse_binding", False, False, False, False),
        ("ubo_sparse_binding_aliased", True, False, False, False),
        ("ubo_sparse_residency", False, True, False, False),
        ("ubo_sparse_residency_aliased", True, True, False, False),
        ("ubo_sparse_residency_non_resident_strict", False, True, True, False),
        ("ssbo_read_write", False, True, True, True),
    ]
    for name, aliased, residency, strict, storage in cases:
        (SRC / f"{name}.frag").write_text(frag_object(aliased, residency, strict, storage))
        out += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "SPARSE_{name.upper()}"',
            'rust_type = "SharedProgram"',
            "programs = [",
            '    { name = "vert", template = "sparse_resources/buffer_draw/vert_object.vert", stage = "vert" },',
            f'    {{ name = "frag", template = "sparse_resources/buffer_draw/{name}.frag", stage = "frag" }},',
            "]",
            "",
        ]
    out += [
        "[[case]]",
        'name = "draw_grid"',
        'rust_const = "SPARSE_DRAW_GRID"',
        'rust_type = "SharedProgram"',
        "programs = [",
        '    { name = "vert", template = "sparse_resources/buffer_draw/vert_grid.vert", stage = "vert" },',
        '    { name = "frag", template = "sparse_resources/buffer_draw/frag_grid.frag", stage = "frag" },',
        "]",
        "",
    ]
    (SRC / "vert_xfb.vert").write_text(VERT_XFB)
    (SRC / "frag_xfb.frag").write_text(FRAG_XFB)
    (SRC / "indirect_dispatch.comp").write_text(COMP_DISPATCH)
    out += [
        "[[case]]",
        'name = "transform_feedback"',
        'rust_const = "SPARSE_TRANSFORM_FEEDBACK"',
        'rust_type = "SharedProgram"',
        "programs = [",
        '    { name = "vert", template = "sparse_resources/buffer_draw/vert_xfb.vert", stage = "vert" },',
        '    { name = "frag", template = "sparse_resources/buffer_draw/frag_xfb.frag", stage = "frag" },',
        "]",
        "",
        "[[case]]",
        'name = "indirect_dispatch"',
        'rust_const = "SPARSE_INDIRECT_DISPATCH"',
        'rust_type = "SharedProgram"',
        'programs = [{ name = "comp", template = "sparse_resources/buffer_draw/indirect_dispatch.comp", stage = "comp" }]',
        "",
    ]
    MANIFEST.write_text("\n".join(out))


if __name__ == "__main__":
    main()
