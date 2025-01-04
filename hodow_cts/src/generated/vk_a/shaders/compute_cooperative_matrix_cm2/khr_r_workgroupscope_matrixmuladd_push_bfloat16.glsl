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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, pc.AStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, pc.BStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, pc.CStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, pc.OStrideVar, gl_CooperativeMatrixLayoutRowMajor);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, pc.AStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, pc.BStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, pc.CStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, pc.OStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared bfloat16_t sharedA[M * K * 1];
shared bfloat16_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
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
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared bfloat16_t sharedA[M * K * 1];
shared bfloat16_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
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
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(buffer_reference) buffer InputA { bfloat16_t x[]; };
layout(buffer_reference) buffer InputB { bfloat16_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, pc.AStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, pc.BStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, pc.CStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, pc.OStrideVar, gl_CooperativeMatrixLayoutRowMajor);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(buffer_reference) buffer InputA { bfloat16_t x[]; };
layout(buffer_reference) buffer InputB { bfloat16_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, pc.AStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, pc.BStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, pc.CStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, pc.OStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, pc.AStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, pc.BStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, pc.CStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, pc.OStrideVar, gl_CooperativeMatrixLayoutRowMajor);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, pc.AStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, pc.BStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, pc.CStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, pc.OStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
shared bfloat16_t sharedA[M * K * 1];
shared bfloat16_t sharedB[K * N * 1];
shared bfloat16_t sharedC[M * N * 1];
shared bfloat16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
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
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
shared bfloat16_t sharedA[M * K * 1];
shared bfloat16_t sharedB[K * N * 1];
shared bfloat16_t sharedC[M * N * 1];
shared bfloat16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
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
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, pc.AStrideVar / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, sharedB, elementS1, pc.BStrideVar / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, sharedC, elementS2, pc.CStrideVar / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, pc.OStrideVar / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(buffer_reference) buffer InputA { bfloat16_t x[]; };
layout(buffer_reference) buffer InputB { bfloat16_t x[]; };
layout(buffer_reference) buffer InputC { bfloat16_t x[]; };
layout(buffer_reference) buffer Output { bfloat16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (pc.AStrideVar * M * matrixID.y + K * matrixID.x);
   uint element1 = (pc.BStrideVar * K * matrixID.y + N * matrixID.x);
   uint element2 = (pc.CStrideVar * M * matrixID.y + N * matrixID.x);
   uint element3 = (pc.OStrideVar * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, pc.AStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, pc.BStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, pc.CStrideVar, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, pc.OStrideVar, gl_CooperativeMatrixLayoutRowMajor);
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
layout (push_constant, std430) uniform PCBlock {
  int AStrideVar;
  int BStrideVar;
  int CStrideVar;
  int OStrideVar;
} pc;
const int workgroupsX = 4;
layout(buffer_reference) buffer InputA { bfloat16_t x[]; };
layout(buffer_reference) buffer InputB { bfloat16_t x[]; };
layout(buffer_reference) buffer InputC { bfloat16_t x[]; };
layout(buffer_reference) buffer Output { bfloat16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (pc.AStrideVar * K * matrixID.y + M * matrixID.x);
   uint element1 = (pc.BStrideVar * N * matrixID.y + K * matrixID.x);
   uint element2 = (pc.CStrideVar * N * matrixID.y + M * matrixID.x);
   uint element3 = (pc.OStrideVar * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, pc.AStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, pc.BStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, pc.CStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, pc.OStrideVar, gl_CooperativeMatrixLayoutColumnMajor);
}
