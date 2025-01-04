#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 3, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 3, binding = 1, scalar) buffer T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 36) ivec3 f;
   layout(offset = 48) uint64_t c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) uint64_t d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, scalar) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 36) ivec3 f;
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
   f = x.f;
   accum |= f.x - 7;
   accum |= f.y - 8;
   accum |= f.z - 9;
   accum |= T1(uint64_t(T1(x.c[0]))).a[0] - 3;
   accum |= T1(uint64_t(T1(x.c[0]))).a[pc.identity[1]] - 4;
   accum |= T1(uint64_t(T1(x.c[0]))).b - 5;
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][0] - 6);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[0][1] - 8);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][0] - 7);
   accum |= int(T1(uint64_t(T1(x.c[0]))).e[1][1] - 9);
   f = T1(uint64_t(T1(x.c[0]))).f;
   accum |= f.x - 10;
   accum |= f.y - 11;
   accum |= f.z - 12;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[0] - 6;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[pc.identity[1]] - 7;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).b - 8;
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][0] - 9);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][1] - 11);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][0] - 10);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][1] - 12);
   f = T1(uint64_t(T1(x.c[pc.identity[1]]))).f;
   accum |= f.x - 13;
   accum |= f.y - 14;
   accum |= f.z - 15;
   accum |= T1(uint64_t(T1(x.d))).a[0] - 9;
   accum |= T1(uint64_t(T1(x.d))).a[pc.identity[1]] - 10;
   accum |= T1(uint64_t(T1(x.d))).b - 11;
   accum |= int(T1(uint64_t(T1(x.d))).e[0][0] - 12);
   accum |= int(T1(uint64_t(T1(x.d))).e[0][1] - 14);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][0] - 13);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][1] - 15);
   f = T1(uint64_t(T1(x.d))).f;
   accum |= f.x - 16;
   accum |= f.y - 17;
   accum |= f.z - 18;
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
