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
  uvec2 zero = uvec2(0, 0);
   accum |= x.a[0] - 0;
   accum |= x.a[pc.identity[1]] - 1;
   accum |= x.b - 2;
   accum |= int(x.e[0][0] - 3);
   accum |= int(x.e[0][1] - 5);
   accum |= int(x.e[1][0] - 4);
   accum |= int(x.e[1][1] - 6);
   uvec2 l0c0 = uvec2(x.c[0]);
   uvec2 l0c1 = uvec2(x.c[pc.identity[1]]);
   uvec2 l0d  = uvec2(x.d);
   if (all(equal(l0c0, zero)) ||
       all(equal(l0c1, zero)) ||
       all(equal(l0d , zero)) ||
       all(equal(l0c0, l0c1)) ||
       all(equal(l0c1, l0d )) ||
       all(equal(l0c0, l0d )) ) {
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
   uvec2 l1c0 = uvec2(l1.c[0]);
   uvec2 l1c1 = uvec2(l1.c[pc.identity[1]]);
   uvec2 l1d  = uvec2(l1.d);
   if (all(equal(l1c0, zero)) ||
       all(equal(l1c1, zero)) ||
       all(equal(l1d , zero)) ||
       all(equal(l1c0, l1c1)) ||
       all(equal(l1c1, l1d )) ||
       all(equal(l1c0, l1d )) ) {
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
   uvec2 l4c0 = uvec2(l4.c[0]);
   uvec2 l4c1 = uvec2(l4.c[pc.identity[1]]);
   uvec2 l4d  = uvec2(l4.d);
   if (!(all(equal(l4c0, l4c1)) &&
         all(equal(l4c1, l4d )) &&
         all(equal(l4c0, l4d )) )) {
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
   uvec2 l5c0 = uvec2(l5.c[0]);
   uvec2 l5c1 = uvec2(l5.c[pc.identity[1]]);
   uvec2 l5d  = uvec2(l5.d);
   if (!(all(equal(l5c0, l5c1)) &&
         all(equal(l5c1, l5d )) &&
         all(equal(l5c0, l5d )) )) {
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
   uvec2 l6c0 = uvec2(l6.c[0]);
   uvec2 l6c1 = uvec2(l6.c[pc.identity[1]]);
   uvec2 l6d  = uvec2(l6.d);
   if (!(all(equal(l6c0, l6c1)) &&
         all(equal(l6c1, l6d )) &&
         all(equal(l6c0, l6d )) )) {
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
   uvec2 l2c0 = uvec2(l2.c[0]);
   uvec2 l2c1 = uvec2(l2.c[pc.identity[1]]);
   uvec2 l2d  = uvec2(l2.d);
   if (all(equal(l2c0, zero)) ||
       all(equal(l2c1, zero)) ||
       all(equal(l2d , zero)) ||
       all(equal(l2c0, l2c1)) ||
       all(equal(l2c1, l2d )) ||
       all(equal(l2c0, l2d )) ) {
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
   uvec2 l7c0 = uvec2(l7.c[0]);
   uvec2 l7c1 = uvec2(l7.c[pc.identity[1]]);
   uvec2 l7d  = uvec2(l7.d);
   if (!(all(equal(l7c0, l7c1)) &&
         all(equal(l7c1, l7d )) &&
         all(equal(l7c0, l7d )) )) {
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
   uvec2 l8c0 = uvec2(l8.c[0]);
   uvec2 l8c1 = uvec2(l8.c[pc.identity[1]]);
   uvec2 l8d  = uvec2(l8.d);
   if (!(all(equal(l8c0, l8c1)) &&
         all(equal(l8c1, l8d )) &&
         all(equal(l8c0, l8d )) )) {
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
   uvec2 l9c0 = uvec2(l9.c[0]);
   uvec2 l9c1 = uvec2(l9.c[pc.identity[1]]);
   uvec2 l9d  = uvec2(l9.d);
   if (!(all(equal(l9c0, l9c1)) &&
         all(equal(l9c1, l9d )) &&
         all(equal(l9c0, l9d )) )) {
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
   uvec2 l3c0 = uvec2(l3.c[0]);
   uvec2 l3c1 = uvec2(l3.c[pc.identity[1]]);
   uvec2 l3d  = uvec2(l3.d);
   if (all(equal(l3c0, zero)) ||
       all(equal(l3c1, zero)) ||
       all(equal(l3d , zero)) ||
       all(equal(l3c0, l3c1)) ||
       all(equal(l3c1, l3d )) ||
       all(equal(l3c0, l3d )) ) {
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
   uvec2 l10c0 = uvec2(l10.c[0]);
   uvec2 l10c1 = uvec2(l10.c[pc.identity[1]]);
   uvec2 l10d  = uvec2(l10.d);
   if (!(all(equal(l10c0, l10c1)) &&
         all(equal(l10c1, l10d )) &&
         all(equal(l10c0, l10d )) )) {
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
   uvec2 l11c0 = uvec2(l11.c[0]);
   uvec2 l11c1 = uvec2(l11.c[pc.identity[1]]);
   uvec2 l11d  = uvec2(l11.d);
   if (!(all(equal(l11c0, l11c1)) &&
         all(equal(l11c1, l11d )) &&
         all(equal(l11c0, l11d )) )) {
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
   uvec2 l12c0 = uvec2(l12.c[0]);
   uvec2 l12c1 = uvec2(l12.c[pc.identity[1]]);
   uvec2 l12d  = uvec2(l12.d);
   if (!(all(equal(l12c0, l12c1)) &&
         all(equal(l12c1, l12d )) &&
         all(equal(l12c0, l12d )) )) {
     accum |= 1;
   }
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
}
