#!/usr/bin/env python3
"""Generate the binding_model.shader_access buffer shaders and their manifest.

`QuadrantRendederCase` assembles each shader from `genResourceDeclarations` and
`genResourceAccessSource`, which upstream evaluates per test case. For the buffer
descriptor types the result depends on only three things - whether the storage is a
uniform or a buffer block, how many descriptor sets there are, and which shader
interface arranges the bindings - so the whole compute half of the group collapses
onto 2 x 3 x 5 = 30 shaders.

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

    MANIFEST.write_text("\n".join(lines))
    print(f"wrote {MANIFEST.relative_to(REPO_DIR)} and {count} shaders in {SRC_DIR.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
