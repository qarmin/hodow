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


def resource_declarations(storage_type: str, set_count: str, interface: str) -> str:
    """`BufferDescriptorCase::genResourceDeclarations`, compute stage.

    `numUsedBindings` is 1, and the result buffer occupies binding 0 of set 0 only,
    which is why every set past the first shifts its bindings down by one.
    """
    out = []
    sets = SET_NDX[set_count]

    for set_ndx, descriptor_set in enumerate(sets):
        desc_binding = 1 - (0 if set_ndx == 0 else 1)
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


def texel_declarations(storage_type: str, set_count: str, interface: str) -> str:
    """`TexelBufferDescriptorCase::genResourceDeclarations`, compute stage."""
    out = []
    sets = SET_NDX[set_count]
    fmt = "" if storage_type == "uniform" else ", rgba8"
    decl = "textureBuffer " if storage_type == "uniform" else "readonly imageBuffer "

    for set_ndx, descriptor_set in enumerate(sets):
        desc_binding = 1 - (0 if set_ndx == 0 else 1)
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


def image_declarations(view_type: str, set_count: str, interface: str) -> str:
    """`ImageDescriptorCase::genResourceDeclarations`, VK_DESCRIPTOR_TYPE_STORAGE_IMAGE."""
    out = []
    sets = SET_NDX[set_count]
    dimension = image_dimension(view_type)

    for set_ndx, descriptor_set in enumerate(sets):
        desc_binding = 1 - (0 if set_ndx == 0 else 1)
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


def image_case_exists(view_type: str, set_count: str, interface: str) -> bool:
    """`createShaderAccessImageTests`' "skip some image view variations to avoid
    unnecessary bloating". Only the plain 2D view gets the arrangements that already
    multiply out, so the group does not become the product of every axis."""
    if view_type == "2d":
        return True
    return interface not in ("multiple_discontiguous", "multiple_arbitrary") and set_count != "multiple_discontiguous"


def main() -> int:
    SRC_DIR.mkdir(parents=True, exist_ok=True)
    for existing in SRC_DIR.glob("*.comp"):
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
                lines += [
                    "[[case]]",
                    f'name = "{name}"',
                    f'rust_const = "{name.upper()}"',
                    'rust_type = "BufferAccessProgram"',
                    f'programs = [{{ name = "compute", template = "binding_model/generated/{name}.comp", stage = "comp" }}]',
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
                lines += [
                    "[[case]]",
                    f'name = "{name}"',
                    f'rust_const = "{name.upper()}"',
                    'rust_type = "BufferAccessProgram"',
                    f'programs = [{{ name = "compute", template = "binding_model/generated/{name}.comp", stage = "comp" }}]',
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
                if not image_case_exists(view_type, set_count, interface):
                    continue
                name = f"image_{view_name}_{set_count}_{interface}"
                (SRC_DIR / f"{name}.comp").write_text(image_compute_shader(view_type, base_mip_level, base_array_slice, set_count, interface))
                lines += [
                    "[[case]]",
                    f'name = "{name}"',
                    f'rust_const = "{name.upper()}"',
                    'rust_type = "ImageAccessProgram"',
                    f'programs = [{{ name = "compute", template = "binding_model/generated/{name}.comp", stage = "comp" }}]',
                    "[case.params]",
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
