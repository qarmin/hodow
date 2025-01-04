#version 450 core
#pragma use_vulkan_memory_model
#extension GL_KHR_shader_subgroup_basic : enable
#extension GL_KHR_memory_scope_semantics : enable
#extension GL_KHR_cooperative_matrix : enable
#extension GL_EXT_split_barrier : enable
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseB>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<float32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { int16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { int16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<int32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint8_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
struct StructA { uint16_t y; };
layout(set=0, binding=0) coherent buffer InputA { StructA x[]; } inputA;
layout(set=0, binding=1) coherent buffer InputB { uint16_t x[]; } inputB;
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<uint32_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate5m2_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { bfloat16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { bfloat16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<floate4m3_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { float32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { float32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<float32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<float32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { int32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { int32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<int32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<int32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint8_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint8_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint8_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint8_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint16_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint16_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { uint32_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { uint32_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<uint32_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<uint32_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate5m2_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate5m2_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate5m2_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate5m2_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
layout(set=0, binding=2) coherent buffer InputC { floate4m3_t x[]; } inputC;
layout(set=0, binding=3) coherent buffer Output { floate4m3_t x[]; } outputO;
#define ARows M
#define ACols N
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<floate4m3_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<floate4m3_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
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
#extension GL_EXT_cooperative_matrix_maintenance1 : enable
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
#define ORows M
#define OCols N
coopmat<bfloat16_t, gl_ScopeWorkgroup, ARows, ACols, gl_MatrixUseB> matA;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseB> matB;
coopmat<bfloat16_t, gl_ScopeWorkgroup, M, N, gl_MatrixUseAccumulator> matC;
coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator> matO;
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
   uint element0 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element1 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element2 = (N * 4 * M * matrixID.y + N * matrixID.x);
   uint element3 = (N * 4 * M * matrixID.y + N * matrixID.x);
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
   matO = coopmat<bfloat16_t, gl_ScopeWorkgroup, ORows, OCols, gl_MatrixUseAccumulator>(matA);
   tensorLayoutNV<2> tensorLayout3 = createTensorLayoutNV(2);
   tensorLayout3 = setTensorLayoutDimensionNV(tensorLayout3, M * 4, N * 4);
   tensorLayout3 = sliceTensorLayoutNV(tensorLayout3, offset30, span30, offset31, span31);
   tensorViewNV<2, false, 1, 0> colMajorView3 = createTensorViewNV(2, false, 1, 0);
   coopMatStoreTensorNV(matO, outputO.x, 0, tensorLayout3);
}
