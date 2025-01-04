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
const int workgroupsX = 4;
struct StructA { floate5m2_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate5m2_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseA> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseA> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseA> matO;
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
   offset00 -= 3; offset01 -= 3;
   offset10 -= 3; offset11 -= 3;
   offset20 -= 3; offset21 -= 3;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2, gl_CooperativeMatrixClampModeClampToEdgeNV> tensorLayout0 = createTensorLayoutNV(2, gl_CooperativeMatrixClampModeClampToEdgeNV);
   tensorLayoutNV<2, gl_CooperativeMatrixClampModeClampToEdgeNV> tensorLayout1 = createTensorLayoutNV(2, gl_CooperativeMatrixClampModeClampToEdgeNV);
   tensorLayoutNV<2, gl_CooperativeMatrixClampModeClampToEdgeNV> tensorLayout2 = createTensorLayoutNV(2, gl_CooperativeMatrixClampModeClampToEdgeNV);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4 - 6, N * 4 - 6);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4 - 6, N * 4 - 6);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4 - 6, N * 4 - 6);
   tensorLayout0 = setTensorLayoutStrideNV(tensorLayout0, N * 4, 1);
   tensorLayout1 = setTensorLayoutStrideNV(tensorLayout1, N * 4, 1);
   tensorLayout2 = setTensorLayoutStrideNV(tensorLayout2, N * 4, 1);
   tensorLayout0 = setTensorLayoutClampValueNV(tensorLayout0, 0x38);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = matA;
   tensorLayoutNV<2, gl_CooperativeMatrixClampModeClampToEdgeNV> tensorLayout3 = createTensorLayoutNV(2, gl_CooperativeMatrixClampModeClampToEdgeNV);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4 - 1, N * 4 - 1);
   tensorLayout3 = setTensorLayoutStrideNV(tensorLayout3, N * 4, 1);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3);
}
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
const int workgroupsX = 4;
struct StructA { floate5m2_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { floate5m2_t x[]; };
layout(buffer_reference) buffer InputC { floate5m2_t x[]; };
layout(buffer_reference) buffer Output { floate5m2_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseA> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseA> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseA> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   offset00 -= 3; offset01 -= 3;
   offset10 -= 3; offset11 -= 3;
   offset20 -= 3; offset21 -= 3;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2, gl_CooperativeMatrixClampModeClampToEdgeNV> tensorLayout0 = createTensorLayoutNV(2, gl_CooperativeMatrixClampModeClampToEdgeNV);
   tensorLayoutNV<2, gl_CooperativeMatrixClampModeClampToEdgeNV> tensorLayout1 = createTensorLayoutNV(2, gl_CooperativeMatrixClampModeClampToEdgeNV);
   tensorLayoutNV<2, gl_CooperativeMatrixClampModeClampToEdgeNV> tensorLayout2 = createTensorLayoutNV(2, gl_CooperativeMatrixClampModeClampToEdgeNV);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4 - 6, N * 4 - 6);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4 - 6, N * 4 - 6);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4 - 6, N * 4 - 6);
   tensorLayout0 = setTensorLayoutStrideNV(tensorLayout0, N * 4, 1);
   tensorLayout1 = setTensorLayoutStrideNV(tensorLayout1, N * 4, 1);
   tensorLayout2 = setTensorLayoutStrideNV(tensorLayout2, N * 4, 1);
   tensorLayout0 = setTensorLayoutClampValueNV(tensorLayout0, 0x38);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = matA;
   tensorLayoutNV<2, gl_CooperativeMatrixClampModeClampToEdgeNV> tensorLayout3 = createTensorLayoutNV(2, gl_CooperativeMatrixClampModeClampToEdgeNV);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4 - 1, N * 4 - 1);
   tensorLayout3 = setTensorLayoutStrideNV(tensorLayout3, N * 4, 1);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3);
}
