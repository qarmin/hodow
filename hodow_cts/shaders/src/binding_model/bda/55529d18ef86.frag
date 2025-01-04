#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 3, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 3, binding = 1, std140) uniform T2 {
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
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[0]))).a[0] - 12;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[0]))).a[pc.identity[1]] - 13;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[0]))).b - 14;
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[0]))).e[0][0] - 15);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[0]))).e[0][1] - 17);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[0]))).e[1][0] - 16);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[0]))).e[1][1] - 18);
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[pc.identity[1]]))).a[0] - 15;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[pc.identity[1]]))).a[pc.identity[1]] - 16;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[pc.identity[1]]))).b - 17;
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[pc.identity[1]]))).e[0][0] - 18);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[pc.identity[1]]))).e[0][1] - 20);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[pc.identity[1]]))).e[1][0] - 19);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).c[pc.identity[1]]))).e[1][1] - 21);
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).d))).a[0] - 18;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).d))).a[pc.identity[1]] - 19;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).d))).b - 20;
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).d))).e[0][0] - 21);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).d))).e[0][1] - 23);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).d))).e[1][0] - 22);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[0]))).d))).e[1][1] - 24);
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[0] - 6;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).a[pc.identity[1]] - 7;
   accum |= T1(uint64_t(T1(x.c[pc.identity[1]]))).b - 8;
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][0] - 9);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[0][1] - 11);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][0] - 10);
   accum |= int(T1(uint64_t(T1(x.c[pc.identity[1]]))).e[1][1] - 12);
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[0]))).a[0] - 21;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[0]))).a[pc.identity[1]] - 22;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[0]))).b - 23;
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[0]))).e[0][0] - 24);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[0]))).e[0][1] - 26);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[0]))).e[1][0] - 25);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[0]))).e[1][1] - 27);
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[pc.identity[1]]))).a[0] - 24;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[pc.identity[1]]))).a[pc.identity[1]] - 25;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[pc.identity[1]]))).b - 26;
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[pc.identity[1]]))).e[0][0] - 27);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[pc.identity[1]]))).e[0][1] - 29);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[pc.identity[1]]))).e[1][0] - 28);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).c[pc.identity[1]]))).e[1][1] - 30);
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).d))).a[0] - 27;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).d))).a[pc.identity[1]] - 28;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).d))).b - 29;
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).d))).e[0][0] - 30);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).d))).e[0][1] - 32);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).d))).e[1][0] - 31);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.c[pc.identity[1]]))).d))).e[1][1] - 33);
   accum |= T1(uint64_t(T1(x.d))).a[0] - 9;
   accum |= T1(uint64_t(T1(x.d))).a[pc.identity[1]] - 10;
   accum |= T1(uint64_t(T1(x.d))).b - 11;
   accum |= int(T1(uint64_t(T1(x.d))).e[0][0] - 12);
   accum |= int(T1(uint64_t(T1(x.d))).e[0][1] - 14);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][0] - 13);
   accum |= int(T1(uint64_t(T1(x.d))).e[1][1] - 15);
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[0]))).a[0] - 30;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[0]))).a[pc.identity[1]] - 31;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[0]))).b - 32;
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[0]))).e[0][0] - 33);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[0]))).e[0][1] - 35);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[0]))).e[1][0] - 34);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[0]))).e[1][1] - 36);
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[pc.identity[1]]))).a[0] - 33;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[pc.identity[1]]))).a[pc.identity[1]] - 34;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[pc.identity[1]]))).b - 35;
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[pc.identity[1]]))).e[0][0] - 36);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[pc.identity[1]]))).e[0][1] - 38);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[pc.identity[1]]))).e[1][0] - 37);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).c[pc.identity[1]]))).e[1][1] - 39);
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.d))).d))).a[0] - 36;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.d))).d))).a[pc.identity[1]] - 37;
   accum |= T1(uint64_t(T1(T1(uint64_t(T1(x.d))).d))).b - 38;
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).d))).e[0][0] - 39);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).d))).e[0][1] - 41);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).d))).e[1][0] - 40);
   accum |= int(T1(uint64_t(T1(T1(uint64_t(T1(x.d))).d))).e[1][1] - 42);
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
