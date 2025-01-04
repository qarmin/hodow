#!/usr/bin/env python3
"""Writes the shaders of dEQP-VK.image.atomic_operations.* (vktImageAtomicOperationTests.cpp, vktImageAtomicSpirvShaders.cpp) and their manifest.

One manifest entry per (operation, image type, format) that some case of the tree uses; its programs are the ones of `BinaryAtomicEndResultCase::initPrograms`
and `BinaryAtomicIntermValuesCase::initPrograms` plus `AddFillReadShader`, under the names the instances look them up by:
`fillShader`, `readShader`, `readShaderResidency`, `end_result` and `intermediate_values`. sub/inc/dec are the SPIR-V assembly templates of
vktImageAtomicSpirvShaders.cpp, extracted from the vendored C++ (the `${OPNAME}` / `${LASTARG}` placeholders are specialised here, as `getSpirvAtomicOpShader`'s
caller does). The tilings, the transfer flag and the read type do not change a shader, so they share the entry.

A pure text generator: no glslang and no cargo.   Run from hodow_cts/:  python3 scripts/gen_image_atomic_manifest.py   (then `just cts-shaders`)
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "image_atomic_operations"
MANIFEST = ROOT / "shaders" / "manifest" / "image_atomic_operations.toml"
SPIRV_CPP = ROOT / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "image" / "vktImageAtomicSpirvShaders.cpp"

OPS = ["add", "sub", "inc", "dec", "min", "max", "and", "or", "xor", "exchange", "compare_exchange"]
IMAGES = [
    ("1d", (64, 1, 1)),
    ("1d_array", (64, 1, 8)),
    ("2d", (64, 64, 1)),
    ("2d_array", (64, 64, 8)),
    ("3d", (48, 48, 8)),
    ("cube", (64, 64, 1)),
    ("cube_array", (64, 64, 2)),
    ("buffer", (64, 1, 1)),
]
# (qualifier, kind, component width, channels)
FORMATS = [
    ("r32ui", "uint", 32, 1),
    ("r32i", "int", 32, 1),
    ("r32f", "float", 32, 1),
    ("r64ui", "uint", 64, 1),
    ("r64i", "int", 64, 1),
    ("rg16f", "half", 16, 2),
    ("rgba16f", "half", 16, 4),
]
FLOAT_KINDS = ("float", "half")
NUM_INVOCATIONS_PER_PIXEL = 5
SPIRV_OPS = ("sub", "inc", "dec")
SPIRV_NAMES = {"sub": "OpAtomicISub", "inc": "OpAtomicIIncrement", "dec": "OpAtomicIDecrement"}
GLSL_FUNCS = {
    "add": "imageAtomicAdd",
    "min": "imageAtomicMin",
    "max": "imageAtomicMax",
    "and": "imageAtomicAnd",
    "or": "imageAtomicOr",
    "xor": "imageAtomicXor",
    "exchange": "imageAtomicExchange",
    "compare_exchange": "imageAtomicCompSwap",
}


def case_exists(op, img, fmt):
    """True when some case of createImageAtomicOperationTests uses this combination (the filters that do not depend on tiling, transfer, read type or backing)"""
    _, kind, _, _ = fmt
    if kind in FLOAT_KINDS and op not in ("add", "min", "max", "exchange"):
        return False
    return True


def grid_size(img, size):
    x, y, z = size
    return {
        "1d": (x, 1, 1),
        "buffer": (x, 1, 1),
        "1d_array": (x, z, 1),
        "2d": (x, y, 1),
        "2d_array": size,
        "3d": size,
        "cube": (x, y, 6),
        "cube_array": (x, y, 6 * z),
    }[img]


def coord_str(img, x, y, z):
    if img in ("1d", "buffer"):
        return x
    if img in ("1d_array", "2d"):
        return f"ivec2({x},{y})"
    return f"ivec3({x},{y},{z})"


def component_type(fmt):
    _, kind, width, channels = fmt
    if kind == "half":
        return f"f16vec{channels}"
    if kind == "int":
        return "int64_t" if width == 64 else "int"
    if kind == "uint":
        return "uint64_t" if width == 64 else "uint"
    return "float"


def vec4_type(fmt):
    _, kind, width, _ = fmt
    if kind == "int":
        return "i64vec4" if width == 64 else "ivec4"
    if kind == "uint":
        return "u64vec4" if width == 64 else "uvec4"
    return "vec4"


def image_type_str(fmt, img):
    _, kind, width, _ = fmt
    prefix = {"int": "i64" if width == 64 else "i", "uint": "u64" if width == 64 else "u"}.get(kind, "")
    suffix = {"1d": "1D", "1d_array": "1DArray", "2d": "2D", "2d_array": "2DArray", "3d": "3D", "cube": "Cube", "cube_array": "CubeArray", "buffer": "Buffer"}[img]
    return f"{prefix}image{suffix}"


def atomic_arg(fmt, op, x, y, z, grid):
    half = fmt[1] == "half"
    if op in ("add", "and", "or", "xor"):
        return f"({x} + 2*{y} + 3*{z})" if half else f"({x}*{x} + {y}*{y} + {z}*{z})"
    if op in ("min", "max"):
        if half:
            return f"((1 - 2*({x} % 2)) * ({x} + 2*{y} + 3*{z}))"
        return f"((1 - 2*({x} % 2)) * ({x}*{x} + {y}*{y} + {z}*{z}))"
    if half:
        return f"((({z}*{grid[0]} + {x})*{grid[1]} + {y}) % 1024)"
    return f"(({z}*{grid[0]} + {x})*{grid[1]} + {y})"


def extensions_fill(fmt):
    if fmt[2] == 64:
        return "#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require\n#extension GL_EXT_shader_image_int64 : require\n"
    return "#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable\n"


def construct_vec4(fmt):
    v4 = vec4_type(fmt)
    if fmt[1] == "half" and fmt[3] == 2:
        return f"#define TOVEC4(x) {v4}(x, 0, 0)\n"
    return f"#define TOVEC4(x) {v4}(x)\n"


def fill_read_shaders(img, fmt):
    ctype = component_type(fmt)
    coord = coord_str(img, "gx", "gy", "gz")
    qual = fmt[0]
    itype = image_type_str(fmt, img)
    ext = extensions_fill(fmt)
    fill = (
        "#version 450\n" + ext + f"precision highp {itype};\n\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
        f"layout ({qual}, binding=0) coherent uniform {itype} u_resultImage;\n\nlayout(std430, binding = 1) buffer inputBuffer\n{{\n    {ctype} data[];\n}} inBuffer;\n\n"
        + construct_vec4(fmt)
        + "\nvoid main(void)\n{\n    int gx = int(gl_GlobalInvocationID.x);\n    int gy = int(gl_GlobalInvocationID.y);\n    int gz = int(gl_GlobalInvocationID.z);\n"
        "    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);\n"
        f"    imageStore(u_resultImage, {coord}, TOVEC4(inBuffer.data[index]));\n}}\n"
    )
    swizzle = (".xy" if fmt[3] != 4 else "") if fmt[1] == "half" else ".x"
    read_body = (
        "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
        f"layout ({qual}, binding=0) coherent uniform {itype} u_resultImage;\n\nlayout(std430, binding = 1) buffer outputBuffer\n{{\n    {ctype} data[];\n}} outBuffer;\n\n"
        "void main(void)\n{\n    int gx = int(gl_GlobalInvocationID.x);\n    int gy = int(gl_GlobalInvocationID.y);\n    int gz = int(gl_GlobalInvocationID.z);\n"
        "    uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);\n"
        f"    outBuffer.data[index] = {ctype}(imageLoad(u_resultImage, {coord}){swizzle});\n"
    )
    read = "#version 450\n" + ext + f"precision highp {itype};\n\n" + read_body + "}\n"
    residency = None
    if img not in ("1d", "1d_array", "buffer"):
        v4 = vec4_type(fmt)
        residency = (
            "#version 450\n#extension GL_ARB_sparse_texture2 : require\n" + ext + f"precision highp {itype};\n\n" + read_body
            + f"    {v4} sparseValue;\n    sparseImageLoadARB(u_resultImage, {coord}, sparseValue);\n"
            f"    if (outBuffer.data[index] != {ctype}(sparseValue))\n        outBuffer.data[index] = {ctype}(1234);\n}}\n"
        )
    return fill, read, residency


def test_shader(op, img, size, fmt, intermediate):
    _, kind, width, channels = fmt
    ctype = component_type(fmt)
    grid = grid_size(img, size)
    atomic_coord = coord_str(img, f"gx % {grid[0]}", "gy", "gz")
    arg = ctype + atomic_arg(fmt, op, "gx", "gy", "gz", (NUM_INVOCATIONS_PER_PIXEL * grid[0], grid[1], grid[2]))
    cmp_str = ""
    if op == "compare_exchange":
        cmp_str = (", 820338753304" if width == 64 else ", 18") + ("u" if kind == "uint" else "") + ("l" if width == 64 else "")
    invocation = f"{GLSL_FUNCS[op]}(u_resultImage, {atomic_coord}{cmp_str}, {arg})"
    qual = fmt[0]
    itype = image_type_str(fmt, img)
    extensions = (
        "#extension GL_EXT_shader_atomic_float : enable\n#extension GL_EXT_shader_atomic_float2 : enable\n#extension GL_KHR_memory_scope_semantics : enable\n"
        "#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable\n#extension GL_NV_shader_atomic_fp16_vector : enable\n"
    )
    src = "#version 450\n" + extensions + "\n"
    if width == 64:
        src += "#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require\n#extension GL_EXT_shader_image_int64 : require\n"
    if not intermediate:
        src += (
            f"precision highp {itype};\n\nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
            f"layout ({qual}, binding=0) coherent uniform {itype} u_resultImage;\n\nvoid main (void)\n{{\n"
            "    int gx = int(gl_GlobalInvocationID.x);\n    int gy = int(gl_GlobalInvocationID.y);\n    int gz = int(gl_GlobalInvocationID.z);\n"
            f"    {invocation};\n}}\n"
        )
    else:
        invocation_coord = coord_str(img, "gx", "gy", "gz")
        src += (
            f"precision highp {itype}; \nlayout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
            f"layout ({qual}, binding=0) coherent uniform {itype} u_resultImage;\n"
            f"layout ({qual}, binding=1) writeonly uniform {itype} u_intermValuesImage;\n\n"
            + construct_vec4(fmt)
            + "\nvoid main (void)\n{\n    int gx = int(gl_GlobalInvocationID.x);\n    int gy = int(gl_GlobalInvocationID.y);\n    int gz = int(gl_GlobalInvocationID.z);\n"
            f"    imageStore(u_intermValuesImage, {invocation_coord}, TOVEC4({invocation}));\n}}\n"
        )
    return src


def spirv_templates():
    text = SPIRV_CPP.read_text()
    return {m.group(1): m.group(2) for m in re.finditer(r'const std::string kShader_(\w+) = R"\((.*?)\)";', text, re.S)}


def spirv_shader(templates, op, img, fmt, intermediate):
    image_name = "image_buffer" if img == "buffer" else img
    key = f"{image_name}_{fmt[0]}_{'intermediate_values' if intermediate else 'end_result'}"
    template = templates[key]
    template = template.replace("${OPNAME}", SPIRV_NAMES[op])
    if op in ("inc", "dec"):
        template = re.sub(r"\$\{LASTARG:default=[^}]*\}", "", template)
    else:
        template = re.sub(r"\$\{LASTARG:default=([^}]*)\}", r"\1", template)
    return template


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    templates = spirv_templates()
    out = [
        "# Shader manifest for dEQP-VK.image.atomic_operations.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_image_atomic_manifest.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/image/vktImageAtomicOperationTests.cpp"',
        'rust_module = "image/atomic_operation_tests"',
        "",
    ]
    fill_read_written = set()
    entries = 0
    for op in OPS:
        for img, size in IMAGES:
            for fmt in FORMATS:
                if not case_exists(op, img, fmt):
                    continue
                if op in SPIRV_OPS and fmt[1] in FLOAT_KINDS:
                    continue
                key = f"{op}_{img}_{fmt[0]}"
                fr_key = f"{img}_{fmt[0]}"
                if fr_key not in fill_read_written:
                    fill, read, residency = fill_read_shaders(img, fmt)
                    (SRC / f"fill_{fr_key}.comp").write_text(fill)
                    (SRC / f"read_{fr_key}.comp").write_text(read)
                    if residency:
                        (SRC / f"read_residency_{fr_key}.comp").write_text(residency)
                    fill_read_written.add(fr_key)
                programs = [
                    ("fillShader", f"fill_{fr_key}.comp", "comp", "spirv1.3"),
                    ("readShader", f"read_{fr_key}.comp", "comp", "spirv1.3"),
                ]
                if img not in ("1d", "1d_array", "buffer"):
                    programs.append(("readShaderResidency", f"read_residency_{fr_key}.comp", "comp", "spirv1.3"))
                for intermediate in (False, True):
                    pname = "intermediate_values" if intermediate else "end_result"
                    if op in SPIRV_OPS:
                        fname = f"{key}_{pname}.spvasm"
                        (SRC / fname).write_text(spirv_shader(templates, op, img, fmt, intermediate))
                        programs.append((pname, fname, "asm", None))
                    else:
                        fname = f"{key}_{pname}.comp"
                        (SRC / fname).write_text(test_shader(op, img, size, fmt, intermediate))
                        programs.append((pname, fname, "comp", None))
                out += ["[[case]]", f'name = "{key}"', f'rust_const = "{key.upper()}"', 'rust_type = "SharedProgram"', "programs = ["]
                for pname, fname, stage, spv in programs:
                    extra = f', spirv_version = "{spv}"' if spv else ""
                    out.append(f'    {{ name = "{pname}", template = "image_atomic_operations/{fname}", stage = "{stage}"{extra} }},')
                out += ["]", ""]
                entries += 1
    MANIFEST.write_text("\n".join(out))
    print(f"{entries} entries")


if __name__ == "__main__":
    main()
