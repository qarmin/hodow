#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_split_barrier : enable
#extension GL_NV_cooperative_matrix2 : enable
#extension GL_EXT_bfloat16 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_bfloat16 : enable
// strides overriden by spec constants
layout(constant_id = 2) const int AStride = 1;
layout(constant_id = 3) const int BStride = 1;
layout(constant_id = 4) const int CStride = 1;
layout(constant_id = 5) const int OStride = 1;
layout(constant_id = 6) const int M = 1;
layout(constant_id = 7) const int N = 1;
layout(constant_id = 8) const int K = 1;
layout(local_size_x_id = 0, local_size_y_id = 1, local_size_z = 1) in;
const int workgroupsX = 1;
struct StructA { uint8_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseA> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseA> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseA> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (N * 1 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 1 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 1 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 1 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<3, gl_CooperativeMatrixClampModeConstantNV> t = createTensorLayoutNV(3, gl_CooperativeMatrixClampModeConstantNV);
   tensorViewNV<3> v = createTensorViewNV(3);
   coopmat<uint8_t, gl_ScopeWorkgroup, 128, 64, gl_MatrixUseA> tempmat0;
   tempmat0 = coopmat<uint8_t, gl_ScopeWorkgroup, 128, 64, gl_MatrixUseA>(0.5);
   v = setTensorViewClipNV(v, 64 + 1, 64, 32 + 1, 32);
   t = setTensorLayoutDimensionNV(t, 33, 44, 55);
   t = sliceTensorLayoutNV(t, 1, 16, 1, 16, 1, 8);
   coopMatLoadTensorNV(tempmat0, inputA.x, 0, t, v);
   t = setTensorLayoutDimensionNV(t, 33, 44, 55);
   t = sliceTensorLayoutNV(t, 2, 16, 2, 16, 2, 8);
   coopMatStoreTensorNV(tempmat0, outputO.x, 0, t, v);
   coopmat<uint8_t, gl_ScopeWorkgroup, 64, 64, gl_MatrixUseA> tempmat1;
   tempmat1 = coopmat<uint8_t, gl_ScopeWorkgroup, 64, 64, gl_MatrixUseA>(0.5);
   v = setTensorViewClipNV(v, 32 + 1, 32, 32 + 1, 32);
   t = setTensorLayoutDimensionNV(t, 33, 44, 55);
   t = sliceTensorLayoutNV(t, -1, 8, -1, 4, -1, 32);
   coopMatLoadTensorNV(tempmat1, inputA.x, 0, t, v);
   t = setTensorLayoutDimensionNV(t, 33, 44, 55);
   t = sliceTensorLayoutNV(t, 23, 8, 2, 4, 1, 32);
   coopMatStoreTensorNV(tempmat1, outputO.x, 0, t, v);
}
