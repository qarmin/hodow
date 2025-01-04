#!/usr/bin/env python3
"""Writes shaders/manifest/sparse_resources_texel_buffer.toml, its GLSL/assembly sources and the program lookup of the Rust port.

`TexelBufferSparseResidencyCase::initPrograms` (vktSparseResourcesBufferSparseResidency.cpp): a GLSL compute shader for the plain `read` operation and
SPIR-V assembly for OpImageSparseFetch / OpImageSparseRead, per (uniform or storage texel buffer, operation, 32 or 64 bit format).
"""
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
SRC = CRATE / "shaders" / "src" / "sparse_resources" / "texel_buffer"
MANIFEST = CRATE / "shaders" / "manifest" / "sparse_resources_texel_buffer.toml"
LOOKUP = CRATE / "src" / "vkt" / "tests" / "sparse_resources" / "texel_programs.rs"


def glsl(uniform: bool, is64: bool) -> str:
    op = "texelFetch" if uniform else "imageLoad"
    buffer_type = "utextureBuffer" if uniform else ("u64imageBuffer" if is64 else "uimageBuffer")
    fmt = "" if uniform else (", r64ui" if is64 else ", r32ui")
    out_type = "uint64_t" if is64 else "uint"
    text = "#version 450\n\n"
    if is64:
        text += "#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require\n#extension GL_EXT_shader_image_int64 : require\n"
    text += (
        f"layout(set = 0, binding = 0{fmt}) uniform {buffer_type} sparseTexelBuffer;\n"
        "layout(set = 0, binding = 1, std430) buffer OutputBuffer { \n"
        f"    {out_type} outputData[]; \n"
        "} outBuffer;\n"
        "layout(local_size_x = 1) in;\n"
        "void main (void)\n"
        "{\n"
        "    uint index = gl_WorkGroupID.x;\n"
        f"    {out_type} value = {op}(sparseTexelBuffer, int(index)).x; \n"
        "    outBuffer.outputData[index] = value; \n"
        "}\n"
    )
    return text


def asm(uniform: bool, op: str, is64: bool) -> str:
    buffer_type = "SampledBuffer" if uniform else "ImageBuffer"
    fmt = "Unknown" if uniform else ("R64ui" if is64 else "R32ui")
    spirv_op = "OpImageSparseFetch" if op == "sparse_fetch" else "OpImageSparseRead"
    sampled = "2" if op == "sparse_read" else "1"
    stride = "8" if is64 else "4"
    dt = "58" if is64 else "6"
    ptr_type = "59" if is64 else "7"
    t = "OpCapability Shader\n" f"OpCapability {buffer_type}\n" "OpCapability SparseResidency\n"
    if is64:
        t += 'OpCapability Int64\nOpCapability Int64ImageEXT\nOpExtension "SPV_EXT_shader_image_int64"\n'
    t += (
        '%1 = OpExtInstImport "GLSL.std.450"\n'
        "OpMemoryModel Logical GLSL450\n"
        'OpEntryPoint GLCompute %4 "main" %11\n'
        "OpExecutionMode %4 LocalSize 1 1 1\n"
        "OpDecorate %11 BuiltIn WorkgroupId\n"
        "OpDecorate %19 Binding 0\n"
        "OpDecorate %19 DescriptorSet 0\n"
        f"OpDecorate %27 ArrayStride {stride}\n"
        "OpDecorate %28 BufferBlock\n"
        "OpMemberDecorate %28 0 Offset 0\n"
        "OpDecorate %30 Binding 1\n"
        "OpDecorate %30 DescriptorSet 0\n"
        "OpDecorate %37 BuiltIn WorkgroupSize\n"
        "%2 = OpTypeVoid\n"
        "%3 = OpTypeFunction %2\n"
        "%6 = OpTypeInt 32 0\n"
    )
    if is64:
        t += "%58 = OpTypeInt 64 0\n"
    t += f"%52 = OpTypeBool\n%56 = OpConstant %{dt} 1\n%57 = OpConstant %{dt} 0\n%7 = OpTypePointer Function %6\n"
    if is64:
        t += "%59 = OpTypePointer Function %58\n"
    t += (
        "%53 = OpTypePointer Function %52\n"
        "%9 = OpTypeVector %6 3\n"
        "%10 = OpTypePointer Input %9\n"
        "%11 = OpVariable %10 Input\n"
        "%12 = OpConstant %6 0\n"
        "%13 = OpTypePointer Input %6\n"
        f"%17 = OpTypeImage %{dt} Buffer 0 0 0 {sampled} {fmt}\n"
        "%18 = OpTypePointer UniformConstant %17\n"
        "%19 = OpVariable %18 UniformConstant\n"
        "%22 = OpTypeInt 32 1\n"
        f"%24 = OpTypeVector %{dt} 4\n"
        "%50 = OpTypeStruct %6 %24\n"
        f"%27 = OpTypeRuntimeArray %{dt}\n"
        "%28 = OpTypeStruct %27\n"
        "%29 = OpTypePointer Uniform %28\n"
        "%30 = OpVariable %29 Uniform\n"
        "%31 = OpConstant %22 0\n"
        f"%34 = OpTypePointer Uniform %{dt}\n"
        "%36 = OpConstant %6 1\n"
        "%37 = OpConstantComposite %9 %36 %36 %36\n"
        "%4 = OpFunction %2 None %3\n"
        "%5 = OpLabel\n"
        "%8 = OpVariable %7 Function\n"
        f"%16 = OpVariable %{ptr_type} Function\n"
        "%14 = OpAccessChain %13 %11 %12\n"
        "%15 = OpLoad %6 %14\n"
        "OpStore %8 %15\n"
        "%20 = OpLoad %17 %19\n"
        "%21 = OpLoad %6 %8\n"
        "%23 = OpBitcast %22 %21\n"
        f"%25 = {spirv_op} %50 %20 %23\n"
        "%26 = OpCompositeExtract %6 %25 0\n"
        "%51 = OpImageSparseTexelsResident %52 %26\n"
        f"%55 = OpSelect %{dt} %51 %56 %57\n"
        "OpStore %16 %55\n"
        "%32 = OpLoad %6 %8\n"
        f"%33 = OpLoad %{dt} %16\n"
        "%35 = OpAccessChain %34 %30 %31 %32\n"
        "OpStore %35 %33\n"
        "OpReturn\n"
        "OpFunctionEnd\n"
    )
    return t


def keys():
    for uniform in (True, False):
        for op in ("sparse_fetch", "sparse_read", "read"):
            if (uniform and op == "sparse_read") or (not uniform and op == "sparse_fetch"):
                continue
            for is64 in (False, True):
                if uniform and is64:
                    continue
                yield uniform, op, is64


def key_name(uniform: bool, op: str, is64: bool) -> str:
    return f"{'uniform' if uniform else 'storage'}_{op}_{'r64' if is64 else 'r32'}"


def main() -> None:
    SRC.mkdir(parents=True, exist_ok=True)
    out = [
        "# Shader manifest for dEQP-VK.sparse_resources.buffer.texel_buffers.sparse_residency.*",
        "#",
        "# @generated by hodow_cts/scripts/gen_sparse_texel_buffer_manifest.py - do not hand-edit.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBufferSparseResidency.cpp"',
        'rust_module = "sparse_resources/buffer_texel_tests"',
        "",
    ]
    table = []
    for uniform, op, is64 in keys():
        name = key_name(uniform, op, is64)
        if op == "read":
            file, stage = f"{name}.comp", "comp"
            (SRC / file).write_text(glsl(uniform, is64))
            spirv = ', spirv_version = "spirv1.3"' if is64 else ', spirv_version = "spirv1.0"'
        else:
            file, stage = f"{name}.spvasm", "asm"
            (SRC / file).write_text(asm(uniform, op, is64))
            spirv = ', spirv_version = "spirv1.0"'
        const = "TEXEL_" + name.upper()
        out += [
            "[[case]]",
            f'name = "{name}"',
            f'rust_const = "{const}"',
            'rust_type = "SharedProgram"',
            "programs = [",
            f'    {{ name = "comp", template = "sparse_resources/texel_buffer/{file}", stage = "{stage}"{spirv} }},',
            "]",
            "",
        ]
        table.append((name, const))
    MANIFEST.write_text("\n".join(out))

    lines = [
        "// @generated by hodow_cts/scripts/gen_sparse_texel_buffer_manifest.py - do not hand-edit.",
        "",
        "use crate::generated::shaders::sparse_resources_texel_buffer::*;",
        "use crate::vk::programs::BinaryCollection;",
        "",
        "/// The programs of the manifest case `name` (see `key_name` in the generator)",
        "pub fn programs_for(name: &str) -> Option<BinaryCollection> {",
        "    match name {",
    ]
    for name, const in table:
        lines.append(f'        "{name}" => Some({const}.programs),')
    lines += ["        _ => None,", "    }", "}", ""]
    LOOKUP.write_text("\n".join(lines))
    print(len(table))


if __name__ == "__main__":
    main()
