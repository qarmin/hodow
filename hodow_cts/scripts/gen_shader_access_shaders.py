#!/usr/bin/env python3
"""Generate the binding_model.shader_access shaders and their manifest.

`QuadrantRendederCase` assembles each shader from `genResourceDeclarations` and
`genResourceAccessSource`, which upstream evaluates per test case. For the buffer
descriptor types the result depends on only three things - whether the storage is a
uniform or a buffer block, how many descriptor sets there are, and which shader
interface arranges the bindings - so the whole compute half of the group collapses
onto 2 x 3 x 5 = 30 shaders.

The storage image types do not collapse anything like as far: their fetch coordinates
come from `getFetchPos`, which depends on the view type, the base mip level and the
base array slice, and they are baked into the GLSL as literals. That is one shader per
test case, 147 of them.

The dispatch is four workgroups, one per "quadrant"; each reads one of the two colours
in its descriptor and writes it to the result buffer, so the host can tell which
descriptor the shader actually reached.

Usage:
    python3 hodow_cts/scripts/gen_shader_access_shaders.py
"""

from __future__ import annotations

import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
SRC_DIR = CRATE_DIR / "shaders" / "src" / "binding_model" / "generated"
MANIFEST = CRATE_DIR / "shaders" / "manifest" / "binding_model_shader_access.toml"

# `DescriptorSetCount` / `getDescriptorSetNdx`
SET_NDX = {"single": [0], "multiple": [0, 1], "multiple_discontiguous": [0, 2]}

# `getArbitraryBindingIndex` - the largest binding values glslang accepts.
ARBITRARY_BINDINGS = [0x7FFE, 0xFFFE]

INTERFACES = ["single_descriptor", "multiple_contiguous", "multiple_discontiguous", "multiple_arbitrary", "descriptor_array"]


def resource_declarations(storage_type: str, set_count: str, interface: str, for_compute: bool = True) -> str:
    """`BufferDescriptorCase::genResourceDeclarations`.

    In a compute case `numUsedBindings` is 1 and the result buffer occupies binding 0 of
    set 0 only, which is why every set past the first shifts its bindings down by one. A
    graphics case has no result buffer, so every binding starts at 0.
    """
    out = []
    sets = SET_NDX[set_count]

    for set_ndx, descriptor_set in enumerate(sets):
        desc_binding = (1 - (0 if set_ndx == 0 else 1)) if for_compute else 0
        postfix = "" if len(sets) == 1 else str(set_ndx)

        def block(name: str, binding: int, instance: str, array: str = "") -> None:
            out.append(f"layout(set = {descriptor_set}, binding = {binding}, std140) {storage_type} {name}")
            out.append("{")
            out.append("    highp vec4 colorA;")
            out.append("    highp vec4 colorB;")
            out.append(f"}} {instance}{array};")

        if interface == "single_descriptor":
            block(f"BufferName{postfix}", desc_binding, f"b_instance{postfix}")
        elif interface == "multiple_contiguous":
            block(f"BufferName{postfix}A", desc_binding, f"b_instance{postfix}A")
            block(f"BufferName{postfix}B", desc_binding + 1, f"b_instance{postfix}B")
        elif interface == "multiple_discontiguous":
            block(f"BufferName{postfix}A", desc_binding, f"b_instance{postfix}A")
            block(f"BufferName{postfix}B", desc_binding + 2, f"b_instance{postfix}B")
        elif interface == "multiple_arbitrary":
            block(f"BufferName{postfix}A", ARBITRARY_BINDINGS[0], f"b_instance{postfix}A")
            block(f"BufferName{postfix}B", ARBITRARY_BINDINGS[1], f"b_instance{postfix}B")
        else:
            block(f"BufferName{postfix}", desc_binding, f"b_instances{postfix}", "[2]")

    return "\n".join(out) + "\n"


def resource_access(set_count: str, interface: str) -> str:
    """`BufferDescriptorCase::genResourceAccessSource`"""
    out = ["    result_color = vec4(0.0);"]
    sets = SET_NDX[set_count]

    for set_ndx in range(len(sets)):
        postfix = "" if len(sets) == 1 else str(set_ndx)
        out.append("    if (quadrant_id == 1 || quadrant_id == 2)")
        if interface == "single_descriptor":
            out.append(f"        result_color += b_instance{postfix}.colorA;")
            out.append("    else")
            out.append(f"        result_color += b_instance{postfix}.colorB;")
        elif interface == "descriptor_array":
            out.append(f"        result_color += b_instances{postfix}[0].colorA;")
            out.append("    else")
            out.append(f"        result_color += b_instances{postfix}[1].colorB;")
        else:
            out.append(f"        result_color += b_instance{postfix}A.colorA;")
            out.append("    else")
            out.append(f"        result_color += b_instance{postfix}B.colorB;")

    if len(sets) > 1:
        out.append(f"    result_color /= vec4({len(sets)}.0);")

    return "\n".join(out) + "\n"


# `s_quadrantGenVertexPosSource` - six vertices per quadrant, four quadrants, so a
# single non-indexed draw of 24 vertices covers the target in four blocks and
# `quadrant_id` says which one a fragment belongs to.
QUADRANT_GEN_VERTEX_POS = (
    "    highp int quadPhase = gl_VertexIndex % 6;\n"
    "    highp int quadXcoord = int(quadPhase == 1 || quadPhase == 4 || quadPhase == 5);\n"
    "    highp int quadYcoord = int(quadPhase == 2 || quadPhase == 3 || quadPhase == 5);\n"
    "    highp int quadOriginX = (gl_VertexIndex / 6) % 2;\n"
    "    highp int quadOriginY = (gl_VertexIndex / 6) / 2;\n"
    "    quadrant_id = gl_VertexIndex / 6;\n"
    "    result_position = vec4(float(quadOriginX + quadXcoord - 1), float(quadOriginY + quadYcoord - 1), 0.0, 1.0);\n"
)

# `genPerVertexBlock` emits nothing for an ES version. The buffer types are all
# `#version 310 es` so the block is absent there, but the 1D image views drop to
# desktop GLSL and do need it.
PER_VERTEX_OUT = "out gl_PerVertex {\n    vec4  gl_Position;\n    float gl_PointSize;\n};\n"


def per_vertex_block(version: str) -> str:
    return "" if version.strip().endswith("es") else PER_VERTEX_OUT

# `BufferDescriptorCase::genNoAccessSource` - the colours the descriptors would have
# held, written without reading any of them.
NO_ACCESS_SOURCE = (
    "    if (quadrant_id == 1 || quadrant_id == 2)\n"
    "        result_color = vec4(0.0, 1.0, 0.0, 1.0);\n"
    "    else\n"
    "        result_color = vec4(1.0, 1.0, 0.0, 1.0);\n"
)


def graphics_vertex_shader(declarations: str, access: str, contributing: bool, extension: str = "", version: str = "#version 310 es\n") -> str:
    """`QuadrantRendederCase::genVertexSource`, the branch where the vertex stage is active.

    `contributing` is upstream's `!onlyVS`: when the fragment stage also reads a
    descriptor, the vertex stage has to pass the quadrant id along so the fragment
    stage knows which half of the image it owns.
    """
    frag_color_prec = "mediump"
    return (
        version
        + extension
        + declarations
        + f"layout(location = 0) out {frag_color_prec} vec4 frag_color;\n"
        + ("layout(location = 1) flat out highp int frag_quadrant_id;\n" if contributing else "")
        + per_vertex_block(version)
        + "void main (void)\n"
        "{\n"
        "    highp vec4 result_position;\n"
        "    highp int quadrant_id;\n"
        + QUADRANT_GEN_VERTEX_POS
        + "    gl_Position = result_position;\n"
        + ("\tfrag_quadrant_id = quadrant_id;\n" if contributing else "")
        + "\n"
        "    highp vec4 result_color;\n"
        + access
        + "    frag_color = result_color;\n"
        "}\n"
    )


def graphics_vertex_passthrough(extension: str = "", version: str = "#version 310 es\n", next_stage: str = "frag") -> str:
    """The same, for the branch where the vertex stage reads nothing.

    Upstream emits `genExtensionDeclarations` here too even though nothing in the shader
    needs them, so this is not one shader shared by every descriptor type.
    """
    return (
        version
        + extension
        + f"layout(location = 1) flat out highp int {next_stage}_quadrant_id;\n"
        + per_vertex_block(version)
        + "void main (void)\n"
        "{\n"
        "    highp vec4 result_position;\n"
        "    highp int quadrant_id;\n"
        + QUADRANT_GEN_VERTEX_POS
        + "    gl_Position = result_position;\n"
        + f"    {next_stage}_quadrant_id = quadrant_id;\n"
        + "}\n"
    )


def graphics_fragment_shader(declarations: str, access: str, contributing: bool, extension: str = "", version: str = "#version 310 es\n") -> str:
    """`QuadrantRendederCase::genFragmentSource`, the branch where the fragment stage is active.

    When it is only a contributor the two stages split the image: the fragment stage's
    own read wins in the first two quadrants and the vertex stage's in the other two, so
    a wrong binding in either stage shows up.
    """
    return (
        version
        + extension
        + declarations
        + ("layout(location = 0) in mediump vec4 frag_color;\n" if contributing else "")
        + "layout(location = 1) flat in highp int frag_quadrant_id;\n"
        "layout(location = 0) out mediump vec4 o_color;\n"
        "void main (void)\n"
        "{\n"
        "    highp int quadrant_id = frag_quadrant_id;\n"
        "    highp vec4 result_color;\n"
        + access
        + (
            "    if (frag_quadrant_id < 2)\n"
            "        o_color = result_color;\n"
            "    else\n"
            "        o_color = frag_color;\n"
            if contributing
            else "    o_color = result_color;\n"
        )
        + "}\n"
    )


def graphics_fragment_passthrough(version: str = "#version 310 es\n") -> str:
    return (
        version
        + "layout(location = 0) in mediump vec4 frag_color;\n"
        "layout(location = 0) out mediump vec4 o_color;\n"
        "void main (void)\n"
        "{\n"
        "    o_color = frag_color;\n"
        "}\n"
    )


def graphics_fragment_no_access(version: str = "#version 310 es\n") -> str:
    return (
        version
        + "layout(location = 1) flat in highp int frag_quadrant_id;\n"
        "layout(location = 0) out mediump vec4 o_color;\n"
        "void main (void)\n"
        "{\n"
        "    highp int quadrant_id = frag_quadrant_id;\n"
        "    highp vec4 result_color;\n"
        + NO_ACCESS_SOURCE
        + "    o_color = result_color;\n"
        "}\n"
    )


def compute_shader(storage_type: str, set_count: str, interface: str) -> str:
    """`QuadrantRendederCase::genComputeSource`"""
    return (
        "#version 310 es\n"
        "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
        + resource_declarations(storage_type, set_count, interface)
        + "layout(set = 0, binding = 0, std140) writeonly buffer OutBuf\n"
        "{\n"
        "    highp vec4 read_colors[4];\n"
        "} b_out;\n"
        "void main (void)\n"
        "{\n"
        "    highp int quadrant_id = int(gl_WorkGroupID.x);\n"
        "    highp vec4 result_color;\n"
        + resource_access(set_count, interface)
        + "    b_out.read_colors[gl_WorkGroupID.x] = result_color;\n"
        "}\n"
    )


# `TexelBufferInstanceBuffers::getFetchPos` - arbitrary points, one per quadrant.
SAMPLE_POINTS = [6, 51, 42, 25]


def texel_declarations(storage_type: str, set_count: str, interface: str, for_compute: bool = True) -> str:
    """`TexelBufferDescriptorCase::genResourceDeclarations`."""
    out = []
    sets = SET_NDX[set_count]
    fmt = "" if storage_type == "uniform" else ", rgba8"
    decl = "textureBuffer " if storage_type == "uniform" else "readonly imageBuffer "

    for set_ndx, descriptor_set in enumerate(sets):
        desc_binding = (1 - (0 if set_ndx == 0 else 1)) if for_compute else 0
        postfix = "" if len(sets) == 1 else str(set_ndx)

        def one(binding: int, name: str, array: str = "") -> None:
            out.append(f"layout(set = {descriptor_set}, binding = {binding}{fmt}) uniform highp {decl}u_texelBuffer{name}{array};")

        if interface == "single_descriptor":
            one(desc_binding, postfix)
        elif interface == "multiple_contiguous":
            one(desc_binding, f"{postfix}A")
            one(desc_binding + 1, f"{postfix}B")
        elif interface == "multiple_discontiguous":
            one(desc_binding, f"{postfix}A")
            one(desc_binding + 2, f"{postfix}B")
        elif interface == "multiple_arbitrary":
            one(ARBITRARY_BINDINGS[0], f"{postfix}A")
            one(ARBITRARY_BINDINGS[1], f"{postfix}B")
        else:
            one(desc_binding, postfix, "[2]")

    return "\n".join(out) + "\n"


def texel_access(storage_type: str, set_count: str, interface: str) -> str:
    """`TexelBufferDescriptorCase::genResourceAccessSource`.

    The four quadrants alternate between the two descriptors, so a swapped binding
    shows up as the wrong texel rather than as no output at all.
    """
    postfix_a = {"single_descriptor": "", "descriptor_array": "[0]"}.get(interface, "A")
    postfix_b = {"single_descriptor": "", "descriptor_array": "[1]"}.get(interface, "B")
    fetch = "texelFetch" if storage_type == "uniform" else "imageLoad"

    out = ["    result_color = vec4(0.0);"]
    sets = SET_NDX[set_count]

    for set_ndx in range(len(sets)):
        p = "" if len(sets) == 1 else str(set_ndx)
        for quadrant in range(4):
            cond = "    if (quadrant_id == 0)" if quadrant == 0 else ("    else" if quadrant == 3 else f"    else if (quadrant_id == {quadrant})")
            out.append(cond)
            postfix = postfix_a if quadrant % 2 == 0 else postfix_b
            out.append(f"        result_color += {fetch}(u_texelBuffer{p}{postfix}, {SAMPLE_POINTS[quadrant]});")

    if len(sets) > 1:
        out.append(f"    result_color /= vec4({len(sets)}.0);")

    return "\n".join(out) + "\n"


def texel_compute_shader(storage_type: str, set_count: str, interface: str) -> str:
    return (
        "#version 310 es\n"
        "#extension GL_EXT_texture_buffer : require\n"
        "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
        + texel_declarations(storage_type, set_count, interface)
        + "layout(set = 0, binding = 0, std140) writeonly buffer OutBuf\n"
        "{\n"
        "    highp vec4 read_colors[4];\n"
        "} b_out;\n"
        "void main (void)\n"
        "{\n"
        "    highp int quadrant_id = int(gl_WorkGroupID.x);\n"
        "    highp vec4 result_color;\n"
        + texel_access(storage_type, set_count, interface)
        + "    b_out.read_colors[gl_WorkGroupID.x] = result_color;\n"
        "}\n"
    )


# `s_imageTypes` - the view type each case name stands for, and whether the view starts
# at a non-zero mip level or array slice.
IMAGE_TYPES = [
    ("1d", "1d", 0, 0),
    ("1d_base_mip", "1d", 1, 0),
    ("1d_base_slice", "1d", 0, 1),
    ("1d_array", "1d_array", 0, 0),
    ("1d_array_base_mip", "1d_array", 1, 0),
    ("1d_array_base_slice", "1d_array", 0, 1),
    ("2d", "2d", 0, 0),
    ("2d_base_mip", "2d", 1, 0),
    ("2d_base_slice", "2d", 0, 1),
    ("2d_array", "2d_array", 0, 0),
    ("2d_array_base_mip", "2d_array", 1, 0),
    ("2d_array_base_slice", "2d_array", 0, 1),
    ("3d", "3d", 0, 0),
    ("3d_base_mip", "3d", 1, 0),
    # no 3d array textures
    ("cube", "cube", 0, 0),
    ("cube_base_mip", "cube", 1, 0),
    ("cube_base_slice", "cube", 0, 1),
    ("cube_array", "cube_array", 0, 0),
    ("cube_array_base_mip", "cube_array", 1, 0),
    ("cube_array_base_slice", "cube_array", 0, 1),
]

# `ImageInstanceImages::IMAGE_SIZE` / `ARRAY_SIZE`
IMAGE_SIZE = 64
ARRAY_SIZE = 2

# `ImageFetchInstanceImages::SAMPLE_POINT_*` - arbitrary points, one per quadrant.
FETCH_POSITIONS = [(6, 13, 49), (51, 40, 44), (42, 26, 19), (25, 25, 18)]

ARRAY_VIEW_TYPES = {"1d_array", "2d_array", "cube_array"}

# `genResourceDeclarations`'s dimensionBase / dimensionArray.
DIMENSION_BASE = {"1d": "1D", "1d_array": "1D", "2d": "2D", "2d_array": "2D", "3d": "3D", "cube": "Cube", "cube_array": "Cube"}
DIMENSION_ARRAY = {"1d": "1DArray", "1d_array": "1DArray", "2d": "2DArray", "2d_array": "2DArray", "3d": "3D", "cube": "CubeArray", "cube_array": "CubeArray"}


def image_dimension(view_type: str) -> str:
    return DIMENSION_ARRAY[view_type] if view_type in ARRAY_VIEW_TYPES else DIMENSION_BASE[view_type]


def fetch_pos(view_type: str, base_mip_level: int, base_array_slice: int, fetch_pos_ndx: int) -> tuple[int, int, int]:
    """`ImageFetchInstanceImages::getFetchPos`"""
    x, y, z = FETCH_POSITIONS[fetch_pos_ndx]
    image_size = IMAGE_SIZE >> base_mip_level
    array_size = ARRAY_SIZE - base_array_slice if view_type in ARRAY_VIEW_TYPES else 1

    if view_type in ("1d", "1d_array"):
        return (x % image_size, y % array_size, 0)
    if view_type in ("2d", "2d_array"):
        return (x % image_size, y % image_size, z % array_size)
    if view_type in ("cube", "cube_array"):
        return (x % image_size, y % image_size, z % (array_size * 6))
    return (x % image_size, y % image_size, z % image_size)


def fetch_coord_str(view_type: str, base_mip_level: int, base_array_slice: int, fetch_pos_ndx: int) -> str:
    """`ImageDescriptorCase::genFetchCoordStr`"""
    x, y, z = fetch_pos(view_type, base_mip_level, base_array_slice, fetch_pos_ndx)
    if view_type == "1d":
        return str(x)
    if view_type in ("1d_array", "2d"):
        return f"ivec2({x}, {y})"
    return f"ivec3({x}, {y}, {z})"


def image_declarations(view_type: str, set_count: str, interface: str, for_compute: bool = True) -> str:
    """`ImageDescriptorCase::genResourceDeclarations`, VK_DESCRIPTOR_TYPE_STORAGE_IMAGE."""
    out = []
    sets = SET_NDX[set_count]
    dimension = image_dimension(view_type)

    for set_ndx, descriptor_set in enumerate(sets):
        desc_binding = (1 - (0 if set_ndx == 0 else 1)) if for_compute else 0
        postfix = "" if len(sets) == 1 else str(set_ndx)

        def one(binding: int, name: str, array: str = "") -> None:
            out.append(f"layout(set = {descriptor_set}, binding = {binding}, rgba8) readonly uniform highp image{dimension} u_image{name}{array};")

        if interface == "single_descriptor":
            one(desc_binding, postfix)
        elif interface == "multiple_contiguous":
            one(desc_binding, f"{postfix}A")
            one(desc_binding + 1, f"{postfix}B")
        elif interface == "multiple_discontiguous":
            one(desc_binding, f"{postfix}A")
            one(desc_binding + 2, f"{postfix}B")
        elif interface == "multiple_arbitrary":
            one(ARBITRARY_BINDINGS[0], f"{postfix}A")
            one(ARBITRARY_BINDINGS[1], f"{postfix}B")
        else:
            one(desc_binding, postfix, "[2]")

    return "\n".join(out) + "\n"


def image_access(view_type: str, base_mip_level: int, base_array_slice: int, set_count: str, interface: str) -> str:
    """`ImageDescriptorCase::genResourceAccessSource`, VK_DESCRIPTOR_TYPE_STORAGE_IMAGE."""
    postfix_a = {"single_descriptor": "", "descriptor_array": "[0]"}.get(interface, "A")
    postfix_b = {"single_descriptor": "", "descriptor_array": "[1]"}.get(interface, "B")
    coords = [fetch_coord_str(view_type, base_mip_level, base_array_slice, ndx) for ndx in range(4)]

    out = ["    result_color = vec4(0.0);"]
    sets = SET_NDX[set_count]

    for set_ndx in range(len(sets)):
        p = "" if len(sets) == 1 else str(set_ndx)
        for quadrant in range(4):
            cond = "    if (quadrant_id == 0)" if quadrant == 0 else ("    else" if quadrant == 3 else f"    else if (quadrant_id == {quadrant})")
            out.append(cond)
            postfix = postfix_a if quadrant % 2 == 0 else postfix_b
            out.append(f"        result_color += imageLoad(u_image{p}{postfix}, {coords[quadrant]});")

    if len(sets) > 1:
        out.append(f"    result_color /= vec4({len(sets)}.0);")

    return "\n".join(out) + "\n"


def image_compute_shader(view_type: str, base_mip_level: int, base_array_slice: int, set_count: str, interface: str) -> str:
    # 1D textures are not in ES, so upstream drops those cases to desktop GLSL.
    version = "#version 440\n" if view_type in ("1d", "1d_array") else "#version 310 es\n"
    extension = "#extension GL_OES_texture_cube_map_array : require\n" if view_type == "cube_array" else ""
    return (
        version
        + extension
        + "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
        + image_declarations(view_type, set_count, interface)
        + "layout(set = 0, binding = 0, std140) writeonly buffer OutBuf\n"
        "{\n"
        "    highp vec4 read_colors[4];\n"
        "} b_out;\n"
        "void main (void)\n"
        "{\n"
        "    highp int quadrant_id = int(gl_WorkGroupID.x);\n"
        "    highp vec4 result_color;\n"
        + image_access(view_type, base_mip_level, base_array_slice, set_count, interface)
        + "    b_out.read_colors[gl_WorkGroupID.x] = result_color;\n"
        "}\n"
    )


def sample_pos(view_type: str, base_mip_level: int, base_array_slice: int, sample_pos_ndx: int) -> tuple[float, float, float, float]:
    """`ImageSampleInstanceImages::getSamplePos` - arbitrary values chosen so that
    NEAREST filtering does not land on a texel boundary."""
    image_size = IMAGE_SIZE >> base_mip_level
    array_size = ARRAY_SIZE - base_array_slice if view_type in ARRAY_VIEW_TYPES else 1

    if view_type in ("cube", "cube_array"):
        coords = [
            (0.75, 0.5, float(image_size)),
            (float(13 % image_size) + 0.25, 0.0, float(16 % image_size) + 0.5),
            (0.0, float(84 % image_size) + 0.5, float(10 % image_size) + 0.75),
            (float(image_size), float(75 % image_size) + 0.25, float(83 % image_size) + 0.75),
        ]
        slices = [1 % array_size, 2 % array_size, 9 % array_size, 5 % array_size]
        x, y, z = coords[sample_pos_ndx]
        # map to [-1, 1]^3
        return (x / image_size * 2.0 - 1.0, y / image_size * 2.0 - 1.0, z / image_size * 2.0 - 1.0, float(slices[sample_pos_ndx]))

    coords = [
        (0.75, 0.5, float(12 % image_size) + 0.25),
        (float(23 % image_size) + 0.25, float(73 % image_size) + 0.5, float(16 % image_size) + 0.5 + image_size),
        (-float(43 % image_size) + 0.25, float(84 % image_size) + 0.5 + image_size, float(117 % image_size) + 0.75),
        (float(image_size) + 0.5, float(75 % image_size) + 0.25, float(83 % image_size) + 0.25 + image_size),
    ]
    slices = [0 % array_size, 4 % array_size, 9 % array_size, 2 % array_size]
    x, y, z = coords[sample_pos_ndx]

    if view_type in ("1d", "1d_array"):
        return (x / image_size, float(slices[sample_pos_ndx]), 0.0, 0.0)
    if view_type in ("2d", "2d_array"):
        return (x / image_size, y / image_size, float(slices[sample_pos_ndx]), 0.0)
    return (x / image_size, y / image_size, z / image_size, 0.0)


def sample_coord_str(view_type: str, base_mip_level: int, base_array_slice: int, sample_pos_ndx: int) -> str:
    """`ImageDescriptorCase::genSampleCoordStr`. The `%g` matches what C++ streams a
    float as by default, so the generated GLSL is byte-identical to upstream's."""
    x, y, z, w = sample_pos(view_type, base_mip_level, base_array_slice, sample_pos_ndx)
    f = lambda v: "%g" % v  # noqa: E731
    if view_type == "1d":
        return f"float({f(x)})"
    if view_type in ("1d_array", "2d"):
        return f"vec2(float({f(x)}), float({f(y)}))"
    if view_type == "cube_array":
        return f"vec4(float({f(x)}), float({f(y)}), float({f(z)}), float({f(w)}))"
    return f"vec3(float({f(x)}), float({f(y)}), float({f(z)}))"


def sampler_declarations(descriptor_type: str, view_type: str, set_count: str, interface: str, for_compute: bool = True) -> str:
    """`ImageDescriptorCase::genResourceDeclarations` for VK_DESCRIPTOR_TYPE_SAMPLER
    and VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER."""
    out = []
    sets = SET_NDX[set_count]
    dimension = image_dimension(view_type)

    for set_ndx, descriptor_set in enumerate(sets):
        desc_binding = (1 - (0 if set_ndx == 0 else 1)) if for_compute else 0
        postfix = "" if len(sets) == 1 else str(set_ndx)

        def texture(binding: int, name: str) -> None:
            out.append(f"layout(set = {descriptor_set}, binding = {binding}) uniform highp texture{dimension} u_separateTexture{name};")

        def sampler(binding: int, name: str, array: str = "") -> None:
            out.append(f"layout(set = {descriptor_set}, binding = {binding}) uniform highp sampler u_separateSampler{name}{array};")

        def combined(binding: int, name: str, array: str = "") -> None:
            out.append(f"layout(set = {descriptor_set}, binding = {binding}) uniform highp sampler{dimension} u_combinedTextureSampler{name}{array};")

        if descriptor_type == "sampler":
            if interface == "single_descriptor":
                texture(desc_binding, postfix)
                sampler(desc_binding + 1, postfix)
            elif interface in ("multiple_contiguous", "multiple_discontiguous"):
                # The discontiguous arrangement puts the texture between the two
                # samplers rather than before them.
                if interface == "multiple_contiguous":
                    texture(desc_binding, postfix)
                    sampler(desc_binding + 1, f"{postfix}A")
                    sampler(desc_binding + 2, f"{postfix}B")
                else:
                    sampler(desc_binding, f"{postfix}A")
                    texture(desc_binding + 1, postfix)
                    sampler(desc_binding + 2, f"{postfix}B")
            elif interface == "multiple_arbitrary":
                texture(desc_binding, postfix)
                sampler(ARBITRARY_BINDINGS[0], f"{postfix}A")
                sampler(ARBITRARY_BINDINGS[1], f"{postfix}B")
            else:
                texture(desc_binding, postfix)
                sampler(desc_binding + 1, postfix, "[2]")
        else:
            if interface == "single_descriptor":
                combined(desc_binding, postfix)
            elif interface == "multiple_contiguous":
                combined(desc_binding, f"{postfix}A")
                combined(desc_binding + 1, f"{postfix}B")
            elif interface == "multiple_discontiguous":
                combined(desc_binding, f"{postfix}A")
                combined(desc_binding + 2, f"{postfix}B")
            elif interface == "multiple_arbitrary":
                combined(ARBITRARY_BINDINGS[0], f"{postfix}A")
                combined(ARBITRARY_BINDINGS[1], f"{postfix}B")
            else:
                combined(desc_binding, postfix, "[2]")

    return "\n".join(out) + "\n"


def sampler_access(descriptor_type: str, view_type: str, base_mip_level: int, base_array_slice: int, set_count: str, interface: str) -> str:
    """`ImageDescriptorCase::genResourceAccessSource` for the two sampler types."""
    postfix_a = {"single_descriptor": "", "descriptor_array": "[0]"}.get(interface, "A")
    postfix_b = {"single_descriptor": "", "descriptor_array": "[1]"}.get(interface, "B")
    coords = [sample_coord_str(view_type, base_mip_level, base_array_slice, ndx) for ndx in range(4)]
    dimension = image_dimension(view_type)

    out = ["    result_color = vec4(0.0);"]
    sets = SET_NDX[set_count]

    for set_ndx in range(len(sets)):
        p = "" if len(sets) == 1 else str(set_ndx)
        for quadrant in range(4):
            cond = "    if (quadrant_id == 0)" if quadrant == 0 else ("    else" if quadrant == 3 else f"    else if (quadrant_id == {quadrant})")
            out.append(cond)
            postfix = postfix_a if quadrant % 2 == 0 else postfix_b
            if descriptor_type == "sampler":
                target = f"sampler{dimension}(u_separateTexture{p}, u_separateSampler{p}{postfix})"
            else:
                target = f"u_combinedTextureSampler{p}{postfix}"
            out.append(f"        result_color += textureLod({target}, {coords[quadrant]}, 0.0);")

    if len(sets) > 1:
        out.append(f"    result_color /= vec4({len(sets)}.0);")

    return "\n".join(out) + "\n"


def sampler_compute_shader(descriptor_type: str, view_type: str, base_mip_level: int, base_array_slice: int, set_count: str, interface: str) -> str:
    version = "#version 440\n" if view_type in ("1d", "1d_array") else "#version 310 es\n"
    extension = "#extension GL_OES_texture_cube_map_array : require\n" if view_type == "cube_array" else ""
    return (
        version
        + extension
        + "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
        + sampler_declarations(descriptor_type, view_type, set_count, interface)
        + "layout(set = 0, binding = 0, std140) writeonly buffer OutBuf\n"
        "{\n"
        "    highp vec4 read_colors[4];\n"
        "} b_out;\n"
        "void main (void)\n"
        "{\n"
        "    highp int quadrant_id = int(gl_WorkGroupID.x);\n"
        "    highp vec4 result_color;\n"
        + sampler_access(descriptor_type, view_type, base_mip_level, base_array_slice, set_count, interface)
        + "    b_out.read_colors[gl_WorkGroupID.x] = result_color;\n"
        "}\n"
    )


def image_case_exists(view_type: str, set_count: str, interface: str, descriptor_type: str = "storage_image", is_compute: bool = True) -> bool:
    """`createShaderAccessImageTests`' "skip some image view variations to avoid
    unnecessary bloating". Only the plain 2D view gets the arrangements that already
    multiply out, so the group does not become the product of every axis.

    Upstream keeps the discontiguous arrangement on every view for the separate
    sampler type - there it is about where the sampler sits relative to the texture,
    not about the view - but a second rule takes it away again in a compute shader.
    So a non-2D separate-sampler case exists in a graphics stage and not in compute.
    """
    if view_type == "2d":
        return True
    if interface == "multiple_arbitrary" or set_count == "multiple_discontiguous":
        return False
    if interface == "multiple_discontiguous":
        return descriptor_type == "sampler" and not is_compute
    return True


# `genPerVertexBlock` for the stages that read a block in as well as writing one out.
PER_VERTEX_TESC = (
    "in gl_PerVertex {\n    vec4  gl_Position;\n    float gl_PointSize;\n} gl_in[gl_MaxPatchVertices];\n"
    "out gl_PerVertex {\n    vec4  gl_Position;\n    float gl_PointSize;\n} gl_out[];\n"
)
PER_VERTEX_TESE = (
    "in gl_PerVertex {\n    vec4  gl_Position;\n    float gl_PointSize;\n} gl_in[gl_MaxPatchVertices];\n"
    "out gl_PerVertex {\n    vec4  gl_Position;\n    float gl_PointSize;\n};\n"
)
PER_VERTEX_GEOM = (
    "in gl_PerVertex {\n    vec4  gl_Position;\n    float gl_PointSize;\n} gl_in[];\n"
    "out gl_PerVertex {\n    vec4  gl_Position;\n    float gl_PointSize;\n};\n"
)

# Every tessellation shader here sets the same levels and forwards the position without
# indexing the input block dynamically, which ES does not allow.
TESS_COMMON_TAIL = (
    "    // no dynamic input block indexing\n"
    "    highp vec4 position;\n"
    "    if (gl_InvocationID == 0)\n"
    "        position = gl_in[0].gl_Position;\n"
    "    else if (gl_InvocationID == 1)\n"
    "        position = gl_in[1].gl_Position;\n"
    "    else\n"
    "        position = gl_in[2].gl_Position;\n"
    "    gl_out[gl_InvocationID].gl_Position = position;\n"
    "    gl_TessLevelInner[0] = 2.8;\n"
    "    gl_TessLevelInner[1] = 2.8;\n"
    "    gl_TessLevelOuter[0] = 2.8;\n"
    "    gl_TessLevelOuter[1] = 2.8;\n"
    "    gl_TessLevelOuter[2] = 2.8;\n"
    "    gl_TessLevelOuter[3] = 2.8;\n"
    "}\n"
)

TESE_POSITION = (
    "    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + "
    "gl_TessCoord.z * gl_in[2].gl_Position;\n"
)


def tess_ext(version: str) -> str:
    """`tessExtDecl` - required only on an ES version at or below 310."""
    return "#extension GL_EXT_tessellation_shader : require\n" if version.strip().endswith("es") else ""


def geom_ext(version: str) -> str:
    return "#extension GL_EXT_geometry_shader : require\n" if version.strip().endswith("es") else ""


def per_vertex(kind: str, version: str) -> str:
    if version.strip().endswith("es"):
        return ""
    return {"tesc": PER_VERTEX_TESC, "tese": PER_VERTEX_TESE, "geom": PER_VERTEX_GEOM}[kind]


def graphics_tesc_active(declarations: str, access: str, extension: str, version: str) -> str:
    """`genTessCtrlSource`, the branch where the control stage is the one that reads."""
    return (
        version
        + tess_ext(version)
        + extension
        + "layout(vertices=3) out;\n"
        + declarations
        + "layout(location = 1) flat in highp int tsc_quadrant_id[];\n"
        "layout(location = 0) out highp vec4 tes_color[];\n"
        + per_vertex("tesc", version)
        + "void main (void)\n"
        "{\n"
        "    highp vec4 result_color;\n"
        "    highp int quadrant_id = tsc_quadrant_id[gl_InvocationID];\n"
        + access
        + "\n"
        "    tes_color[gl_InvocationID] = result_color;\n"
        "\n" + TESS_COMMON_TAIL
    )


def graphics_tesc_passthrough(version: str) -> str:
    """The same, for the branch where the evaluation stage is the reader."""
    return (
        version
        + tess_ext(version)
        + "layout(vertices=3) out;\n"
        "layout(location = 1) flat in highp int tsc_quadrant_id[];\n"
        "layout(location = 1) flat out highp int tes_quadrant_id[];\n"
        + per_vertex("tesc", version)
        + "void main (void)\n"
        "{\n"
        "    tes_quadrant_id[gl_InvocationID] = tsc_quadrant_id[0];\n"
        "\n" + TESS_COMMON_TAIL
    )


def graphics_tese_active(declarations: str, access: str, extension: str, version: str) -> str:
    """`genTessEvalSource`, the branch where the evaluation stage reads."""
    return (
        version
        + tess_ext(version)
        + extension
        + "layout(triangles) in;\n"
        + declarations
        + "layout(location = 1) flat in highp int tes_quadrant_id[];\n"
        "layout(location = 0) out mediump vec4 frag_color;\n"
        + per_vertex("tese", version)
        + "void main (void)\n"
        "{\n"
        "    highp vec4 result_color;\n"
        "    highp int quadrant_id = tes_quadrant_id[0];\n"
        + access
        + "\n"
        "    frag_color = result_color;\n" + TESE_POSITION + "}\n"
    )


def graphics_tese_passthrough(version: str) -> str:
    """The same, when the control stage was the reader and only forwards its colour."""
    return (
        version
        + tess_ext(version)
        + "layout(triangles) in;\n"
        "layout(location = 0) in highp vec4 tes_color[];\n"
        "layout(location = 0) out mediump vec4 frag_color;\n"
        + per_vertex("tese", version)
        + "void main (void)\n"
        "{\n"
        "    frag_color = tes_color[0];\n" + TESE_POSITION + "}\n"
    )


def graphics_geom_active(declarations: str, access: str, extension: str, version: str) -> str:
    """`genGeometrySource`. It reads the descriptor once per emitted vertex, and the
    quadrant it asks for is deliberately not the vertex's own on the last one."""
    quadrants = [("0", "gl_in[0].gl_Position"), ("1", "gl_in[1].gl_Position"), ("2", "gl_in[0].gl_Position * 0.5 + gl_in[2].gl_Position * 0.5"), ("0", "gl_in[2].gl_Position")]
    body = ""
    for ndx, (which, position) in enumerate(quadrants):
        body += ("" if ndx == 0 else "\n")
        body += f"    quadrant_id = geo_quadrant_id[{which}];\n"
        body += access
        body += "    frag_color = result_color;\n"
        body += f"    gl_Position = {position};\n"
        body += "    EmitVertex();\n"
    return (
        version
        + geom_ext(version)
        + extension
        + "layout(triangles) in;\n"
        "layout(triangle_strip, max_vertices=4) out;\n"
        + declarations
        + "layout(location = 1) flat in highp int geo_quadrant_id[];\n"
        "layout(location = 0) out mediump vec4 frag_color;\n"
        + per_vertex("geom", version)
        + "void main (void)\n"
        "{\n"
        "    highp int quadrant_id;\n"
        "    highp vec4 result_color;\n"
        "\n" + body + "}\n"
    )


def emit_graphics_programs(name: str, declarations: str, access: str, extension: str = "", version: str = "#version 310 es\n") -> list[str]:
    """The four stage-active combinations a graphics case needs, as manifest entries.

    `vertex`/`fragment` are the "this stage is the only reader" forms and `*_contrib`
    the ones used when both stages read, where each owns half the image.
    """
    variants = [
        ("vert", graphics_vertex_shader(declarations, access, False, extension, version), "vert"),
        ("vert_contrib", graphics_vertex_shader(declarations, access, True, extension, version), "vert"),
        ("frag", graphics_fragment_shader(declarations, access, False, extension, version), "frag"),
        ("frag_contrib", graphics_fragment_shader(declarations, access, True, extension, version), "frag"),
        ("vert_passthrough", graphics_vertex_passthrough(extension, version), "vert"),
        # The two shaders that read no descriptor still belong to the case: upstream's
        # GLSL version is a property of the case, not of the shader, so a 1D image view
        # gets desktop-GLSL pass-throughs while a 2D one gets ES ones.
        ("frag_passthrough", graphics_fragment_passthrough(version), "frag"),
        ("frag_no_access", graphics_fragment_no_access(version), "frag"),
        # The tessellation and geometry configurations. The vertex stage only forwards
        # the quadrant id there, and its name depends on which stage comes next.
        ("vert_passthrough_tsc", graphics_vertex_passthrough(extension, version, "tsc"), "vert"),
        ("vert_passthrough_geo", graphics_vertex_passthrough(extension, version, "geo"), "vert"),
        ("tesc", graphics_tesc_active(declarations, access, extension, version), "tesc"),
        ("tesc_passthrough", graphics_tesc_passthrough(version), "tesc"),
        ("tese", graphics_tese_active(declarations, access, extension, version), "tese"),
        ("tese_passthrough", graphics_tese_passthrough(version), "tese"),
        ("geom", graphics_geom_active(declarations, access, extension, version), "geom"),
    ]
    entries = []
    for suffix, source, stage in variants:
        (SRC_DIR / f"{name}_{suffix}.{stage}").write_text(source)
        entries.append(f'    {{ name = "{suffix}", template = "binding_model/generated/{name}_{suffix}.{stage}", stage = "{stage}" }},')
    return entries


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for pattern in ("*.comp", "*.vert", "*.frag"):
        for existing in SRC_DIR.glob(pattern):
            existing.unlink()

    lines = [
        "# Shader manifest for dEQP-VK.binding_model.shader_access.*.{uniform,storage}_buffer*.compute.*",
        "#",
        "# Generated by scripts/gen_shader_access_shaders.py together with the GLSL it names;",
        "# do not hand-edit either. Upstream assembles the shader per test case out of",
        "# genResourceDeclarations() and genResourceAccessSource(); for the buffer types those",
        "# depend only on the storage class, the number of descriptor sets and the shader",
        "# interface, so the whole compute half is 30 shaders.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/binding_model/vktBindingShaderAccessTests.cpp"',
        'rust_module = "binding_model/shader_access_tests"',
        "",
    ]

    count = 0
    for storage_type in ("uniform", "buffer"):
        for set_count in SET_NDX:
            for interface in INTERFACES:
                name = f"buffer_{storage_type}_{set_count}_{interface}"
                (SRC_DIR / f"{name}.comp").write_text(compute_shader(storage_type, set_count, interface))
                graphics = emit_graphics_programs(
                    name,
                    resource_declarations(storage_type, set_count, interface, for_compute=False),
                    resource_access(set_count, interface),
                )
                lines += [
                    "[[case]]",
                    f'name = "{name}"',
                    f'rust_const = "{name.upper()}"',
                    'rust_type = "BufferAccessProgram"',
                    "programs = [",
                    f'    {{ name = "compute", template = "binding_model/generated/{name}.comp", stage = "comp" }},',
                    *graphics,
                    "]",
                    "[case.params]",
                    f'storage_type = {{ type = "str", value = "{storage_type}" }}',
                    f'set_count = {{ type = "str", value = "{set_count}" }}',
                    f'shader_interface = {{ type = "str", value = "{interface}" }}',
                    "",
                ]
                count += 1

    for storage_type in ("uniform", "buffer"):
        for set_count in SET_NDX:
            for interface in INTERFACES:
                name = f"texel_{storage_type}_{set_count}_{interface}"
                (SRC_DIR / f"{name}.comp").write_text(texel_compute_shader(storage_type, set_count, interface))
                graphics = emit_graphics_programs(
                    name,
                    texel_declarations(storage_type, set_count, interface, for_compute=False),
                    texel_access(storage_type, set_count, interface),
                    "#extension GL_EXT_texture_buffer : require\n",
                )
                lines += [
                    "[[case]]",
                    f'name = "{name}"',
                    f'rust_const = "{name.upper()}"',
                    'rust_type = "BufferAccessProgram"',
                    "programs = [",
                    f'    {{ name = "compute", template = "binding_model/generated/{name}.comp", stage = "comp" }},',
                    *graphics,
                    "]",
                    "[case.params]",
                    f'storage_type = {{ type = "str", value = "{storage_type}" }}',
                    f'set_count = {{ type = "str", value = "{set_count}" }}',
                    f'shader_interface = {{ type = "str", value = "{interface}" }}',
                    "",
                ]
                count += 1

    for view_name, view_type, base_mip_level, base_array_slice in IMAGE_TYPES:
        for set_count in SET_NDX:
            for interface in INTERFACES:
                # A case may exist only in the graphics stages, in which case it has
                # no compute program at all.
                in_compute = image_case_exists(view_type, set_count, interface, "storage_image", True)
                in_graphics = image_case_exists(view_type, set_count, interface, "storage_image", False)
                if not in_compute and not in_graphics:
                    continue
                name = f"storage_image_{view_name}_{set_count}_{interface}"
                version = "#version 440\n" if view_type in ("1d", "1d_array") else "#version 310 es\n"
                extension = "#extension GL_OES_texture_cube_map_array : require\n" if view_type == "cube_array" else ""
                programs = []
                if in_compute:
                    (SRC_DIR / f"{name}.comp").write_text(image_compute_shader(view_type, base_mip_level, base_array_slice, set_count, interface))
                    programs.append(f'    {{ name = "compute", template = "binding_model/generated/{name}.comp", stage = "comp" }},')
                if in_graphics:
                    programs += emit_graphics_programs(
                        name,
                        image_declarations(view_type, set_count, interface, for_compute=False),
                        image_access(view_type, base_mip_level, base_array_slice, set_count, interface),
                        extension,
                        version,
                    )
                lines += [
                    "[[case]]",
                    f'name = "{name}"',
                    f'rust_const = "{name.upper()}"',
                    'rust_type = "ImageAccessProgram"',
                    "programs = [",
                    *programs,
                    "]",
                    "[case.params]",
                    'descriptor_type = { type = "str", value = "storage_image" }',
                    f'view_name = {{ type = "str", value = "{view_name}" }}',
                    f'set_count = {{ type = "str", value = "{set_count}" }}',
                    f'shader_interface = {{ type = "str", value = "{interface}" }}',
                    "",
                ]
                count += 1

    for descriptor_type in ("sampler", "combined_image_sampler"):
        for view_name, view_type, base_mip_level, base_array_slice in IMAGE_TYPES:
            for set_count in SET_NDX:
                for interface in INTERFACES:
                    in_compute = image_case_exists(view_type, set_count, interface, descriptor_type, True)
                    in_graphics = image_case_exists(view_type, set_count, interface, descriptor_type, False)
                    if not in_compute and not in_graphics:
                        continue
                    name = f"{descriptor_type}_{view_name}_{set_count}_{interface}"
                    version = "#version 440\n" if view_type in ("1d", "1d_array") else "#version 310 es\n"
                    extension = "#extension GL_OES_texture_cube_map_array : require\n" if view_type == "cube_array" else ""
                    programs = []
                    if in_compute:
                        (SRC_DIR / f"{name}.comp").write_text(sampler_compute_shader(descriptor_type, view_type, base_mip_level, base_array_slice, set_count, interface))
                        programs.append(f'    {{ name = "compute", template = "binding_model/generated/{name}.comp", stage = "comp" }},')
                    if in_graphics:
                        programs += emit_graphics_programs(
                            name,
                            sampler_declarations(descriptor_type, view_type, set_count, interface, for_compute=False),
                            sampler_access(descriptor_type, view_type, base_mip_level, base_array_slice, set_count, interface),
                            extension,
                            version,
                        )
                    lines += [
                        "[[case]]",
                        f'name = "{name}"',
                        f'rust_const = "{name.upper()}"',
                        'rust_type = "ImageAccessProgram"',
                        "programs = [",
                        *programs,
                        "]",
                        "[case.params]",
                        f'descriptor_type = {{ type = "str", value = "{descriptor_type}" }}',
                        f'view_name = {{ type = "str", value = "{view_name}" }}',
                        f'set_count = {{ type = "str", value = "{set_count}" }}',
                        f'shader_interface = {{ type = "str", value = "{interface}" }}',
                        "",
                    ]
                    count += 1

    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)} and {count} shaders in {SRC_DIR.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
