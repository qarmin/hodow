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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, K * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, N * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, K * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
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
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3, colMajorView3);
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4 / workgroupsX);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, sharedB, elementS1, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, sharedC, elementS2, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4 / workgroupsX);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3, colMajorView3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, K * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, N * 4, gl_CooperativeMatrixLayoutRowMajor);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, K * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3, colMajorView3);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4 / workgroupsX);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, sharedB, elementS1, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, sharedC, elementS2, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4 / workgroupsX);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3, colMajorView3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
const int workgroupsX = 4;
layout(buffer_reference) buffer InputA { floate4m3_t x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { floate4m3_t x[]; };
layout(buffer_reference) buffer Output { floate4m3_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, K * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, N * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { floate4m3_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { floate4m3_t x[]; };
layout(buffer_reference) buffer Output { floate4m3_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
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
layout(buffer_reference) buffer InputA { floate4m3_t x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { floate4m3_t x[]; };
layout(buffer_reference) buffer Output { floate4m3_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, K * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
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
struct StructA { floate4m3_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { floate4m3_t x[]; };
layout(buffer_reference) buffer Output { floate4m3_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3, colMajorView3);
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, K * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, N * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, K * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
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
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3, colMajorView3);
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4 / workgroupsX);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, sharedB, elementS1, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, sharedC, elementS2, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4 / workgroupsX);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3, colMajorView3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, K * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, N * 4, gl_CooperativeMatrixLayoutRowMajor);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, K * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3, colMajorView3);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4 / workgroupsX);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, sharedB, elementS1, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, sharedC, elementS2, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4 / workgroupsX);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3, colMajorView3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
const int workgroupsX = 4;
layout(buffer_reference) buffer InputA { floate4m3_t x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, K * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, N * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { floate4m3_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
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
layout(buffer_reference) buffer InputA { floate4m3_t x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, K * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
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
struct StructA { floate4m3_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3, colMajorView3);
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, K * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, N * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, K * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
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
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3, colMajorView3);
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
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4 / workgroupsX);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, sharedB, elementS1, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, sharedC, elementS2, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4 / workgroupsX);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3, colMajorView3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, K * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, N * 4, gl_CooperativeMatrixLayoutRowMajor);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, K * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
struct StructA { floate4m3_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3, colMajorView3);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (K * 4 * i + j);
           int localElementShared = (K * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4 / workgroupsX);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, sharedB, elementS1, K * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, sharedC, elementS2, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, sharedO, elementS3, M * 4 / workgroupsX, gl_CooperativeMatrixLayoutColumnMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
#pragma use_variable_pointers
const int workgroupsX = 4;
layout(set=0, binding=0) coherent buffer InputA { floate4m3_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate4m3_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared floate4m3_t sharedA[M * K * 1];
shared floate4m3_t sharedB[K * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[M * N * 1];
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < K; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
       for (int i = 0; i < K; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (K * 4 * j + i);
           int localElementShared = (K * 4 / workgroupsX * j + i);
           sharedB[elementS1 + localElementShared] = inputB.x[element1 + localElementInput];
       }
       }
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
           sharedC[elementS2 + localElementShared] = inputC.x[element2 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4 / workgroupsX);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4 / workgroupsX);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3, colMajorView3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (M * 4 * j + i);
           int localElementShared = (M * 4 / workgroupsX * j + i);
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
const int workgroupsX = 4;
layout(buffer_reference) buffer InputA { floate4m3_t x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, K * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, N * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { floate4m3_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   int offset00 = int(M * matrixID.y); int offset01 = int(K * matrixID.x);
   int offset10 = int(K * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int(M * matrixID.y); int offset31 = int(N * matrixID.x);
   uint span00 = M; uint span01 = K;
   uint span10 = K; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = M; uint span31 = N;
   uint element0 = (K * 4 * M * matrixID.y + K * matrixID.x);
   uint element1 = (N * 4 * K * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, K * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, K * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
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
layout(buffer_reference) buffer InputA { floate4m3_t x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matB, inputB.x, element1, K * 4, gl_CooperativeMatrixLayoutColumnMajor);
   coopMatLoad(matC, inputC.x, element2, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
   matO = coopMatMulAdd(matA, matB, matC);
   coopMatStore(matO, outputO.x, element3, M * 4, gl_CooperativeMatrixLayoutColumnMajor);
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
struct StructA { floate4m3_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { floate4m3_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols K
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseA> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, K, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   int offset00 = int(K * matrixID.y); int offset01 = int(M * matrixID.x);
   int offset10 = int(N * matrixID.y); int offset11 = int(K * matrixID.x);
   int offset20 = int(N * matrixID.y); int offset21 = int(M * matrixID.x);
   int offset30 = int(N * matrixID.y); int offset31 = int(M * matrixID.x);
   uint span00 = K; uint span01 = M;
   uint span10 = N; uint span11 = K;
   uint span20 = N; uint span21 = M;
   uint span30 = N; uint span31 = M;
   uint element0 = (M * 4 * K * matrixID.y + M * matrixID.x);
   uint element1 = (K * 4 * N * matrixID.y + K * matrixID.x);
   uint element2 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint element3 = (M * 4 * N * matrixID.y + M * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, K * 4, M * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, N * 4, K * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, N * 4, M * 4);
   tensorViewNV<2, true, 1, 0> colMajorView0 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView1 = createTensorViewNV(2, true, 1, 0);
   tensorViewNV<2, true, 1, 0> colMajorView2 = createTensorViewNV(2, true, 1, 0);
   colMajorView0 = setTensorViewDimensionsNV(colMajorView0, span00, span01);
   colMajorView1 = setTensorViewDimensionsNV(colMajorView1, span10, span11);
   colMajorView2 = setTensorViewDimensionsNV(colMajorView2, span20, span21);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0, colMajorView0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1, colMajorView1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2, colMajorView2);
   matO = coopMatMulAdd(matA, matB, matC);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, N * 4, M * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3, colMajorView3);
}
