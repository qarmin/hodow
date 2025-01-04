#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 3, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 3, binding = 1, std140) buffer T2 {
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
   accum |= x.c[0].a[0] - 3;
   accum |= x.c[0].a[pc.identity[1]] - 4;
   accum |= x.c[0].b - 5;
   accum |= int(x.c[0].e[0][0] - 6);
   accum |= int(x.c[0].e[0][1] - 8);
   accum |= int(x.c[0].e[1][0] - 7);
   accum |= int(x.c[0].e[1][1] - 9);
   uvec2 l1c0 = uvec2(x.c[0].c[0]);
   uvec2 l1c1 = uvec2(x.c[0].c[pc.identity[1]]);
   uvec2 l1d  = uvec2(x.c[0].d);
   if (all(equal(l1c0, zero)) ||
       all(equal(l1c1, zero)) ||
       all(equal(l1d , zero)) ||
       all(equal(l1c0, l1c1)) ||
       all(equal(l1c1, l1d )) ||
       all(equal(l1c0, l1d )) ) {
     accum |= 1;
   }
   accum |= x.c[0].c[0].a[0] - 12;
   accum |= x.c[0].c[0].a[pc.identity[1]] - 13;
   accum |= x.c[0].c[0].b - 14;
   accum |= int(x.c[0].c[0].e[0][0] - 15);
   accum |= int(x.c[0].c[0].e[0][1] - 17);
   accum |= int(x.c[0].c[0].e[1][0] - 16);
   accum |= int(x.c[0].c[0].e[1][1] - 18);
   uvec2 l4c0 = uvec2(x.c[0].c[0].c[0]);
   uvec2 l4c1 = uvec2(x.c[0].c[0].c[pc.identity[1]]);
   uvec2 l4d  = uvec2(x.c[0].c[0].d);
   if (all(equal(l4c0, zero)) ||
       all(equal(l4c1, zero)) ||
       all(equal(l4d , zero)) ||
       all(equal(l4c0, l4c1)) ||
       all(equal(l4c1, l4d )) ||
       all(equal(l4c0, l4d )) ) {
     accum |= 1;
   }
   accum |= x.c[0].c[0].c[0].a[0] - 39;
   accum |= x.c[0].c[0].c[0].a[pc.identity[1]] - 40;
   accum |= x.c[0].c[0].c[0].b - 41;
   accum |= int(x.c[0].c[0].c[0].e[0][0] - 42);
   accum |= int(x.c[0].c[0].c[0].e[0][1] - 44);
   accum |= int(x.c[0].c[0].c[0].e[1][0] - 43);
   accum |= int(x.c[0].c[0].c[0].e[1][1] - 45);
   uvec2 l13c0 = uvec2(x.c[0].c[0].c[0].c[0]);
   uvec2 l13c1 = uvec2(x.c[0].c[0].c[0].c[pc.identity[1]]);
   uvec2 l13d  = uvec2(x.c[0].c[0].c[0].d);
   if (!(all(equal(l13c0, l13c1)) &&
         all(equal(l13c1, l13d )) &&
         all(equal(l13c0, l13d )) )) {
     accum |= 1;
   }
   accum |= x.c[0].c[0].c[pc.identity[1]].a[0] - 42;
   accum |= x.c[0].c[0].c[pc.identity[1]].a[pc.identity[1]] - 43;
   accum |= x.c[0].c[0].c[pc.identity[1]].b - 44;
   accum |= int(x.c[0].c[0].c[pc.identity[1]].e[0][0] - 45);
   accum |= int(x.c[0].c[0].c[pc.identity[1]].e[0][1] - 47);
   accum |= int(x.c[0].c[0].c[pc.identity[1]].e[1][0] - 46);
   accum |= int(x.c[0].c[0].c[pc.identity[1]].e[1][1] - 48);
   uvec2 l14c0 = uvec2(x.c[0].c[0].c[pc.identity[1]].c[0]);
   uvec2 l14c1 = uvec2(x.c[0].c[0].c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l14d  = uvec2(x.c[0].c[0].c[pc.identity[1]].d);
   if (!(all(equal(l14c0, l14c1)) &&
         all(equal(l14c1, l14d )) &&
         all(equal(l14c0, l14d )) )) {
     accum |= 1;
   }
   accum |= x.c[0].c[0].d.a[0] - 45;
   accum |= x.c[0].c[0].d.a[pc.identity[1]] - 46;
   accum |= x.c[0].c[0].d.b - 47;
   accum |= int(x.c[0].c[0].d.e[0][0] - 48);
   accum |= int(x.c[0].c[0].d.e[0][1] - 50);
   accum |= int(x.c[0].c[0].d.e[1][0] - 49);
   accum |= int(x.c[0].c[0].d.e[1][1] - 51);
   uvec2 l15c0 = uvec2(x.c[0].c[0].d.c[0]);
   uvec2 l15c1 = uvec2(x.c[0].c[0].d.c[pc.identity[1]]);
   uvec2 l15d  = uvec2(x.c[0].c[0].d.d);
   if (!(all(equal(l15c0, l15c1)) &&
         all(equal(l15c1, l15d )) &&
         all(equal(l15c0, l15d )) )) {
     accum |= 1;
   }
   accum |= x.c[0].c[pc.identity[1]].a[0] - 15;
   accum |= x.c[0].c[pc.identity[1]].a[pc.identity[1]] - 16;
   accum |= x.c[0].c[pc.identity[1]].b - 17;
   accum |= int(x.c[0].c[pc.identity[1]].e[0][0] - 18);
   accum |= int(x.c[0].c[pc.identity[1]].e[0][1] - 20);
   accum |= int(x.c[0].c[pc.identity[1]].e[1][0] - 19);
   accum |= int(x.c[0].c[pc.identity[1]].e[1][1] - 21);
   uvec2 l5c0 = uvec2(x.c[0].c[pc.identity[1]].c[0]);
   uvec2 l5c1 = uvec2(x.c[0].c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l5d  = uvec2(x.c[0].c[pc.identity[1]].d);
   if (all(equal(l5c0, zero)) ||
       all(equal(l5c1, zero)) ||
       all(equal(l5d , zero)) ||
       all(equal(l5c0, l5c1)) ||
       all(equal(l5c1, l5d )) ||
       all(equal(l5c0, l5d )) ) {
     accum |= 1;
   }
   accum |= x.c[0].c[pc.identity[1]].c[0].a[0] - 48;
   accum |= x.c[0].c[pc.identity[1]].c[0].a[pc.identity[1]] - 49;
   accum |= x.c[0].c[pc.identity[1]].c[0].b - 50;
   accum |= int(x.c[0].c[pc.identity[1]].c[0].e[0][0] - 51);
   accum |= int(x.c[0].c[pc.identity[1]].c[0].e[0][1] - 53);
   accum |= int(x.c[0].c[pc.identity[1]].c[0].e[1][0] - 52);
   accum |= int(x.c[0].c[pc.identity[1]].c[0].e[1][1] - 54);
   uvec2 l16c0 = uvec2(x.c[0].c[pc.identity[1]].c[0].c[0]);
   uvec2 l16c1 = uvec2(x.c[0].c[pc.identity[1]].c[0].c[pc.identity[1]]);
   uvec2 l16d  = uvec2(x.c[0].c[pc.identity[1]].c[0].d);
   if (!(all(equal(l16c0, l16c1)) &&
         all(equal(l16c1, l16d )) &&
         all(equal(l16c0, l16d )) )) {
     accum |= 1;
   }
   accum |= x.c[0].c[pc.identity[1]].c[pc.identity[1]].a[0] - 51;
   accum |= x.c[0].c[pc.identity[1]].c[pc.identity[1]].a[pc.identity[1]] - 52;
   accum |= x.c[0].c[pc.identity[1]].c[pc.identity[1]].b - 53;
   accum |= int(x.c[0].c[pc.identity[1]].c[pc.identity[1]].e[0][0] - 54);
   accum |= int(x.c[0].c[pc.identity[1]].c[pc.identity[1]].e[0][1] - 56);
   accum |= int(x.c[0].c[pc.identity[1]].c[pc.identity[1]].e[1][0] - 55);
   accum |= int(x.c[0].c[pc.identity[1]].c[pc.identity[1]].e[1][1] - 57);
   uvec2 l17c0 = uvec2(x.c[0].c[pc.identity[1]].c[pc.identity[1]].c[0]);
   uvec2 l17c1 = uvec2(x.c[0].c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l17d  = uvec2(x.c[0].c[pc.identity[1]].c[pc.identity[1]].d);
   if (!(all(equal(l17c0, l17c1)) &&
         all(equal(l17c1, l17d )) &&
         all(equal(l17c0, l17d )) )) {
     accum |= 1;
   }
   accum |= x.c[0].c[pc.identity[1]].d.a[0] - 54;
   accum |= x.c[0].c[pc.identity[1]].d.a[pc.identity[1]] - 55;
   accum |= x.c[0].c[pc.identity[1]].d.b - 56;
   accum |= int(x.c[0].c[pc.identity[1]].d.e[0][0] - 57);
   accum |= int(x.c[0].c[pc.identity[1]].d.e[0][1] - 59);
   accum |= int(x.c[0].c[pc.identity[1]].d.e[1][0] - 58);
   accum |= int(x.c[0].c[pc.identity[1]].d.e[1][1] - 60);
   uvec2 l18c0 = uvec2(x.c[0].c[pc.identity[1]].d.c[0]);
   uvec2 l18c1 = uvec2(x.c[0].c[pc.identity[1]].d.c[pc.identity[1]]);
   uvec2 l18d  = uvec2(x.c[0].c[pc.identity[1]].d.d);
   if (!(all(equal(l18c0, l18c1)) &&
         all(equal(l18c1, l18d )) &&
         all(equal(l18c0, l18d )) )) {
     accum |= 1;
   }
   accum |= x.c[0].d.a[0] - 18;
   accum |= x.c[0].d.a[pc.identity[1]] - 19;
   accum |= x.c[0].d.b - 20;
   accum |= int(x.c[0].d.e[0][0] - 21);
   accum |= int(x.c[0].d.e[0][1] - 23);
   accum |= int(x.c[0].d.e[1][0] - 22);
   accum |= int(x.c[0].d.e[1][1] - 24);
   uvec2 l6c0 = uvec2(x.c[0].d.c[0]);
   uvec2 l6c1 = uvec2(x.c[0].d.c[pc.identity[1]]);
   uvec2 l6d  = uvec2(x.c[0].d.d);
   if (all(equal(l6c0, zero)) ||
       all(equal(l6c1, zero)) ||
       all(equal(l6d , zero)) ||
       all(equal(l6c0, l6c1)) ||
       all(equal(l6c1, l6d )) ||
       all(equal(l6c0, l6d )) ) {
     accum |= 1;
   }
   accum |= x.c[0].d.c[0].a[0] - 57;
   accum |= x.c[0].d.c[0].a[pc.identity[1]] - 58;
   accum |= x.c[0].d.c[0].b - 59;
   accum |= int(x.c[0].d.c[0].e[0][0] - 60);
   accum |= int(x.c[0].d.c[0].e[0][1] - 62);
   accum |= int(x.c[0].d.c[0].e[1][0] - 61);
   accum |= int(x.c[0].d.c[0].e[1][1] - 63);
   uvec2 l19c0 = uvec2(x.c[0].d.c[0].c[0]);
   uvec2 l19c1 = uvec2(x.c[0].d.c[0].c[pc.identity[1]]);
   uvec2 l19d  = uvec2(x.c[0].d.c[0].d);
   if (!(all(equal(l19c0, l19c1)) &&
         all(equal(l19c1, l19d )) &&
         all(equal(l19c0, l19d )) )) {
     accum |= 1;
   }
   accum |= x.c[0].d.c[pc.identity[1]].a[0] - 60;
   accum |= x.c[0].d.c[pc.identity[1]].a[pc.identity[1]] - 61;
   accum |= x.c[0].d.c[pc.identity[1]].b - 62;
   accum |= int(x.c[0].d.c[pc.identity[1]].e[0][0] - 63);
   accum |= int(x.c[0].d.c[pc.identity[1]].e[0][1] - 65);
   accum |= int(x.c[0].d.c[pc.identity[1]].e[1][0] - 64);
   accum |= int(x.c[0].d.c[pc.identity[1]].e[1][1] - 66);
   uvec2 l20c0 = uvec2(x.c[0].d.c[pc.identity[1]].c[0]);
   uvec2 l20c1 = uvec2(x.c[0].d.c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l20d  = uvec2(x.c[0].d.c[pc.identity[1]].d);
   if (!(all(equal(l20c0, l20c1)) &&
         all(equal(l20c1, l20d )) &&
         all(equal(l20c0, l20d )) )) {
     accum |= 1;
   }
   accum |= x.c[0].d.d.a[0] - 63;
   accum |= x.c[0].d.d.a[pc.identity[1]] - 64;
   accum |= x.c[0].d.d.b - 65;
   accum |= int(x.c[0].d.d.e[0][0] - 66);
   accum |= int(x.c[0].d.d.e[0][1] - 68);
   accum |= int(x.c[0].d.d.e[1][0] - 67);
   accum |= int(x.c[0].d.d.e[1][1] - 69);
   uvec2 l21c0 = uvec2(x.c[0].d.d.c[0]);
   uvec2 l21c1 = uvec2(x.c[0].d.d.c[pc.identity[1]]);
   uvec2 l21d  = uvec2(x.c[0].d.d.d);
   if (!(all(equal(l21c0, l21c1)) &&
         all(equal(l21c1, l21d )) &&
         all(equal(l21c0, l21d )) )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].a[0] - 6;
   accum |= x.c[pc.identity[1]].a[pc.identity[1]] - 7;
   accum |= x.c[pc.identity[1]].b - 8;
   accum |= int(x.c[pc.identity[1]].e[0][0] - 9);
   accum |= int(x.c[pc.identity[1]].e[0][1] - 11);
   accum |= int(x.c[pc.identity[1]].e[1][0] - 10);
   accum |= int(x.c[pc.identity[1]].e[1][1] - 12);
   uvec2 l2c0 = uvec2(x.c[pc.identity[1]].c[0]);
   uvec2 l2c1 = uvec2(x.c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l2d  = uvec2(x.c[pc.identity[1]].d);
   if (all(equal(l2c0, zero)) ||
       all(equal(l2c1, zero)) ||
       all(equal(l2d , zero)) ||
       all(equal(l2c0, l2c1)) ||
       all(equal(l2c1, l2d )) ||
       all(equal(l2c0, l2d )) ) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[0].a[0] - 21;
   accum |= x.c[pc.identity[1]].c[0].a[pc.identity[1]] - 22;
   accum |= x.c[pc.identity[1]].c[0].b - 23;
   accum |= int(x.c[pc.identity[1]].c[0].e[0][0] - 24);
   accum |= int(x.c[pc.identity[1]].c[0].e[0][1] - 26);
   accum |= int(x.c[pc.identity[1]].c[0].e[1][0] - 25);
   accum |= int(x.c[pc.identity[1]].c[0].e[1][1] - 27);
   uvec2 l7c0 = uvec2(x.c[pc.identity[1]].c[0].c[0]);
   uvec2 l7c1 = uvec2(x.c[pc.identity[1]].c[0].c[pc.identity[1]]);
   uvec2 l7d  = uvec2(x.c[pc.identity[1]].c[0].d);
   if (all(equal(l7c0, zero)) ||
       all(equal(l7c1, zero)) ||
       all(equal(l7d , zero)) ||
       all(equal(l7c0, l7c1)) ||
       all(equal(l7c1, l7d )) ||
       all(equal(l7c0, l7d )) ) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[0].c[0].a[0] - 66;
   accum |= x.c[pc.identity[1]].c[0].c[0].a[pc.identity[1]] - 67;
   accum |= x.c[pc.identity[1]].c[0].c[0].b - 68;
   accum |= int(x.c[pc.identity[1]].c[0].c[0].e[0][0] - 69);
   accum |= int(x.c[pc.identity[1]].c[0].c[0].e[0][1] - 71);
   accum |= int(x.c[pc.identity[1]].c[0].c[0].e[1][0] - 70);
   accum |= int(x.c[pc.identity[1]].c[0].c[0].e[1][1] - 72);
   uvec2 l22c0 = uvec2(x.c[pc.identity[1]].c[0].c[0].c[0]);
   uvec2 l22c1 = uvec2(x.c[pc.identity[1]].c[0].c[0].c[pc.identity[1]]);
   uvec2 l22d  = uvec2(x.c[pc.identity[1]].c[0].c[0].d);
   if (!(all(equal(l22c0, l22c1)) &&
         all(equal(l22c1, l22d )) &&
         all(equal(l22c0, l22d )) )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[0].c[pc.identity[1]].a[0] - 69;
   accum |= x.c[pc.identity[1]].c[0].c[pc.identity[1]].a[pc.identity[1]] - 70;
   accum |= x.c[pc.identity[1]].c[0].c[pc.identity[1]].b - 71;
   accum |= int(x.c[pc.identity[1]].c[0].c[pc.identity[1]].e[0][0] - 72);
   accum |= int(x.c[pc.identity[1]].c[0].c[pc.identity[1]].e[0][1] - 74);
   accum |= int(x.c[pc.identity[1]].c[0].c[pc.identity[1]].e[1][0] - 73);
   accum |= int(x.c[pc.identity[1]].c[0].c[pc.identity[1]].e[1][1] - 75);
   uvec2 l23c0 = uvec2(x.c[pc.identity[1]].c[0].c[pc.identity[1]].c[0]);
   uvec2 l23c1 = uvec2(x.c[pc.identity[1]].c[0].c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l23d  = uvec2(x.c[pc.identity[1]].c[0].c[pc.identity[1]].d);
   if (!(all(equal(l23c0, l23c1)) &&
         all(equal(l23c1, l23d )) &&
         all(equal(l23c0, l23d )) )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[0].d.a[0] - 72;
   accum |= x.c[pc.identity[1]].c[0].d.a[pc.identity[1]] - 73;
   accum |= x.c[pc.identity[1]].c[0].d.b - 74;
   accum |= int(x.c[pc.identity[1]].c[0].d.e[0][0] - 75);
   accum |= int(x.c[pc.identity[1]].c[0].d.e[0][1] - 77);
   accum |= int(x.c[pc.identity[1]].c[0].d.e[1][0] - 76);
   accum |= int(x.c[pc.identity[1]].c[0].d.e[1][1] - 78);
   uvec2 l24c0 = uvec2(x.c[pc.identity[1]].c[0].d.c[0]);
   uvec2 l24c1 = uvec2(x.c[pc.identity[1]].c[0].d.c[pc.identity[1]]);
   uvec2 l24d  = uvec2(x.c[pc.identity[1]].c[0].d.d);
   if (!(all(equal(l24c0, l24c1)) &&
         all(equal(l24c1, l24d )) &&
         all(equal(l24c0, l24d )) )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].a[0] - 24;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].a[pc.identity[1]] - 25;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].b - 26;
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[0][0] - 27);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[0][1] - 29);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[1][0] - 28);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[1][1] - 30);
   uvec2 l8c0 = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].c[0]);
   uvec2 l8c1 = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l8d  = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].d);
   if (all(equal(l8c0, zero)) ||
       all(equal(l8c1, zero)) ||
       all(equal(l8d , zero)) ||
       all(equal(l8c0, l8c1)) ||
       all(equal(l8c1, l8d )) ||
       all(equal(l8c0, l8d )) ) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[0].a[0] - 75;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[0].a[pc.identity[1]] - 76;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[0].b - 77;
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[0].e[0][0] - 78);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[0].e[0][1] - 80);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[0].e[1][0] - 79);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[0].e[1][1] - 81);
   uvec2 l25c0 = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].c[0].c[0]);
   uvec2 l25c1 = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].c[0].c[pc.identity[1]]);
   uvec2 l25d  = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].c[0].d);
   if (!(all(equal(l25c0, l25c1)) &&
         all(equal(l25c1, l25d )) &&
         all(equal(l25c0, l25d )) )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].a[0] - 78;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].a[pc.identity[1]] - 79;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].b - 80;
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].e[0][0] - 81);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].e[0][1] - 83);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].e[1][0] - 82);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].e[1][1] - 84);
   uvec2 l26c0 = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].c[0]);
   uvec2 l26c1 = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l26d  = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].d);
   if (!(all(equal(l26c0, l26c1)) &&
         all(equal(l26c1, l26d )) &&
         all(equal(l26c0, l26d )) )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].d.a[0] - 81;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].d.a[pc.identity[1]] - 82;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].d.b - 83;
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].d.e[0][0] - 84);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].d.e[0][1] - 86);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].d.e[1][0] - 85);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].d.e[1][1] - 87);
   uvec2 l27c0 = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].d.c[0]);
   uvec2 l27c1 = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].d.c[pc.identity[1]]);
   uvec2 l27d  = uvec2(x.c[pc.identity[1]].c[pc.identity[1]].d.d);
   if (!(all(equal(l27c0, l27c1)) &&
         all(equal(l27c1, l27d )) &&
         all(equal(l27c0, l27d )) )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].d.a[0] - 27;
   accum |= x.c[pc.identity[1]].d.a[pc.identity[1]] - 28;
   accum |= x.c[pc.identity[1]].d.b - 29;
   accum |= int(x.c[pc.identity[1]].d.e[0][0] - 30);
   accum |= int(x.c[pc.identity[1]].d.e[0][1] - 32);
   accum |= int(x.c[pc.identity[1]].d.e[1][0] - 31);
   accum |= int(x.c[pc.identity[1]].d.e[1][1] - 33);
   uvec2 l9c0 = uvec2(x.c[pc.identity[1]].d.c[0]);
   uvec2 l9c1 = uvec2(x.c[pc.identity[1]].d.c[pc.identity[1]]);
   uvec2 l9d  = uvec2(x.c[pc.identity[1]].d.d);
   if (all(equal(l9c0, zero)) ||
       all(equal(l9c1, zero)) ||
       all(equal(l9d , zero)) ||
       all(equal(l9c0, l9c1)) ||
       all(equal(l9c1, l9d )) ||
       all(equal(l9c0, l9d )) ) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].d.c[0].a[0] - 84;
   accum |= x.c[pc.identity[1]].d.c[0].a[pc.identity[1]] - 85;
   accum |= x.c[pc.identity[1]].d.c[0].b - 86;
   accum |= int(x.c[pc.identity[1]].d.c[0].e[0][0] - 87);
   accum |= int(x.c[pc.identity[1]].d.c[0].e[0][1] - 89);
   accum |= int(x.c[pc.identity[1]].d.c[0].e[1][0] - 88);
   accum |= int(x.c[pc.identity[1]].d.c[0].e[1][1] - 90);
   uvec2 l28c0 = uvec2(x.c[pc.identity[1]].d.c[0].c[0]);
   uvec2 l28c1 = uvec2(x.c[pc.identity[1]].d.c[0].c[pc.identity[1]]);
   uvec2 l28d  = uvec2(x.c[pc.identity[1]].d.c[0].d);
   if (!(all(equal(l28c0, l28c1)) &&
         all(equal(l28c1, l28d )) &&
         all(equal(l28c0, l28d )) )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].d.c[pc.identity[1]].a[0] - 87;
   accum |= x.c[pc.identity[1]].d.c[pc.identity[1]].a[pc.identity[1]] - 88;
   accum |= x.c[pc.identity[1]].d.c[pc.identity[1]].b - 89;
   accum |= int(x.c[pc.identity[1]].d.c[pc.identity[1]].e[0][0] - 90);
   accum |= int(x.c[pc.identity[1]].d.c[pc.identity[1]].e[0][1] - 92);
   accum |= int(x.c[pc.identity[1]].d.c[pc.identity[1]].e[1][0] - 91);
   accum |= int(x.c[pc.identity[1]].d.c[pc.identity[1]].e[1][1] - 93);
   uvec2 l29c0 = uvec2(x.c[pc.identity[1]].d.c[pc.identity[1]].c[0]);
   uvec2 l29c1 = uvec2(x.c[pc.identity[1]].d.c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l29d  = uvec2(x.c[pc.identity[1]].d.c[pc.identity[1]].d);
   if (!(all(equal(l29c0, l29c1)) &&
         all(equal(l29c1, l29d )) &&
         all(equal(l29c0, l29d )) )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].d.d.a[0] - 90;
   accum |= x.c[pc.identity[1]].d.d.a[pc.identity[1]] - 91;
   accum |= x.c[pc.identity[1]].d.d.b - 92;
   accum |= int(x.c[pc.identity[1]].d.d.e[0][0] - 93);
   accum |= int(x.c[pc.identity[1]].d.d.e[0][1] - 95);
   accum |= int(x.c[pc.identity[1]].d.d.e[1][0] - 94);
   accum |= int(x.c[pc.identity[1]].d.d.e[1][1] - 96);
   uvec2 l30c0 = uvec2(x.c[pc.identity[1]].d.d.c[0]);
   uvec2 l30c1 = uvec2(x.c[pc.identity[1]].d.d.c[pc.identity[1]]);
   uvec2 l30d  = uvec2(x.c[pc.identity[1]].d.d.d);
   if (!(all(equal(l30c0, l30c1)) &&
         all(equal(l30c1, l30d )) &&
         all(equal(l30c0, l30d )) )) {
     accum |= 1;
   }
   accum |= x.d.a[0] - 9;
   accum |= x.d.a[pc.identity[1]] - 10;
   accum |= x.d.b - 11;
   accum |= int(x.d.e[0][0] - 12);
   accum |= int(x.d.e[0][1] - 14);
   accum |= int(x.d.e[1][0] - 13);
   accum |= int(x.d.e[1][1] - 15);
   uvec2 l3c0 = uvec2(x.d.c[0]);
   uvec2 l3c1 = uvec2(x.d.c[pc.identity[1]]);
   uvec2 l3d  = uvec2(x.d.d);
   if (all(equal(l3c0, zero)) ||
       all(equal(l3c1, zero)) ||
       all(equal(l3d , zero)) ||
       all(equal(l3c0, l3c1)) ||
       all(equal(l3c1, l3d )) ||
       all(equal(l3c0, l3d )) ) {
     accum |= 1;
   }
   accum |= x.d.c[0].a[0] - 30;
   accum |= x.d.c[0].a[pc.identity[1]] - 31;
   accum |= x.d.c[0].b - 32;
   accum |= int(x.d.c[0].e[0][0] - 33);
   accum |= int(x.d.c[0].e[0][1] - 35);
   accum |= int(x.d.c[0].e[1][0] - 34);
   accum |= int(x.d.c[0].e[1][1] - 36);
   uvec2 l10c0 = uvec2(x.d.c[0].c[0]);
   uvec2 l10c1 = uvec2(x.d.c[0].c[pc.identity[1]]);
   uvec2 l10d  = uvec2(x.d.c[0].d);
   if (all(equal(l10c0, zero)) ||
       all(equal(l10c1, zero)) ||
       all(equal(l10d , zero)) ||
       all(equal(l10c0, l10c1)) ||
       all(equal(l10c1, l10d )) ||
       all(equal(l10c0, l10d )) ) {
     accum |= 1;
   }
   accum |= x.d.c[0].c[0].a[0] - 93;
   accum |= x.d.c[0].c[0].a[pc.identity[1]] - 94;
   accum |= x.d.c[0].c[0].b - 95;
   accum |= int(x.d.c[0].c[0].e[0][0] - 96);
   accum |= int(x.d.c[0].c[0].e[0][1] - 98);
   accum |= int(x.d.c[0].c[0].e[1][0] - 97);
   accum |= int(x.d.c[0].c[0].e[1][1] - 99);
   uvec2 l31c0 = uvec2(x.d.c[0].c[0].c[0]);
   uvec2 l31c1 = uvec2(x.d.c[0].c[0].c[pc.identity[1]]);
   uvec2 l31d  = uvec2(x.d.c[0].c[0].d);
   if (!(all(equal(l31c0, l31c1)) &&
         all(equal(l31c1, l31d )) &&
         all(equal(l31c0, l31d )) )) {
     accum |= 1;
   }
   accum |= x.d.c[0].c[pc.identity[1]].a[0] - 96;
   accum |= x.d.c[0].c[pc.identity[1]].a[pc.identity[1]] - 97;
   accum |= x.d.c[0].c[pc.identity[1]].b - 98;
   accum |= int(x.d.c[0].c[pc.identity[1]].e[0][0] - 99);
   accum |= int(x.d.c[0].c[pc.identity[1]].e[0][1] - 101);
   accum |= int(x.d.c[0].c[pc.identity[1]].e[1][0] - 100);
   accum |= int(x.d.c[0].c[pc.identity[1]].e[1][1] - 102);
   uvec2 l32c0 = uvec2(x.d.c[0].c[pc.identity[1]].c[0]);
   uvec2 l32c1 = uvec2(x.d.c[0].c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l32d  = uvec2(x.d.c[0].c[pc.identity[1]].d);
   if (!(all(equal(l32c0, l32c1)) &&
         all(equal(l32c1, l32d )) &&
         all(equal(l32c0, l32d )) )) {
     accum |= 1;
   }
   accum |= x.d.c[0].d.a[0] - 99;
   accum |= x.d.c[0].d.a[pc.identity[1]] - 100;
   accum |= x.d.c[0].d.b - 101;
   accum |= int(x.d.c[0].d.e[0][0] - 102);
   accum |= int(x.d.c[0].d.e[0][1] - 104);
   accum |= int(x.d.c[0].d.e[1][0] - 103);
   accum |= int(x.d.c[0].d.e[1][1] - 105);
   uvec2 l33c0 = uvec2(x.d.c[0].d.c[0]);
   uvec2 l33c1 = uvec2(x.d.c[0].d.c[pc.identity[1]]);
   uvec2 l33d  = uvec2(x.d.c[0].d.d);
   if (!(all(equal(l33c0, l33c1)) &&
         all(equal(l33c1, l33d )) &&
         all(equal(l33c0, l33d )) )) {
     accum |= 1;
   }
   accum |= x.d.c[pc.identity[1]].a[0] - 33;
   accum |= x.d.c[pc.identity[1]].a[pc.identity[1]] - 34;
   accum |= x.d.c[pc.identity[1]].b - 35;
   accum |= int(x.d.c[pc.identity[1]].e[0][0] - 36);
   accum |= int(x.d.c[pc.identity[1]].e[0][1] - 38);
   accum |= int(x.d.c[pc.identity[1]].e[1][0] - 37);
   accum |= int(x.d.c[pc.identity[1]].e[1][1] - 39);
   uvec2 l11c0 = uvec2(x.d.c[pc.identity[1]].c[0]);
   uvec2 l11c1 = uvec2(x.d.c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l11d  = uvec2(x.d.c[pc.identity[1]].d);
   if (all(equal(l11c0, zero)) ||
       all(equal(l11c1, zero)) ||
       all(equal(l11d , zero)) ||
       all(equal(l11c0, l11c1)) ||
       all(equal(l11c1, l11d )) ||
       all(equal(l11c0, l11d )) ) {
     accum |= 1;
   }
   accum |= x.d.c[pc.identity[1]].c[0].a[0] - 102;
   accum |= x.d.c[pc.identity[1]].c[0].a[pc.identity[1]] - 103;
   accum |= x.d.c[pc.identity[1]].c[0].b - 104;
   accum |= int(x.d.c[pc.identity[1]].c[0].e[0][0] - 105);
   accum |= int(x.d.c[pc.identity[1]].c[0].e[0][1] - 107);
   accum |= int(x.d.c[pc.identity[1]].c[0].e[1][0] - 106);
   accum |= int(x.d.c[pc.identity[1]].c[0].e[1][1] - 108);
   uvec2 l34c0 = uvec2(x.d.c[pc.identity[1]].c[0].c[0]);
   uvec2 l34c1 = uvec2(x.d.c[pc.identity[1]].c[0].c[pc.identity[1]]);
   uvec2 l34d  = uvec2(x.d.c[pc.identity[1]].c[0].d);
   if (!(all(equal(l34c0, l34c1)) &&
         all(equal(l34c1, l34d )) &&
         all(equal(l34c0, l34d )) )) {
     accum |= 1;
   }
   accum |= x.d.c[pc.identity[1]].c[pc.identity[1]].a[0] - 105;
   accum |= x.d.c[pc.identity[1]].c[pc.identity[1]].a[pc.identity[1]] - 106;
   accum |= x.d.c[pc.identity[1]].c[pc.identity[1]].b - 107;
   accum |= int(x.d.c[pc.identity[1]].c[pc.identity[1]].e[0][0] - 108);
   accum |= int(x.d.c[pc.identity[1]].c[pc.identity[1]].e[0][1] - 110);
   accum |= int(x.d.c[pc.identity[1]].c[pc.identity[1]].e[1][0] - 109);
   accum |= int(x.d.c[pc.identity[1]].c[pc.identity[1]].e[1][1] - 111);
   uvec2 l35c0 = uvec2(x.d.c[pc.identity[1]].c[pc.identity[1]].c[0]);
   uvec2 l35c1 = uvec2(x.d.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l35d  = uvec2(x.d.c[pc.identity[1]].c[pc.identity[1]].d);
   if (!(all(equal(l35c0, l35c1)) &&
         all(equal(l35c1, l35d )) &&
         all(equal(l35c0, l35d )) )) {
     accum |= 1;
   }
   accum |= x.d.c[pc.identity[1]].d.a[0] - 108;
   accum |= x.d.c[pc.identity[1]].d.a[pc.identity[1]] - 109;
   accum |= x.d.c[pc.identity[1]].d.b - 110;
   accum |= int(x.d.c[pc.identity[1]].d.e[0][0] - 111);
   accum |= int(x.d.c[pc.identity[1]].d.e[0][1] - 113);
   accum |= int(x.d.c[pc.identity[1]].d.e[1][0] - 112);
   accum |= int(x.d.c[pc.identity[1]].d.e[1][1] - 114);
   uvec2 l36c0 = uvec2(x.d.c[pc.identity[1]].d.c[0]);
   uvec2 l36c1 = uvec2(x.d.c[pc.identity[1]].d.c[pc.identity[1]]);
   uvec2 l36d  = uvec2(x.d.c[pc.identity[1]].d.d);
   if (!(all(equal(l36c0, l36c1)) &&
         all(equal(l36c1, l36d )) &&
         all(equal(l36c0, l36d )) )) {
     accum |= 1;
   }
   accum |= x.d.d.a[0] - 36;
   accum |= x.d.d.a[pc.identity[1]] - 37;
   accum |= x.d.d.b - 38;
   accum |= int(x.d.d.e[0][0] - 39);
   accum |= int(x.d.d.e[0][1] - 41);
   accum |= int(x.d.d.e[1][0] - 40);
   accum |= int(x.d.d.e[1][1] - 42);
   uvec2 l12c0 = uvec2(x.d.d.c[0]);
   uvec2 l12c1 = uvec2(x.d.d.c[pc.identity[1]]);
   uvec2 l12d  = uvec2(x.d.d.d);
   if (all(equal(l12c0, zero)) ||
       all(equal(l12c1, zero)) ||
       all(equal(l12d , zero)) ||
       all(equal(l12c0, l12c1)) ||
       all(equal(l12c1, l12d )) ||
       all(equal(l12c0, l12d )) ) {
     accum |= 1;
   }
   accum |= x.d.d.c[0].a[0] - 111;
   accum |= x.d.d.c[0].a[pc.identity[1]] - 112;
   accum |= x.d.d.c[0].b - 113;
   accum |= int(x.d.d.c[0].e[0][0] - 114);
   accum |= int(x.d.d.c[0].e[0][1] - 116);
   accum |= int(x.d.d.c[0].e[1][0] - 115);
   accum |= int(x.d.d.c[0].e[1][1] - 117);
   uvec2 l37c0 = uvec2(x.d.d.c[0].c[0]);
   uvec2 l37c1 = uvec2(x.d.d.c[0].c[pc.identity[1]]);
   uvec2 l37d  = uvec2(x.d.d.c[0].d);
   if (!(all(equal(l37c0, l37c1)) &&
         all(equal(l37c1, l37d )) &&
         all(equal(l37c0, l37d )) )) {
     accum |= 1;
   }
   accum |= x.d.d.c[pc.identity[1]].a[0] - 114;
   accum |= x.d.d.c[pc.identity[1]].a[pc.identity[1]] - 115;
   accum |= x.d.d.c[pc.identity[1]].b - 116;
   accum |= int(x.d.d.c[pc.identity[1]].e[0][0] - 117);
   accum |= int(x.d.d.c[pc.identity[1]].e[0][1] - 119);
   accum |= int(x.d.d.c[pc.identity[1]].e[1][0] - 118);
   accum |= int(x.d.d.c[pc.identity[1]].e[1][1] - 120);
   uvec2 l38c0 = uvec2(x.d.d.c[pc.identity[1]].c[0]);
   uvec2 l38c1 = uvec2(x.d.d.c[pc.identity[1]].c[pc.identity[1]]);
   uvec2 l38d  = uvec2(x.d.d.c[pc.identity[1]].d);
   if (!(all(equal(l38c0, l38c1)) &&
         all(equal(l38c1, l38d )) &&
         all(equal(l38c0, l38d )) )) {
     accum |= 1;
   }
   accum |= x.d.d.d.a[0] - 117;
   accum |= x.d.d.d.a[pc.identity[1]] - 118;
   accum |= x.d.d.d.b - 119;
   accum |= int(x.d.d.d.e[0][0] - 120);
   accum |= int(x.d.d.d.e[0][1] - 122);
   accum |= int(x.d.d.d.e[1][0] - 121);
   accum |= int(x.d.d.d.e[1][1] - 123);
   uvec2 l39c0 = uvec2(x.d.d.d.c[0]);
   uvec2 l39c1 = uvec2(x.d.d.d.c[pc.identity[1]]);
   uvec2 l39d  = uvec2(x.d.d.d.d);
   if (!(all(equal(l39c0, l39c1)) &&
         all(equal(l39c1, l39d )) &&
         all(equal(l39c0, l39d )) )) {
     accum |= 1;
   }
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
