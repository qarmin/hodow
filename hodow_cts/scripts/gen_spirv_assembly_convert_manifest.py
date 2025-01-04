#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_convert.toml: the compute cases of dEQP-VK.spirv_assembly.instruction.compute.{sconvert,uconvert,
fconvert,convertstof,convertftos,convertutof,convertftou}.

`createConvertComputeTests` of vktSpvAsmInstructionTests.cpp turns every `ConvertCase` into one assembly shader (`getConvertCaseShaderStr`) with a
one-element input and output buffer. The case tables are read out of upstream's `createConvertCases` itself (`--cts-dir`), so they cannot drift, and
the assembly, the buffers and the Vulkan features are written the way `ConvertCase` and `getVulkanFeaturesAndExtensions` derive them. The cases are
`AmberCase` entries of src/vkt/tests/spirv_assembly/amber_tests.rs (a buffer list, an expectation and the feature tokens), so they run on the same
compute case as the Amber scripts.

    python3 hodow_cts/scripts/gen_spirv_assembly_convert_manifest.py [--cts-dir ../tmp/VK-GL-CTS]

A pure text generator: no spirv-as and no cargo.
"""

import argparse
import json
import re
import sys
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_convert.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmInstructionTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"

GROUPS = [
    ("OpSConvert", "sconvert"),
    ("OpUConvert", "uconvert"),
    ("OpFConvert", "fconvert"),
    ("OpConvertSToF", "convertstof"),
    ("OpConvertFToS", "convertftos"),
    ("OpConvertUToF", "convertutof"),
    ("OpConvertFToU", "convertftou"),
]

# ConversionDataType -> (bit width string, byte width, kind)
TYPES = {
    "DATA_TYPE_SIGNED_8": ("8", 1, "sint"),
    "DATA_TYPE_SIGNED_16": ("16", 2, "sint"),
    "DATA_TYPE_SIGNED_32": ("32", 4, "sint"),
    "DATA_TYPE_SIGNED_64": ("64", 8, "sint"),
    "DATA_TYPE_UNSIGNED_8": ("8", 1, "uint"),
    "DATA_TYPE_UNSIGNED_16": ("16", 2, "uint"),
    "DATA_TYPE_UNSIGNED_32": ("32", 4, "uint"),
    "DATA_TYPE_UNSIGNED_64": ("64", 8, "uint"),
    "DATA_TYPE_FLOAT_16": ("16", 2, "float"),
    "DATA_TYPE_FLOAT_32": ("32", 4, "float"),
    "DATA_TYPE_FLOAT_64": ("64", 8, "float"),
    "DATA_TYPE_VEC2_SIGNED_16": ("32", 4, "vec2_16"),
    "DATA_TYPE_VEC2_SIGNED_32": ("64", 8, "vec2_32"),
}


def bit_width(type_):
    return TYPES[type_][0]


def is_int(type_):
    return TYPES[type_][2] in ("sint", "uint")


def is_float(type_):
    return TYPES[type_][2] == "float"


def is_signed(type_):
    return TYPES[type_][2] != "uint"


def uses_int8(a, b):
    return any(t in ("DATA_TYPE_SIGNED_8", "DATA_TYPE_UNSIGNED_8") for t in (a, b))


def uses_int16(a, b):
    return any(t in ("DATA_TYPE_SIGNED_16", "DATA_TYPE_UNSIGNED_16", "DATA_TYPE_VEC2_SIGNED_16") for t in (a, b))


def uses_int32(a, b):
    return any(t in ("DATA_TYPE_SIGNED_32", "DATA_TYPE_UNSIGNED_32", "DATA_TYPE_VEC2_SIGNED_32") for t in (a, b))


def uses_int64(a, b):
    return any(t in ("DATA_TYPE_SIGNED_64", "DATA_TYPE_UNSIGNED_64") for t in (a, b))


def uses_float16(a, b):
    return "DATA_TYPE_FLOAT_16" in (a, b)


def uses_float32(a, b):
    return "DATA_TYPE_FLOAT_32" in (a, b)


def uses_float64(a, b):
    return "DATA_TYPE_FLOAT_64" in (a, b)


def type_name(type_):
    prefix = "" if is_signed(type_) else "u"
    if is_int(type_):
        return f"{prefix}int{bit_width(type_)}"
    if is_float(type_):
        return f"{prefix}float{bit_width(type_)}"
    return "i16vec2" if type_ == "DATA_TYPE_VEC2_SIGNED_16" else "i32vec2"


def asm_type_name(type_, elements=1):
    if is_int(type_):
        prefix = "i" if is_signed(type_) else "u"
    elif is_float(type_):
        prefix = "f"
    else:
        return "i16vec2" if type_ == "DATA_TYPE_VEC2_SIGNED_16" else "v2i32"
    if elements == 2:
        prefix = "v2" + prefix
    return prefix + bit_width(type_)


def buffer_bytes(type_, number, elements):
    size = TYPES[type_][1]
    value = number & ((1 << (8 * size)) - 1)
    return value.to_bytes(size, "little") * elements


class ConvertCase:
    def __init__(self, instruction, from_, to, number, separate_output=False, output_number=0, suffix=None, use_storage_ext=True):
        self.from_ = from_
        self.to = to
        self.elements = 1
        self.use_storage_ext = use_storage_ext
        suffix_text = "" if suffix is None else "_" + suffix
        self.name = f"{type_name(from_)}_to_{type_name(to)}{suffix_text}"
        types = {"inStorageType": asm_type_name(from_), "outStorageType": asm_type_name(to), "inCast": "OpCopyObject", "outCast": "OpCopyObject"}

        if not use_storage_ext:
            in_change = out_change = False
            if uses_float16(from_, from_) or uses_int16(from_, from_):
                types["inStorageType"] = "u32"
                types["inCast"] = "OpBitcast"
                self.elements = 2
                in_change = True
            if uses_float16(to, to) or uses_int16(to, to):
                types["outStorageType"] = "u32"
                types["outCast"] = "OpBitcast"
                self.elements = 2
                out_change = True
            if in_change and not out_change:
                types["outStorageType"] = asm_type_name(to, self.elements)
            if not in_change and out_change:
                types["inStorageType"] = asm_type_name(from_, self.elements)

        types["inputType"] = asm_type_name(from_, self.elements)
        types["outputType"] = asm_type_name(to, self.elements)
        self.input = buffer_bytes(from_, number, self.elements)
        self.output = buffer_bytes(to, output_number if separate_output else number, self.elements)

        caps, decl, exts = "", "", ""
        if uses_int8(from_, to):
            requires_int8 = True
            if instruction in ("OpUConvert", "OpSConvert") and uses_int32(from_, to):
                requires_int8 = False
            caps += "OpCapability StorageBuffer8BitAccess\n"
            if requires_int8:
                caps += "OpCapability Int8\n"
            decl += "%i8         = OpTypeInt 8 1\n%u8         = OpTypeInt 8 0\n"
            if self.elements == 2:
                decl += "%v2i8       = OpTypeVector %i8 2\n%v2u8       = OpTypeVector %u8 2\n"
            exts += 'OpExtension "SPV_KHR_8bit_storage"\n'

        if uses_int16(from_, to):
            requires_int16 = True
            if instruction in ("OpUConvert", "OpSConvert", "OpFConvert") and (uses_int32(from_, to) or uses_float32(from_, to)):
                requires_int16 = False
            decl += "%i16        = OpTypeInt 16 1\n%u16        = OpTypeInt 16 0\n"
            if self.elements == 2:
                decl += "%v2i16      = OpTypeVector %i16 2\n%v2u16      = OpTypeVector %u16 2\n"
            else:
                decl += "%i16vec2    = OpTypeVector %i16 2\n"
            if requires_int16 or not use_storage_ext:
                caps += "OpCapability Int16\n"

        if uses_float16(from_, to):
            decl += "%f16        = OpTypeFloat 16\n"
            if self.elements == 2:
                decl += "%v2f16      = OpTypeVector %f16 2\n"
            if not uses_float32(from_, to) or not use_storage_ext:
                caps += "OpCapability Float16\n"

        if (uses_int16(from_, to) or uses_float16(from_, to)) and use_storage_ext:
            caps += "OpCapability StorageUniformBufferBlock16\n"
            exts += 'OpExtension "SPV_KHR_16bit_storage"\n'

        if uses_int64(from_, to):
            caps += "OpCapability Int64\n"
            decl += "%i64        = OpTypeInt 64 1\n%u64        = OpTypeInt 64 0\n"
            if self.elements == 2:
                decl += "%v2i64      = OpTypeVector %i64 2\n%v2u64      = OpTypeVector %u64 2\n"

        if uses_float64(from_, to):
            caps += "OpCapability Float64\n"
            decl += "%f64        = OpTypeFloat 64\n"
            if self.elements == 2:
                decl += "%v2f64        = OpTypeVector %f64 2\n"

        types["datatype_capabilities"] = caps
        types["datatype_additional_decl"] = decl
        types["datatype_extensions"] = exts
        types["instruction"] = instruction
        self.asm_types = types

    def shader(self):
        text = (
            "OpCapability Shader\n"
            "${datatype_capabilities}"
            "${datatype_extensions}"
            "OpMemoryModel Logical GLSL450\n"
            'OpEntryPoint GLCompute %main "main"\n'
            "OpExecutionMode %main LocalSize 1 1 1\n"
            "OpSource GLSL 430\n"
            'OpName %main           "main"\n'
            "OpDecorate %indata DescriptorSet 0\n"
            "OpDecorate %indata Binding 0\n"
            "OpDecorate %outdata DescriptorSet 0\n"
            "OpDecorate %outdata Binding 1\n"
            "OpDecorate %in_buf BufferBlock\n"
            "OpDecorate %out_buf BufferBlock\n"
            "OpMemberDecorate %in_buf 0 Offset 0\n"
            "OpMemberDecorate %out_buf 0 Offset 0\n"
            "%void       = OpTypeVoid\n"
            "%voidf      = OpTypeFunction %void\n"
            "%u32        = OpTypeInt 32 0\n"
            "%i32        = OpTypeInt 32 1\n"
            "%f32        = OpTypeFloat 32\n"
            "%v2i32      = OpTypeVector %i32 2\n"
            "${datatype_additional_decl}"
            "%v2u32 = OpTypeVector %u32 2\n"
            "%v2f32 = OpTypeVector %f32 2\n"
            "%uvec3      = OpTypeVector %u32 3\n"
            "%in_ptr     = OpTypePointer Uniform %${inStorageType}\n"
            "%out_ptr    = OpTypePointer Uniform %${outStorageType}\n"
            "%in_buf     = OpTypeStruct %${inStorageType}\n"
            "%out_buf    = OpTypeStruct %${outStorageType}\n"
            "%in_bufptr  = OpTypePointer Uniform %in_buf\n"
            "%out_bufptr = OpTypePointer Uniform %out_buf\n"
            "%indata     = OpVariable %in_bufptr Uniform\n"
            "%outdata    = OpVariable %out_bufptr Uniform\n"
            "%zero       = OpConstant %i32 0\n"
            "%main       = OpFunction %void None %voidf\n"
            "%label      = OpLabel\n"
            "%inloc      = OpAccessChain %in_ptr %indata %zero\n"
            "%outloc     = OpAccessChain %out_ptr %outdata %zero\n"
            "%inval      = OpLoad %${inStorageType} %inloc\n"
            "%in_cast    = ${inCast} %${inputType} %inval\n"
            "%conv       = ${instruction} %${outputType} %in_cast\n"
            "%out_cast   = ${outCast} %${outStorageType} %conv\n"
            "              OpStore %outloc %out_cast\n"
            "              OpReturn\n"
            "              OpFunctionEnd\n"
        )
        return re.sub(r"\$\{(\w+)\}", lambda match: self.asm_types[match.group(1)], text)

    def features(self):
        """`getVulkanFeaturesAndExtensions`, as the feature tokens of an `AmberCase`."""
        tokens = []
        a, b = self.from_, self.to
        if uses_int16(a, b) and not uses_int32(a, b):
            tokens.append("Features.shaderInt16")
        if uses_int64(a, b):
            tokens.append("Features.shaderInt64")
        if uses_float64(a, b):
            tokens.append("shaderFloat64")
        if (uses_int16(a, b) or uses_float16(a, b)) and self.use_storage_ext:
            tokens += ["VK_KHR_16bit_storage", "Storage16BitFeatures.storageBuffer16BitAccess"]
        if uses_float16(a, b) or uses_int8(a, b):
            tokens.append("VK_KHR_shader_float16_int8")
            if uses_float16(a, b):
                tokens.append("Float16Int8Features.shaderFloat16")
            if uses_int8(a, b):
                tokens += ["Float16Int8Features.shaderInt8", "VK_KHR_8bit_storage", "Storage8BitFeatures.storageBuffer8BitAccess"]
        return tokens


def split_arguments(text):
    arguments, depth, current = [], 0, ""
    for char in text:
        if char == "(":
            depth += 1
        elif char == ")":
            depth -= 1
        if char == "," and depth == 0:
            arguments.append(current.strip())
            current = ""
        else:
            current += char
    arguments.append(current.strip())
    return arguments


def evaluate_number(text):
    text = re.sub(r"\b(0x[0-9a-fA-F]+|\d+)(?:ull|ll|u)\b", r"\1", text)
    return int(eval(text, {"__builtins__": {}}, {}))


def parse_cases(source, instruction):
    start = source.index("void createConvertCases")
    end = source.index("\n}\n", start)
    body = source[start:end]
    body = re.sub(r"/\*.*?\*/", "", body, flags=re.S)
    marker = body.index(f'instruction == "{instruction}"')
    following = re.search(r'else if \(instruction == "', body[marker + 1 :])
    block = body[marker : marker + 1 + following.start()] if following else body[marker:]

    cases = []
    for match in re.finditer(r"ConvertCase\(instruction,", block):
        depth, cursor = 0, match.start() + len("ConvertCase")
        while True:
            char = block[cursor]
            if char == "(":
                depth += 1
            elif char == ")":
                depth -= 1
                if depth == 0:
                    break
            cursor += 1
        arguments = split_arguments(block[match.start() + len("ConvertCase(") : cursor])
        _, from_, to, number, *rest = arguments
        separate = rest[0] == "true" if rest else False
        output_number = evaluate_number(rest[1]) if len(rest) > 1 else 0
        suffix = json.loads(rest[2]) if len(rest) > 2 and rest[2] != "nullptr" else None
        use_storage = rest[3] == "true" if len(rest) > 3 else True
        cases.append(ConvertCase(instruction, from_, to, evaluate_number(number), separate, output_number, suffix, use_storage))
    return cases


def toml_string(text):
    return json.dumps(text, ensure_ascii=False)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cts-dir", default=str(CRATE.parent / "tmp" / "VK-GL-CTS"))
    args = parser.parse_args()
    source = (Path(args.cts_dir) / SOURCE).read_text(encoding="utf-8")

    out = [
        "# Shader manifest for the compute convert groups of dEQP-VK.spirv_assembly.instruction.compute.*\n"
        "#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_convert_manifest.py - do not hand-edit; the case tables are read out of upstream.\n\n"
        f'upstream_source = "{SOURCE}"\n'
        'rust_module = "spirv_assembly/amber_tests"\n'
    ]
    written = 0
    for instruction, group in GROUPS:
        for case in parse_cases(source, instruction):
            name = f"{group}/{case.name}"
            const = "CONVERT_" + "".join(c if c.isalnum() else "_" for c in name).upper()
            filler = (b"\xff" * len(case.output)).hex()
            buffers = f"0:{case.input.hex()};1:{filler}"
            checks = f"1:{case.output.hex()}:{filler}"
            params = (
                'dispatch_x = { type = "u32", value = 1 }, dispatch_y = { type = "u32", value = 1 }, dispatch_z = { type = "u32", value = 1 }, '
                f'buffers = {{ type = "str", value = {toml_string(buffers)} }}, checks = {{ type = "str", value = {toml_string(checks)} }}, '
                'tolerance_width = { type = "u32", value = 0 }, push_constants = { type = "str", value = "" }, spec_constants = { type = "str", value = "" }, '
                f'features = {{ type = "str", value = {toml_string(",".join(case.features()))} }}'
            )
            out.append(
                f'\n[[case]]\nname = {toml_string(name)}\nrust_const = "{const}"\nrust_type = "AmberCase"\n'
                f'programs = [ {{ name = "compute", template = "{TEMPLATE}", stage = "asm" }} ]\n'
                f"params = {{ {params} }}\n"
                f"derived = {{ source = {json.dumps(repr(case.shader()), ensure_ascii=False)} }}\n"
            )
            written += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {written} cases", file=sys.stderr)


if __name__ == "__main__":
    main()
