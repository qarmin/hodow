#!/usr/bin/env python3
"""Writes the shaders of dEQP-VK.tensor.* (modules/vulkan/tensor/shaders/*.cpp, the genShader* functions) and their manifests, one manifest per group.

A pure text generator: no glslang and no cargo.   Run from hodow_cts/:  python3 scripts/gen_tensor_manifests.py   (then `just cts-shaders`)
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "tensor"
MANIFESTS = ROOT / "shaders" / "manifest"
UPSTREAM = "external/vulkancts/modules/vulkan/tensor/"

# (short name used in case names and constants, GLSL element type)
FORMATS = [
    ("R64_UINT", "uint64_t"),
    ("R64_SINT", "int64_t"),
    ("R32_UINT", "uint32_t"),
    ("R32_SINT", "int32_t"),
    ("R32_SFLOAT", "float32_t"),
    ("R16_UINT", "uint16_t"),
    ("R16_SINT", "int16_t"),
    ("R16_SFLOAT", "float16_t"),
    ("R8_UINT", "uint8_t"),
    ("R8_SINT", "int8_t"),
    ("R8_BOOL", "bool"),
    ("R8_SFLOAT_FPENCODING_FLOAT8E5M2", "floate5m2_t"),
    ("R8_SFLOAT_FPENCODING_FLOAT8E4M3", "floate4m3_t"),
    ("R16_SFLOAT_FPENCODING_BFLOAT16", "bfloat16_t"),
]


def format_extensions(short):
    if short == "R16_SFLOAT_FPENCODING_BFLOAT16":
        return "#extension GL_EXT_bfloat16: require\n#extension GL_ARM_tensors_bfloat16 : require\n"
    if short == "R8_SFLOAT_FPENCODING_FLOAT8E5M2":
        return "#extension GL_EXT_float_e5m2 : require\n#extension GL_ARM_tensors_float_e5m2 : require\n"
    if short == "R8_SFLOAT_FPENCODING_FLOAT8E4M3":
        return "#extension GL_EXT_float_e4m3 : require\n#extension GL_ARM_tensors_float_e4m3 : require\n"
    return ""


def gen_query_dimensions(rank, short, glsl_type):
    src = "#version 450\n#extension GL_ARM_tensors : require\n#extension GL_EXT_shader_explicit_arithmetic_types : require\n\n"
    src += format_extensions(short)
    src += "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
    src += f"layout(set=0, binding=0) uniform tensorARM<{glsl_type}, {rank}> tens;\n"
    src += "layout(set=0, binding=1, std430) buffer _buff { uint data[]; };\n\nvoid main()\n{\n"
    for idx in range(rank):
        src += f"\tdata[{idx}] = tensorSizeARM(tens, {idx});\n"
    return src + "}"


def coords_code(rank, indent="\t"):
    """The size queries, early exit and coordinate computation every access shader starts with"""
    src = ""
    for i in range(rank):
        src += f"{indent}const uint size_d{i} = tensorSizeARM(tens, {i});\n"
    src += f"{indent}const uint tensor_element_count = " + " * ".join(f"size_d{i}" for i in range(rank)) + ";\n"
    src += f"{indent}if (gl_GlobalInvocationID.x >= tensor_element_count) return;\n"
    for i in range(rank):
        src += f"{indent}const uint coord_{i} = gl_GlobalInvocationID.x / (1" + "".join(f" * size_d{j}" for j in range(i + 1, rank)) + f") % size_d{i};\n"
    return src


def coord_list(rank):
    return ", ".join(f"coord_{i}" for i in range(rank))


BOOLEAN_OPS = ["and", "or", "not", "xor"]


def gen_boolean_op(rank, op, test_value):
    value = "true" if test_value else "false"
    src = "#version 450\n#extension GL_ARM_tensors : require\n#extension GL_EXT_shader_explicit_arithmetic_types : require\n"
    src += "layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;\n"
    src += f"layout(set=0, binding = 0) uniform tensorARM<bool, {rank}> tens;\n"
    src += f"layout(set=0, binding = 1) uniform tensorARM<bool, {rank}> tens_out;\n"
    src += "void main()\n{\n" + coords_code(rank)
    src += "\tbool tens_val;\n"
    src += f"\ttensorReadARM(tens, uint[]({coord_list(rank)}), tens_val);\n"
    expr = {"not": "!tens_val", "and": f"tens_val && {value}", "or": f"tens_val || {value}", "xor": f"tens_val ^^ {value}"}[op]
    src += f"\tbool res = {expr};\n"
    src += f"\ttensorWriteARM(tens_out, uint[]({coord_list(rank)}), res);\n}}\n"
    return src


REGULAR_FORMATS = [f for f in FORMATS if f[0] not in ("R8_BOOL", "R8_SFLOAT_FPENCODING_FLOAT8E5M2", "R8_SFLOAT_FPENCODING_FLOAT8E4M3", "R16_SFLOAT_FPENCODING_BFLOAT16")]

# The access array sizes of the cases, and the sizes the `max` cases pick from at run time (the largest one the device allows)
ARRAY_SIZES = [2, 3, 4]
ARRAY_MAX_SIZES = [1, 5, 6, 7, 8, 12, 16, 24, 32, 48, 64]


def gen_array_access(rank, variant, glsl_type, array_size):
    last = rank - 1
    src = "#version 450\n#extension GL_ARM_tensors : require\n#extension GL_EXT_shader_explicit_arithmetic_types : require\n"
    src += "layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n"
    src += f"layout(set=0, binding = 0) uniform tensorARM<{glsl_type}, {rank}> tens;\n"
    src += f"layout(set=0, binding = 1, std430) buffer _buff {{ {glsl_type} data[]; }};\n"
    src += "void main()\n{\n"
    for i in range(rank):
        src += f"\tconst uint size_d{i} = tensorSizeARM(tens, {i});\n"
    src += f"\tconst uint offset_x = {array_size} * gl_GlobalInvocationID.x;\n"
    src += "\tconst uint offset_y = gl_GlobalInvocationID.y;\n"
    for i in range(rank - 1):
        src += f"\tconst uint coord_{i} = offset_y / (1" + "".join(f" * size_d{j}" for j in range(i + 1, rank - 1)) + f") % size_d{i};\n"
    src += f"\tconst uint coord_{last} = offset_x;\n"
    src += f"\tconst uint buffer_index = size_d{last} * gl_GlobalInvocationID.y + {array_size} * gl_GlobalInvocationID.x;\n"
    src += f"\t{glsl_type} tmp[{array_size}];\n"
    loop = f"\tfor (int i = 0; (i < {array_size}) && (coord_{last} + i < size_d{last}); ++i)\n\t{{\n"
    if variant == "read":
        src += f"\ttensorReadARM(tens, uint[]({coord_list(rank)}), tmp);\n"
        src += loop + "\t\tdata[buffer_index + i] = tmp[i];\t}\n"
    else:
        src += loop + "\t\ttmp[i] = data[buffer_index + i];\n\t}\n"
        src += f"\ttensorWriteARM(tens, uint[]({coord_list(rank)}), tmp);\n"
    return src + "}\n"


BASIC_ACCESS_FORMATS = [f for f in FORMATS if f[0] != "R8_BOOL"]
# The rank of a `max_rank` case is the device's maximum dimension count, which a precompiled shader cannot know: ranks up to this are compiled
BASIC_ACCESS_MAX_RANK = 8


def gen_tensor_access(rank, short, glsl_type, variant):
    """variant: "read" (WRITE_TO_BUFFER, the shader reads the tensor) or "write" (READ_FROM_BUFFER)"""
    is_float = short in ("R32_SFLOAT", "R16_SFLOAT", "R16_SFLOAT_FPENCODING_BFLOAT16", "R8_SFLOAT_FPENCODING_FLOAT8E5M2", "R8_SFLOAT_FPENCODING_FLOAT8E4M3")
    src = "#version 450\n#extension GL_ARM_tensors : require\n#extension GL_EXT_shader_explicit_arithmetic_types : require\n"
    src += format_extensions(short)
    src += "layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;\n"
    src += f"layout(set=0, binding = 0) uniform tensorARM<{glsl_type}, {rank}> tens;\n"
    src += f"layout(set=0, binding = 1, std430) buffer _buff {{ {glsl_type} data[]; }};\n"
    src += "void main()\n{\n" + coords_code(rank)
    src += "\tconst uint index = gl_GlobalInvocationID.x;\n"
    coords = coord_list(rank)
    if is_float:
        src += f"\t{glsl_type} value;\n"
        if variant == "read":
            src += f"\ttensorReadARM(tens, uint[]({coords}), value);\n"
            src += f"\tdata[index] = {glsl_type}(float(value));\n"
        else:
            src += "\tfloat floatValue = float(data[index]);\n"
            src += f"\tvalue = {glsl_type}(floatValue);\n"
            src += f"\ttensorWriteARM(tens, uint[]({coords}), value);\n"
    elif variant == "read":
        src += f"\ttensorReadARM(tens, uint[]({coords}), data[index]);\n"
    else:
        src += f"\ttensorWriteARM(tens, uint[]({coords}), data[index]);\n"
    return src + "}\n"


OOB_LINE_ACCESSES = [(-1, 24), (0, 42), (13, 0), (65537, 84)]


def gen_oob_access(rank, short, glsl_type, variant):
    src = "#version 450\n#extension GL_ARM_tensors : require\n#extension GL_EXT_shader_explicit_arithmetic_types : require\n"
    src += format_extensions(short)
    src += "layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;\n"
    src += f"layout(set=0, binding = 0) uniform tensorARM<{glsl_type}, {rank}> tens;\n"
    src += f"layout(set=0, binding = 1, std430) buffer _buff {{ {glsl_type} data[]; }};\n"
    src += "void main()\n{\n"
    for i in range(rank):
        plus = " + 1" if i < rank - 1 else ""
        src += f"\tconst uint size_d{i} = tensorSizeARM(tens, {i}){plus};\n"
    src += "\tconst uint line = gl_GlobalInvocationID.x;\n"
    src += "\tconst uint line_count = 1" + "".join(f" * size_d{i}" for i in range(rank - 1)) + ";\n"
    src += "\tif (line >= line_count) return;\n"
    for i in range(rank - 1):
        src += f"\tconst uint coord_{i} = line / (1" + "".join(f" * size_d{j}" for j in range(i + 1, rank - 1)) + f") % size_d{i};\n"
    src += "\tconst uint buffer_base_index = gl_GlobalInvocationID.x * 4;\n"
    for index, (offset, oob_value) in enumerate(OOB_LINE_ACCESSES):
        call = "tensorReadARM" if variant == "read" else "tensorWriteARM"
        coords = "".join(f"coord_{i}, " for i in range(rank - 1))
        src += f"\t{call}(tens, uint[]({coords}size_d{rank - 1} + {offset}), data[buffer_base_index + {index}]"
        if oob_value != 0 and variant == "read":
            src += f", gl_TensorOperandsOutOfBoundsValueARM, {glsl_type}({oob_value})\n"
        src += ");\n"
    return src + "}\n"


# image format short name -> (tensor format short name, components, image format qualifier, image type prefix)
IMAGE_ALIASING_FORMATS = {
    "R8_SINT": ("R8_SINT", 1, "r8i", "i"),
    "R8_UINT": ("R8_UINT", 1, "r8ui", "u"),
    "R8G8_SINT": ("R8_SINT", 2, "rg8i", "i"),
    "R8G8_UINT": ("R8_UINT", 2, "rg8ui", "u"),
    "R8G8B8A8_SINT": ("R8_SINT", 4, "rgba8i", "i"),
    "R8G8B8A8_UINT": ("R8_UINT", 4, "rgba8ui", "u"),
    "R16_SINT": ("R16_SINT", 1, "r16i", "i"),
    "R16_UINT": ("R16_UINT", 1, "r16ui", "u"),
    "R16G16_SINT": ("R16_SINT", 2, "rg16i", "i"),
    "R16G16_UINT": ("R16_UINT", 2, "rg16ui", "u"),
    "R16G16B16A16_SINT": ("R16_SINT", 4, "rgba16i", "i"),
    "R16G16B16A16_UINT": ("R16_UINT", 4, "rgba16ui", "u"),
    "R32_SINT": ("R32_SINT", 1, "r32i", "i"),
    "R32_UINT": ("R32_UINT", 1, "r32ui", "u"),
    "R32G32_SINT": ("R32_SINT", 2, "rg32i", "i"),
    "R32G32_UINT": ("R32_UINT", 2, "rg32ui", "u"),
    "R32G32B32A32_SINT": ("R32_SINT", 4, "rgba32i", "i"),
    "R32G32B32A32_UINT": ("R32_UINT", 4, "rgba32ui", "u"),
    "R64_SINT": ("R64_SINT", 1, "r64i", "i64"),
    "R64_UINT": ("R64_UINT", 1, "r64ui", "u64"),
}
IMAGE_ALIASING_VARIANTS = ["image_to_tensor", "tensor_to_image", "tensor_to_sampled_image"]


def gen_image_access_head(image_rank, image_format, variant):
    tensor_short, components, qualifier, prefix = IMAGE_ALIASING_FORMATS[image_format]
    glsl_type = dict(FORMATS)[tensor_short]
    sampled = variant == "tensor_to_sampled_image"
    image_type = f"{prefix}image{image_rank}D"
    image_coord_type = "int" if image_rank == 1 else f"ivec{image_rank}"
    sampled_coord_type = "float" if image_rank == 1 else f"vec{image_rank}"
    src = "#version 450\n#extension GL_EXT_shader_explicit_arithmetic_types : require\n"
    if prefix in ("i64", "u64"):
        src += "#extension GL_EXT_shader_image_int64 : require\n"
    src += "layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;\n"
    src += f"layout(set = 0, binding = 2, {qualifier}) uniform {image_type} image;\n"
    src += f"layout(set = 0, binding = 3, std430) buffer _buff {{ {glsl_type} data[]; }};\n"
    if sampled:
        src += f"layout(set = 0, binding = 4) uniform {prefix}sampler{image_rank}D samplr;\n"
    src += "void main()\n{\n"
    src += f"\tconst uint buffer_idx = gl_GlobalInvocationID.x * {components};\n"
    src += f"\tconst {image_coord_type} image_dims = imageSize(image);\n"
    if image_rank > 1:
        src += "\tconst uint texel_count = " + " * ".join(f"image_dims[{i}]" for i in range(image_rank)) + ";\n"
        src += "\tif (gl_GlobalInvocationID.x >= texel_count) return;\n"
        for i in range(image_rank):
            src += f"\tconst uint image_coord_{i} = gl_GlobalInvocationID.x / (1" + "".join(f" * image_dims[{j}]" for j in range(i)) + f") % image_dims[{i}];\n"
        if sampled:
            for i in range(image_rank):
                src += f"\tconst float sampled_coord_{i} = (float(image_coord_{i}) + 0.5) / float(image_dims[{i}]);\n"
    else:
        src += "\tif (gl_GlobalInvocationID.x >= image_dims) return;\n"
        src += "\tconst uint image_coord_0 = gl_GlobalInvocationID.x % image_dims;\n"
        if sampled:
            src += "\tconst float sampled_coord_0 = (float(image_coord_0) + 0.5) / float(image_dims);\n"
    return src


def gen_image_access(image_rank, image_format, variant):
    tensor_short, components, qualifier, prefix = IMAGE_ALIASING_FORMATS[image_format]
    glsl_type = dict(FORMATS)[tensor_short]
    src = gen_image_access_head(image_rank, image_format, variant)
    sampled = variant == "tensor_to_sampled_image"
    image_coord_type = "int" if image_rank == 1 else f"ivec{image_rank}"
    sampled_coord_type = "float" if image_rank == 1 else f"vec{image_rank}"
    if not sampled:
        src += f"\tconst {image_coord_type} image_coord = {image_coord_type}(" + ", ".join(f"image_coord_{i}" for i in range(image_rank)) + ");\n"
        if variant == "tensor_to_image":
            # TENSOR_PRODUCER_IMAGE_CONSUMER: the image is read into the buffer
            src += f"\tconst {prefix}vec4 pixel_data = imageLoad(image, image_coord);\n"
            for i in range(components):
                src += f"\tdata[buffer_idx+{i}] = {glsl_type}(pixel_data[{i}]);\n"
        else:
            # IMAGE_PRODUCER_TENSOR_CONSUMER: the buffer is written into the image
            src += f"\tconst {prefix}vec4 pixel_data = {prefix}vec4(data[buffer_idx + 0], data[buffer_idx + 1], data[buffer_idx + 2], data[buffer_idx + 3]);\n"
            src += "\timageStore(image, image_coord, pixel_data);\n"
    else:
        src += f"\tconst {sampled_coord_type} sampled_coord = {sampled_coord_type}(" + ", ".join(f"sampled_coord_{i}" for i in range(image_rank)) + ");\n"
        src += f"\tconst {prefix}vec4 pixel_data = texture(samplr, sampled_coord);\n"
        for i in range(components):
            src += f"\tdata[buffer_idx+{i}] = {glsl_type}(pixel_data[{i}]);\n"
    return src + "}\n"


DESCRIPTORS_ARRAY_COUNTS = [8, 6]


def gen_descriptors_array_access(rank, glsl_type, descriptor_count):
    src = "#version 450\n#extension GL_ARM_tensors : require\n#extension GL_EXT_shader_explicit_arithmetic_types : require\n#extension GL_EXT_scalar_block_layout : require\n"
    src += "layout(local_size_x = 128, local_size_y = 1, local_size_z = 1) in;\n"
    src += f"layout(set=0, binding=0) uniform tensorARM<{glsl_type}, {rank}> tens[{descriptor_count}];\n"
    src += f"layout(set=0, binding=1, std430) uniform desc_idx_buff {{ uint desc_arr[{descriptor_count}]; }};\n"
    src += f"layout(set=0, binding=2, std430) buffer buff {{ {glsl_type} data[]; }};\n"
    src += "void main()\n{\n"
    src += "\tconst uint element_idx = gl_GlobalInvocationID.x;\n\tconst uint tens_idx = gl_GlobalInvocationID.y;\n\tconst uint desc_idx = desc_arr[tens_idx];\n\n"
    for i in range(rank):
        src += f"\tconst uint size_d{i} = tensorSizeARM(tens[desc_idx], {i});\n"
    src += "\tconst uint tens_element_count = " + " * ".join(f"size_d{i}" for i in range(rank)) + ";\n\n"
    src += "\tif (gl_GlobalInvocationID.x >= tens_element_count) return;\n\n"
    for j in range(rank):
        src += f"\tconst uint coord_{j} = element_idx / (1" + "".join(f" * size_d{k}" for k in range(j + 1, rank)) + f") % size_d{j};\n"
    src += "\n\tconst uint out_idx = tens_idx * tens_element_count + element_idx;\n"
    src += f"\ttensorReadARM(tens[desc_idx], uint[]({coord_list(rank)}), data[out_idx]);\n"
    return src + "}\n"


GRAPHICS_PIPELINE_VERTEX = """#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(set=0, binding=1) uniform readonly tensorARM<int32_t, 2> tensor;

layout (constant_id = 0) const uint32_t imageShapeWidth  = 0;
layout (constant_id = 1) const uint32_t imageShapeHeight = 0;

vec2 imageShape = vec2(float(imageShapeWidth), float(imageShapeHeight));
vec2 imageShapeHalvedInv = 2.0 / imageShape;

void main() {
    int32_t pos_x, pos_y;
    tensorReadARM(tensor, uint[](gl_VertexIndex, 0), pos_x);
    tensorReadARM(tensor, uint[](gl_VertexIndex, 1), pos_y);
    const vec2 position = vec2(pos_x, pos_y);
    const vec2 clip_space_pos = position * imageShapeHalvedInv - 1.0;
    gl_Position = vec4(clip_space_pos, 0.0, 1.0);
}
"""

GRAPHICS_PIPELINE_FRAGMENT = """#version 450
#extension GL_ARM_tensors : require
#extension GL_EXT_shader_explicit_arithmetic_types : require

layout(location = 0) out vec4 outColor;

layout(set=0, binding=0) uniform readonly tensorARM<uint8_t, 3> tensor;

void main() {
    const uint coord_x = uint(gl_FragCoord.x);
    const uint coord_y = uint(gl_FragCoord.y);

    uint8_t tensorValue = uint8_t(0);
    tensorReadARM(tensor, uint[](coord_y, coord_x, 0), tensorValue);
    outColor = vec4(0.0, tensorValue, 0.0, 255.0);
}
"""


class Manifest:
    def __init__(self, stem, comment, upstream_file, rust_module):
        self.stem = stem
        self.lines = [
            f"# Shader manifest for {comment}",
            "#",
            "# @generated by hodow_cts/scripts/gen_tensor_manifests.py - do not hand-edit.",
            "",
            f'upstream_source = "{UPSTREAM}{upstream_file}"',
            f'rust_module = "{rust_module}"',
            "",
        ]

    def add(self, name, files):
        """files: [(program name, extension, source)]"""
        programs = []
        for program_name, ext, source in files:
            (SRC / self.stem).mkdir(parents=True, exist_ok=True)
            file_stem = name if len(files) == 1 else f"{name}_{program_name}"
            (SRC / self.stem / f"{file_stem}.{ext}").write_text(source)
            programs.append(f'{{ name = "{program_name}", template = "tensor/{self.stem}/{file_stem}.{ext}", stage = "{ext}" }}')
        self.lines += ["[[case]]", f'name = "{name}"', f'rust_const = "{name.upper()}"', 'rust_type = "SharedProgram"', f"programs = [{', '.join(programs)}]", ""]

    def write(self):
        (MANIFESTS / f"{self.stem}.toml").write_text("\n".join(self.lines))


def main():
    manifest = Manifest("tensor_dimension_query", "dEQP-VK.tensor.dimension_query.*", "vktTensorDimensionQuery.cpp", "tensor/dimension_query_tests")
    for rank in range(1, 7):
        for short, glsl_type in FORMATS:
            manifest.add(f"q{rank}_{short}", [("comp", "comp", gen_query_dimensions(rank, short, glsl_type))])
    manifest.write()

    manifest = Manifest("tensor_boolean", "dEQP-VK.tensor.boolean.*", "vktTensorBool.cpp", "tensor/boolean_tests")
    for rank in (1, 2, 3, 4, 6):
        for op in BOOLEAN_OPS:
            for test_value in (False, True):
                manifest.add(f"b{rank}_{op}_{int(test_value)}", [("comp", "comp", gen_boolean_op(rank, op, test_value))])
    manifest.write()

    manifest = Manifest("tensor_array_access", "dEQP-VK.tensor.array_access.*", "vktTensorArrayAccess.cpp", "tensor/array_access_tests")
    for short, glsl_type in REGULAR_FORMATS:
        for variant in ("read", "write"):
            files = [(f"comp{size}", "comp", gen_array_access(4, variant, glsl_type, size)) for size in sorted(ARRAY_SIZES + ARRAY_MAX_SIZES)]
            manifest.add(f"ar_{short}_{variant}", files)
    manifest.write()

    manifest = Manifest("tensor_basic_access", "dEQP-VK.tensor.basic_access.*", "vktTensorBasicShaderAccess.cpp", "tensor/basic_access_tests")
    for short, glsl_type in BASIC_ACCESS_FORMATS:
        files = []
        for rank in range(1, BASIC_ACCESS_MAX_RANK + 1):
            for variant in ("read", "write"):
                files.append((f"r{rank}_{variant}", "comp", gen_tensor_access(rank, short, glsl_type, variant)))
        manifest.add(f"ba_{short}", files)
    manifest.write()

    manifest = Manifest("tensor_robustness", "dEQP-VK.tensor.robustness.*", "vktTensorRobustness.cpp", "tensor/robustness_tests")
    for short, glsl_type in BASIC_ACCESS_FORMATS:
        files = []
        for rank in (1, 2, 3, 4, 6):
            for variant in ("read", "write"):
                files.append((f"r{rank}_{variant}", "comp", gen_oob_access(rank, short, glsl_type, variant)))
        manifest.add(f"rb_{short}", files)
    manifest.write()

    manifest = Manifest("tensor_image_aliasing", "dEQP-VK.tensor.image_aliasing.*", "vktTensorImageAliasing.cpp", "tensor/image_aliasing_tests")
    for image_format, (tensor_short, _components, _qualifier, _prefix) in IMAGE_ALIASING_FORMATS.items():
        glsl_type = dict(FORMATS)[tensor_short]
        files = []
        for image_rank in (1, 2, 3):
            for variant in IMAGE_ALIASING_VARIANTS:
                if variant == "tensor_to_sampled_image" and _prefix in ("i64", "u64"):
                    continue
                files.append((f"image_r{image_rank}_{variant}", "comp", gen_image_access(image_rank, image_format, variant)))
            for tensor_variant in ("read", "write"):
                files.append((f"tensor_r{image_rank + 1}_{tensor_variant}", "comp", gen_tensor_access(image_rank + 1, tensor_short, glsl_type, tensor_variant)))
        manifest.add(f"ia_{image_format}", files)
    manifest.write()

    manifest = Manifest("tensor_descriptors_array", "dEQP-VK.tensor.descriptors_array_update.*", "vktTensorDescriptorsArray.cpp", "tensor/descriptors_array_tests")
    for short, glsl_type in FORMATS:
        if not short.startswith(("R8_", "R16_", "R32_", "R64_")) or "SFLOAT" in short or "BOOL" in short:
            continue
        files = [(f"comp{count}", "comp", gen_descriptors_array_access(4, glsl_type, count)) for count in DESCRIPTORS_ARRAY_COUNTS]
        manifest.add(f"da_{short}", files)
    manifest.write()

    manifest = Manifest("tensor_graphics_pipeline", "dEQP-VK.tensor.graphics_pipeline.*", "vktTensorGraphicsPipeline.cpp", "tensor/graphics_pipeline_tests")
    manifest.add("graphics_pipeline", [("vertex", "vert", GRAPHICS_PIPELINE_VERTEX), ("fragment", "frag", GRAPHICS_PIPELINE_FRAGMENT)])
    manifest.write()


main()
