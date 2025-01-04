#!/usr/bin/env python3
"""Writes the shaders of dEQP-VK.compute.*.cooperative_matrix.* (vktComputeCooperativeMatrixTests.cpp, `CooperativeMatrixTestCase::initProgramsGLSL`) and their manifest.

Every case of the tree gets a shader (`matrixmuladd_cross` is the handwritten SPIR-V of `initProgramsSPIRV`, written as `.spvasm`) except the 64 bit component types and the base-feature transposes (glslang requires an Accumulator source and a B result for coopMatTransposeNV, which the same-use cases upstream do not have). The shaders are split over three manifests so that a glslang without the newer extensions only fails the part that needs them: the base feature set,
VK_NV_cooperative_matrix2 / VK_EXT_cooperative_matrix_maintenance1 at subgroup scope with linear addressing, and workgroup scope or tensor addressing. The case
tree is a mirror of `createCooperativeMatrixTestsInternal` (scripts/coopmat_tree_check.py checks the names against the mustpass); `key` is the case's path
below `cooperative_matrix.` and is what the Rust case looks its program up by. Identical sources share one template file.

A pure text generator: no glslang and no cargo.   Run from hodow_cts/:  python3 scripts/gen_cooperative_matrix_manifest.py   (then `just cts-shaders`)
"""
import hashlib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "shaders" / "src" / "coopmat"
MANIFEST = ROOT / "shaders" / "manifest" / "compute_cooperative_matrix.toml"

NV, A, B, C, R = "nv", "khr_a", "khr_b", "khr_c", "khr_r"
F16, F32, S8, S16, S32, U8, U16, U32 = "float16_t", "float32_t", "int8_t", "int16_t", "int32_t", "uint8_t", "uint16_t", "uint32_t"
BF16, E5M2, E4M3 = "bfloat16_t", "floate5m2_t", "floate4m3_t"
F64, S64, U64 = "float64_t", "int64_t", "uint64_t"
# type name -> (coopmatTypeName, vecprefix, bits)
INFO = {
    F16: ("fcoopmatNV", "f16", 16), F32: ("fcoopmatNV", "f32", 32), F64: ("fcoopmatNV", "f64", 64),
    S8: ("icoopmatNV", "i8", 8), S16: ("icoopmatNV", "i16", 16), S32: ("icoopmatNV", "i32", 32), S64: ("icoopmatNV", "i64", 64),
    U8: ("ucoopmatNV", "u8", 8), U16: ("ucoopmatNV", "u16", 16), U32: ("ucoopmatNV", "u32", 32), U64: ("ucoopmatNV", "u64", 64),
    BF16: ("fcoopmatNV", "bf16", 16), E5M2: ("fcoopmatNV", "fe5m2", 8), E4M3: ("fcoopmatNV", "fe4m3", 8),
}
RUN_TYPES = [F16, F32, S8, S16, S32, U8, U16, U32, BF16, E5M2, E4M3]
bits = lambda t: INFO[t][2]
isfloat = lambda t: t in (F16, F32, F64, BF16, E5M2, E4M3)
issint = lambda t: t in (S8, S16, S32, S64)
noarith = lambda t: t in (BF16, E5M2, E4M3)

MMA = ["matrixmuladd", "matrixmuladd_array", "matrixmuladd_saturated", "matrixmuladd_wrapping", "matrixmuladd_stride0", "matrixmuladd_cross", "matrixmuladd_dequant",
       "matrixmuladd_push", "matrixmuladd_split_barrier", "matrixmuladd_split_barrier_loop", "matrixmuladd_split_barrier_skew"]
BASE_TT = ["length", "constant", "composite", "composite_rvalue", "add", "sub", "div", "mul", "negate", "matrixtimesscalar", "func", "func_const_in", "matrixmuladd",
           "composite_array", "matrixmuladd_array", "matrixmuladd_saturated", "matrixmuladd_wrapping", "matrixmuladd_stride0", "matrixmuladd_cross", "matrixmuladd_dequant",
           "matrixmuladd_push", "matrixmuladd_split_barrier", "matrixmuladd_split_barrier_loop", "matrixmuladd_split_barrier_skew", "transpose_acc_to_a", "transpose_acc_to_b"]
DT = [(F32, F32), (F32, F16), (F16, F32), (F16, F16), (U8, U8), (U8, U32), (S8, S8), (S8, S32), (U8, S32), (U32, U32), (U32, U8), (S32, S32), (S32, S8),
      (BF16, F32), (BF16, BF16), (F32, BF16), (E5M2, E5M2), (E4M3, E4M3), (E5M2, F16), (E4M3, F16), (E5M2, F32), (E4M3, F32), (F16, E5M2), (F16, E4M3), (F32, E5M2), (F32, E4M3)]
DTN = {S8: "sint8", S32: "sint32", U8: "uint8", U32: "uint32", F16: "float16", F32: "float32", BF16: "bfloat16", E5M2: "floate5m2", E4M3: "floate4m3"}
ALL_TYPES = [F16, F32, S8, S16, S32, U8, U16, U32, E5M2, E4M3, BF16]
SCS = ["buffer", "workgroup", "buffer_varptr", "workgroup_varptr", "physical_buffer"]
is_mma = lambda t: t in MMA
is_split = lambda t: t.startswith("matrixmuladd_split_barrier")
is_arith = lambda t: t in ("composite", "func", "func_const_in", "add", "sub", "mul", "div", "negate", "matrixtimesscalar")


RED = ["reduce_sum_row", "reduce_sum_col", "reduce_sum_rowcol", "reduce_sum_2x2", "reduce_sum_row_changedim", "reduce_sum_col_changedim", "reduce_sum_rowcol_changedim",
       "reduce_min_row", "reduce_min_col", "reduce_min_rowcol", "reduce_min_2x2"]
PER = ["per_element_op", "per_element_op_row_col", "per_element_op_struct", "per_element_op_mat"]
is_reduce = lambda t: t in RED
is_per = lambda t: t in PER


is_reduce_2x2 = lambda t: t in ("reduce_sum_2x2", "reduce_min_2x2")
is_reduce_changedim = lambda t: t in ("reduce_sum_row_changedim", "reduce_sum_col_changedim", "reduce_sum_rowcol_changedim")
is_reduce_row = lambda t: t in ("reduce_sum_row", "reduce_min_row", "reduce_sum_row_changedim")
is_reduce_col = lambda t: t in ("reduce_sum_col", "reduce_min_col", "reduce_sum_col_changedim")
reduce_m_scale = lambda t: 3 if t in ("reduce_sum_col_changedim", "reduce_sum_rowcol_changedim") else 1
reduce_n_scale = lambda t: 3 if t in ("reduce_sum_row_changedim", "reduce_sum_rowcol_changedim") else 1


def tt_entries():
    out = [(n, n, "base") for n in BASE_TT]
    out += [(n, n, "nv2") for n in RED + PER]
    out += [(n, n + "_maint1", "maint1") for n in RED + PER]
    out += [("tensorlayout%dd" % d, "tensorlayout%dd" % d, "base") for d in range(1, 6)]
    out += [("tensorlayout%ddclip" % d, "tensorlayout%ddclip" % d, "base") for d in range(1, 6)]
    out.append(("spacetodepth", "spacetodepth", "base"))
    out += [(n, n, "base") for n in ("clampconstant", "clamptoedge", "clamprepeat", "clampmirrorrepeat")]
    out.append(("getcoordinate", "getcoordinate", "maint1"))
    return out


def cases():
    out = []
    for use in [NV, A, B, C, R]:
        for scope in ("subgroup", "workgroup"):
            if use == NV and scope == "workgroup":
                continue
            for (t, n, feat) in tt_entries():
                for sgs, sfx in [(0, ""), (1, "_min"), (2, "_max")]:
                    if t != "matrixmuladd" and sgs != 0:
                        continue
                    if t == "matrixmuladd" and sgs != 0 and use == NV:
                        continue
                    for (it, ot) in DT:
                        for sc in SCS:
                            if is_split(t) and (sc != "workgroup" or use != R):
                                continue
                            for col in ["rowmajor", "colmajor"]:
                                for addr in ["linear", "tensorlayout", "blocksize", "decode"]:
                                    mm = is_mma(t)
                                    if feat == "maint1" and (is_reduce(t) or is_per(t)) and (scope != "subgroup" or addr != "linear"):
                                        continue
                                    if t == "matrixmuladd_cross":
                                        if isfloat(it) or isfloat(ot) or use == NV or sc != "buffer" or scope == "workgroup" or addr in ("blocksize", "decode"):
                                            continue
                                        out.append(dict(
                                            key=".".join([use, scope + "scope", n + sfx, DTN[it] + "_" + DTN[ot], sc, col, addr]), tt=t, use=use, use2=use, it=it, ot=ot, feat=feat,
                                            col=col == "colmajor", sc=sc, sx=2, sy=2, wx=4, wy=4, icc=1, occ=1, scope=scope, addr=addr))
                                        continue
                                    if use == C:
                                        continue
                                    if mm and use in (A, B):
                                        continue
                                    if mm and use == NV and issint(it) != issint(ot):
                                        continue
                                    if mm and bits(it) > bits(ot):
                                        continue
                                    if noarith(it) or noarith(ot):
                                        if use == NV:
                                            continue
                                        if is_arith(t) or is_per(t):
                                            continue
                                    if t == "matrixmuladd_dequant":
                                        if it != F16 and not noarith(it):
                                            continue
                                        if addr != "decode":
                                            continue
                                        if col == "colmajor":
                                            continue
                                    if addr in ("blocksize", "decode") and t not in ("negate", "matrixmuladd_dequant"):
                                        continue
                                    if addr in ("blocksize", "decode") and sc in ("workgroup", "workgroup_varptr"):
                                        continue
                                    if not mm and it != ot:
                                        continue
                                    if t == "mul" and use == NV:
                                        continue
                                    if t in ("matrixmuladd_saturated", "matrixmuladd_wrapping") and (isfloat(it) or use == NV):
                                        continue
                                    if t == "matrixmuladd_stride0" and use == NV:
                                        continue
                                    if t == "getcoordinate" and use == NV:
                                        continue
                                    if t == "length" and use != NV and ot in (S8, U8):
                                        continue
                                    if t == "matrixmuladd_push" and addr != "linear":
                                        continue
                                    if use == NV and (addr != "linear" or is_reduce(t) or is_per(t)):
                                        continue
                                    if is_reduce(t) and use in (A, B):
                                        continue
                                    if is_reduce(t) and it != ot:
                                        continue
                                    if is_tl_test(t) and (col == "colmajor" or sc in ("workgroup", "workgroup_varptr", "physical_buffer") or addr == "linear"):
                                        continue
                                    if sc in ("buffer_varptr", "workgroup_varptr") and (t not in ("matrixmuladd", "mul") or sgs != 0):
                                        continue
                                    if col == "colmajor" and not (mm or t == "mul"):
                                        continue
                                    if (sc in ("workgroup", "workgroup_varptr") or addr == "linear") and is_clamp(t):
                                        continue
                                    if is_split(t) and addr != "linear":
                                        continue
                                    if t == "matrixmuladd_dequant" and False:
                                        continue
                                    sx, sy, wx, wy = 2, 2, 4, 4
                                    if is_tl_test(t):
                                        sx = sy = wx = wy = 1
                                    if is_split(t):
                                        sx, sy = 1, 2
                                    out.append(dict(
                                        key=".".join([use, scope + "scope", n + sfx, DTN[it] + "_" + DTN[ot], sc, col, addr]), tt=t, use=use, use2=use, it=it, ot=ot, feat=feat,
                                        col=col == "colmajor", sc=sc, sx=sx, sy=sy, wx=wx, wy=wy, icc=1, occ=1, scope=scope, addr=addr))
            if use != C:
                for dst in [NV, A, B, R]:
                    if (use == NV) != (dst == NV):
                        continue
                    if use != dst and use in (A, B) and dst in (A, B):
                        continue
                    cc = []
                    if use == dst:
                        cc.append(("convert_base", "convert_base", "base"))
                        cc.append(("convert_nv", "convert", "nv2"))
                        cc.append(("convert_sat_nv", "convert_sat", "nv2"))
                        if use != NV:
                            cc.append(("convert_maint1", "convert", "maint1"))
                            cc.append(("convert_sat_maint1", "convert_sat", "maint1"))
                    elif use == R:
                        cc += [("convert_nv", "convert", "nv2"), ("convert_maint1", "convert", "maint1"), ("convert_sat_nv", "convert_sat", "nv2"), ("convert_sat_maint1", "convert_sat", "maint1")]
                    elif dst == R:
                        cc += [("convert_maint1", "convert", "maint1"), ("convert_sat_maint1", "convert_sat", "maint1")]
                    if use == R and dst == B:
                        cc += [("transpose", "transpose_acc_to_b", "nv2"), ("transpose_maint1", "transpose_acc_to_b", "maint1")]
                    if use == R and dst == A:
                        cc += [("transpose_maint1", "transpose_acc_to_a", "maint1")]
                    for (n, t, feat) in cc:
                        for it in ALL_TYPES:
                            for ot in ALL_TYPES:
                                if use == NV and (noarith(it) or noarith(ot)):
                                    continue
                                if t == "convert_sat":
                                    if it in (E5M2, E4M3):
                                        continue
                                    if ot not in (E5M2, E4M3):
                                        continue
                                out.append(dict(
                                    key=".".join([use, scope + "scope", n + "_dst_" + dst, "input_%s_output_%s" % (it, ot), "buffer", "rowmajor"]), tt=t, use=use, use2=dst,
                                    it=it, ot=ot, feat=feat, col=False, sc="buffer", sx=2, sy=2, wx=4, wy=4, icc=1, occ=1, scope=scope,
                                    addr="tensorlayout" if scope == "workgroup" else "linear"))
            if use not in (NV, C):
                for ct, n in [("vec2", 2), ("vec4", 4)]:
                    for io in ["load", "save"]:
                        for it in ALL_TYPES:
                            for sc in SCS:
                                out.append(dict(
                                    key=".".join([use, scope + "scope", "multicomponent", ct, io, it, sc, "rowmajor"]), tt="multicomponent_" + io, use=use, use2=use, feat="base",
                                    it=it, ot=it, col=False, sc=sc, sx=2, sy=2, wx=4, wy=4, icc=n if io == "load" else 1, occ=1 if io == "load" else n, scope=scope,
                                    addr="tensorlayout" if scope == "workgroup" else "linear"))
    return [c for c in out if c["it"] in RUN_TYPES and c["ot"] in RUN_TYPES and not (c["tt"].startswith("transpose") and c["feat"] == "base")]


def reduce_dummy(c):
    return None


TL_TABLES = {
    1: dict(size=[(32, 32), (64, 64)], dim=[65536, 1, 1, 1, 1], span=[[1024], [4096]], load=[[10000], [-1]], store=[[-1], [4321]]),
    2: dict(size=[(32, 32), (64, 64)], dim=[512, 512, 1, 1, 1], span=[[32, 32], [64, 64]], load=[[7, 13], [128, 128]], store=[[13, 7], [148, 0]]),
    3: dict(size=[(64, 32), (32, 32)], dim=[33, 44, 55, 1, 1], span=[[16, 16, 8], [8, 4, 32]], load=[[1, 1, 1], [-1, -1, -1]], store=[[2, 2, 2], [23, 2, 1]]),
    4: dict(size=[(64, 64)], dim=[20, 25, 40, 10, 1], span=[[16, 8, 8, 4]], load=[[-1, -1, -1, -1]], store=[[1, 2, 1, 2]]),
    5: dict(size=[(32, 32)], dim=[4, 4, 32, 16, 8], span=[[1, 4, 8, 4, 8]], load=[[-1, -1, -1, -1, -1]], store=[[1, 2, 1, 0, 1]]),
}
BLOCK_SIZE = (2, 4)
CLAMP_MODE = {"clampconstant": "gl_CooperativeMatrixClampModeConstantNV", "clamptoedge": "gl_CooperativeMatrixClampModeClampToEdgeNV",
              "clamprepeat": "gl_CooperativeMatrixClampModeRepeatNV", "clampmirrorrepeat": "gl_CooperativeMatrixClampModeMirrorRepeatNV"}
is_tl_test = lambda t: t.startswith("tensorlayout") or t == "spacetodepth"
is_clamp = lambda t: t.startswith("clamp")
tl_dim = lambda t: int(t[len("tensorlayout")])


CROSS_TYPE_NAME = {S8: "s8", S32: "s32", U8: "u8", U32: "u32"}
CROSS_TYPE_WIDTH = {S8: 1, S32: 4, U8: 1, U32: 4}
CROSS_TEMPLATE = (
    "OpCapability Shader\n"
    "OpCapability Int8\n"
    "OpCapability GroupNonUniform\n"
    "OpCapability StorageBuffer8BitAccess\n"
    "OpCapability VulkanMemoryModel\n"
    "OpCapability CooperativeMatrixKHR\n"
    'OpExtension "SPV_KHR_8bit_storage"\n'
    'OpExtension "SPV_KHR_cooperative_matrix"\n'
    'OpExtension "SPV_KHR_vulkan_memory_model"\n'
    '%1 = OpExtInstImport "GLSL.std.450"\n'
    "OpMemoryModel Logical Vulkan\n"
    'OpEntryPoint GLCompute %main "main" %gl_SubgroupId %gl_WorkgroupID\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpDecorate %gl_SubgroupId BuiltIn SubgroupId\n"
    "OpDecorate %gl_WorkgroupID BuiltIn WorkgroupId\n"
    "OpDecorate %local_size_x SpecId 0\n"
    "OpDecorate %local_size_y SpecId 1\n"
    "OpDecorate %M            SpecId 6\n"
    "OpDecorate %N            SpecId 7\n"
    "OpDecorate %K            SpecId 8\n"
    "OpDecorate %inputA_x ArrayStride ${STRIDE_A}\n"
    "OpMemberDecorate %inputA_struct 0 Offset 0\n"
    "OpDecorate %inputA_struct Block\n"
    "OpDecorate %inputA_var DescriptorSet 0\n"
    "OpDecorate %inputA_var Binding 0\n"
    "OpDecorate %inputB_x ArrayStride ${STRIDE_B}\n"
    "OpMemberDecorate %inputB_struct 0 Offset 0\n"
    "OpDecorate %inputB_struct Block\n"
    "OpDecorate %inputB_var DescriptorSet 0\n"
    "OpDecorate %inputB_var Binding 1\n"
    "OpDecorate %inputC_x ArrayStride ${STRIDE_C}\n"
    "OpMemberDecorate %inputC_struct 0 Offset 0\n"
    "OpDecorate %inputC_struct Block\n"
    "OpDecorate %inputC_var DescriptorSet 0\n"
    "OpDecorate %inputC_var Binding 2\n"
    "OpDecorate %outputO_x ArrayStride ${STRIDE_R}\n"
    "OpMemberDecorate %outputO_struct 0 Offset 0\n"
    "OpDecorate %outputO_struct Block\n"
    "OpDecorate %outputO_var DescriptorSet 0\n"
    "OpDecorate %outputO_var Binding 3\n"
    "OpDecorate %wg_size BuiltIn WorkgroupSize\n"
    "%void            = OpTypeVoid\n"
    "%voidfunc        = OpTypeFunction %void\n"
    "%u8              = OpTypeInt 8 0\n"
    "%s8              = OpTypeInt 8 1\n"
    "%u32             = OpTypeInt 32 0\n"
    "%s32             = OpTypeInt 32 1\n"
    "%uvec2           = OpTypeVector %u32 2\n"
    "%uvec3           = OpTypeVector %u32 3\n"
    "%piu32           = OpTypePointer Input %u32\n"
    "%gl_SubgroupId   = OpVariable %piu32 Input\n"
    "%c0u             = OpConstant %u32 0\n"
    "%c1u             = OpConstant %u32 1\n"
    "%c2u             = OpConstant %u32 2\n"
    "%c3u             = OpConstant %u32 3\n"
    "%c5u             = OpConstant %u32 5\n"
    "%c8s             = OpConstant %s32 8\n"
    "%c0s             = OpConstant %s32 0\n"
    "%layout          = OpConstant %s32 ${LAYOUT}\n"
    "%piuvec3         = OpTypePointer Input %uvec3\n"
    "%gl_WorkgroupID  = OpVariable %piuvec3 Input\n"
    "%csubgroupsPerWG = OpConstantComposite %uvec2 %c2u %c2u\n"
    "%K               = OpSpecConstant %s32 1\n"
    "%M               = OpSpecConstant %s32 1\n"
    "%N               = OpSpecConstant %s32 1\n"
    "%Ku              = OpSpecConstantOp %u32 IAdd %K %c0u\n"
    "%Mu              = OpSpecConstantOp %u32 IAdd %M %c0u\n"
    "%Nu              = OpSpecConstantOp %u32 IAdd %N %c0u\n"
    "%k8              = OpSpecConstantOp %s32 IMul %K %c8s\n"
    "%mk8             = OpSpecConstantOp %s32 IMul %k8 %M\n"
    "%mk8u            = OpSpecConstantOp %u32 IAdd %mk8 %c0u\n"
    "%n8              = OpSpecConstantOp %s32 IMul %N %c8s\n"
    "%nk8             = OpSpecConstantOp %s32 IMul %n8 %K\n"
    "%nk8u            = OpSpecConstantOp %u32 IAdd %nk8 %c0u\n"
    "%nm8             = OpSpecConstantOp %s32 IMul %n8 %M\n"
    "%nm8u            = OpSpecConstantOp %u32 IAdd %nm8 %c0u\n"
    "%strideAs        = OpSpecConstantOp %s32 IMul %${MULT_A} %c8s\n"
    "%strideA         = OpSpecConstantOp %u32 IAdd %strideAs %c0u\n"
    "%strideBs        = OpSpecConstantOp %s32 IMul %${MULT_B} %c8s\n"
    "%strideB         = OpSpecConstantOp %u32 IAdd %strideBs %c0u\n"
    "%strideCs        = OpSpecConstantOp %s32 IMul %${MULT_C} %c8s\n"
    "%strideC         = OpSpecConstantOp %u32 IAdd %strideCs %c0u\n"
    "%strideRs        = OpSpecConstantOp %s32 IMul %${MULT_R} %c8s\n"
    "%strideR         = OpSpecConstantOp %u32 IAdd %strideRs %c0u\n"
    "%psbmat_s8       = OpTypePointer StorageBuffer %s8\n"
    "%psbmat_s32      = OpTypePointer StorageBuffer %s32\n"
    "%psbmat_u8       = OpTypePointer StorageBuffer %u8\n"
    "%psbmat_u32      = OpTypePointer StorageBuffer %u32\n"
    "%matA            = OpTypeCooperativeMatrixKHR %${A_ELEM_TYPE} %c3u %M %K %c0u\n"
    "%inputA_x        = OpTypeRuntimeArray %${A_ELEM_TYPE}\n"
    "%inputA_struct   = OpTypeStruct %inputA_x\n"
    "%inputA_ptr      = OpTypePointer StorageBuffer %inputA_struct\n"
    "%inputA_var      = OpVariable %inputA_ptr StorageBuffer\n"
    "%matB            = OpTypeCooperativeMatrixKHR %${B_ELEM_TYPE} %c3u %K %N %c1u\n"
    "%inputB_x        = OpTypeRuntimeArray %${B_ELEM_TYPE}\n"
    "%inputB_struct   = OpTypeStruct %inputB_x\n"
    "%inputB_ptr      = OpTypePointer StorageBuffer %inputB_struct\n"
    "%inputB_var      = OpVariable %inputB_ptr StorageBuffer\n"
    "%matS            = OpTypeCooperativeMatrixKHR %${S_ELEM_TYPE} %c3u %M %N %c2u\n"
    "%matU            = OpTypeCooperativeMatrixKHR %${U_ELEM_TYPE} %c3u %M %N %c2u\n"
    "%inputC_x        = OpTypeRuntimeArray %${C_ELEM_TYPE}\n"
    "%inputC_struct   = OpTypeStruct %inputC_x\n"
    "%inputC_ptr      = OpTypePointer StorageBuffer %inputC_struct\n"
    "%inputC_var      = OpVariable %inputC_ptr StorageBuffer\n"
    "%outputO_x       = OpTypeRuntimeArray %${R_ELEM_TYPE}\n"
    "%outputO_struct  = OpTypeStruct %outputO_x\n"
    "%outputO_ptr     = OpTypePointer StorageBuffer %outputO_struct\n"
    "%outputO_var     = OpVariable %outputO_ptr StorageBuffer\n"
    "%local_size_x           = OpSpecConstant %u32 1\n"
    "%local_size_y           = OpSpecConstant %u32 1\n"
    "%wg_size                = OpSpecConstantComposite %uvec3 %local_size_x %local_size_y %c1u\n"
    "%main                   = OpFunction %void None %voidfunc\n"
    "%label                  = OpLabel\n"
    "%gl_SubgroupId_         = OpLoad %u32 %gl_SubgroupId\n"
    "%subgroupXY_x           = OpUMod %u32 %gl_SubgroupId_ %c2u\n"
    "%subgroupXY_y           = OpUDiv %u32 %gl_SubgroupId_ %c2u\n"
    "%subgroupXY_uvec2       = OpCompositeConstruct %uvec2 %subgroupXY_x %subgroupXY_y\n"
    "%gl_WorkgroupID_uvec3   = OpLoad %uvec3 %gl_WorkgroupID\n"
    "%gl_WorkgroupID_uvec2   = OpVectorShuffle %uvec2 %gl_WorkgroupID_uvec3 %gl_WorkgroupID_uvec3 0 1\n"
    "%2xgl_WorkgroupID_uvec2 = OpIMul %uvec2 %gl_WorkgroupID_uvec2 %csubgroupsPerWG\n"
    "%matrixID               = OpIAdd %uvec2 %2xgl_WorkgroupID_uvec2 %subgroupXY_uvec2\n"
    "%matrixID_x             = OpCompositeExtract %u32 %matrixID 0\n"
    "%matrixID_y             = OpCompositeExtract %u32 %matrixID 1\n"
    "%e0a      = OpIMul %u32 %mk8u %matrixID_y\n"
    "%e0b      = OpIMul %u32 %${MULT_A}u %matrixID_x\n"
    "%element0 = OpIAdd %u32 %e0a %e0b\n"
    "%e1a      = OpIMul %u32 %nk8u %matrixID_y\n"
    "%e1b      = OpIMul %u32 %${MULT_B}u %matrixID_x\n"
    "%element1 = OpIAdd %u32 %e1a %e1b\n"
    "%e2a      = OpIMul %u32 %nm8u %matrixID_y\n"
    "%e2b      = OpIMul %u32 %${MULT_C}u %matrixID_x\n"
    "%element2 = OpIAdd %u32 %e2a %e2b\n"
    "%e3a      = OpIMul %u32 %nm8u %matrixID_y\n"
    "%e3b      = OpIMul %u32 %${MULT_R}u %matrixID_x\n"
    "%element3 = OpIAdd %u32 %e3a %e3b\n"
    "%Aij      = OpAccessChain %psbmat_${A_ELEM_TYPE} %inputA_var %c0s %element0\n"
    "%Aij_mat  = OpCooperativeMatrixLoadKHR %matA %Aij %layout %strideA MakePointerVisible|NonPrivatePointer %c5u\n"
    "%Bij      = OpAccessChain %psbmat_${B_ELEM_TYPE} %inputB_var %c0s %element1\n"
    "%Bij_mat  = OpCooperativeMatrixLoadKHR %matB %Bij %layout %strideB MakePointerVisible|NonPrivatePointer %c5u\n"
    "%Cij      = OpAccessChain %psbmat_${C_ELEM_TYPE} %inputC_var %c0s %element2\n"
    "%Cij_mat  = OpCooperativeMatrixLoadKHR %${C_TYPE} %Cij %layout %strideC MakePointerVisible|NonPrivatePointer %c5u\n"
    "%matR     = OpCooperativeMatrixMulAddKHR %${R_TYPE} %Aij_mat %Bij_mat %Cij_mat ${SIGNEDNESS}\n"
    "%Rij_mat  = OpAccessChain %psbmat_${R_ELEM_TYPE} %outputO_var %c0s %element3\n"
    "OpCooperativeMatrixStoreKHR %Rij_mat %matR %layout %strideR MakePointerAvailable|NonPrivatePointer %c5u\n"
    "OpReturn\n"
    "OpFunctionEnd\n"
)


def opposite_signedness(name):
    return ("s" if name[0] == "u" else "u") + name[1:]


def cross_asm(c):
    """`CooperativeMatrixTestCase::initProgramsSPIRV` (matrixmuladd_cross: handwritten SPIR-V 1.3 with a cooperative matrix whose signedness is crossed)."""
    use, it, ot = c["use"], c["it"], c["ot"]
    col = c["col"]
    dims = [("M" if col else "K"), ("K" if col else "N"), ("M" if col else "N"), ("M" if col else "N")]
    in_name, out_name = CROSS_TYPE_NAME[it], CROSS_TYPE_NAME[ot]
    out_signed = issint(ot)
    in_signed = issint(it)
    signedness = ("|MatrixASignedComponentsKHR" if in_signed else "") + ("|MatrixBSignedComponentsKHR" if in_signed else "") + \
        ("|MatrixCSignedComponentsKHR" if out_signed else "") + ("|MatrixResultSignedComponentsKHR" if out_signed else "")
    attributes = {
        "A_ELEM_TYPE": opposite_signedness(in_name) if use == A else in_name,
        "B_ELEM_TYPE": opposite_signedness(in_name) if use == B else in_name,
        "C_ELEM_TYPE": out_name,
        "R_ELEM_TYPE": out_name,
        "S_ELEM_TYPE": out_name if out_signed else opposite_signedness(out_name),
        "U_ELEM_TYPE": opposite_signedness(out_name) if out_signed else out_name,
        "C_TYPE": ("matU" if out_signed else "matS") if use == C else ("matS" if out_signed else "matU"),
        "R_TYPE": ("matU" if out_signed else "matS") if use == R else ("matS" if out_signed else "matU"),
        "SIGNEDNESS": signedness[1:],
        "MULT_A": dims[0],
        "MULT_B": dims[1],
        "MULT_C": dims[2],
        "MULT_R": dims[3],
        "STRIDE_A": str(CROSS_TYPE_WIDTH[it]),
        "STRIDE_B": str(CROSS_TYPE_WIDTH[it]),
        "STRIDE_C": str(CROSS_TYPE_WIDTH[ot]),
        "STRIDE_R": str(CROSS_TYPE_WIDTH[ot]),
        "LAYOUT": "1" if col else "0",
    }
    text = CROSS_TEMPLATE
    for name, value in attributes.items():
        text = text.replace("${%s}" % name, value)
    assert "${" not in text
    return text


def glsl(c):
    tt, use, it, ot = c["tt"], c["use"], c["it"], c["ot"]
    khr = use != NV
    suffix = "" if khr else "NV"
    ext = "#extension GL_KHR_cooperative_matrix : enable\n" if khr else "#extension GL_NV_cooperative_matrix : enable\n#extension GL_NV_integer_cooperative_matrix : enable\n"
    sat = ", gl_MatrixOperandsSaturatingAccumulation" if tt == "matrixmuladd_saturated" else ""
    col_major = c["col"]
    sc = c["sc"]
    addr = c["addr"]
    wg = c["scope"] == "workgroup"
    wg_storage = sc in ("workgroup", "workgroup_varptr")
    feat = c["feat"]
    needs_cm2 = wg or addr != "linear" or is_tl_test(tt) or is_clamp(tt) or feat == "nv2"
    cm2_sfx = "EXT" if feat == "maint1" else "NV"
    s = []
    s.append("#version 450 core\n#pragma use_vulkan_memory_model\n")
    s.append("#extension GL_KHR_shader_subgroup_basic : enable\n#extension GL_KHR_memory_scope_semantics : enable\n" + ext)
    s.append("#extension GL_EXT_split_barrier : enable\n")
    if feat == "maint1":
        s.append("#extension GL_EXT_cooperative_matrix_maintenance1 : enable\n")
    if needs_cm2:
        s.append("#extension GL_NV_cooperative_matrix2 : enable\n")
    s.append("#extension GL_EXT_bfloat16 : enable\n#extension GL_EXT_float_e5m2 : enable\n#extension GL_EXT_float_e4m3 : enable\n")
    s.append("#extension GL_EXT_shader_explicit_arithmetic_types : enable\n#extension GL_EXT_buffer_reference : enable\n#extension GL_EXT_bfloat16 : enable\n"
             "// strides overriden by spec constants\n"
             "layout(constant_id = 2) const int AStride = 1;\nlayout(constant_id = 3) const int BStride = 1;\nlayout(constant_id = 4) const int CStride = 1;\n"
             "layout(constant_id = 5) const int OStride = 1;\nlayout(constant_id = 6) const int M = 1;\nlayout(constant_id = 7) const int N = 1;\n"
             "layout(constant_id = 8) const int K = 1;\nlayout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;\n")
    if tt == "matrixmuladd_push":
        s.append("layout (push_constant, std430) uniform PCBlock {\n  int AStrideVar;\n  int BStrideVar;\n  int CStrideVar;\n  int OStrideVar;\n} pc;\n")
    if sc in ("buffer_varptr", "workgroup_varptr"):
        s.append("#pragma use_variable_pointers\n")
    mm = is_mma(tt)
    if mm:
        dims = [("M", "K"), ("K", "N"), ("M", "N"), ("M", "N")]
    else:
        dims = [("(M*2)", "(N*2)") if is_reduce_2x2(tt) else ("M", "N"), ("M", "N"), ("M", "N"), ("M", "N")]
        if is_reduce_changedim(tt):
            dims[3] = ("(M*%d)" % reduce_m_scale(tt), "(N*%d)" % reduce_n_scale(tt))
        elif tt.startswith("transpose"):
            dims[2] = ("N", "M")
            dims[3] = ("N", "M")
    tA = it
    tB = it
    tC = ot
    tO = ot
    divs = ["", "", "", ""]
    if tt == "multicomponent_load":
        cs = {2: "vec2", 4: "vec4"}.get(c["icc"], "")
        tA = tB = INFO[it][1] + cs
        divs[0] = divs[1] = {2: "/2", 4: "/4"}.get(c["icc"], "")
    if tt == "multicomponent_save":
        cs = {2: "vec2", 4: "vec4"}.get(c["occ"], "")
        tC = tO = INFO[ot][1] + cs
        divs[2] = divs[3] = {2: "/2", 4: "/4"}.get(c["occ"], "")
    scope = "gl_ScopeWorkgroup" if wg else "gl_ScopeSubgroup"
    s.append("const int workgroupsX = %d;\n" % c["wx"])
    if not wg:
        s.append("const uvec2 subgroupsPerWG = uvec2(%d, %d);\n" % (c["sx"], c["sy"]))
    tA_struct = tA
    if not wg_storage and addr != "linear":
        s.append("struct StructA { %s y; };\n" % tA)
        tA_struct = "StructA"
    if sc == "physical_buffer":
        s.append("layout(buffer_reference) buffer InputA { %s x[]; };\n" % tA_struct)
        s.append("layout(buffer_reference) buffer InputB { %s x[]; };\n" % tB)
        s.append("layout(buffer_reference) buffer InputC { %s x[]; };\n" % tC)
        s.append("layout(buffer_reference) buffer Output { %s x[]; };\n" % tO)
        s.append("layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;\n")
    else:
        s.append("layout(set=0, binding=0) coherent buffer InputA { %s x[]; } inputA;\n" % tA_struct)
        s.append("layout(set=0, binding=1) coherent buffer InputB { %s x[]; } inputB;\n" % tB)
        s.append("layout(set=0, binding=2) coherent buffer InputC { %s x[]; } inputC;\n" % tC)
        s.append("layout(set=0, binding=3) coherent buffer Output { %s x[]; } outputO;\n" % tO)
    if wg_storage:
        scale = "1" if wg else "subgroupsPerWG.x * subgroupsPerWG.y"
        for nm, ty, d in (("sharedA", tA, dims[0]), ("sharedB", tB, dims[1]), ("sharedC", tC, dims[2]), ("sharedO", tO, dims[3])):
            s.append("shared %s %s[%s * %s * %s];\n" % (ty, nm, d[0], d[1], scale))
        if tt == "matrixmuladd_split_barrier_skew":
            s.append("shared uint splitSkewedSink;\n")
    if is_reduce_2x2(tt):
        s.append("const int ARows = %s;\nconst int ACols = %s;\n" % dims[0])
    else:
        s.append("#define ARows %s\n#define ACols %s\n" % dims[0])
    if is_reduce_changedim(tt):
        s.append("const int ORows = %s;\nconst int OCols = %s;\n" % dims[3])
    else:
        s.append("#define ORows %s\n#define OCols %s\n" % dims[3])
    same_type = {A: "gl_MatrixUseA", B: "gl_MatrixUseB", R: "gl_MatrixUseAccumulator"}.get(use, "Invalid use")
    if khr:
        def use_str(u):
            return {A: "gl_MatrixUseA", B: "gl_MatrixUseB", R: "gl_MatrixUseAccumulator"}.get(u, "Invalid use")
        if mm:
            at, bt, ct, rt = "gl_MatrixUseA", "gl_MatrixUseB", "gl_MatrixUseAccumulator", "gl_MatrixUseAccumulator"
        else:
            at = bt = use_str(use)
            ct = rt = use_str(c["use2"])
        matA = "coopmat<%s, %s, ARows, ACols, %s>" % (it, scope, at)
        matB = "coopmat<%s, %s, %s, %s, %s>" % (it, scope, dims[1][0], dims[1][1], bt)
        matC = "coopmat<%s, %s, %s, %s, %s>" % (ot, scope, dims[2][0], dims[2][1], ct)
        matO = "coopmat<%s, %s, ORows, OCols, %s>" % (ot, scope, rt)
    else:
        matA = "%s<%d, %s, ARows, ACols>" % (INFO[it][0], bits(it), scope)
        matB = "%s<%d, %s, %s, %s>" % (INFO[it][0], bits(it), scope, dims[1][0], dims[1][1])
        matC = "%s<%d, %s, %s, %s>" % (INFO[ot][0], bits(ot), scope, dims[2][0], dims[2][1])
        matO = "%s<%d, %s, ORows, OCols>" % (INFO[ot][0], bits(ot), scope)
    s.append("%s matA;\n%s matB;\n%s matC;\n%s matO;\n" % (matA, matB, matC, matO))
    if tt == "constant":
        s.append("const %s matConst = %s(1.0);\n" % (matO, matO))
    if tt in ("func", "func_const_in"):
        q = "const in " if tt == "func_const_in" else ""
        s.append("%s f(%s%s m) { return -m; }\n" % (matA, q, matA))
    if tt in ("per_element_op", "per_element_op_mat"):
        s.append("%s elemOp(const in uint32_t row, const in uint32_t col, const in %s elem, const in %s other) {\n    return elem + other;\n}\n" % (it, it, it))
    elif tt == "per_element_op_row_col":
        s.append("%s elemOpRowCol(const in uint32_t row, const in uint32_t col, const in %s elem) {\n    return elem + %s(row*3 + col);\n}\n" % (it, it, it))
    elif tt == "per_element_op_struct":
        s.append("struct ParamType { %s x; };\n" % it)
        s.append("%s elemOp(const in uint32_t row, const in uint32_t col, const in %s elem, const in ParamType other) {\n    return elem + other.x;\n}\n" % (it, it))
    elif is_reduce(tt):
        s.append("%s combineOp(const in %s a, const in %s b) {\n" % (it, it, it))
        if tt.startswith("reduce_sum"):
            s.append("    return %s(float(a) + float(b));\n" % it if noarith(it) else "    return a + b;\n")
        else:
            s.append("    return %s(min(float(a), float(b)));\n" % it if noarith(it) else "    return min(a, b);\n")
        s.append("}\n")
    bs0, bs1 = BLOCK_SIZE
    if tt == "matrixmuladd_dequant":
        s.append("layout(buffer_reference, std430, buffer_reference_align = 1) buffer decodeBuf {\n   uint8_t bits[%d];\n};\n" % (bs0 * bs1 // 2))
        s.append("%s decodeFunc(const in decodeBuf b, const in uint32_t blockCoords[2], const in uint32_t coordInBlock[2]) {\n"
                 "   uint32_t idx = coordInBlock[0] * %d + coordInBlock[1];\n   uint32_t arrayidx = idx / 2;\n   uint32_t shift = (idx & 1) * 4;\n"
                 "   int32_t bits = int32_t(b.bits[arrayidx]);\n   bits = (bits >> shift) & 0xF;\n   return %s(0.5 * float((bits & 7) - 3) * (1+(bits/8)));\n}\n" % (tA, bs1, tA))
    elif addr == "decode":
        s.append("layout(buffer_reference, std430, buffer_reference_align = %d) buffer decodeBuf {\n   %s f[%d];\n};\n" % (bits(it) // 8, tA, bs0 * bs1))
        s.append("%s decodeFunc(const in decodeBuf b, const in uint32_t blockCoords[2], const in uint32_t coordInBlock[2]) {\n"
                 "   return b.f[coordInBlock[0] * %d + coordInBlock[1]] + %s((2*blockCoords[0] + blockCoords[1]) & 3);\n}\n" % (tA, bs1, tA))
    s.append("void main()\n{\n")
    if wg:
        s.append("   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);\n")
    else:
        s.append("   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);\n"
                 "   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;\n"
                 "   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)\n"
                 "       return;\n")
    if sc == "physical_buffer":
        s.append("   InputA inputA = params.inputA;\n   InputB inputB = params.inputB;\n   InputC inputC = params.inputC;\n   Output outputO = params.outputO;\n")
    outer = lambda d: d[1] if col_major else d[0]
    inner = lambda d: d[0] if col_major else d[1]
    strides = [None] * 4
    heights = [None] * 4
    for i in range(4):
        if wg:
            strides[i] = "%s * %d" % (inner(dims[i]), c["wx"])
            heights[i] = "%s * %d" % (outer(dims[i]), c["wy"])
        else:
            strides[i] = "%s * %d" % (inner(dims[i]), c["sx"] * c["wx"])
            heights[i] = "%s * %d" % (outer(dims[i]), c["sy"] * c["wy"])
    if addr != "linear":
        for i in range(4):
            s.append("   int offset%d0 = int(%s * matrixID.y); int offset%d1 = int(%s * matrixID.x);\n" % (i, outer(dims[i]), i, inner(dims[i])))
        for i in range(4):
            s.append("   uint span%d0 = %s; uint span%d1 = %s;\n" % (i, outer(dims[i]), i, inner(dims[i])))
    if is_clamp(tt):
        s.append("   offset00 -= 3; offset01 -= 3;\n   offset10 -= 3; offset11 -= 3;\n   offset20 -= 3; offset21 -= 3;\n")
    if tt == "matrixmuladd_push":
        strides = ["pc.AStrideVar", "pc.BStrideVar", "pc.CStrideVar", "pc.OStrideVar"]
    elems = []
    for i in range(4):
        elems.append("(%s * %s * matrixID.y + %s * matrixID.x)%s" % (strides[i], outer(dims[i]), inner(dims[i]), divs[i]))
    s.append("   uint element0 = %s;\n   uint element1 = %s;\n   uint element2 = %s;\n   uint element3 = %s;\n   uint elementS0, elementS1, elementS2, elementS3;\n" % tuple(elems))
    split_loop = tt in ("matrixmuladd_split_barrier_loop", "matrixmuladd_split_barrier_skew")
    names = ["sharedA", "sharedB", "sharedC"]
    inames = ["inputA", "inputB", "inputC"]
    if wg_storage:
        for m in range(4):
            shared_stride = strides[m] + " / workgroupsX"
            if wg:
                s.append("       elementS%d = 0;\n" % m)
            else:
                s.append("       elementS%d = (%s * %s * subgroupXY.y + %s * subgroupXY.x)%s;\n" % (m, shared_stride, outer(dims[m]), inner(dims[m]), divs[m]))
        if tt == "matrixmuladd_split_barrier_skew":
            s.append("   if (gl_SubgroupID == 0u && subgroupElect())\n       splitSkewedSink = 0u;\n")
            s.append("   controlBarrier(%s, %s, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);\n" % (scope, scope))
        if split_loop:
            s.append("   for (uint step = 0u; step < 2u; ++step) {\n")
            if isfloat(it):
                s.append("       const float stepBiasA = (step == 0u) ? 0.0f : 1.0f;\n")
            else:
                s.append("       const uint stepBiasA = (step == 0u) ? 0u : 1u;\n")
        s.append("   if (subgroupElect()) {\n")
        for m in range(3):
            if m == 0 and tt in ("length", "constant"):
                continue
            if m == 1:
                if is_reduce(tt) or is_clamp(tt):
                    continue
                if tt in ("constant", "length", "convert_base", "convert", "convert_sat", "negate", "func", "func_const_in", "matrixtimesscalar", "multicomponent_load",
                          "multicomponent_save", "transpose_acc_to_a", "transpose_acc_to_b", "per_element_op", "per_element_op_mat", "per_element_op_struct",
                          "per_element_op_row_col", "spacetodepth"):
                    continue
            if m == 2 and not mm:
                continue
            shared_stride = strides[m] + " / workgroupsX"
            ci, cj = ("j", "i") if col_major else ("i", "j")
            s.append("       for (int i = 0; i < %s; ++i) {\n       for (int j = 0; j < %s; ++j) {\n" % (dims[m][0], dims[m][1]))
            s.append("           int localElementInput = (%s * %s + %s)%s;\n" % (strides[m], ci, cj, divs[m]))
            s.append("           int localElementShared = (%s * %s + %s)%s;\n           " % (shared_stride, ci, cj, divs[m]))
            if split_loop and m == 0:
                sbt = "float" if isfloat(it) else "uint"
                s.append("%s[elementS%d + localElementShared] = %s(%s(%s.x[element%d + localElementInput]) + stepBiasA)" % (names[m], m, it, sbt, inames[m], m))
            else:
                s.append("%s[elementS%d + localElementShared] = %s.x[element%d + localElementInput]" % (names[m], m, inames[m], m))
            s.append(";\n       }\n       }\n")
            strides[m] = shared_stride
        s.append("   }\n")
        s.append("   controlBarrier(%s, %s, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);\n" % (scope, scope))
    cm_nv = "true" if col_major else "false"
    cm_khr = "gl_CooperativeMatrixLayoutColumnMajor" if col_major else "gl_CooperativeMatrixLayoutRowMajor"
    colm = cm_khr if khr else cm_nv
    load_strides = [strides[0] + divs[0], strides[1] + divs[1], strides[2] + divs[2]]
    if tt == "matrixmuladd_stride0":
        load_strides = ["0", "0", "0"]
    clamp_string = CLAMP_MODE.get(tt, "")
    if not is_tl_test(tt):
        if addr != "linear":
            if is_clamp(tt):
                for i in range(3):
                    s.append("   tensorLayoutNV<2, %s> tensorLayout%d = createTensorLayoutNV(2, %s);\n" % (clamp_string, i, clamp_string))
                for i in range(3):
                    s.append("   tensorLayout%d = setTensorLayoutDimensionNV(tensorLayout%d, %s - 6, %s - 6);\n" % (i, i, heights[i], strides[i]))
                for i in range(3):
                    s.append("   tensorLayout%d = setTensorLayoutStrideNV(tensorLayout%d, %s, 1);\n" % (i, i, strides[i]))
                clamp_value = {F32: "floatBitsToUint(0.5)", F16: "0x3800", BF16: "0x3f00", E5M2: "0x38", E4M3: "0x30"}.get(it, "17")
                s.append("   tensorLayout0 = setTensorLayoutClampValueNV(tensorLayout0, %s);\n" % clamp_value)
            else:
                for i in range(3):
                    s.append("   tensorLayoutNV<2> tensorLayout%d = createTensorLayoutNV(2);\n" % i)
                if addr in ("blocksize", "decode"):
                    s.append("   tensorLayout0 = setTensorLayoutBlockSizeNV(tensorLayout0, %d, %d);\n   tensorLayout1 = setTensorLayoutBlockSizeNV(tensorLayout1, %d, %d);\n" % (bs0, bs1, bs0, bs1))
                for i in range(3):
                    s.append("   tensorLayout%d = setTensorLayoutDimensionNV(tensorLayout%d, %s, %s);\n" % (i, i, heights[i], strides[i]))
            view = ["", "", ""]
            decode_func = ""
            if tt == "matrixmuladd_stride0":
                for i in range(3):
                    if col_major:
                        s.append("   tensorViewNV<2, true, 1, 0> stride0View%d = createTensorViewNV(2, true, 1, 0);\n" % i)
                    else:
                        s.append("   tensorViewNV<2, true> stride0View%d = createTensorViewNV(2, true);\n" % i)
                for i in range(3):
                    s.append("   stride0View%d = setTensorViewDimensionsNV(stride0View%d, span%d0, span%d1);\n" % (i, i, i, i))
                for i in range(3):
                    s.append("   stride0View%d = setTensorViewStrideNV(stride0View%d, 0, 1);\n" % (i, i))
                view = [", stride0View%d" % i for i in range(3)]
            elif col_major:
                for i in range(3):
                    s.append("   tensorViewNV<2, true, 1, 0> colMajorView%d = createTensorViewNV(2, true, 1, 0);\n" % i)
                for i in range(3):
                    s.append("   colMajorView%d = setTensorViewDimensionsNV(colMajorView%d, span%d0, span%d1);\n" % (i, i, i, i))
                view = [", colMajorView%d" % i for i in range(3)]
            if addr == "decode":
                decode_func = ", decodeFunc"
            if wg_storage:
                if wg:
                    s.append("   elementS0 = elementS1 = elementS2 = 0;\n")
                for i in range(3):
                    s.append("   tensorLayout%d = sliceTensorLayoutNV(tensorLayout%d, 0, span%d0, 0, span%d1);\n" % (i, i, i, i))
                s.append("   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0%s);\n   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1%s);\n"
                         "   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2%s);\n" % (view[0], view[1], view[2]))
            else:
                for i in range(3):
                    s.append("   tensorLayout%d = sliceTensorLayoutNV(tensorLayout%d, offset%d0, span%d0, offset%d1, span%d1);\n" % (i, i, i, i, i, i))
                s.append("   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0%s%s);\n   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1%s%s);\n"
                         "   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2%s);\n" % (view[0], decode_func, view[1], decode_func, view[2]))
        elif wg_storage:
            s.append("   coopMatLoad%s(matA, sharedA, elementS0, %s, %s);\n   coopMatLoad%s(matB, sharedB, elementS1, %s, %s);\n   coopMatLoad%s(matC, sharedC, elementS2, %s, %s);\n"
                     % (suffix, load_strides[0], colm, suffix, load_strides[1], colm, suffix, load_strides[2], colm))
            if is_split(tt):
                s.append("   controlBarrierArrive();\n")
        else:
            s.append("   coopMatLoad%s(matA, inputA.x, element0, %s, %s);\n   coopMatLoad%s(matB, inputB.x, element1, %s, %s);\n   coopMatLoad%s(matC, inputC.x, element2, %s, %s);\n"
                     % (suffix, load_strides[0], colm, suffix, load_strides[1], colm, suffix, load_strides[2], colm))
    if tt in ("composite_array", "matrixmuladd_array"):
        s.append("   %s matAArr[2];\n    matAArr[1] = matA; matAArr[0] = %s(0.0);\n" % (matA, matA))
        s.append("   %s matBArr[2];\n    matBArr[1] = matB; matBArr[0] = %s(0.0);\n" % (matB, matB))
        s.append("   %s matCArr[2];\n    matCArr[1] = matC; matCArr[0] = %s(0.0);\n" % (matC, matC))
        s.append("   %s matOArr[2];\n" % matO)
    mma_call = lambda third: "coopMatMulAdd%s(matA, matB, %s%s)" % (suffix, third, sat)
    if tt == "length":
        s.append("   matO = %s(matO.length());\n" % matO)
    elif tt == "constant":
        s.append("   matO = matConst;\n")
    elif tt in ("convert_base", "convert"):
        s.append("   matO = %s(matA);\n" % matO)
    elif tt == "composite":
        s.append("   %s t = %s(matB[0]);\n   for (int i = 1; i < matA.length(); ++i) {\n       matO[i] = matA[i] + matB[i];\n   }\n"
                 "   if (matA.length() > 0)\n       matO[0] = matA[0] + t[0];\n" % (matA, matA))
    elif tt == "composite_rvalue":
        s.append("   for (int i = 1; i < matA.length(); ++i) {\n       matO[i] = matA[i];\n   }\n   %s t = matB;\n   if (matA.length() > 0) {\n       matO[0] = (t = matA)[0];\n   }\n" % matA)
    elif tt == "composite_array":
        s.append("   for (int i = 0; i < matA.length(); ++i) {\n       matOArr[1][i] = matAArr[1][i];\n   }\n")
    elif tt == "add":
        s.append("   matO = matA + matB;\n")
    elif tt == "sub":
        s.append("   matO = matA - matB;\n")
    elif tt == "div":
        s.append("   matO = matA / matB;\n")
    elif tt == "mul":
        s.append("   matO = matA * matB;\n")
    elif tt == "negate":
        s.append("   matO = -matA;\n")
    elif tt in ("func", "func_const_in"):
        s.append("   matO = f(matA);\n")
    elif is_clamp(tt):
        s.append("   matO = matA;\n")
    elif tt == "matrixtimesscalar":
        s.append("   matO = (%s(2.0)*matA)*%s(3.0);\n" % (tA, tA))
    elif tt in ("matrixmuladd_dequant", "matrixmuladd_stride0", "matrixmuladd_wrapping", "matrixmuladd_saturated", "matrixmuladd_push", "matrixmuladd"):
        s.append("   matO = %s;\n" % mma_call("matC"))
    elif tt == "matrixmuladd_split_barrier":
        s.append("   matO = %s;\n   controlBarrierWait();\n" % mma_call("matC"))
    elif tt == "matrixmuladd_split_barrier_loop":
        s.append("   if (step == 0u) {\n     matO = %s;\n   }\n   else {\n     matO = %s;\n   }\n   controlBarrierWait();\n}\n" % (mma_call("matC"), mma_call("matO")))
    elif tt == "matrixmuladd_split_barrier_skew":
        s.append("   if (step == 0u) {\n     matO = %s;\n   }\n   else {\n     matO = %s;\n   }\n" % (mma_call("matC"), mma_call("matO")))
        s.append("   if (gl_SubgroupID == 0u) {\n      uint splitSkewed = 1u;\n      // deliberately long private ALU path for subgroup 0 only\n"
                 "      for (uint spin = 0u; spin < 8192u; ++spin) {\n         splitSkewed += splitSkewed * 56u + gl_SubgroupInvocationID;\n      }\n"
                 "      if (subgroupElect())\n         atomicAdd(splitSkewedSink, splitSkewed);\n   }\n   controlBarrierWait();\n}\n")
    elif tt == "matrixmuladd_array":
        s.append("   matOArr[1] = coopMatMulAdd%s(matAArr[1], matBArr[1], matCArr[1]);\n" % suffix)
    elif tt in ("multicomponent_load", "multicomponent_save"):
        s.append("   matO = matA;\n")
    elif tt == "convert_sat":
        s.append("   saturatedConvertEXT(matO, matA);\n")
    elif tt == "getcoordinate":
        s.append("   for (int i = 0; i < matA.length(); ++i) {\n       uvec2 coord = coopMatGetCoordinateEXT(matA, i);\n       coord.x += M * matrixID.y;\n"
                 "       coord.y += N * matrixID.x;\n       uint coord1d = coord.y * 3 + coord.x;\n       matO[i] = %s(coord1d);\n   }\n" % ot)
    elif tt.startswith("transpose"):
        s.append("   coopMatTranspose%s(matO, matA);\n" % cm2_sfx)
    elif is_reduce(tt):
        kind = "2x2" if is_reduce_2x2(tt) else "Row" if is_reduce_row(tt) else "Column" if is_reduce_col(tt) else "RowAndColumn"
        s.append("   coopMatReduce%s(matO, matA, gl_CooperativeMatrixReduce%s%s, combineOp);\n" % (cm2_sfx, kind, cm2_sfx))
    elif tt == "per_element_op":
        s.append("   coopMatPerElement%s(matO, matA, elemOp, %s(2.0));\n" % (cm2_sfx, it))
    elif tt == "per_element_op_mat":
        s.append("   coopMatPerElement%s(matO, matA, elemOp, %s(2.0) * matA);\n" % (cm2_sfx, it))
    elif tt == "per_element_op_row_col":
        s.append("   coopMatPerElement%s(matO, matA, elemOpRowCol);\n" % cm2_sfx)
    elif tt == "per_element_op_struct":
        s.append("   ParamType p; p.x = %s(2.0);\n   coopMatPerElement%s(matO, matA, elemOp, p);\n" % (it, cm2_sfx))
    elif is_tl_test(tt) and tt != "spacetodepth":
        dim = tl_dim(tt)
        clip = tt.endswith("clip")
        tab = TL_TABLES[dim]
        s.append("   tensorLayoutNV<%d, gl_CooperativeMatrixClampModeConstantNV> t = createTensorLayoutNV(%d, gl_CooperativeMatrixClampModeConstantNV);\n" % (dim, dim))
        if clip:
            s.append("   tensorViewNV<%d> v = createTensorViewNV(%d);\n" % (dim, dim))
        for i in range(len(tab["load"])):
            factor = 2 if clip else 1
            mattype = "coopmat<%s, %s, %d, %d, %s>" % (it, scope, factor * tab["size"][i][0], factor * tab["size"][i][1], same_type)
            s.append("   %s tempmat%d;\n" % (mattype, i))
            s.append("   tempmat%d = %s(0.5);\n" % (i, mattype))
            if clip:
                d0, d1 = tab["size"][i]
                s.append("   v = setTensorViewClipNV(v, %d + 1, %d, %d + 1, %d);\n" % (d0, d0, d1, d1))
            s.append("   t = setTensorLayoutDimensionNV(t%s);\n" % "".join(", %d" % tab["dim"][j] for j in range(dim)))
            s.append("   t = sliceTensorLayoutNV(t%s);\n" % "".join(", %d, %d" % (tab["load"][i][j], tab["span"][i][j]) for j in range(dim)))
            s.append("   coopMatLoadTensorNV(tempmat%d, inputA.x, 0, t%s);\n" % (i, ", v" if clip else ""))
            s.append("   t = setTensorLayoutDimensionNV(t%s);\n" % "".join(", %d" % tab["dim"][j] for j in range(dim)))
            s.append("   t = sliceTensorLayoutNV(t%s);\n" % "".join(", %d, %d" % (tab["store"][i][j], tab["span"][i][j]) for j in range(dim)))
            s.append("   coopMatStoreTensorNV(tempmat%d, outputO.x, 0, t%s);\n" % (i, ", v" if clip else ""))
    elif tt == "spacetodepth":
        s.append("   const uint32_t H = 32;\n   const uint32_t W = 32;\n   const uint32_t NumCh = 16;\n")
        s.append("   tensorLayoutNV<3> t = createTensorLayoutNV(3);\n")
        s.append("   tensorViewNV<5, true, 0, 2, 1, 3, 4> v = createTensorViewNV(5, true, 0, 2, 1, 3, 4);\n")
        mattype = "coopmat<%s, %s, (H/2 * W/2), (4*NumCh),%s>" % (it, scope, same_type)
        s.append("   %s tempmat;\n   tempmat = %s(0.5);\n" % (mattype, mattype))
        s.append("   t = setTensorLayoutDimensionNV(t, H, W, NumCh);\n")
        s.append("   v = setTensorViewDimensionsNV(v, H/2, 2, W/2, 2, NumCh);\n")
        s.append("   coopMatLoadTensorNV(tempmat, inputA.x, 0, t, v);\n")
        s.append("   tensorLayoutNV<2> t2 = createTensorLayoutNV(2);\n")
        s.append("   t2 = setTensorLayoutDimensionNV(t2, H/2 * W/2, 4*NumCh);")
        s.append("   coopMatStoreTensorNV(tempmat, outputO.x, 0, t2);\n")
    else:
        raise SystemExit("unhandled test type " + tt)
    if not is_tl_test(tt):
        if tt in ("composite_array", "matrixmuladd_array"):
            s.append("   matOArr[0] = %s(0.0);\n   matO = matOArr[1];\n" % matO)
        if wg_storage:
            shared_stride = strides[3] + " / workgroupsX"
            if addr != "linear":
                s.append("   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);\n   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, %s, %s);\n"
                         "   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);\n" % (heights[3], shared_stride))
                s.append("   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);\n")
                if wg:
                    s.append("   elementS3 = 0;\n")
                s.append("   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3%s);\n" % (", colMajorView3" if col_major else ""))
            else:
                s.append("   coopMatStore%s(matO, sharedO, elementS3, %s%s, %s);\n" % (suffix, shared_stride, divs[3], colm))
            s.append("   controlBarrier(%s, %s, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);\n   if (subgroupElect()) {\n" % (scope, scope))
            ci, cj = ("j", "i") if col_major else ("i", "j")
            s.append("       for (int i = 0; i < %s; ++i) {\n       for (int j = 0; j < %s; ++j) {\n" % (dims[3][0], dims[3][1]))
            s.append("           int localElementInput = (%s * %s + %s)%s;\n" % (strides[3], ci, cj, divs[3]))
            s.append("           int localElementShared = (%s * %s + %s)%s;\n" % (shared_stride, ci, cj, divs[3]))
            s.append("           outputO.x[element3 + localElementInput] = sharedO[elementS3 + localElementShared];\n       }\n       }\n")
            s.append("   }\n")
        else:
            if addr != "linear":
                if is_clamp(tt):
                    s.append("   tensorLayoutNV<2, %s> tensorLayout3 = createTensorLayoutNV(2, %s);\n" % (clamp_string, clamp_string))
                    s.append("   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, %s - 1, %s - 1);\n" % (heights[3], strides[3]))
                    s.append("   tensorLayout3 = setTensorLayoutStrideNV(tensorLayout3, %s, 1);\n" % strides[3])
                else:
                    s.append("   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);\n   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, %s, %s);\n" % (heights[3], strides[3]))
                s.append("   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);\n")
                s.append("   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);\n")
                s.append("   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3%s);\n" % (", colMajorView3" if col_major else ""))
            else:
                s.append("   coopMatStore%s(matO, outputO.x, element3, %s%s, %s);\n" % (suffix, strides[3], divs[3], colm))
    s.append("}\n")
    return "".join(s)


def main():
    SRC.mkdir(parents=True, exist_ok=True)
    all_cases = cases()
    files = {}
    seen = set()
    needs_cm2 = lambda c: c["tt"] != "matrixmuladd_cross" and (c["scope"] == "workgroup" or c["addr"] != "linear" or is_tl_test(c["tt"]) or is_clamp(c["tt"]))
    for stem, wanted, title in (("compute_cooperative_matrix", lambda c: c["feat"] == "base" and not needs_cm2(c), "base feature set, subgroup scope, linear addressing"),
                                ("compute_cooperative_matrix_ext", lambda c: c["feat"] != "base" and not needs_cm2(c), "VK_NV_cooperative_matrix2 and VK_EXT_cooperative_matrix_maintenance1, subgroup scope, linear addressing"),
                                ("compute_cooperative_matrix_cm2", needs_cm2, "workgroup scope and tensor addressing (VK_NV_cooperative_matrix2)")):
        manifest = [
            "# Shader manifest for dEQP-VK.compute.*.cooperative_matrix.* (%s)." % title,
            "#",
            "# @generated by hodow_cts/scripts/gen_cooperative_matrix_manifest.py - do not hand-edit.",
            "",
            'upstream_source = "external/vulkancts/modules/vulkan/compute/vktComputeCooperativeMatrixTests.cpp"',
            'rust_module = "compute/cooperative_matrix_tests"',
            'spirv_version = "spirv1.6"',
            "",
        ]
        count = 0
        for n, c in enumerate(all_cases):
            if not wanted(c):
                continue
            assert c["key"] not in seen, c["key"]
            seen.add(c["key"])
            cross = c["tt"] == "matrixmuladd_cross"
            src = cross_asm(c) if cross else glsl(c)
            h = hashlib.sha1(src.encode()).hexdigest()[:16]
            files[h + (".spvasm" if cross else ".comp")] = src
            count += 1
            program = ('{ name = "test", template = "coopmat/%s.spvasm", stage = "asm", spirv_version = "spirv1.3" }' % h) if cross else \
                '{ name = "test", template = "coopmat/%s.comp", stage = "comp" }' % h
            manifest += ["[[case]]", 'name = "%s"' % c["key"], 'rust_const = "COOPMAT_%d"' % n, 'rust_type = "SharedProgram"', "programs = [%s]" % program, ""]
        (ROOT / "shaders" / "manifest" / (stem + ".toml")).write_text("\n".join(manifest))
        print(stem, count, "cases")
    for old in list(SRC.glob("*.comp")) + list(SRC.glob("*.spvasm")):
        if old.name not in files:
            old.unlink()
    for name, src in files.items():
        (SRC / name).write_text(src)
    print(len(files), "distinct shaders")


main()
