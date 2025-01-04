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
  uint64_t zero = uint64_t(0);
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   uint64_t l0c0 = uint64_t(x.c[0]);
   uint64_t l0c1 = uint64_t(x.c[pc.identity[1]]);
   uint64_t l0d  = uint64_t(x.d);
   if (l0c0 == zero ||
       l0c1 == zero ||
       l0d  == zero ||
       l0c0 == l0c1 ||
       l0c1 == l0d  ||
       l0c0 == l0d  ) {
     accum |= 1;
   }
   restrict T1 l1 = x.c[0];
   accum |= l1.a[0] - 3;
   accum |= l1.a[pc.identity[1]] - 4;
   accum |= l1.b - 5;
   accum |= int(l1.e[0][0] - 6);
   accum |= int(l1.e[0][1] - 8);
   accum |= int(l1.e[1][0] - 7);
   accum |= int(l1.e[1][1] - 9);
   uint64_t l1c0 = uint64_t(l1.c[0]);
   uint64_t l1c1 = uint64_t(l1.c[pc.identity[1]]);
   uint64_t l1d  = uint64_t(l1.d);
   if (l1c0 == zero ||
       l1c1 == zero ||
       l1d  == zero ||
       l1c0 == l1c1 ||
       l1c1 == l1d  ||
       l1c0 == l1d  ) {
     accum |= 1;
   }
   T1 l4 = l1.c[0];
   accum |= l4.a[0] - 12;
   accum |= l4.a[pc.identity[1]] - 13;
   accum |= l4.b - 14;
   accum |= int(l4.e[0][0] - 15);
   accum |= int(l4.e[0][1] - 17);
   accum |= int(l4.e[1][0] - 16);
   accum |= int(l4.e[1][1] - 18);
   uint64_t l4c0 = uint64_t(l4.c[0]);
   uint64_t l4c1 = uint64_t(l4.c[pc.identity[1]]);
   uint64_t l4d  = uint64_t(l4.d);
   if (!(l4c0 == l4c1 &&
         l4c1 == l4d  &&
         l4c0 == l4d  )) {
     accum |= 1;
   }
   restrict T1 l5 = l1.c[pc.identity[1]];
   accum |= l5.a[0] - 15;
   accum |= l5.a[pc.identity[1]] - 16;
   accum |= l5.b - 17;
   accum |= int(l5.e[0][0] - 18);
   accum |= int(l5.e[0][1] - 20);
   accum |= int(l5.e[1][0] - 19);
   accum |= int(l5.e[1][1] - 21);
   uint64_t l5c0 = uint64_t(l5.c[0]);
   uint64_t l5c1 = uint64_t(l5.c[pc.identity[1]]);
   uint64_t l5d  = uint64_t(l5.d);
   if (!(l5c0 == l5c1 &&
         l5c1 == l5d  &&
         l5c0 == l5d  )) {
     accum |= 1;
   }
   T1 l6 = l1.d;
   accum |= l6.a[0] - 18;
   accum |= l6.a[pc.identity[1]] - 19;
   accum |= l6.b - 20;
   accum |= int(l6.e[0][0] - 21);
   accum |= int(l6.e[0][1] - 23);
   accum |= int(l6.e[1][0] - 22);
   accum |= int(l6.e[1][1] - 24);
   uint64_t l6c0 = uint64_t(l6.c[0]);
   uint64_t l6c1 = uint64_t(l6.c[pc.identity[1]]);
   uint64_t l6d  = uint64_t(l6.d);
   if (!(l6c0 == l6c1 &&
         l6c1 == l6d  &&
         l6c0 == l6d  )) {
     accum |= 1;
   }
   T1 l2 = x.c[pc.identity[1]];
   accum |= l2.a[0] - 6;
   accum |= l2.a[pc.identity[1]] - 7;
   accum |= l2.b - 8;
   accum |= int(l2.e[0][0] - 9);
   accum |= int(l2.e[0][1] - 11);
   accum |= int(l2.e[1][0] - 10);
   accum |= int(l2.e[1][1] - 12);
   uint64_t l2c0 = uint64_t(l2.c[0]);
   uint64_t l2c1 = uint64_t(l2.c[pc.identity[1]]);
   uint64_t l2d  = uint64_t(l2.d);
   if (l2c0 == zero ||
       l2c1 == zero ||
       l2d  == zero ||
       l2c0 == l2c1 ||
       l2c1 == l2d  ||
       l2c0 == l2d  ) {
     accum |= 1;
   }
   restrict T1 l7 = l2.c[0];
   accum |= l7.a[0] - 21;
   accum |= l7.a[pc.identity[1]] - 22;
   accum |= l7.b - 23;
   accum |= int(l7.e[0][0] - 24);
   accum |= int(l7.e[0][1] - 26);
   accum |= int(l7.e[1][0] - 25);
   accum |= int(l7.e[1][1] - 27);
   uint64_t l7c0 = uint64_t(l7.c[0]);
   uint64_t l7c1 = uint64_t(l7.c[pc.identity[1]]);
   uint64_t l7d  = uint64_t(l7.d);
   if (!(l7c0 == l7c1 &&
         l7c1 == l7d  &&
         l7c0 == l7d  )) {
     accum |= 1;
   }
   T1 l8 = l2.c[pc.identity[1]];
   accum |= l8.a[0] - 24;
   accum |= l8.a[pc.identity[1]] - 25;
   accum |= l8.b - 26;
   accum |= int(l8.e[0][0] - 27);
   accum |= int(l8.e[0][1] - 29);
   accum |= int(l8.e[1][0] - 28);
   accum |= int(l8.e[1][1] - 30);
   uint64_t l8c0 = uint64_t(l8.c[0]);
   uint64_t l8c1 = uint64_t(l8.c[pc.identity[1]]);
   uint64_t l8d  = uint64_t(l8.d);
   if (!(l8c0 == l8c1 &&
         l8c1 == l8d  &&
         l8c0 == l8d  )) {
     accum |= 1;
   }
   restrict T1 l9 = l2.d;
   accum |= l9.a[0] - 27;
   accum |= l9.a[pc.identity[1]] - 28;
   accum |= l9.b - 29;
   accum |= int(l9.e[0][0] - 30);
   accum |= int(l9.e[0][1] - 32);
   accum |= int(l9.e[1][0] - 31);
   accum |= int(l9.e[1][1] - 33);
   uint64_t l9c0 = uint64_t(l9.c[0]);
   uint64_t l9c1 = uint64_t(l9.c[pc.identity[1]]);
   uint64_t l9d  = uint64_t(l9.d);
   if (!(l9c0 == l9c1 &&
         l9c1 == l9d  &&
         l9c0 == l9d  )) {
     accum |= 1;
   }
   restrict T1 l3 = x.d;
   accum |= l3.a[0] - 9;
   accum |= l3.a[pc.identity[1]] - 10;
   accum |= l3.b - 11;
   accum |= int(l3.e[0][0] - 12);
   accum |= int(l3.e[0][1] - 14);
   accum |= int(l3.e[1][0] - 13);
   accum |= int(l3.e[1][1] - 15);
   uint64_t l3c0 = uint64_t(l3.c[0]);
   uint64_t l3c1 = uint64_t(l3.c[pc.identity[1]]);
   uint64_t l3d  = uint64_t(l3.d);
   if (l3c0 == zero ||
       l3c1 == zero ||
       l3d  == zero ||
       l3c0 == l3c1 ||
       l3c1 == l3d  ||
       l3c0 == l3d  ) {
     accum |= 1;
   }
   T1 l10 = l3.c[0];
   accum |= l10.a[0] - 30;
   accum |= l10.a[pc.identity[1]] - 31;
   accum |= l10.b - 32;
   accum |= int(l10.e[0][0] - 33);
   accum |= int(l10.e[0][1] - 35);
   accum |= int(l10.e[1][0] - 34);
   accum |= int(l10.e[1][1] - 36);
   uint64_t l10c0 = uint64_t(l10.c[0]);
   uint64_t l10c1 = uint64_t(l10.c[pc.identity[1]]);
   uint64_t l10d  = uint64_t(l10.d);
   if (!(l10c0 == l10c1 &&
         l10c1 == l10d  &&
         l10c0 == l10d  )) {
     accum |= 1;
   }
   restrict T1 l11 = l3.c[pc.identity[1]];
   accum |= l11.a[0] - 33;
   accum |= l11.a[pc.identity[1]] - 34;
   accum |= l11.b - 35;
   accum |= int(l11.e[0][0] - 36);
   accum |= int(l11.e[0][1] - 38);
   accum |= int(l11.e[1][0] - 37);
   accum |= int(l11.e[1][1] - 39);
   uint64_t l11c0 = uint64_t(l11.c[0]);
   uint64_t l11c1 = uint64_t(l11.c[pc.identity[1]]);
   uint64_t l11d  = uint64_t(l11.d);
   if (!(l11c0 == l11c1 &&
         l11c1 == l11d  &&
         l11c0 == l11d  )) {
     accum |= 1;
   }
   T1 l12 = l3.d;
   accum |= l12.a[0] - 36;
   accum |= l12.a[pc.identity[1]] - 37;
   accum |= l12.b - 38;
   accum |= int(l12.e[0][0] - 39);
   accum |= int(l12.e[0][1] - 41);
   accum |= int(l12.e[1][0] - 40);
   accum |= int(l12.e[1][1] - 42);
   uint64_t l12c0 = uint64_t(l12.c[0]);
   uint64_t l12c1 = uint64_t(l12.c[pc.identity[1]]);
   uint64_t l12d  = uint64_t(l12.d);
   if (!(l12c0 == l12c1 &&
         l12c1 == l12d  &&
         l12c0 == l12d  )) {
     accum |= 1;
   }
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
