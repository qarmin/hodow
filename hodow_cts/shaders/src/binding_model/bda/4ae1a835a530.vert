#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 0, binding = 1, std140) buffer T2 {
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
   accum |= x.c[0].a[0] - 3;
   accum |= x.c[0].a[pc.identity[1]] - 4;
   accum |= x.c[0].b - 5;
   accum |= int(x.c[0].e[0][0] - 6);
   accum |= int(x.c[0].e[0][1] - 8);
   accum |= int(x.c[0].e[1][0] - 7);
   accum |= int(x.c[0].e[1][1] - 9);
   uint64_t l1c0 = uint64_t(x.c[0].c[0]);
   uint64_t l1c1 = uint64_t(x.c[0].c[pc.identity[1]]);
   uint64_t l1d  = uint64_t(x.c[0].d);
   if (l1c0 == zero ||
       l1c1 == zero ||
       l1d  == zero ||
       l1c0 == l1c1 ||
       l1c1 == l1d  ||
       l1c0 == l1d  ) {
     accum |= 1;
   }
   accum |= x.c[0].c[0].a[0] - 12;
   accum |= x.c[0].c[0].a[pc.identity[1]] - 13;
   accum |= x.c[0].c[0].b - 14;
   accum |= int(x.c[0].c[0].e[0][0] - 15);
   accum |= int(x.c[0].c[0].e[0][1] - 17);
   accum |= int(x.c[0].c[0].e[1][0] - 16);
   accum |= int(x.c[0].c[0].e[1][1] - 18);
   uint64_t l4c0 = uint64_t(x.c[0].c[0].c[0]);
   uint64_t l4c1 = uint64_t(x.c[0].c[0].c[pc.identity[1]]);
   uint64_t l4d  = uint64_t(x.c[0].c[0].d);
   if (!(l4c0 == l4c1 &&
         l4c1 == l4d  &&
         l4c0 == l4d  )) {
     accum |= 1;
   }
   accum |= x.c[0].c[pc.identity[1]].a[0] - 15;
   accum |= x.c[0].c[pc.identity[1]].a[pc.identity[1]] - 16;
   accum |= x.c[0].c[pc.identity[1]].b - 17;
   accum |= int(x.c[0].c[pc.identity[1]].e[0][0] - 18);
   accum |= int(x.c[0].c[pc.identity[1]].e[0][1] - 20);
   accum |= int(x.c[0].c[pc.identity[1]].e[1][0] - 19);
   accum |= int(x.c[0].c[pc.identity[1]].e[1][1] - 21);
   uint64_t l5c0 = uint64_t(x.c[0].c[pc.identity[1]].c[0]);
   uint64_t l5c1 = uint64_t(x.c[0].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l5d  = uint64_t(x.c[0].c[pc.identity[1]].d);
   if (!(l5c0 == l5c1 &&
         l5c1 == l5d  &&
         l5c0 == l5d  )) {
     accum |= 1;
   }
   accum |= x.c[0].d.a[0] - 18;
   accum |= x.c[0].d.a[pc.identity[1]] - 19;
   accum |= x.c[0].d.b - 20;
   accum |= int(x.c[0].d.e[0][0] - 21);
   accum |= int(x.c[0].d.e[0][1] - 23);
   accum |= int(x.c[0].d.e[1][0] - 22);
   accum |= int(x.c[0].d.e[1][1] - 24);
   uint64_t l6c0 = uint64_t(x.c[0].d.c[0]);
   uint64_t l6c1 = uint64_t(x.c[0].d.c[pc.identity[1]]);
   uint64_t l6d  = uint64_t(x.c[0].d.d);
   if (!(l6c0 == l6c1 &&
         l6c1 == l6d  &&
         l6c0 == l6d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].a[0] - 6;
   accum |= x.c[pc.identity[1]].a[pc.identity[1]] - 7;
   accum |= x.c[pc.identity[1]].b - 8;
   accum |= int(x.c[pc.identity[1]].e[0][0] - 9);
   accum |= int(x.c[pc.identity[1]].e[0][1] - 11);
   accum |= int(x.c[pc.identity[1]].e[1][0] - 10);
   accum |= int(x.c[pc.identity[1]].e[1][1] - 12);
   uint64_t l2c0 = uint64_t(x.c[pc.identity[1]].c[0]);
   uint64_t l2c1 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l2d  = uint64_t(x.c[pc.identity[1]].d);
   if (l2c0 == zero ||
       l2c1 == zero ||
       l2d  == zero ||
       l2c0 == l2c1 ||
       l2c1 == l2d  ||
       l2c0 == l2d  ) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[0].a[0] - 21;
   accum |= x.c[pc.identity[1]].c[0].a[pc.identity[1]] - 22;
   accum |= x.c[pc.identity[1]].c[0].b - 23;
   accum |= int(x.c[pc.identity[1]].c[0].e[0][0] - 24);
   accum |= int(x.c[pc.identity[1]].c[0].e[0][1] - 26);
   accum |= int(x.c[pc.identity[1]].c[0].e[1][0] - 25);
   accum |= int(x.c[pc.identity[1]].c[0].e[1][1] - 27);
   uint64_t l7c0 = uint64_t(x.c[pc.identity[1]].c[0].c[0]);
   uint64_t l7c1 = uint64_t(x.c[pc.identity[1]].c[0].c[pc.identity[1]]);
   uint64_t l7d  = uint64_t(x.c[pc.identity[1]].c[0].d);
   if (!(l7c0 == l7c1 &&
         l7c1 == l7d  &&
         l7c0 == l7d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].a[0] - 24;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].a[pc.identity[1]] - 25;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].b - 26;
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[0][0] - 27);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[0][1] - 29);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[1][0] - 28);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[1][1] - 30);
   uint64_t l8c0 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[0]);
   uint64_t l8c1 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l8d  = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].d);
   if (!(l8c0 == l8c1 &&
         l8c1 == l8d  &&
         l8c0 == l8d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].d.a[0] - 27;
   accum |= x.c[pc.identity[1]].d.a[pc.identity[1]] - 28;
   accum |= x.c[pc.identity[1]].d.b - 29;
   accum |= int(x.c[pc.identity[1]].d.e[0][0] - 30);
   accum |= int(x.c[pc.identity[1]].d.e[0][1] - 32);
   accum |= int(x.c[pc.identity[1]].d.e[1][0] - 31);
   accum |= int(x.c[pc.identity[1]].d.e[1][1] - 33);
   uint64_t l9c0 = uint64_t(x.c[pc.identity[1]].d.c[0]);
   uint64_t l9c1 = uint64_t(x.c[pc.identity[1]].d.c[pc.identity[1]]);
   uint64_t l9d  = uint64_t(x.c[pc.identity[1]].d.d);
   if (!(l9c0 == l9c1 &&
         l9c1 == l9d  &&
         l9c0 == l9d  )) {
     accum |= 1;
   }
   accum |= x.d.a[0] - 9;
   accum |= x.d.a[pc.identity[1]] - 10;
   accum |= x.d.b - 11;
   accum |= int(x.d.e[0][0] - 12);
   accum |= int(x.d.e[0][1] - 14);
   accum |= int(x.d.e[1][0] - 13);
   accum |= int(x.d.e[1][1] - 15);
   uint64_t l3c0 = uint64_t(x.d.c[0]);
   uint64_t l3c1 = uint64_t(x.d.c[pc.identity[1]]);
   uint64_t l3d  = uint64_t(x.d.d);
   if (l3c0 == zero ||
       l3c1 == zero ||
       l3d  == zero ||
       l3c0 == l3c1 ||
       l3c1 == l3d  ||
       l3c0 == l3d  ) {
     accum |= 1;
   }
   accum |= x.d.c[0].a[0] - 30;
   accum |= x.d.c[0].a[pc.identity[1]] - 31;
   accum |= x.d.c[0].b - 32;
   accum |= int(x.d.c[0].e[0][0] - 33);
   accum |= int(x.d.c[0].e[0][1] - 35);
   accum |= int(x.d.c[0].e[1][0] - 34);
   accum |= int(x.d.c[0].e[1][1] - 36);
   uint64_t l10c0 = uint64_t(x.d.c[0].c[0]);
   uint64_t l10c1 = uint64_t(x.d.c[0].c[pc.identity[1]]);
   uint64_t l10d  = uint64_t(x.d.c[0].d);
   if (!(l10c0 == l10c1 &&
         l10c1 == l10d  &&
         l10c0 == l10d  )) {
     accum |= 1;
   }
   accum |= x.d.c[pc.identity[1]].a[0] - 33;
   accum |= x.d.c[pc.identity[1]].a[pc.identity[1]] - 34;
   accum |= x.d.c[pc.identity[1]].b - 35;
   accum |= int(x.d.c[pc.identity[1]].e[0][0] - 36);
   accum |= int(x.d.c[pc.identity[1]].e[0][1] - 38);
   accum |= int(x.d.c[pc.identity[1]].e[1][0] - 37);
   accum |= int(x.d.c[pc.identity[1]].e[1][1] - 39);
   uint64_t l11c0 = uint64_t(x.d.c[pc.identity[1]].c[0]);
   uint64_t l11c1 = uint64_t(x.d.c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l11d  = uint64_t(x.d.c[pc.identity[1]].d);
   if (!(l11c0 == l11c1 &&
         l11c1 == l11d  &&
         l11c0 == l11d  )) {
     accum |= 1;
   }
   accum |= x.d.d.a[0] - 36;
   accum |= x.d.d.a[pc.identity[1]] - 37;
   accum |= x.d.d.b - 38;
   accum |= int(x.d.d.e[0][0] - 39);
   accum |= int(x.d.d.e[0][1] - 41);
   accum |= int(x.d.d.e[1][0] - 40);
   accum |= int(x.d.d.e[1][1] - 42);
   uint64_t l12c0 = uint64_t(x.d.d.c[0]);
   uint64_t l12c1 = uint64_t(x.d.d.c[pc.identity[1]]);
   uint64_t l12d  = uint64_t(x.d.d.d);
   if (!(l12c0 == l12c1 &&
         l12c1 == l12d  &&
         l12c0 == l12d  )) {
     accum |= 1;
   }
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
