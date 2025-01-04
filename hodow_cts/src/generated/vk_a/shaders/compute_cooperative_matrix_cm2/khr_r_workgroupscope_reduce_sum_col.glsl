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
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float32_t combineOp(const in float32_t a, const in float32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { float32_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float32_t combineOp(const in float32_t a, const in float32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float32_t sharedA[M * N * 1];
shared float32_t sharedB[M * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float32_t combineOp(const in float32_t a, const in float32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, sharedO, elementS3, (N*1) * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(set=0, binding=0) coherent buffer InputA { float32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
shared float32_t sharedA[M * N * 1];
shared float32_t sharedB[M * N * 1];
shared float32_t sharedC[M * N * 1];
shared float32_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float32_t combineOp(const in float32_t a, const in float32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(buffer_reference) buffer InputA { float32_t x[]; };
layout(buffer_reference) buffer InputB { float32_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float32_t combineOp(const in float32_t a, const in float32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { float32_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { float32_t x[]; };
layout(buffer_reference) buffer InputC { float32_t x[]; };
layout(buffer_reference) buffer Output { float32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float32_t combineOp(const in float32_t a, const in float32_t b) {
    return a + b;
}
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
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float16_t combineOp(const in float16_t a, const in float16_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { float16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float16_t combineOp(const in float16_t a, const in float16_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared float16_t sharedA[M * N * 1];
shared float16_t sharedB[M * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float16_t combineOp(const in float16_t a, const in float16_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, sharedO, elementS3, (N*1) * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(set=0, binding=0) coherent buffer InputA { float16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { float16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
shared float16_t sharedA[M * N * 1];
shared float16_t sharedB[M * N * 1];
shared float16_t sharedC[M * N * 1];
shared float16_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float16_t combineOp(const in float16_t a, const in float16_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(buffer_reference) buffer InputA { float16_t x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float16_t combineOp(const in float16_t a, const in float16_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { float16_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { float16_t x[]; };
layout(buffer_reference) buffer InputC { float16_t x[]; };
layout(buffer_reference) buffer Output { float16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
float16_t combineOp(const in float16_t a, const in float16_t b) {
    return a + b;
}
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
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint8_t combineOp(const in uint8_t a, const in uint8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { uint8_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint8_t combineOp(const in uint8_t a, const in uint8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
shared uint8_t sharedA[M * N * 1];
shared uint8_t sharedB[M * N * 1];
shared uint8_t sharedC[M * N * 1];
shared uint8_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint8_t combineOp(const in uint8_t a, const in uint8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, sharedO, elementS3, (N*1) * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(set=0, binding=0) coherent buffer InputA { uint8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
shared uint8_t sharedA[M * N * 1];
shared uint8_t sharedB[M * N * 1];
shared uint8_t sharedC[M * N * 1];
shared uint8_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint8_t combineOp(const in uint8_t a, const in uint8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(buffer_reference) buffer InputA { uint8_t x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint8_t x[]; };
layout(buffer_reference) buffer Output { uint8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint8_t combineOp(const in uint8_t a, const in uint8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { uint8_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { uint8_t x[]; };
layout(buffer_reference) buffer InputC { uint8_t x[]; };
layout(buffer_reference) buffer Output { uint8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint8_t combineOp(const in uint8_t a, const in uint8_t b) {
    return a + b;
}
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
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int8_t combineOp(const in int8_t a, const in int8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { int8_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int8_t combineOp(const in int8_t a, const in int8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
shared int8_t sharedA[M * N * 1];
shared int8_t sharedB[M * N * 1];
shared int8_t sharedC[M * N * 1];
shared int8_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int8_t combineOp(const in int8_t a, const in int8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, sharedO, elementS3, (N*1) * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(set=0, binding=0) coherent buffer InputA { int8_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int8_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
shared int8_t sharedA[M * N * 1];
shared int8_t sharedB[M * N * 1];
shared int8_t sharedC[M * N * 1];
shared int8_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int8_t combineOp(const in int8_t a, const in int8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(buffer_reference) buffer InputA { int8_t x[]; };
layout(buffer_reference) buffer InputB { int8_t x[]; };
layout(buffer_reference) buffer InputC { int8_t x[]; };
layout(buffer_reference) buffer Output { int8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int8_t combineOp(const in int8_t a, const in int8_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { int8_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { int8_t x[]; };
layout(buffer_reference) buffer InputC { int8_t x[]; };
layout(buffer_reference) buffer Output { int8_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int8_t combineOp(const in int8_t a, const in int8_t b) {
    return a + b;
}
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
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint32_t combineOp(const in uint32_t a, const in uint32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { uint32_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint32_t combineOp(const in uint32_t a, const in uint32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint32_t sharedA[M * N * 1];
shared uint32_t sharedB[M * N * 1];
shared uint32_t sharedC[M * N * 1];
shared uint32_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint32_t combineOp(const in uint32_t a, const in uint32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, sharedO, elementS3, (N*1) * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(set=0, binding=0) coherent buffer InputA { uint32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
shared uint32_t sharedA[M * N * 1];
shared uint32_t sharedB[M * N * 1];
shared uint32_t sharedC[M * N * 1];
shared uint32_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint32_t combineOp(const in uint32_t a, const in uint32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(buffer_reference) buffer InputA { uint32_t x[]; };
layout(buffer_reference) buffer InputB { uint32_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint32_t combineOp(const in uint32_t a, const in uint32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { uint32_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { uint32_t x[]; };
layout(buffer_reference) buffer InputC { uint32_t x[]; };
layout(buffer_reference) buffer Output { uint32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
uint32_t combineOp(const in uint32_t a, const in uint32_t b) {
    return a + b;
}
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
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int32_t combineOp(const in int32_t a, const in int32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { int32_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int32_t combineOp(const in int32_t a, const in int32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int32_t sharedA[M * N * 1];
shared int32_t sharedB[M * N * 1];
shared int32_t sharedC[M * N * 1];
shared int32_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int32_t combineOp(const in int32_t a, const in int32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, sharedO, elementS3, (N*1) * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(set=0, binding=0) coherent buffer InputA { int32_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int32_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
shared int32_t sharedA[M * N * 1];
shared int32_t sharedB[M * N * 1];
shared int32_t sharedC[M * N * 1];
shared int32_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int32_t combineOp(const in int32_t a, const in int32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(buffer_reference) buffer InputA { int32_t x[]; };
layout(buffer_reference) buffer InputB { int32_t x[]; };
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int32_t combineOp(const in int32_t a, const in int32_t b) {
    return a + b;
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { int32_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { int32_t x[]; };
layout(buffer_reference) buffer InputC { int32_t x[]; };
layout(buffer_reference) buffer Output { int32_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
int32_t combineOp(const in int32_t a, const in int32_t b) {
    return a + b;
}
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
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
bfloat16_t combineOp(const in bfloat16_t a, const in bfloat16_t b) {
    return bfloat16_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { bfloat16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
bfloat16_t combineOp(const in bfloat16_t a, const in bfloat16_t b) {
    return bfloat16_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
shared bfloat16_t sharedA[M * N * 1];
shared bfloat16_t sharedB[M * N * 1];
shared bfloat16_t sharedC[M * N * 1];
shared bfloat16_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
bfloat16_t combineOp(const in bfloat16_t a, const in bfloat16_t b) {
    return bfloat16_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, sharedO, elementS3, (N*1) * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(set=0, binding=0) coherent buffer InputA { bfloat16_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { bfloat16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
shared bfloat16_t sharedA[M * N * 1];
shared bfloat16_t sharedB[M * N * 1];
shared bfloat16_t sharedC[M * N * 1];
shared bfloat16_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
bfloat16_t combineOp(const in bfloat16_t a, const in bfloat16_t b) {
    return bfloat16_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(buffer_reference) buffer InputA { bfloat16_t x[]; };
layout(buffer_reference) buffer InputB { bfloat16_t x[]; };
layout(buffer_reference) buffer InputC { bfloat16_t x[]; };
layout(buffer_reference) buffer Output { bfloat16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
bfloat16_t combineOp(const in bfloat16_t a, const in bfloat16_t b) {
    return bfloat16_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
struct StructA { bfloat16_t y; };
layout(buffer_reference) buffer InputA { StructA x[]; };
layout(buffer_reference) buffer InputB { bfloat16_t x[]; };
layout(buffer_reference) buffer InputC { bfloat16_t x[]; };
layout(buffer_reference) buffer Output { bfloat16_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
bfloat16_t combineOp(const in bfloat16_t a, const in bfloat16_t b) {
    return bfloat16_t(float(a) + float(b));
}
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
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { floate5m2_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate5m2_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate5m2_t combineOp(const in floate5m2_t a, const in floate5m2_t b) {
    return floate5m2_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate5m2_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate5m2_t combineOp(const in floate5m2_t a, const in floate5m2_t b) {
    return floate5m2_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
layout(set=0, binding=0) coherent buffer InputA { floate5m2_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate5m2_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
shared floate5m2_t sharedA[M * N * 1];
shared floate5m2_t sharedB[M * N * 1];
shared floate5m2_t sharedC[M * N * 1];
shared floate5m2_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate5m2_t combineOp(const in floate5m2_t a, const in floate5m2_t b) {
    return floate5m2_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, sharedO, elementS3, (N*1) * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(set=0, binding=0) coherent buffer InputA { floate5m2_t x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { floate5m2_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
shared floate5m2_t sharedA[M * N * 1];
shared floate5m2_t sharedB[M * N * 1];
shared floate5m2_t sharedC[M * N * 1];
shared floate5m2_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate5m2_t combineOp(const in floate5m2_t a, const in floate5m2_t b) {
    return floate5m2_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
layout(buffer_reference) buffer InputA { floate5m2_t x[]; };
layout(buffer_reference) buffer InputB { floate5m2_t x[]; };
layout(buffer_reference) buffer InputC { floate5m2_t x[]; };
layout(buffer_reference) buffer Output { floate5m2_t x[]; };
layout(set=0, binding=4) buffer Params { InputA inputA; InputB inputB; InputC inputC; Output outputO; } params;
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate5m2_t combineOp(const in floate5m2_t a, const in floate5m2_t b) {
    return floate5m2_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate5m2_t combineOp(const in floate5m2_t a, const in floate5m2_t b) {
    return floate5m2_t(float(a) + float(b));
}
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
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate4m3_t combineOp(const in floate4m3_t a, const in floate4m3_t b) {
    return floate4m3_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate4m3_t combineOp(const in floate4m3_t a, const in floate4m3_t b) {
    return floate4m3_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
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
shared floate4m3_t sharedA[M * N * 1];
shared floate4m3_t sharedB[M * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate4m3_t combineOp(const in floate4m3_t a, const in floate4m3_t b) {
    return floate4m3_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   coopMatLoad(matA, sharedA, elementS0, N * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, sharedB, elementS1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, sharedC, elementS2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, sharedO, elementS3, (N*1) * 4 / workgroupsX, gl_CooperativeMatrixLayoutRowMajor);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
shared floate4m3_t sharedA[M * N * 1];
shared floate4m3_t sharedB[M * N * 1];
shared floate4m3_t sharedC[M * N * 1];
shared floate4m3_t sharedO[(M*3) * (N*1) * 1];
#define ARows M
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate4m3_t combineOp(const in floate4m3_t a, const in floate4m3_t b) {
    return floate4m3_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   int offset00 = int(M * matrixID.y); int offset01 = int(N * matrixID.x);
   int offset10 = int(M * matrixID.y); int offset11 = int(N * matrixID.x);
   int offset20 = int(M * matrixID.y); int offset21 = int(N * matrixID.x);
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
       elementS0 = 0;
       elementS1 = 0;
       elementS2 = 0;
       elementS3 = 0;
   if (subgroupElect()) {
       for (int i = 0; i < M; ++i) {
       for (int j = 0; j < N; ++j) {
           int localElementInput = (N * 4 * i + j);
           int localElementShared = (N * 4 / workgroupsX * i + j);
           sharedA[elementS0 + localElementShared] = inputA.x[element0 + localElementInput];
       }
       }
   }
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4 / workgroupsX);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   elementS0 = elementS1 = elementS2 = 0;
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, 0, span00, 0, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, 0, span10, 0, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, 0, span20, 0, span21);
   coopMatLoadTensorNV(matA, sharedA, elementS0, tensorLayout0);
   coopMatLoadTensorNV(matB, sharedB, elementS1, tensorLayout1);
   coopMatLoadTensorNV(matC, sharedC, elementS2, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4 / workgroupsX);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, 0, span30, 0, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   elementS3 = 0;
   coopMatStoreTensorNV(matO, sharedO, elementS3, tensorLayout3);
   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, gl_StorageSemanticsShared, gl_SemanticsAcquireRelease);
   if (subgroupElect()) {
       for (int i = 0; i < (M*3); ++i) {
       for (int j = 0; j < (N*1); ++j) {
           int localElementInput = ((N*1) * 4 * i + j);
           int localElementShared = ((N*1) * 4 / workgroupsX * i + j);
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
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate4m3_t combineOp(const in floate4m3_t a, const in floate4m3_t b) {
    return floate4m3_t(float(a) + float(b));
}
void main()
{
   uvec2 matrixID = uvec2(gl_WorkGroupID.xy);
   InputA inputA = params.inputA;
   InputB inputB = params.inputB;
   InputC inputC = params.inputC;
   Output outputO = params.outputO;
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   coopMatLoad(matA, inputA.x, element0, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matB, inputB.x, element1, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatLoad(matC, inputC.x, element2, N * 4, gl_CooperativeMatrixLayoutRowMajor);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   coopMatStore(matO, outputO.x, element3, (N*1) * 4, gl_CooperativeMatrixLayoutRowMajor);
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
#define ACols N
const int ORows = (M*3);
const int OCols = (N*1);
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseAccumulator> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
floate4m3_t combineOp(const in floate4m3_t a, const in floate4m3_t b) {
    return floate4m3_t(float(a) + float(b));
}
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
   int offset30 = int((M*3) * matrixID.y); int offset31 = int((N*1) * matrixID.x);
   uint span00 = M; uint span01 = N;
   uint span10 = M; uint span11 = N;
   uint span20 = M; uint span21 = N;
   uint span30 = (M*3); uint span31 = (N*1);
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = ((N*1) * 4 * (M*3) * matrixID.y + (N*1) * matrixID.x);
   uint elementS0, elementS1, elementS2, elementS3;
   tensorLayoutNV<2> tensorLayout0 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout1 = createTensorLayoutNV(2);
   tensorLayoutNV<2> tensorLayout2 = createTensorLayoutNV(2);
   tensorLayout0 = setTensorLayoutDimensionNV(tensorLayout0, M * 4, N * 4);
   tensorLayout1 = setTensorLayoutDimensionNV(tensorLayout1, M * 4, N * 4);
   tensorLayout2 = setTensorLayoutDimensionNV(tensorLayout2, M * 4, N * 4);
   tensorLayout0 = sliceTensorLayoutNV(tensorLayout0, offset00, span00, offset01, span01);
   tensorLayout1 = sliceTensorLayoutNV(tensorLayout1, offset10, span10, offset11, span11);
   tensorLayout2 = sliceTensorLayoutNV(tensorLayout2, offset20, span20, offset21, span21);
   coopMatLoadTensorNV(matA, inputA.x, 0, tensorLayout0);
   coopMatLoadTensorNV(matB, inputB.x, 0, tensorLayout1);
   coopMatLoadTensorNV(matC, inputC.x, 0, tensorLayout2);
   coopMatReduceNV(matO, matA, gl_CooperativeMatrixReduceColumnNV, combineOp);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, (M*3) * 4, (N*1) * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3);
}
