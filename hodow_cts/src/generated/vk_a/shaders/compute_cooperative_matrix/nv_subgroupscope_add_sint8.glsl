#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_NV_cooperative_matrix : enable
#extension GL_NV_integer_cooperative_matrix : enable
#extension GL_EXT_split_barrier : enable
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
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, N * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   matO = matA + matB;
   coopMatStoreNV(matO, outputO.x, element3, N * 8, false);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_NV_cooperative_matrix : enable
#extension GL_NV_integer_cooperative_matrix : enable
#extension GL_EXT_split_barrier : enable
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
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
shared int8_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, N * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8, false);
   matO = matA + matB;
   coopMatStoreNV(matO, sharedO, elementS3, N * 8 / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           outputO.x[element3 + localElementInput] = sharedO[elementS3 + localElementShared];
       }
       }
   }
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_NV_cooperative_matrix : enable
#extension GL_NV_integer_cooperative_matrix : enable
#extension GL_EXT_split_barrier : enable
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
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { int8_t x[]; };
layout(buffer_reference) buffer InputB { int8_t x[]; };
layout(buffer_reference) buffer InputC { int8_t x[]; };
layout(buffer_reference) buffer Output { int8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, N * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   matO = matA + matB;
   coopMatStoreNV(matO, outputO.x, element3, N * 8, false);
}
