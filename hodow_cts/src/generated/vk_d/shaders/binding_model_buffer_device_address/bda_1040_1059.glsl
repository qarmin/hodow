#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uvec2 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uvec2 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uvec2 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uvec2 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= T1(uint64_t(T1(x.c[0]))).a[0] - 3;
   accum |= T1(uint64_t(T1(x.c[0]))).a[pc.identity[1]] - 4;
   accum |= T1(uint64_t(T1(x.c[0]))).b - 5;
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][0] - 6);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][1] - 8);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][0] - 7);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][1] - 9);
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[0] - 6;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[pc.identity[1]] - 7;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).b - 8;
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][0] - 9);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][1] - 11);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][0] - 10);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][1] - 12);
   accum |= T1(uint64_t(T1(x.d))).a[0] - 9;
   accum |= T1(uint64_t(T1(x.d))).a[pc.identity[1]] - 10;
   accum |= T1(uint64_t(T1(x.d))).b - 11;
   accum |= int(T1(uint64_t(T1(x.d))).e[0][0] - 12);
   accum |= int(T1(uint64_t(T1(x.d))).e[0][1] - 14);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][0] - 13);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uvec2 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uvec2 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uvec2 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uvec2 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = T1(uint64_t(T1(x.c[0])));
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = T1(uint64_t(T1(x.c[pc.identity[1]])));
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = T1(uint64_t(T1(x.d)));
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450 core
void main()
{
  gl_Position = vec4( 2.0*float(gl_VertexIndex&2) - 1.0, 4.0*(gl_VertexIndex&1)-1.0, 1.0 - 2.0 * float(gl_VertexIndex&1), 1);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uvec2 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uvec2 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uvec2 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uvec2 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = T1(uint64_t(T1(x.c[0])));
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = T1(uint64_t(T1(x.c[pc.identity[1]])));
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = T1(uint64_t(T1(x.d)));
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uvec2 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uvec2 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uvec2 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uvec2 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = T1(uint64_t(T1(x.c[0])));
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = T1(uint64_t(T1(x.c[pc.identity[1]])));
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = T1(uint64_t(T1(x.d)));
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= T1(uvec2(T1(x.c[0]))).a[0] - 3;
   accum |= T1(uvec2(T1(x.c[0]))).a[pc.identity[1]] - 4;
   accum |= T1(uvec2(T1(x.c[0]))).b - 5;
   accum |= int(T1(uvec2(T1(x.c[0]))).e[0][0] - 6);
   accum |= int(T1(uvec2(T1(x.c[0]))).e[0][1] - 8);
   accum |= int(T1(uvec2(T1(x.c[0]))).e[1][0] - 7);
   accum |= int(T1(uvec2(T1(x.c[0]))).e[1][1] - 9);
   accum |= T1(uvec2(T1(x.c[pc.identity[1]]))).a[0] - 6;
   accum |= T1(uvec2(T1(x.c[pc.identity[1]]))).a[pc.identity[1]] - 7;
   accum |= T1(uvec2(T1(x.c[pc.identity[1]]))).b - 8;
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[0][0] - 9);
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[0][1] - 11);
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[1][0] - 10);
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[1][1] - 12);
   accum |= T1(uvec2(T1(x.d))).a[0] - 9;
   accum |= T1(uvec2(T1(x.d))).a[pc.identity[1]] - 10;
   accum |= T1(uvec2(T1(x.d))).b - 11;
   accum |= int(T1(uvec2(T1(x.d))).e[0][0] - 12);
   accum |= int(T1(uvec2(T1(x.d))).e[0][1] - 14);
   accum |= int(T1(uvec2(T1(x.d))).e[1][0] - 13);
   accum |= int(T1(uvec2(T1(x.d))).e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= T1(uvec2(T1(x.c[0]))).a[0] - 3;
   accum |= T1(uvec2(T1(x.c[0]))).a[pc.identity[1]] - 4;
   accum |= T1(uvec2(T1(x.c[0]))).b - 5;
   accum |= int(T1(uvec2(T1(x.c[0]))).e[0][0] - 6);
   accum |= int(T1(uvec2(T1(x.c[0]))).e[0][1] - 8);
   accum |= int(T1(uvec2(T1(x.c[0]))).e[1][0] - 7);
   accum |= int(T1(uvec2(T1(x.c[0]))).e[1][1] - 9);
   accum |= T1(uvec2(T1(x.c[pc.identity[1]]))).a[0] - 6;
   accum |= T1(uvec2(T1(x.c[pc.identity[1]]))).a[pc.identity[1]] - 7;
   accum |= T1(uvec2(T1(x.c[pc.identity[1]]))).b - 8;
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[0][0] - 9);
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[0][1] - 11);
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[1][0] - 10);
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[1][1] - 12);
   accum |= T1(uvec2(T1(x.d))).a[0] - 9;
   accum |= T1(uvec2(T1(x.d))).a[pc.identity[1]] - 10;
   accum |= T1(uvec2(T1(x.d))).b - 11;
   accum |= int(T1(uvec2(T1(x.d))).e[0][0] - 12);
   accum |= int(T1(uvec2(T1(x.d))).e[0][1] - 14);
   accum |= int(T1(uvec2(T1(x.d))).e[1][0] - 13);
   accum |= int(T1(uvec2(T1(x.d))).e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= T1(uvec2(T1(x.c[0]))).a[0] - 3;
   accum |= T1(uvec2(T1(x.c[0]))).a[pc.identity[1]] - 4;
   accum |= T1(uvec2(T1(x.c[0]))).b - 5;
   accum |= int(T1(uvec2(T1(x.c[0]))).e[0][0] - 6);
   accum |= int(T1(uvec2(T1(x.c[0]))).e[0][1] - 8);
   accum |= int(T1(uvec2(T1(x.c[0]))).e[1][0] - 7);
   accum |= int(T1(uvec2(T1(x.c[0]))).e[1][1] - 9);
   accum |= T1(uvec2(T1(x.c[pc.identity[1]]))).a[0] - 6;
   accum |= T1(uvec2(T1(x.c[pc.identity[1]]))).a[pc.identity[1]] - 7;
   accum |= T1(uvec2(T1(x.c[pc.identity[1]]))).b - 8;
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[0][0] - 9);
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[0][1] - 11);
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[1][0] - 10);
   accum |= int(T1(uvec2(T1(x.c[pc.identity[1]]))).e[1][1] - 12);
   accum |= T1(uvec2(T1(x.d))).a[0] - 9;
   accum |= T1(uvec2(T1(x.d))).a[pc.identity[1]] - 10;
   accum |= T1(uvec2(T1(x.d))).b - 11;
   accum |= int(T1(uvec2(T1(x.d))).e[0][0] - 12);
   accum |= int(T1(uvec2(T1(x.d))).e[0][1] - 14);
   accum |= int(T1(uvec2(T1(x.d))).e[1][0] - 13);
   accum |= int(T1(uvec2(T1(x.d))).e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = T1(uvec2(T1(x.c[0])));
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = T1(uvec2(T1(x.c[pc.identity[1]])));
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = T1(uvec2(T1(x.d)));
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = T1(uvec2(T1(x.c[0])));
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = T1(uvec2(T1(x.c[pc.identity[1]])));
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = T1(uvec2(T1(x.d)));
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = T1(uvec2(T1(x.c[0])));
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = T1(uvec2(T1(x.c[pc.identity[1]])));
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = T1(uvec2(T1(x.d)));
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= x.c[0].a[0] - 3;
   accum |= x.c[0].a[pc.identity[1]] - 4;
   accum |= x.c[0].b - 5;
   accum |= int(x.c[0].e[0][0] - 6);
   accum |= int(x.c[0].e[0][1] - 8);
   accum |= int(x.c[0].e[1][0] - 7);
   accum |= int(x.c[0].e[1][1] - 9);
   accum |= x.c[pc.identity[1]].a[0] - 6;
   accum |= x.c[pc.identity[1]].a[pc.identity[1]] - 7;
   accum |= x.c[pc.identity[1]].b - 8;
   accum |= int(x.c[pc.identity[1]].e[0][0] - 9);
   accum |= int(x.c[pc.identity[1]].e[0][1] - 11);
   accum |= int(x.c[pc.identity[1]].e[1][0] - 10);
   accum |= int(x.c[pc.identity[1]].e[1][1] - 12);
   accum |= x.d.a[0] - 9;
   accum |= x.d.a[pc.identity[1]] - 10;
   accum |= x.d.b - 11;
   accum |= int(x.d.e[0][0] - 12);
   accum |= int(x.d.e[0][1] - 14);
   accum |= int(x.d.e[1][0] - 13);
   accum |= int(x.d.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= x.c[0].a[0] - 3;
   accum |= x.c[0].a[pc.identity[1]] - 4;
   accum |= x.c[0].b - 5;
   accum |= int(x.c[0].e[0][0] - 6);
   accum |= int(x.c[0].e[0][1] - 8);
   accum |= int(x.c[0].e[1][0] - 7);
   accum |= int(x.c[0].e[1][1] - 9);
   accum |= x.c[pc.identity[1]].a[0] - 6;
   accum |= x.c[pc.identity[1]].a[pc.identity[1]] - 7;
   accum |= x.c[pc.identity[1]].b - 8;
   accum |= int(x.c[pc.identity[1]].e[0][0] - 9);
   accum |= int(x.c[pc.identity[1]].e[0][1] - 11);
   accum |= int(x.c[pc.identity[1]].e[1][0] - 10);
   accum |= int(x.c[pc.identity[1]].e[1][1] - 12);
   accum |= x.d.a[0] - 9;
   accum |= x.d.a[pc.identity[1]] - 10;
   accum |= x.d.b - 11;
   accum |= int(x.d.e[0][0] - 12);
   accum |= int(x.d.e[0][1] - 14);
   accum |= int(x.d.e[1][0] - 13);
   accum |= int(x.d.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= x.c[0].a[0] - 3;
   accum |= x.c[0].a[pc.identity[1]] - 4;
   accum |= x.c[0].b - 5;
   accum |= int(x.c[0].e[0][0] - 6);
   accum |= int(x.c[0].e[0][1] - 8);
   accum |= int(x.c[0].e[1][0] - 7);
   accum |= int(x.c[0].e[1][1] - 9);
   accum |= x.c[pc.identity[1]].a[0] - 6;
   accum |= x.c[pc.identity[1]].a[pc.identity[1]] - 7;
   accum |= x.c[pc.identity[1]].b - 8;
   accum |= int(x.c[pc.identity[1]].e[0][0] - 9);
   accum |= int(x.c[pc.identity[1]].e[0][1] - 11);
   accum |= int(x.c[pc.identity[1]].e[1][0] - 10);
   accum |= int(x.c[pc.identity[1]].e[1][1] - 12);
   accum |= x.d.a[0] - 9;
   accum |= x.d.a[pc.identity[1]] - 10;
   accum |= x.d.b - 11;
   accum |= int(x.d.e[0][0] - 12);
   accum |= int(x.d.e[0][1] - 14);
   accum |= int(x.d.e[1][0] - 13);
   accum |= int(x.d.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = x.c[0];
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = x.c[pc.identity[1]];
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = x.d;
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = x.c[0];
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = x.c[pc.identity[1]];
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = x.d;
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = x.c[0];
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = x.c[pc.identity[1]];
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = x.d;
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= T1(uint64_t(T1(x.c[0]))).a[0] - 3;
   accum |= T1(uint64_t(T1(x.c[0]))).a[pc.identity[1]] - 4;
   accum |= T1(uint64_t(T1(x.c[0]))).b - 5;
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][0] - 6);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][1] - 8);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][0] - 7);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][1] - 9);
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[0] - 6;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[pc.identity[1]] - 7;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).b - 8;
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][0] - 9);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][1] - 11);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][0] - 10);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][1] - 12);
   accum |= T1(uint64_t(T1(x.d))).a[0] - 9;
   accum |= T1(uint64_t(T1(x.d))).a[pc.identity[1]] - 10;
   accum |= T1(uint64_t(T1(x.d))).b - 11;
   accum |= int(T1(uint64_t(T1(x.d))).e[0][0] - 12);
   accum |= int(T1(uint64_t(T1(x.d))).e[0][1] - 14);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][0] - 13);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= T1(uint64_t(T1(x.c[0]))).a[0] - 3;
   accum |= T1(uint64_t(T1(x.c[0]))).a[pc.identity[1]] - 4;
   accum |= T1(uint64_t(T1(x.c[0]))).b - 5;
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][0] - 6);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][1] - 8);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][0] - 7);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][1] - 9);
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[0] - 6;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[pc.identity[1]] - 7;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).b - 8;
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][0] - 9);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][1] - 11);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][0] - 10);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][1] - 12);
   accum |= T1(uint64_t(T1(x.d))).a[0] - 9;
   accum |= T1(uint64_t(T1(x.d))).a[pc.identity[1]] - 10;
   accum |= T1(uint64_t(T1(x.d))).b - 11;
   accum |= int(T1(uint64_t(T1(x.d))).e[0][0] - 12);
   accum |= int(T1(uint64_t(T1(x.d))).e[0][1] - 14);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][0] - 13);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   accum |= T1(uint64_t(T1(x.c[0]))).a[0] - 3;
   accum |= T1(uint64_t(T1(x.c[0]))).a[pc.identity[1]] - 4;
   accum |= T1(uint64_t(T1(x.c[0]))).b - 5;
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][0] - 6);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][1] - 8);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][0] - 7);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][1] - 9);
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[0] - 6;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[pc.identity[1]] - 7;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).b - 8;
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][0] - 9);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][1] - 11);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][0] - 10);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][1] - 12);
   accum |= T1(uint64_t(T1(x.d))).a[0] - 9;
   accum |= T1(uint64_t(T1(x.d))).a[pc.identity[1]] - 10;
   accum |= T1(uint64_t(T1(x.d))).b - 11;
   accum |= int(T1(uint64_t(T1(x.d))).e[0][0] - 12);
   accum |= int(T1(uint64_t(T1(x.d))).e[0][1] - 14);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][0] - 13);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 31, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 31, binding = 1, std140) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, std140) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
};
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  int accum = 0, temp;
  ivec3 f;
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   restrict T1 l1 = T1(uint64_t(T1(x.c[0])));
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   T1 l2 = T1(uint64_t(T1(x.c[pc.identity[1]])));
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   restrict T1 l3 = T1(uint64_t(T1(x.d)));
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
