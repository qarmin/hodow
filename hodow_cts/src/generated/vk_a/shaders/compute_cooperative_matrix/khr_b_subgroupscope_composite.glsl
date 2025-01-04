#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared float32_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared float16_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared uint8_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared uint32_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared int32_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
shared bfloat16_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared bfloat16_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared bfloat16_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared bfloat16_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
layout(buffer_reference) buffer InputA { bfloat16_t x[]; };
layout(buffer_reference) buffer InputB { bfloat16_t x[]; };
layout(buffer_reference) buffer InputC { bfloat16_t x[]; };
layout(buffer_reference) buffer Output { bfloat16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { floate5m2_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate5m2_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { floate5m2_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate5m2_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
shared floate5m2_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate5m2_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate5m2_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate5m2_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
layout(buffer_reference) buffer InputA { floate5m2_t x[]; };
layout(buffer_reference) buffer InputB { floate5m2_t x[]; };
layout(buffer_reference) buffer InputC { floate5m2_t x[]; };
layout(buffer_reference) buffer Output { floate5m2_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate4m3_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate4m3_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate4m3_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
layout(buffer_reference) buffer InputA { floate4m3_t x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { floate4m3_t x[]; };
layout(buffer_reference) buffer Output { floate4m3_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   for (int i = 1; i < matA.length(); ++i) {
       matO[i] = matA[i];
   }
   coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> t = matB;
   if (matA.length() > 0) {
       matO[0] = (t = matA)[0];
   }
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared float32_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<float32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<float32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<float32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared float16_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared float16_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<float16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<float16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<float16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared uint8_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint8_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<uint8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<int8_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<int8_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<int8_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared uint32_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared uint32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<uint32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
shared int32_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared int32_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<int32_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<int32_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<int32_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
shared bfloat16_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared bfloat16_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared bfloat16_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared bfloat16_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
layout(buffer_reference) buffer InputA { bfloat16_t x[]; };
layout(buffer_reference) buffer InputB { bfloat16_t x[]; };
layout(buffer_reference) buffer InputC { bfloat16_t x[]; };
layout(buffer_reference) buffer Output { bfloat16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<bfloat16_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { floate5m2_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate5m2_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { floate5m2_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate5m2_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
shared floate5m2_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate5m2_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate5m2_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate5m2_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
layout(buffer_reference) buffer InputA { floate5m2_t x[]; };
layout(buffer_reference) buffer InputB { floate5m2_t x[]; };
layout(buffer_reference) buffer InputC { floate5m2_t x[]; };
layout(buffer_reference) buffer Output { floate5m2_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<floate5m2_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate4m3_t sharedB[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate4m3_t sharedC[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
shared floate4m3_t sharedO[M * N * subgroupsPerWG.x * subgroupsPerWG.y];
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, sharedA, elementS0, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, sharedO, elementS3, N * 8 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
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
#extension GL_KHR_cooperative_matrix : enable
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
layout(buffer_reference) buffer InputA { floate4m3_t x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { floate4m3_t x[]; };
layout(buffer_reference) buffer Output { floate4m3_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   coopMatLoad(matA, inputA.x, element0, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 8, gl_CooperativeMatrixLayoutRowMajor);
   coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB> matAArr[2];
    matAArr[1] = matA; matAArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, ARows, ACols, gl_MatrixUseB>(0.0);
   coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matBArr[2];
    matBArr[1] = matB; matBArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB> matCArr[2];
    matCArr[1] = matC; matCArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, M, N, gl_MatrixUseB>(0.0);
   coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB> matOArr[2];
   for (int i = 0; i < matA.length(); ++i) {
       matOArr[1][i] = matAArr[1][i];
   }
   matOArr[0] = coopmat<floate4m3_t, gl_ScopeSubgroup, ORows, OCols, gl_MatrixUseB>(0.0);
   matO = matOArr[1];
   coopMatStore(matO, outputO.x, element3, N * 8, gl_CooperativeMatrixLayoutRowMajor);
}
