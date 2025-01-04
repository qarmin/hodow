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
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (K * 8 / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 8 * i + j);
           int localElementShared = (K * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, K * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8 / workgroupsX, false);
   fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (M * 8 / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (K * 8 / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 8 * j + i);
           int localElementShared = (K * 8 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, M * 8 / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, K * 8 / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, M * 8 / workgroupsX, true);
   fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, sharedO, elementS3, M * 8 / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
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
layout(buffer_reference) buffer InputA { float32_t x[]; };
layout(buffer_reference) buffer InputB { float32_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(buffer_reference) buffer InputA { float32_t x[]; };
layout(buffer_reference) buffer InputB { float32_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float16_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (K * 8 / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 8 * i + j);
           int localElementShared = (K * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, K * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8 / workgroupsX, false);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float16_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (M * 8 / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (K * 8 / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 8 * j + i);
           int localElementShared = (K * 8 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, M * 8 / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, K * 8 / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, M * 8 / workgroupsX, true);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, sharedO, elementS3, M * 8 / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
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
layout(buffer_reference) buffer InputA { float16_t x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(buffer_reference) buffer InputA { float16_t x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared float16_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (K * 8 / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 8 * i + j);
           int localElementShared = (K * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, K * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8 / workgroupsX, false);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared float16_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (M * 8 / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (K * 8 / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 8 * j + i);
           int localElementShared = (K * 8 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, M * 8 / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, K * 8 / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, M * 8 / workgroupsX, true);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, sharedO, elementS3, M * 8 / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
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
layout(buffer_reference) buffer InputA { float16_t x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(buffer_reference) buffer InputA { float16_t x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, K, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, M, N>(0.0);
   fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
shared uint8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (K * 8 / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 8 * i + j);
           int localElementShared = (K * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, K * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8 / workgroupsX, false);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
shared uint8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (M * 8 / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (K * 8 / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 8 * j + i);
           int localElementShared = (K * 8 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, M * 8 / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, K * 8 / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, M * 8 / workgroupsX, true);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, sharedO, elementS3, M * 8 / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
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
layout(buffer_reference) buffer InputA { uint8_t x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint8_t x[]; };
layout(buffer_reference) buffer Output { uint8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(buffer_reference) buffer InputA { uint8_t x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint8_t x[]; };
layout(buffer_reference) buffer Output { uint8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (K * 8 / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 8 * i + j);
           int localElementShared = (K * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, K * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8 / workgroupsX, false);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (M * 8 / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (K * 8 / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 8 * j + i);
           int localElementShared = (K * 8 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, M * 8 / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, K * 8 / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, M * 8 / workgroupsX, true);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, sharedO, elementS3, M * 8 / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
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
layout(buffer_reference) buffer InputA { uint8_t x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(buffer_reference) buffer InputA { uint8_t x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
shared int8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (K * 8 / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 8 * i + j);
           int localElementShared = (K * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, K * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8 / workgroupsX, false);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
shared int8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (M * 8 / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (K * 8 / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 8 * j + i);
           int localElementShared = (K * 8 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, M * 8 / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, K * 8 / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, M * 8 / workgroupsX, true);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, sharedO, elementS3, M * 8 / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
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
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
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
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(buffer_reference) buffer InputA { int8_t x[]; };
layout(buffer_reference) buffer InputB { int8_t x[]; };
layout(buffer_reference) buffer InputC { int8_t x[]; };
layout(buffer_reference) buffer Output { int8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
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
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<8, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (K * 8 / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 8 * i + j);
           int localElementShared = (K * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, K * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8 / workgroupsX, false);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (M * 8 / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (K * 8 / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 8 * j + i);
           int localElementShared = (K * 8 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, M * 8 / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, K * 8 / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, M * 8 / workgroupsX, true);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, sharedO, elementS3, M * 8 / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
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
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(buffer_reference) buffer InputA { int8_t x[]; };
layout(buffer_reference) buffer InputB { int8_t x[]; };
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<8, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<8, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (K * 8 / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 8 * i + j);
           int localElementShared = (K * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, K * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8 / workgroupsX, false);
   ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (M * 8 / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (K * 8 / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 8 * j + i);
           int localElementShared = (K * 8 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, M * 8 / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, K * 8 / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, M * 8 / workgroupsX, true);
   ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, sharedO, elementS3, M * 8 / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
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
layout(buffer_reference) buffer InputA { uint32_t x[]; };
layout(buffer_reference) buffer InputB { uint32_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(buffer_reference) buffer InputA { uint32_t x[]; };
layout(buffer_reference) buffer InputB { uint32_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (K * 8 / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (N * 8 / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (N * 8 / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 8 * i + j);
           int localElementShared = (K * 8 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 8 * i + j);
           int localElementShared = (N * 8 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, K * 8 / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, N * 8 / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, N * 8 / workgroupsX, false);
   icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (M * 8 / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (K * 8 / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (M * 8 / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 8 * j + i);
           int localElementShared = (K * 8 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, M * 8 / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, K * 8 / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, M * 8 / workgroupsX, true);
   icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, sharedO, elementS3, M * 8 / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 8 * j + i);
           int localElementShared = (M * 8 / workgroupsX * j + i);
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
layout(buffer_reference) buffer InputA { int32_t x[]; };
layout(buffer_reference) buffer InputB { int32_t x[]; };
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (K * 8 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 8 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 8 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, K * 8, false);
   coopMatLoadNV(matB, inputB.x, element1, N * 8, false);
   coopMatLoadNV(matC, inputC.x, element2, N * 8, false);
   icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
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
layout(buffer_reference) buffer InputA { int32_t x[]; };
layout(buffer_reference) buffer InputB { int32_t x[]; };
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (M * 8 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 8 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 8 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, M * 8, true);
   coopMatLoadNV(matB, inputB.x, element1, K * 8, true);
   coopMatLoadNV(matC, inputC.x, element2, M * 8, true);
   icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matAArr[2];
    matAArr[1] = matA; matAArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, K, N> matBArr[2];
    matBArr[1] = matB; matBArr[0] = icoopmatNV<32, gl_ScopeSubgroup, K, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, M, N> matCArr[2];
    matCArr[1] = matC; matCArr[0] = icoopmatNV<32, gl_ScopeSubgroup, M, N>(0.0);
   icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matOArr[2];
   matOArr[1] = coopMatMulAddNV(matAArr[1], matBArr[1], matCArr[1]);
   matOArr[0] = icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols>(0.0);
   matO = matOArr[1];
   coopMatStoreNV(matO, outputO.x, element3, M * 8, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * i + j);
           int localElementShared = (pc.AStrideVar / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * i + j);
           int localElementShared = (pc.BStrideVar / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * i + j);
           int localElementShared = (pc.CStrideVar / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * i + j);
           int localElementShared = (pc.OStrideVar / workgroupsX * i + j);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * j + i);
           int localElementShared = (pc.AStrideVar / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * j + i);
           int localElementShared = (pc.BStrideVar / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * j + i);
           int localElementShared = (pc.CStrideVar / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * j + i);
           int localElementShared = (pc.OStrideVar / workgroupsX * j + i);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { float32_t x[]; };
layout(buffer_reference) buffer InputB { float32_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { float32_t x[]; };
layout(buffer_reference) buffer InputB { float32_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float16_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * i + j);
           int localElementShared = (pc.AStrideVar / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * i + j);
           int localElementShared = (pc.BStrideVar / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * i + j);
           int localElementShared = (pc.CStrideVar / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * i + j);
           int localElementShared = (pc.OStrideVar / workgroupsX * i + j);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float16_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * j + i);
           int localElementShared = (pc.AStrideVar / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * j + i);
           int localElementShared = (pc.BStrideVar / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * j + i);
           int localElementShared = (pc.CStrideVar / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * j + i);
           int localElementShared = (pc.OStrideVar / workgroupsX * j + i);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { float16_t x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { float16_t x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared float16_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * i + j);
           int localElementShared = (pc.AStrideVar / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * i + j);
           int localElementShared = (pc.BStrideVar / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * i + j);
           int localElementShared = (pc.CStrideVar / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * i + j);
           int localElementShared = (pc.OStrideVar / workgroupsX * i + j);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared float16_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * j + i);
           int localElementShared = (pc.AStrideVar / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * j + i);
           int localElementShared = (pc.BStrideVar / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * j + i);
           int localElementShared = (pc.CStrideVar / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * j + i);
           int localElementShared = (pc.OStrideVar / workgroupsX * j + i);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { float16_t x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { float16_t x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
fcoopmatNV<16, gl_ScopeSubgroup, ARows, ACols> matA;
fcoopmatNV<16, gl_ScopeSubgroup, K, N> matB;
fcoopmatNV<16, gl_ScopeSubgroup, M, N> matC;
fcoopmatNV<16, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
shared uint8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * i + j);
           int localElementShared = (pc.AStrideVar / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * i + j);
           int localElementShared = (pc.BStrideVar / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * i + j);
           int localElementShared = (pc.CStrideVar / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * i + j);
           int localElementShared = (pc.OStrideVar / workgroupsX * i + j);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
shared uint8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * j + i);
           int localElementShared = (pc.AStrideVar / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * j + i);
           int localElementShared = (pc.BStrideVar / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * j + i);
           int localElementShared = (pc.CStrideVar / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * j + i);
           int localElementShared = (pc.OStrideVar / workgroupsX * j + i);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { uint8_t x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint8_t x[]; };
layout(buffer_reference) buffer Output { uint8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { uint8_t x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint8_t x[]; };
layout(buffer_reference) buffer Output { uint8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * i + j);
           int localElementShared = (pc.AStrideVar / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * i + j);
           int localElementShared = (pc.BStrideVar / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * i + j);
           int localElementShared = (pc.CStrideVar / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * i + j);
           int localElementShared = (pc.OStrideVar / workgroupsX * i + j);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * j + i);
           int localElementShared = (pc.AStrideVar / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * j + i);
           int localElementShared = (pc.BStrideVar / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * j + i);
           int localElementShared = (pc.CStrideVar / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * j + i);
           int localElementShared = (pc.OStrideVar / workgroupsX * j + i);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { uint8_t x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { uint8_t x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
shared int8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * i + j);
           int localElementShared = (pc.AStrideVar / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * i + j);
           int localElementShared = (pc.BStrideVar / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * i + j);
           int localElementShared = (pc.CStrideVar / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * i + j);
           int localElementShared = (pc.OStrideVar / workgroupsX * i + j);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
shared int8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<8, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<8, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * j + i);
           int localElementShared = (pc.AStrideVar / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * j + i);
           int localElementShared = (pc.BStrideVar / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * j + i);
           int localElementShared = (pc.CStrideVar / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * j + i);
           int localElementShared = (pc.OStrideVar / workgroupsX * j + i);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { int8_t x[]; };
layout(buffer_reference) buffer InputB { int8_t x[]; };
layout(buffer_reference) buffer InputC { int8_t x[]; };
layout(buffer_reference) buffer Output { int8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
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
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { int8_t x[]; };
layout(buffer_reference) buffer InputB { int8_t x[]; };
layout(buffer_reference) buffer InputC { int8_t x[]; };
layout(buffer_reference) buffer Output { int8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
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
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * i + j);
           int localElementShared = (pc.AStrideVar / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * i + j);
           int localElementShared = (pc.BStrideVar / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * i + j);
           int localElementShared = (pc.CStrideVar / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * i + j);
           int localElementShared = (pc.OStrideVar / workgroupsX * i + j);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int8_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int8_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * j + i);
           int localElementShared = (pc.AStrideVar / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * j + i);
           int localElementShared = (pc.BStrideVar / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * j + i);
           int localElementShared = (pc.CStrideVar / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * j + i);
           int localElementShared = (pc.OStrideVar / workgroupsX * j + i);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { int8_t x[]; };
layout(buffer_reference) buffer InputB { int8_t x[]; };
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { int8_t x[]; };
layout(buffer_reference) buffer InputB { int8_t x[]; };
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<8, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<8, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * i + j);
           int localElementShared = (pc.AStrideVar / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * i + j);
           int localElementShared = (pc.BStrideVar / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * i + j);
           int localElementShared = (pc.CStrideVar / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * i + j);
           int localElementShared = (pc.OStrideVar / workgroupsX * i + j);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * j + i);
           int localElementShared = (pc.AStrideVar / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * j + i);
           int localElementShared = (pc.BStrideVar / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * j + i);
           int localElementShared = (pc.CStrideVar / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * j + i);
           int localElementShared = (pc.OStrideVar / workgroupsX * j + i);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { uint32_t x[]; };
layout(buffer_reference) buffer InputB { uint32_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { uint32_t x[]; };
layout(buffer_reference) buffer InputB { uint32_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
ucoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
ucoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
ucoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
ucoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * M * subgroupXY.y + K * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * K * subgroupXY.y + N * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * M * subgroupXY.y + N * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * i + j);
           int localElementShared = (pc.AStrideVar / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * i + j);
           int localElementShared = (pc.BStrideVar / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * i + j);
           int localElementShared = (pc.CStrideVar / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, false);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, false);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, false);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * i + j);
           int localElementShared = (pc.OStrideVar / workgroupsX * i + j);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int32_t sharedA[M * K * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedB[K * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
void main()
{
   uvec2 subgroupXY = uvec2(gl_SubgroupID % subgroupsPerWG.x, gl_SubgroupID / subgroupsPerWG.x);
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy) * subgroupsPerWG + subgroupXY;
   if (gl_SubgroupID >= subgroupsPerWG.x * subgroupsPerWG.y)
       return;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = (pc.AStrideVar / workgroupsX * K * subgroupXY.y + M * subgroupXY.x);
       elementS1 = (pc.BStrideVar / workgroupsX * N * subgroupXY.y + K * subgroupXY.x);
       elementS2 = (pc.CStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
       elementS3 = (pc.OStrideVar / workgroupsX * N * subgroupXY.y + M * subgroupXY.x);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (pc.AStrideVar * j + i);
           int localElementShared = (pc.AStrideVar / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.BStrideVar * j + i);
           int localElementShared = (pc.BStrideVar / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.CStrideVar * j + i);
           int localElementShared = (pc.CStrideVar / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoadNV(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, true);
   coopMatLoadNV(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, true);
   coopMatLoadNV(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, true);
   controlBarrier(gl_ScopeSubgroup, gl_ScopeSubgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (pc.OStrideVar * j + i);
           int localElementShared = (pc.OStrideVar / workgroupsX * j + i);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { int32_t x[]; };
layout(buffer_reference) buffer InputB { int32_t x[]; };
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, false);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, false);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, false);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, false);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
const uvec2 subgroupsPerWG = uvec2(2, 2);
layout(buffer_reference) buffer InputA { int32_t x[]; };
layout(buffer_reference) buffer InputB { int32_t x[]; };
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
icoopmatNV<32, gl_ScopeSubgroup, ARows, ACols> matA;
icoopmatNV<32, gl_ScopeSubgroup, K, N> matB;
icoopmatNV<32, gl_ScopeSubgroup, M, N> matC;
icoopmatNV<32, gl_ScopeSubgroup, ORows, OCols> matO;
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
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoadNV(matA, inputA.x, element0, pc.AStrideVar, true);
   coopMatLoadNV(matB, inputB.x, element1, pc.BStrideVar, true);
   coopMatLoadNV(matC, inputC.x, element2, pc.CStrideVar, true);
   matO = coopMatMulAddNV(matA, matB, matC);
   coopMatStoreNV(matO, outputO.x, element3, pc.OStrideVar, true);
}
