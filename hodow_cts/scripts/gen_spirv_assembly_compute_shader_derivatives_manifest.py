#!/usr/bin/env python3
"""Writes shaders/manifest/spirv_assembly_compute_shader_derivatives.toml: the cases of
dEQP-VK.spirv_assembly.instruction.compute.compute_shader_derivatives.{compute,mesh,task}.*
(vktSpvAsmComputeShaderDerivativesTests.cpp, 3 x 183 cases).

`ComputeShaderDerivativeCase::initPrograms` composes the assembly with two `tcu::StringTemplate` passes; this does the same in `specialize`
and writes the finished text of every program into the manifest. `--verify-tables` also checks the swapped-values formulas that
src/vkt/tests/spirv_assembly/compute_shader_derivatives_tests.rs uses against the explicit tables of the C++.

    python3 hodow_cts/scripts/gen_spirv_assembly_compute_shader_derivatives_manifest.py [--verify-tables]

A pure text generator: no spirv-as and no cargo.
"""

import json
import re
import sys
from pathlib import Path

CRATE = Path(__file__).resolve().parent.parent
CPP = CRATE / "upstream/external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmComputeShaderDerivativesTests.cpp"
OUT = CRATE / "shaders" / "manifest" / "spirv_assembly_compute_shader_derivatives.toml"
SOURCE = "external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmComputeShaderDerivativesTests.cpp"
TEMPLATE_DIR = CRATE / "shaders" / "src" / "spirv_assembly"

DERIVATIVE_VALUE, VERIFY_NDX, QUAD_OPERATIONS, LOD_SAMPLE, LOD_QUERY = range(5)
FLOAT32, VEC2_FLOAT32, VEC3_FLOAT32, VEC4_FLOAT32 = range(4)
LINEAR, QUADS = range(2)
NORMAL, FINE, COARSE = range(3)
BROADCAST, SWAP = range(2)
COMPUTE, MESH, TASK = range(3)

DATA_NAMES = ["float32", "vec2_float32", "vec3_float32", "vec4_float32"]
VARIANT_NAMES = ["normal", "fine", "coarse"]
SHADER_NAMES = ["compute", "mesh", "task"]
SWAP_NAMES = ["horizontal", "vertical", "diagonal"]
ALIGNED_SIZE = [4, 8, 16, 16]


def specialize(template, env, allow_missing=False):
    """`tcu::StringTemplate::specialize`: `${key}` and `${key:opt}`, one pass, the values are not scanned again."""

    def repl(m):
        key, opt = m.group(1), m.group(2)
        if key in env:
            return env[key]
        if opt:
            return ""
        if allow_missing:
            return m.group(0)
        raise SystemExit(f"template key {key} has no value")

    return re.sub(r"\$\{(\w+)(:opt)?\}", repl, template)


def data_type_name(t):
    return "%" + DATA_NAMES[t]


def array_declaration(t, size_const="%c_uint32_16"):
    return f"OpTypeArray {data_type_name(t)} {size_const}"


def derivative_capability(feature):
    return ["ComputeDerivativeGroupLinearKHR", "ComputeDerivativeGroupQuadsKHR"][feature]


def derivative_execution_mode(feature):
    return ["DerivativeGroupLinearKHR", "DerivativeGroupQuadsKHR"][feature]


def dx_func(var):
    return ["OpDPdx", "OpDPdxFine", "OpDPdxCoarse"][var]


def dy_func(var):
    return ["OpDPdy", "OpDPdyFine", "OpDPdyCoarse"][var]


def width_func(var):
    return ["OpFwidth", "OpFwidthFine", "OpFwidthCoarse"][var]


def test_value_code(feature, var, t):
    if var == FINE:
        lin = (
            "%masked_ndx_uint32    = OpBitwiseAnd  %uint32  %ndx_uint32 %c_uint32_3\n"
            "%masked_ndx_float32   = OpConvertUToF %float32 %masked_ndx_uint32\n"
            "%masked_ndx_2_float32 = OpFMul        %float32 %masked_ndx_float32 %masked_ndx_float32\n"
            "%scalar_value         = OpFMul        %float32 %c_float32_10 %masked_ndx_2_float32\n"
        )
        quad = (
            "%masked_ndx_uint32    = OpBitwiseAnd  %uint32  %ndx_uint32 %c_uint32_1\n"
            "%masked_ndy_uint32    = OpBitwiseAnd  %uint32  %ndy_uint32 %c_uint32_1\n"
            "%masked_ndx_float32   = OpConvertUToF %float32 %masked_ndx_uint32\n"
            "%masked_ndy_float32   = OpConvertUToF %float32 %masked_ndy_uint32\n"
            "%masked_ndx_2_float32 = OpFMul        %float32 %masked_ndx_float32 %masked_ndx_float32\n"
            "%masked_ndy_2_float32 = OpFMul        %float32 %masked_ndy_float32 %masked_ndy_float32\n"
            "%test_x               = OpFMul        %float32 %c_float32_10 %masked_ndx_2_float32\n"
            "%test_y               = OpFMul        %float32 %c_float32_20 %masked_ndy_2_float32\n"
            "%scalar_value         = OpFAdd        %float32 %test_x       %test_y\n"
        )
    else:
        lin = (
            "%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_3\n"
            "%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32\n"
            "%scalar_value       = OpFMul               %float32      %c_float32_10 %masked_ndx_float32\n"
        )
        quad = (
            "%masked_ndx_uint32  = OpBitwiseAnd         %uint32       %ndx_uint32 %c_uint32_1\n"
            "%masked_ndy_uint32  = OpBitwiseAnd         %uint32       %ndy_uint32 %c_uint32_1\n"
            "%masked_ndx_float32 = OpConvertUToF        %float32      %masked_ndx_uint32\n"
            "%masked_ndy_float32 = OpConvertUToF        %float32      %masked_ndy_uint32\n"
            "%test_x             = OpFMul               %float32      %c_float32_10 %masked_ndx_float32\n"
            "%test_y             = OpFMul               %float32      %c_float32_20 %masked_ndy_float32\n"
            "%scalar_value       = OpFAdd               %float32      %test_x       %test_y\n"
        )

    if t == FLOAT32:
        ndx = "%masked_ndx_2_float32" if var == FINE else "%masked_ndx_float32"
        lin += "%test_value  = OpFMul        %float32 %c_float32_10 " + ndx + "\n"
        quad += "%test_value = OpFAdd        %float32 %test_x       %test_y\n"
    elif t == VEC2_FLOAT32:
        lin += "%test_value  = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value\n"
        quad += "%test_value = OpCompositeConstruct %vec2_float32 %scalar_value %scalar_value\n"
    elif t == VEC3_FLOAT32:
        lin += "%test_value  = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value\n"
        quad += "%test_value = OpCompositeConstruct %vec3_float32 %scalar_value %scalar_value %scalar_value\n"
    else:
        lin += "%test_value  = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value\n"
        quad += "%test_value = OpCompositeConstruct %vec4_float32 %scalar_value %scalar_value %scalar_value %scalar_value\n"

    return lin if feature == LINEAR else quad


def linear_ndx_mul_by_type(test_type):
    if test_type == VERIFY_NDX:
        return "%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_32\n"
    return "%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 %c_uint32_4\n"


def store_ndx(wg):
    return "linear_ndx" if wg[1] > 1 else "ndx_uint32"


def gen_tex_coords(feature, mip):
    multiplier = "%c_float32_0_08" if mip == 0 else "%c_float32_0_10"
    s = (
        "%masked_ndx_uint32  = OpBitwiseAnd  %uint32  %ndx_uint32 %c_uint32_1\n"
        "%masked_ndx_float32 = OpConvertUToF %float32 %masked_ndx_uint32\n"
        "%masked_ndy_uint32  = OpBitwiseAnd  %uint32  %ndy_uint32 %c_uint32_1\n"
        "%masked_ndy_float32 = OpConvertUToF %float32 %masked_ndy_uint32\n"
    )
    if feature == LINEAR:
        s += "%test_value = OpFMul %float32 " + multiplier + " %masked_ndx_float32\n"
    else:
        s += "%scalar_x = OpFMul %float32 " + multiplier + " %masked_ndx_float32\n"
        s += "%scalar_y = OpFMul %float32 " + multiplier + " %masked_ndy_float32\n"
        if mip == 0:
            s += "%scalar_y_multi = OpFMul %float32 %scalar_y %c_float32_2\n"
        else:
            s += "%scalar_y_multi = OpFMul %float32 %scalar_y %c_float32_4\n"
        s += (
            "%scalar     = OpFAdd               %float32 %scalar_x %scalar_y_multi\n"
            "%test_value = OpCompositeConstruct %vec2_float32      %scalar %scalar\n"
        )
    return s


FRAGMENT = (
    "OpCapability Shader\n"
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint Fragment %main "main" %frag_color\n'
    "OpExecutionMode %main OriginUpperLeft\n"
    "OpDecorate %frag_color Location 0\n"
    "%void         = OpTypeVoid\n"
    "%void_func    = OpTypeFunction %void\n"
    "%float32      = OpTypeFloat    32\n"
    "%vec4_float32 = OpTypeVector   %float32 4\n"
    "%c_float32_0    = OpConstant %float32 0\n"
    "%c_float32_1    = OpConstant %float32 1\n"
    "%c_output_color = OpConstantComposite %vec4_float32 %c_float32_1 %c_float32_0 %c_float32_0 %c_float32_1\n"
    "%vec4_float32_output_ptr = OpTypePointer Output %vec4_float32\n"
    "%frag_color = OpVariable %vec4_float32_output_ptr Output\n"
    "%main       = OpFunction %void None %void_func\n"
    "%label_main = OpLabel\n"
    "              OpStore %frag_color %c_output_color\n"
    "              OpReturn\n"
    "              OpFunctionEnd\n"
)

MESH_OUTPUT_DECORATIONS = (
    "OpMemberDecorate %gl_MeshPerVertexEXT 0 BuiltIn Position\n"
    "OpMemberDecorate %gl_MeshPerVertexEXT 1 BuiltIn PointSize\n"
    "OpMemberDecorate %gl_MeshPerVertexEXT 2 BuiltIn ClipDistance\n"
    "OpMemberDecorate %gl_MeshPerVertexEXT 3 BuiltIn CullDistance\n"
    "OpDecorate       %gl_MeshPerVertexEXT Block\n"
)

MESH_OUTPUT_STORE = (
    "                      OpSetMeshOutputsEXT %c_uint32_3 %c_uint32_1\n"
    "%position_loc_0     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_0 %c_uint32_0\n"
    "                      OpStore       %position_loc_0          %c_vertex_0\n"
    "%position_loc_1     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_1 %c_uint32_0\n"
    "                      OpStore       %position_loc_1          %c_vertex_1\n"
    "%position_loc_2     = OpAccessChain %vec4_float32_output_ptr %gl_MeshVerticesEXT %c_uint32_2 %c_uint32_0\n"
    "                      OpStore       %position_loc_2          %c_vertex_2\n"
    "%indices_loc        = OpAccessChain %vec3_uint32_output_ptr  %gl_PrimitiveTriangleIndicesEXT %c_uint32_0\n"
    "                      OpStore       %indices_loc             %c_indices\n"
)

MESH_VERTEX_CONSTANTS = (
    "%c_vertex_0     = OpConstantComposite %vec4_float32 %c_float32_n0_5 %c_float32_n0_5 %c_float32_0 %c_float32_0\n"
    "%c_vertex_1     = OpConstantComposite %vec4_float32 %c_float32_0_5  %c_float32_n0_5 %c_float32_0 %c_float32_0\n"
    "%c_vertex_2     = OpConstantComposite %vec4_float32 %c_float32_0    %c_float32_0_5  %c_float32_0 %c_float32_0\n"
    "%c_indices      = OpConstantComposite %vec3_uint32  %c_uint32_0     %c_uint32_1     %c_uint32_2\n"
)

# `meshShaderStr`: the mesh shader that accompanies a task shader.
MESH_ONLY = (
    "OpCapability MeshShadingEXT\n"
    'OpExtension "SPV_EXT_mesh_shader"\n'
    "OpMemoryModel Logical GLSL450\n"
    'OpEntryPoint MeshEXT %main "main" %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT\n'
    "OpExecutionMode %main LocalSize 1 1 1\n"
    "OpExecutionMode %main OutputVertices 3\n"
    "OpExecutionMode %main OutputPrimitivesEXT 1\n"
    "OpExecutionMode %main OutputTrianglesEXT\n"
    + MESH_OUTPUT_DECORATIONS
    + "OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn PrimitiveTriangleIndicesEXT\n"
    "%void         = OpTypeVoid\n"
    "%void_func    = OpTypeFunction %void\n"
    "%uint32       = OpTypeInt      32      0\n"
    "%float32      = OpTypeFloat    32\n"
    "%vec3_uint32  = OpTypeVector   %uint32  3\n"
    "%vec2_float32 = OpTypeVector   %float32 2\n"
    "%vec3_float32 = OpTypeVector   %float32 3\n"
    "%vec4_float32 = OpTypeVector   %float32 4\n"
    "%c_uint32_0     = OpConstant          %uint32  0\n"
    "%c_uint32_1     = OpConstant          %uint32  1\n"
    "%c_uint32_2     = OpConstant          %uint32  2\n"
    "%c_uint32_3     = OpConstant          %uint32  3\n"
    "%c_uint32_4     = OpConstant          %uint32  4\n"
    "%c_uint32_16    = OpConstant          %uint32  16\n"
    "%c_uint32_32    = OpConstant          %uint32  32\n"
    "%c_uint32_128   = OpConstant          %uint32  128\n"
    "%c_float32_0    = OpConstant          %float32 0\n"
    "%c_float32_0_5  = OpConstant          %float32 0.5\n"
    "%c_float32_n0_5 = OpConstant          %float32 -0.5\n"
    "%c_float32_10   = OpConstant          %float32 10\n"
    "%c_float32_20   = OpConstant          %float32 20\n"
    + MESH_VERTEX_CONSTANTS
    + "%array_float32_1     = OpTypeArray %float32     %c_uint32_1\n"
    "%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1\n"
    "%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1\n"
    "%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3\n"
    "%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32\n"
    "%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32\n"
    "%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1\n"
    "%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3\n"
    "%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output\n"
    "%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output\n"
    "%main               = OpFunction %void None %void_func\n"
    "%label_main         = OpLabel\n"
    + MESH_OUTPUT_STORE
    + "                      OpReturn\n"
    "                      OpFunctionEnd\n"
)


def common_decorations(local_inv_var, local_inv_builtin, pad):
    return (
        f"OpDecorate      {local_inv_var}    BuiltIn     {local_inv_builtin}\n"
        "OpDecorate      %gl_SubgroupID           BuiltIn     SubgroupId\n"
        "OpDecorate      %gl_SubgroupInvocationID BuiltIn     SubgroupLocalInvocationId\n"
        "OpDecorate      %out_array               ArrayStride ${arrayStride}\n"
        "OpMemberDecorate %out_x 0 Offset 0\n"
        "OpDecorate       %out_x Block\n"
        "OpDecorate       %out_x_var DescriptorSet 0\n"
        "OpDecorate       %out_x_var Binding       0\n"
        "OpMemberDecorate %out_y 0 Offset 0\n"
        "OpDecorate       %out_y Block\n"
        "OpDecorate       %out_y_var DescriptorSet 0\n"
        "OpDecorate       %out_y_var Binding       1\n"
        "OpMemberDecorate %out_f 0 Offset 0\n"
        "OpDecorate       %out_f Block\n"
        "OpDecorate       %out_f_var DescriptorSet 0\n"
        "OpDecorate       %out_f_var Binding       2\n"
        "${decorations:opt}\n"
    )


COMPUTE_TYPES = (
    "%void         = OpTypeVoid\n"
    "%void_func    = OpTypeFunction %void\n"
    "%uint32       = OpTypeInt      32       0\n"
    "%vec3_uint32  = OpTypeVector   %uint32  3\n"
    "%float32      = OpTypeFloat    32\n"
    "%vec2_float32 = OpTypeVector   %float32 2\n"
    "%vec3_float32 = OpTypeVector   %float32 3\n"
    "%vec4_float32 = OpTypeVector   %float32 4\n"
)

UINT_CONSTANTS = (
    "%c_uint32_0     = OpConstant %uint32  0\n"
    "%c_uint32_1     = OpConstant %uint32  1\n"
    "%c_uint32_2     = OpConstant %uint32  2\n"
    "%c_uint32_3     = OpConstant %uint32  3\n"
    "%c_uint32_4     = OpConstant %uint32  4\n"
    "%c_uint32_16    = OpConstant %uint32  16\n"
    "%c_uint32_32    = OpConstant %uint32  32\n"
    "%c_uint32_128   = OpConstant %uint32  128\n"
)

FLOAT_CONSTANTS = (
    "%c_float32_2    = OpConstant %float32 2\n"
    "%c_float32_3    = OpConstant %float32 3\n"
    "%c_float32_4    = OpConstant %float32 4\n"
    "%c_float32_10   = OpConstant %float32 10\n"
    "%c_float32_20   = OpConstant %float32 20\n"
    "%c_float32_0_08 = OpConstant %float32 0.08\n"
    "%c_float32_0_10 = OpConstant %float32 0.10\n"
    "%c_float32_0_12 = OpConstant %float32 0.12\n"
)

MESH_FLOAT_CONSTANTS = (
    "%c_float32_0    = OpConstant          %float32 0\n"
    "%c_float32_0_5  = OpConstant          %float32 0.5\n"
    "%c_float32_n0_5 = OpConstant          %float32 -0.5\n"
)


def test_shader_template(shader, local_inv_var, local_inv_builtin, local_inv_type, extra_constants, ndx_ndy_calc):
    """`testShaderStr` of `initPrograms`, with the concatenated pieces already in and the `${...}` keys of the first pass left."""
    header_caps = (
        "OpCapability ${capability}\n"
        "${sampleCap:opt}\n"
        "${queryCap:opt}\n"
        "OpCapability DerivativeControl\n"
        "OpCapability GroupNonUniformQuad\n"
    )
    body_common_types = (
        "%out_array = ${arrayDeclaration}\n"
        if shader != MESH
        else "%out_array           = ${arrayDeclaration}\n%array_float32_1     = OpTypeArray %float32     %c_uint32_1\n%array_vec3_uint32_1 = OpTypeArray %vec3_uint32 %c_uint32_1\n"
    )
    structs = "%out_x = OpTypeStruct %out_array\n%out_y = OpTypeStruct %out_array\n%out_f = OpTypeStruct %out_array\n"
    ptrs = (
        "%uint32_input_ptr              = OpTypePointer Input         %uint32\n"
        "%vec3_uint32_input_ptr         = OpTypePointer Input         %vec3_uint32\n"
        "%out_x_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_x\n"
        "%out_y_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_y\n"
        "%out_f_storage_buffer_ptr      = OpTypePointer StorageBuffer %out_f\n"
        "${dataType}_storage_buffer_ptr = OpTypePointer StorageBuffer ${dataType}\n"
    )
    variables = (
        f"{local_inv_var}    = OpVariable {local_inv_type}    Input\n"
        "%gl_SubgroupID           = OpVariable %uint32_input_ptr         Input\n"
        "%gl_SubgroupInvocationID = OpVariable %uint32_input_ptr         Input\n"
        "%out_x_var               = OpVariable %out_x_storage_buffer_ptr StorageBuffer\n"
        "%out_y_var               = OpVariable %out_y_storage_buffer_ptr StorageBuffer\n"
        "%out_f_var               = OpVariable %out_f_storage_buffer_ptr StorageBuffer\n"
    )
    main = (
        "%main               = OpFunction %void None %void_func\n"
        "%label_main         = OpLabel\n"
        + ndx_ndy_calc
        + "${linearNdxMul}\n"
        "%linear_ndx             = OpIAdd        %uint32           %ndx_uint32 %multi_ndy_uint32\n"
        "${testValueCode:opt}\n"
        "${testLogicCode}\n"
        "${storeCode}\n"
    )

    if shader == COMPUTE:
        return (
            "OpCapability Shader\n"
            + header_caps
            + 'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
            'OpExtension "SPV_KHR_compute_shader_derivatives"\n'
            "OpMemoryModel Logical GLSL450\n"
            f'OpEntryPoint GLCompute %main "main" {local_inv_var} %gl_SubgroupID %gl_SubgroupInvocationID\n'
            "OpExecutionMode %main LocalSize ${x} ${y} ${z}\n"
            "OpExecutionMode %main ${executionMode}\n"
            + common_decorations(local_inv_var, local_inv_builtin, "")
            + COMPUTE_TYPES
            + UINT_CONSTANTS
            + FLOAT_CONSTANTS
            + extra_constants
            + body_common_types
            + structs
            + ptrs
            + variables
            + "${images:opt}\n"
            + main
            + "                      OpReturn\n"
            "                      OpFunctionEnd\n"
        )
    if shader == MESH:
        return (
            "OpCapability MeshShadingEXT\n"
            + header_caps
            + 'OpExtension "SPV_EXT_mesh_shader"\n'
            'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
            'OpExtension "SPV_KHR_compute_shader_derivatives"\n'
            "OpMemoryModel Logical GLSL450\n"
            f'OpEntryPoint MeshEXT %main "main" %out_x_var %out_y_var %out_f_var {local_inv_var} %gl_SubgroupID '
            "%gl_SubgroupInvocationID ${interface:opt} %gl_MeshVerticesEXT %gl_PrimitiveTriangleIndicesEXT\n"
            "OpExecutionMode %main LocalSize ${x} ${y} ${z}\n"
            "OpExecutionMode %main ${executionMode}\n"
            "OpExecutionMode %main OutputVertices 3\n"
            "OpExecutionMode %main OutputPrimitivesEXT 1\n"
            "OpExecutionMode %main OutputTrianglesEXT\n"
            + MESH_OUTPUT_DECORATIONS
            + "OpDecorate       %gl_PrimitiveTriangleIndicesEXT BuiltIn     PrimitiveTriangleIndicesEXT\n"
            + common_decorations(local_inv_var, local_inv_builtin, "")
            + COMPUTE_TYPES
            + UINT_CONSTANTS
            + MESH_FLOAT_CONSTANTS
            + FLOAT_CONSTANTS
            + MESH_VERTEX_CONSTANTS
            + extra_constants
            + body_common_types
            + structs
            + "%gl_MeshPerVertexEXT = OpTypeStruct %vec4_float32 %float32 %array_float32_1 %array_float32_1\n"
            "%array_gl_MeshPerVertexEXT_3 = OpTypeArray %gl_MeshPerVertexEXT %c_uint32_3\n"
            + ptrs
            + "%vec4_float32_output_ptr                = OpTypePointer Output        %vec4_float32\n"
            "%vec3_uint32_output_ptr                 = OpTypePointer Output        %vec3_uint32\n"
            "%array_vec3_uint32_output_ptr           = OpTypePointer Output        %array_vec3_uint32_1\n"
            "%array_gl_MeshPerVertexEXT_3_output_ptr = OpTypePointer Output        %array_gl_MeshPerVertexEXT_3\n"
            + variables
            + "%gl_MeshVerticesEXT             = OpVariable %array_gl_MeshPerVertexEXT_3_output_ptr Output\n"
            "%gl_PrimitiveTriangleIndicesEXT = OpVariable %array_vec3_uint32_output_ptr           Output\n"
            "${images:opt}\n"
            + main
            + MESH_OUTPUT_STORE
            + "                      OpReturn\n"
            "                      OpFunctionEnd\n"
        )
    return (
        "OpCapability MeshShadingEXT\n"
        + header_caps
        + 'OpExtension "SPV_KHR_storage_buffer_storage_class"\n'
        'OpExtension "SPV_KHR_compute_shader_derivatives"\n'
        'OpExtension "SPV_EXT_mesh_shader"\n'
        "OpMemoryModel Logical GLSL450\n"
        f'OpEntryPoint TaskEXT %main "main" %out_x_var %out_y_var %out_f_var {local_inv_var} %gl_SubgroupID '
        "%gl_SubgroupInvocationID ${interface:opt}\n"
        "OpExecutionMode %main LocalSize ${x} ${y} ${z}\n"
        "OpExecutionMode %main ${executionMode}\n"
        + common_decorations(local_inv_var, local_inv_builtin, "")
        + COMPUTE_TYPES.replace("%uint32       = OpTypeInt      32       0", "%uint32       = OpTypeInt      32      0")
        + UINT_CONSTANTS
        + FLOAT_CONSTANTS
        + extra_constants
        + body_common_types
        + structs
        + ptrs
        + variables
        + "${images:opt}\n"
        + main
        + "                      OpEmitMeshTasksEXT %c_uint32_1 %c_uint32_1 %c_uint32_1\n"
        "                      OpFunctionEnd\n"
    )


IMAGES = (
    "%image         = OpTypeImage        %float32 ${dim} 0 0 0 1 Unknown\n"
    "%sampled_image = OpTypeSampledImage %image\n"
    "%float32_uniform_constant_ptr       = OpTypePointer UniformConstant %float32\n"
    "%sampled_image_uniform_constant_ptr = OpTypePointer UniformConstant %sampled_image\n"
    "%sampled_image_var    = OpVariable %sampled_image_uniform_constant_ptr UniformConstant\n"
)

SAMPLED_DECORATIONS = (
    "OpDecorate       %sampled_image_var DescriptorSet 0\n"
    "OpDecorate       %sampled_image_var Binding       4\n"
)


def build_programs(p):
    """The (name, assembly, spirv version) list `initPrograms` adds for the case `p`."""
    wg = (p["wg_x"], p["wg_y"], p["wg_z"])
    feature, test_type, shader = p["feature"], p["test_type"], p["shader"]
    need_extra = test_type == DERIVATIVE_VALUE and feature == QUADS and not p["local_inv"]
    arr_size_const = "%c_arr_size"

    if p["local_inv"]:
        local_inv_var = "%gl_LocalInvocationIndex"
        local_inv_builtin = "LocalInvocationIndex"
        local_inv_type = "%uint32_input_ptr"
        extra = "%wg_size_x = OpConstant %uint32 ${x}\n%wg_size_y = OpConstant %uint32 ${y}\n"
        ndx_ndy = (
            "%inv_index = OpLoad %uint32 %gl_LocalInvocationIndex\n"
            "%ndx_uint32 = OpUMod %uint32 %inv_index %wg_size_x\n"
            "%row_index = OpUDiv %uint32 %inv_index %wg_size_x\n"
            "%ndy_uint32 = OpUMod %uint32 %row_index %wg_size_y\n"
        )
        wg_x_const = ""
    else:
        local_inv_var = "%gl_LocalInvocationID"
        local_inv_builtin = "LocalInvocationId"
        local_inv_type = "%vec3_uint32_input_ptr"
        extra = "%c_wg_x = OpConstant %uint32 ${x}\n" if need_extra else ""
        ndx_ndy = (
            "%gl_LocalInvocationID_x = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_0\n"
            "%ndx_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_x\n"
            "%gl_LocalInvocationID_y = OpAccessChain %uint32_input_ptr %gl_LocalInvocationID   %c_uint32_1\n"
            "%ndy_uint32             = OpLoad        %uint32           %gl_LocalInvocationID_y\n"
        )
        wg_x_const = "%c_wg_x"

    total = wg[0] * wg[1] * wg[2]
    if need_extra:
        extra += f"%c_arr_size = OpConstant %uint32 {total}\n"

    template = test_shader_template(shader, local_inv_var, local_inv_builtin, local_inv_type, extra, ndx_ndy)
    env = {
        "x": str(wg[0]),
        "y": str(wg[1]),
        "z": str(wg[2]),
        "capability": derivative_capability(feature),
        "executionMode": derivative_execution_mode(feature),
    }
    second = {}
    dt = p["data_type"]
    if test_type == DERIVATIVE_VALUE:
        env["arrayStride"] = str(ALIGNED_SIZE[dt])
        env["arrayDeclaration"] = array_declaration(dt, arr_size_const) if need_extra else array_declaration(dt)
        env["testValueCode"] = test_value_code(feature, p["variant"], dt)
        env["dataType"] = data_type_name(dt)
        env["linearNdxMul"] = (
            f"%multi_ndy_uint32 = OpIMul %uint32 %ndy_uint32 {wg_x_const}\n" if need_extra else linear_ndx_mul_by_type(test_type)
        )
        env["testLogicCode"] = (
            "%dx                 = ${dxFunc}     ${dataType}       %test_value\n"
            "%dy                 = ${dyFunc}     ${dataType}       %test_value\n"
            "%fwidth             = ${dwidthFunc} ${dataType}       %test_value\n"
        )
        env["storeCode"] = (
            "%out_x_loc          = OpAccessChain ${dataType}_storage_buffer_ptr %out_x_var %c_uint32_0 %${storeNdx}\n"
            "                      OpStore       %out_x_loc                     %dx\n"
            "%out_y_loc          = OpAccessChain ${dataType}_storage_buffer_ptr %out_y_var %c_uint32_0 %${storeNdx}\n"
            "                      OpStore       %out_y_loc                     %dy\n"
            "%out_f_loc          = OpAccessChain ${dataType}_storage_buffer_ptr %out_f_var %c_uint32_0 %${storeNdx}\n"
            "                      OpStore       %out_f_loc                     %fwidth\n"
        )
        second = {
            "dataType": data_type_name(dt),
            "dxFunc": dx_func(p["variant"]),
            "dyFunc": dy_func(p["variant"]),
            "dwidthFunc": width_func(p["variant"]),
            "storeNdx": store_ndx(wg),
        }
    elif test_type == VERIFY_NDX:
        env["arrayDeclaration"] = "OpTypeArray %uint32 %c_uint32_128"
        env["arrayStride"] = "4"
        env["dataType"] = "%uint32"
        env["linearNdxMul"] = linear_ndx_mul_by_type(test_type)
        env["testLogicCode"] = (
            "%gl_SubgroupID_loc           = OpAccessChain %uint32_input_ptr          %gl_SubgroupID\n"
            "%subgroup_val                = OpLoad        %uint32                    %gl_SubgroupID_loc\n"
            "%subgroup_loc                = OpAccessChain %uint32_storage_buffer_ptr %out_x_var      %c_uint32_0 %${storeNdx}\n"
            "%gl_SubgroupInvocationID_loc = OpAccessChain %uint32_input_ptr          %gl_SubgroupInvocationID\n"
            "%invocation_val              = OpLoad        %uint32                    %gl_SubgroupInvocationID_loc\n"
            "%rem_val                     = OpSRem        %uint32                    %invocation_val %c_uint32_4\n"
            "%invocation_loc              = OpAccessChain %uint32_storage_buffer_ptr %out_y_var    %c_uint32_0 %${storeNdx}\n"
        )
        env["storeCode"] = (
            "            OpStore       %subgroup_loc              %subgroup_val\n"
            "            OpStore       %invocation_loc            %rem_val\n"
        )
        second = {"storeNdx": store_ndx(wg)}
    elif test_type == QUAD_OPERATIONS:
        env["arrayStride"] = str(ALIGNED_SIZE[dt])
        env["arrayDeclaration"] = array_declaration(dt)
        env["dataType"] = data_type_name(dt)
        env["linearNdxMul"] = linear_ndx_mul_by_type(test_type)
        env["testValueCode"] = test_value_code(feature, NORMAL, dt)
        env["testLogicCode"] = "%store_value = ${quadOp} ${dataType} %c_uint32_3 %test_value %${quadNdx}\n"
        env["storeCode"] = (
            "%out_x_loc = OpAccessChain ${dataType}_storage_buffer_ptr %out_x_var %c_uint32_0 %${storeNdx}\n"
            "             OpStore       %out_x_loc                     %store_value\n"
        )
        second = {
            "storeNdx": store_ndx(wg),
            "quadOp": ["OpGroupNonUniformQuadBroadcast", "OpGroupNonUniformQuadSwap"][p["quad_op"]],
            "quadNdx": f"c_uint32_{p['quad_ndx']}",
            "dataType": data_type_name(dt),
        }
    else:
        sample = test_type == LOD_SAMPLE
        vec = VEC4_FLOAT32 if sample else VEC2_FLOAT32
        env["sampleCap"] = "OpCapability Sampled1D" if feature == LINEAR else ""
        if not sample:
            env["queryCap"] = "OpCapability ImageQuery\n"
        env["interface"] = "%sampled_image_var"
        env["dataType"] = data_type_name(vec)
        env["linearNdxMul"] = linear_ndx_mul_by_type(test_type)
        env["arrayDeclaration"] = array_declaration(vec)
        env["arrayStride"] = str(ALIGNED_SIZE[vec])
        env["decorations"] = SAMPLED_DECORATIONS
        env["images"] = IMAGES
        env["testValueCode"] = gen_tex_coords(feature, p["mip_lvl"])
        if sample:
            env["testLogicCode"] = (
                "%sampled_image_loc = OpLoad                   %sampled_image %sampled_image_var\n"
                "%store_value       = OpImageSampleImplicitLod %vec4_float32  %sampled_image_loc %test_value\n"
            )
            env["storeCode"] = (
                "%out_x_loc = OpAccessChain %vec4_float32_storage_buffer_ptr   %out_x_var     %c_uint32_0 %${storeNdx}\n"
                "             OpStore       %out_x_loc %store_value\n"
            )
        else:
            env["testLogicCode"] = (
                "%sampled_image_loc = OpLoad %sampled_image %sampled_image_var\n"
                "%store_value       = OpImageQueryLod %vec2_float32 %sampled_image_loc %test_value\n"
            )
            env["storeCode"] = (
                "%out_x_loc         = OpAccessChain %vec2_float32_storage_buffer_ptr   %out_x_var     %c_uint32_0 %${storeNdx}\n"
                "                     OpStore       %out_x_loc %store_value\n"
            )
        second = {"dim": "1D" if feature == LINEAR else "2D", "storeNdx": store_ndx(wg)}

    first_pass = specialize(template, env)
    text = specialize(first_pass, second, allow_missing=True)
    if re.search(r"\$\{", text):
        raise SystemExit(f"unresolved key in {p['name']}: {re.search(r'.{40}[$][{].{30}', text, re.S)}")

    if shader == COMPUTE:
        return [("compute", text, "spirv1.3")]
    if shader == MESH:
        return [("mesh", text, "spirv1.4"), ("fragment", FRAGMENT, "spirv1.3")]
    return [("mesh", MESH_ONLY, "spirv1.4"), ("task", text, "spirv1.4"), ("fragment", FRAGMENT, "spirv1.3")]


def case(shader, rel, **kw):
    base = dict(
        shader=shader,
        wg_x=1,
        wg_y=1,
        wg_z=1,
        test_type=0,
        variant=0,
        feature=0,
        quad_op=0,
        quad_ndx=0,
        data_type=0,
        mip_lvl=0,
        local_inv=False,
    )
    base.update(kw)
    base["name"] = f"compute_shader_derivatives/{SHADER_NAMES[shader]}/{rel}"
    return base


def build_cases():
    cases = []
    for shader in (COMPUTE, MESH, TASK):
        for variant in (NORMAL, FINE, COARSE):
            for dt in range(4):
                prefix = f"derivative_value/{VARIANT_NAMES[variant]}/{DATA_NAMES[dt]}"
                common = dict(test_type=DERIVATIVE_VALUE, variant=variant, data_type=dt)
                cases.append(case(shader, f"{prefix}/linear/16_1_1", wg_x=16, feature=LINEAR, **common))
                cases.append(case(shader, f"{prefix}/linear/4_4_1", wg_x=4, wg_y=4, feature=LINEAR, **common))
                for x, y in ((4, 4), (4, 8), (8, 4), (8, 8)):
                    cases.append(case(shader, f"{prefix}/quads/{x}_{y}_1", wg_x=x, wg_y=y, feature=QUADS, **common))
                cases.append(
                    case(shader, f"{prefix}/quads/4_4_1_local_inv_index", wg_x=4, wg_y=4, feature=QUADS, local_inv=True, **common)
                )

        cases.append(case(shader, "verify_ndx/linear/128_1_1", wg_x=128, test_type=VERIFY_NDX, feature=LINEAR))
        cases.append(case(shader, "verify_ndx/linear/32_4_1", wg_x=32, wg_y=4, test_type=VERIFY_NDX, feature=LINEAR))
        cases.append(case(shader, "verify_ndx/quads/32_4_1", wg_x=32, wg_y=4, test_type=VERIFY_NDX, feature=QUADS))

        for op, op_name, count in ((BROADCAST, "broadcast", 4), (SWAP, "swap", 3)):
            for dt in range(4):
                prefix = f"quad_op/{op_name}/{DATA_NAMES[dt]}"
                common = dict(test_type=QUAD_OPERATIONS, quad_op=op, data_type=dt)
                for ndz in range(count):
                    leaf = f"ndx_{ndz}" if op == BROADCAST else SWAP_NAMES[ndz]
                    cases.append(case(shader, f"{prefix}/linear/16_1_1/{leaf}", wg_x=16, quad_ndx=ndz, feature=LINEAR, **common))
                    cases.append(case(shader, f"{prefix}/linear/4_4_1/{leaf}", wg_x=4, wg_y=4, quad_ndx=ndz, feature=LINEAR, **common))
                for ndz in range(count):
                    leaf = f"ndx_{ndz}" if op == BROADCAST else SWAP_NAMES[ndz]
                    cases.append(case(shader, f"{prefix}/quads/4_4_1/{leaf}", wg_x=4, wg_y=4, quad_ndx=ndz, feature=QUADS, **common))

        for test_type, group, dt in ((LOD_SAMPLE, "sample", VEC4_FLOAT32), (LOD_QUERY, "query", VEC2_FLOAT32)):
            for mip in range(2):
                common = dict(test_type=test_type, data_type=dt, mip_lvl=mip)
                cases.append(case(shader, f"lod_op/{group}/linear/16_1_1/mip_{mip}", wg_x=16, feature=LINEAR, **common))
                cases.append(case(shader, f"lod_op/{group}/linear/4_4_1/mip_{mip}", wg_x=4, wg_y=4, feature=LINEAR, **common))
            for mip in range(2):
                common = dict(test_type=test_type, data_type=dt, mip_lvl=mip)
                cases.append(case(shader, f"lod_op/{group}/quads/4_4_1/mip_{mip}", wg_x=4, wg_y=4, feature=QUADS, **common))
    return cases


def py(value):
    return json.dumps(repr(value))


def const_name(name):
    return "CSD_" + re.sub(r"[^A-Za-z0-9]", "_", name).upper()


def write_manifest():
    cases = build_cases()
    names = [c["name"] for c in cases]
    assert len(names) == len(set(names)), "duplicate case names"
    header = (
        "# Shader manifest for dEQP-VK.spirv_assembly.instruction.compute.compute_shader_derivatives.*\n#\n"
        "# @generated by hodow_cts/scripts/gen_spirv_assembly_compute_shader_derivatives_manifest.py - do not hand-edit.\n\n"
        f'upstream_source = "{SOURCE}"\nrust_module = "spirv_assembly/compute_shader_derivatives_tests"\n'
    )
    entries = []
    templates = {}
    for c in cases:
        programs = build_programs(c)
        prog_toml = []
        derived = []
        for pname, text, version in programs:
            template = f"spirv_assembly/csd_{pname}.asm"
            templates[template] = "${csd_" + pname + "}"
            prog_toml.append(f'{{ name = "{pname}", template = "{template}", stage = "asm", spirv_version = "{version}" }}')
            derived.append(f"csd_{pname} = {py(text)}")
        params = (
            f'wg_x = {{ type = "u32", value = {c["wg_x"]} }}, wg_y = {{ type = "u32", value = {c["wg_y"]} }}, '
            f'wg_z = {{ type = "u32", value = {c["wg_z"]} }}, test_type = {{ type = "u32", value = {c["test_type"]} }}, '
            f'variant = {{ type = "u32", value = {c["variant"]} }}, feature = {{ type = "u32", value = {c["feature"]} }}, '
            f'quad_op = {{ type = "u32", value = {c["quad_op"]} }}, quad_ndx = {{ type = "u32", value = {c["quad_ndx"]} }}, '
            f'data_type = {{ type = "u32", value = {c["data_type"]} }}, mip_lvl = {{ type = "u32", value = {c["mip_lvl"]} }}, '
            f'shader_type = {{ type = "u32", value = {c["shader"]} }}, '
            f'use_local_invocation_index = {{ type = "bool", value = {"true" if c["local_inv"] else "false"} }}'
        )
        entries.append(
            f'\n[[case]]\nname = "{c["name"]}"\nrust_const = "{const_name(c["name"])}"\nrust_type = "ComputeShaderDerivativesCase"\n'
            f"programs = [ {', '.join(prog_toml)} ]\nparams = {{ {params} }}\nderived = {{ {', '.join(derived)} }}\n"
        )
    OUT.write_text(header + "".join(entries))
    for template, text in templates.items():
        (TEMPLATE_DIR / template.split("/", 1)[1]).write_text(text)
    print(f"{len(cases)} cases -> {OUT}", file=sys.stderr)


def verify_tables():
    src = CPP.read_text()
    funcs = {}
    for name, op in (("getHorizontallySwappedValues", 0), ("getVerticallySwappedValues", 1), ("getDiagonallySwappedValues", 2)):
        start = src.index(f"std::vector<float> {name}(")
        end = src.index("\n}\n", start)
        body = src[start:end]
        blocks = re.findall(r"case DataType::(\w+):\s*\{(.*?)break;\s*\}", body, re.S)
        assert len(blocks) == 8, (name, len(blocks))
        for i, (dtname, block) in enumerate(blocks):
            feature = LINEAR if i < 4 else QUADS
            dt = ["FLOAT32", "VEC2_FLOAT32", "VEC3_FLOAT32", "VEC4_FLOAT32"].index(dtname)
            assigned = {int(m.group(1)): float(m.group(2)) for m in re.finditer(r"swapped\[(\d+)\]\s*=\s*([\d.]+)f;", block)}
            period_m = re.search(r"for \(uint32_t ndx = (\d+); ndx < elemCnt; \+\+ndx\)\s*\{\s*swapped\[ndx\] = swapped\[ndx - (\d+)\];", block)
            period = int(period_m.group(2))
            zero_pad = "% 4 == 0" in block
            funcs[(op, feature, dt)] = (assigned, period, zero_pad)
    bad = 0
    for (op, feature, dt), (assigned, period, zero_pad) in sorted(funcs.items()):
        explicit = [assigned[i] for i in range(period)]
        comps = [1, 2, 4, 4][dt]
        model = []
        for lane in range(period // comps):
            if feature == LINEAR:
                q = lane & 3
                partner = lane - q + (q ^ [1, 2, 3][op])
                value = 10.0 * (partner & 3)
            else:
                x, y = lane % 4, lane // 4
                sx, sy = [(1, 0), (0, 1), (1, 1)][op]
                value = 10.0 * ((x ^ sx) & 1) + 20.0 * ((y ^ sy) & 1)
            model.extend([value] * comps)
        if zero_pad:
            model = [0.0 if (i + 1) % 4 == 0 else v for i, v in enumerate(model)]
        if zero_pad:
            explicit = [0.0 if (i + 1) % 4 == 0 else v for i, v in enumerate(explicit)]
        status = "ok" if model == explicit else "MISMATCH"
        if status == "MISMATCH":
            bad += 1
        print(op, "lin" if feature == LINEAR else "quad", DATA_NAMES[dt], "period", period, "pad0", zero_pad, status)
        if status == "MISMATCH":
            print("   ", explicit)
    print("mismatches:", bad)


if __name__ == "__main__":
    if "--verify-tables" in sys.argv:
        verify_tables()
    else:
        write_manifest()
