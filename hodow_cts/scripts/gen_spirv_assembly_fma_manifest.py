#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_fma.toml: dEQP-VK.spirv_assembly.instruction.compute.opfma.fp{16,32,64}.{scalar,vec2,vec3,vec4}.{rtz,rte,undef}.{denorm_preserve,denorm_flush,denorm_none}.{random,directed,float_controls}
(vktSpvAsmFmaTests.cpp, 324 cases of OpFmaKHR).

The assembly is built the way `getFmaCode` does; `spec` carries the width, the vector size, the rounding and denorm modes, whether SignedZeroInfNanPreserve is used and the input mode
for src/vkt/tests/spirv_assembly/fma_tests.rs.

    python3 hodow_cts/scripts/gen_spirv_assembly_fma_manifest.py

A pure text generator: no spirv-as and no cargo.
"""

import json
import struct
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_fma.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmFmaTests.cpp"
TEMPLATE = "spirv_assembly/source.asm"

ROUNDING_NAMES = {"rtz": "rtz", "rte": "rte", "undef": "undef"}
ROUNDING_EXEC = {"rtz": "RoundingModeRTZ", "rte": "RoundingModeRTE"}
DENORM_NAMES = {"preserve": "denorm_preserve", "flush": "denorm_flush", "undef": "denorm_none"}
DENORM_EXEC = {"preserve": "DenormPreserve", "flush": "DenormFlushToZero"}


def preamble(capabilities, extensions):
    return (
        "OpCapability Shader\n" + capabilities + extensions + "OpMemoryModel Logical GLSL450\n"
        'OpEntryPoint GLCompute %main "main" %id \n' + "OpExecutionMode %main LocalSize 1 1 1\n"
    )


def fma_code(bit_depth, vec_sz, m, d, use_sz_inf_nan):
    capabilities = "OpCapability FMAKHR\n"
    extensions = 'OpExtension "SPV_KHR_fma"\n'
    if m != "undef" or d != "undef" or use_sz_inf_nan:
        extensions += 'OpExtension "SPV_KHR_float_controls"\n'

    exec_modes = ""
    if m != "undef":
        capabilities += "OpCapability " + ROUNDING_EXEC[m] + "\n"
        exec_modes += "OpExecutionMode %main " + ROUNDING_EXEC[m] + " " + str(bit_depth) + "\n"
    if d != "undef":
        capabilities += "OpCapability " + DENORM_EXEC[d] + "\n"
        exec_modes += "OpExecutionMode %main " + DENORM_EXEC[d] + " " + str(bit_depth) + "\n"
    if use_sz_inf_nan:
        capabilities += "OpCapability SignedZeroInfNanPreserve\n"
        exec_modes += "OpExecutionMode %main SignedZeroInfNanPreserve " + str(bit_depth) + "\n"
    if bit_depth != 32:
        capabilities += "OpCapability Float" + str(bit_depth) + "\n"

    code = (
        preamble(capabilities, extensions)
        + exec_modes
        + 'OpName %main "main"\n'
        'OpName %id   "gl_GlobalInvocationID"\n'
        "OpDecorate %id BuiltIn GlobalInvocationId\n"
        "OpDecorate %buf BufferBlock\n"
        "OpDecorate %indata1 DescriptorSet 0\n"
        "OpDecorate %indata1 Binding 0\n"
        "OpDecorate %indata2 DescriptorSet 0\n"
        "OpDecorate %indata2 Binding 1\n"
        "OpDecorate %indata3 DescriptorSet 0\n"
        "OpDecorate %indata3 Binding 2\n"
        "OpDecorate %outdata DescriptorSet 0\n"
        "OpDecorate %outdata Binding 3\n"
        "OpDecorate %datarr ArrayStride " + str(bit_depth // 8) + "\n"
        "OpMemberDecorate %buf 0 Offset 0\n"
        "%void      = OpTypeVoid\n"
        "%voidf     = OpTypeFunction %void\n"
        "%u32       = OpTypeInt 32 0\n"
        "%i32       = OpTypeInt 32 1\n"
        "%uvec3     = OpTypeVector %u32 3\n"
        "%uvec3ptr  = OpTypePointer Input %uvec3\n"
        "%dat       = OpTypeFloat " + str(bit_depth) + "\n"
        "%datptr    = OpTypePointer Uniform %dat\n"
        "%datarr    = OpTypeRuntimeArray %dat\n"
        "%vec2      = OpTypeVector %dat 2\n"
        "%vec3      = OpTypeVector %dat 3\n"
        "%vec4      = OpTypeVector %dat 4\n"
        "%buf       = OpTypeStruct %datarr\n"
        "%bufptr    = OpTypePointer Uniform %buf\n"
        "%indata1   = OpVariable %bufptr Uniform\n"
        "%indata2   = OpVariable %bufptr Uniform\n"
        "%indata3   = OpVariable %bufptr Uniform\n"
        "%outdata   = OpVariable %bufptr Uniform\n"
        "%id        = OpVariable %uvec3ptr Input\n"
        "%zero      = OpConstant %i32 0\n"
        "%one       = OpConstant %i32 1\n"
        "%two       = OpConstant %i32 2\n"
        "%three     = OpConstant %i32 3\n"
        "%stride    = OpConstant %u32 65536\n"
        "%vec_sz    = OpConstant %i32 " + str(vec_sz) + "\n"
        "%main      = OpFunction %void None %voidf\n"
        "%label     = OpLabel\n"
        "%idval     = OpLoad %uvec3 %id\n"
        "%x         = OpCompositeExtract %u32 %idval 0\n"
        "%y         = OpCompositeExtract %u32 %idval 1\n"
        "%scale_y   = OpIMul %u32 %y %stride\n"
        "%vec_idx   = OpIAdd %u32 %scale_y %x\n"
        "%idx       = OpIMul %u32 %vec_idx %vec_sz\n"
    )

    if vec_sz == 1:
        code += (
            "%loc1      = OpAccessChain %datptr %indata1 %zero %idx\n"
            "%loc2      = OpAccessChain %datptr %indata2 %zero %idx\n"
            "%loc3      = OpAccessChain %datptr %indata3 %zero %idx\n"
            "%val1      = OpLoad %dat %loc1\n"
            "%val2      = OpLoad %dat %loc2\n"
            "%val3      = OpLoad %dat %loc3\n"
            "%res       = OpFmaKHR %dat %val1 %val2 %val3\n"
            "%outloc    = OpAccessChain %datptr %outdata %zero %idx\n"
            "             OpStore %outloc %res\n"
        )
    else:
        type_str = ["not used", "%dat", "%vec2", "%vec3", "%vec4"]
        index_str = ["%zero", "%one", "%two", "%three"]
        for i in range(vec_sz):
            s = str(i)
            code += (
                "%idx" + s + " = OpIAdd %u32 %idx " + index_str[i] + "\n"
                "%loc1" + s + " = OpAccessChain %datptr %indata1 %zero %idx" + s + "\n"
                "%loc2" + s + " = OpAccessChain %datptr %indata2 %zero %idx" + s + "\n"
                "%loc3" + s + " = OpAccessChain %datptr %indata3 %zero %idx" + s + "\n"
                "%val1" + s + " = OpLoad %dat %loc1" + s + "\n"
                "%val2" + s + " = OpLoad %dat %loc2" + s + "\n"
                "%val3" + s + " = OpLoad %dat %loc3" + s + "\n"
            )
        for n in ("1", "2", "3"):
            code += "%val" + n + " = OpCompositeConstruct " + type_str[vec_sz]
            for i in range(vec_sz):
                code += " %val" + n + str(i)
            code += "\n"
        code += "%res       = OpFmaKHR " + type_str[vec_sz] + " %val1 %val2 %val3\n"
        for i in range(vec_sz):
            s = str(i)
            code += (
                "%res" + s + " = OpCompositeExtract %dat %res " + s + "\n"
                "%outloc" + s + " = OpAccessChain %datptr %outdata %zero %idx" + s + "\n"
                "             OpStore %outloc" + s + " %res" + s + "\n"
            )
    code += "             OpReturn\n             OpFunctionEnd\n"
    return code


def main():
    out = [
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.opfma.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_fma_manifest.py - do not hand-edit; `spec` is the width, the vector size, the modes and the input mode of a case.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/fma_tests"\n'
    ]
    count = 0
    for bits in (16, 32, 64):
        for vec_sz in (1, 2, 3, 4):
            vec_name = "scalar" if vec_sz == 1 else f"vec{vec_sz}"
            for m in ("rtz", "rte", "undef"):
                for d in ("preserve", "flush", "undef"):
                    for leaf, sz, mode in (("random", False, "random"), ("directed", False, "directed"), ("float_controls", True, "directed")):
                        name = f"opfma/fp{bits}/{vec_name}/{ROUNDING_NAMES[m]}/{DENORM_NAMES[d]}/{leaf}"
                        const = "FMA_" + "".join(c if c.isalnum() else "_" for c in name).upper()
                        spec = f"bits={bits};vec={vec_sz};m={m};d={d};sz={int(sz)};mode={mode}"
                        out.append(
                            f'\n[[case]]\nname = "{name}"\nrust_const = "{const}"\nrust_type = "FmaCase"\n'
                            f'programs = [ {{ name = "comp", template = "{TEMPLATE}", stage = "asm" }} ]\n'
                            f'params = {{ spec = {{ type = "str", value = "{spec}" }} }}\n'
                            f"derived = {{ source = {json.dumps(repr(fma_code(bits, vec_sz, m, d, sz)))} }}\n"
                        )
                        count += 1
    OUT.write_text("".join(out), encoding="utf-8")
    print(f"wrote {count} cases")


if __name__ == "__main__":
    main()
