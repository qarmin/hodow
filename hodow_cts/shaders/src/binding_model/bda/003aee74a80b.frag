#version 450 core
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference_uvec2 : enable
layout (push_constant, std430) uniform Block { int identity[32]; } pc;
layout(r32ui, set = 3, binding = 0) uniform uimage2D image0_0;
layout(buffer_reference) buffer T1;
layout(set = 3, binding = 1, scalar) uniform T2 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 36) ivec3 f;
   layout(offset = 48) T1 c[2]; // stride = 8 for scalar, 16 for std140
   layout(offset = 80) T1 d;
   layout(offset = 96, row_major) mat2 e; // tightly packed for scalar, 16 byte matrix stride for std140
} x;
layout(buffer_reference, scalar) buffer T1 {
   layout(offset = 0) int a[2]; // stride = 4 for scalar, 16 for std140
   layout(offset = 32) int b;
   layout(offset = 36) ivec3 f;
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
   f = x.f;
   accum |= f.x - 7;
   accum |= f.y - 8;
   accum |= f.z - 9;
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
   f = x.c[0].f;
   accum |= f.x - 10;
   accum |= f.y - 11;
   accum |= f.z - 12;
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
   f = x.c[0].c[0].f;
   accum |= f.x - 19;
   accum |= f.y - 20;
   accum |= f.z - 21;
   uint64_t l4c0 = uint64_t(x.c[0].c[0].c[0]);
   uint64_t l4c1 = uint64_t(x.c[0].c[0].c[pc.identity[1]]);
   uint64_t l4d  = uint64_t(x.c[0].c[0].d);
   if (l4c0 == zero ||
       l4c1 == zero ||
       l4d  == zero ||
       l4c0 == l4c1 ||
       l4c1 == l4d  ||
       l4c0 == l4d  ) {
     accum |= 1;
   }
   accum |= x.c[0].c[0].c[0].a[0] - 39;
   accum |= x.c[0].c[0].c[0].a[pc.identity[1]] - 40;
   accum |= x.c[0].c[0].c[0].b - 41;
   accum |= int(x.c[0].c[0].c[0].e[0][0] - 42);
   accum |= int(x.c[0].c[0].c[0].e[0][1] - 44);
   accum |= int(x.c[0].c[0].c[0].e[1][0] - 43);
   accum |= int(x.c[0].c[0].c[0].e[1][1] - 45);
   f = x.c[0].c[0].c[0].f;
   accum |= f.x - 46;
   accum |= f.y - 47;
   accum |= f.z - 48;
   uint64_t l13c0 = uint64_t(x.c[0].c[0].c[0].c[0]);
   uint64_t l13c1 = uint64_t(x.c[0].c[0].c[0].c[pc.identity[1]]);
   uint64_t l13d  = uint64_t(x.c[0].c[0].c[0].d);
   if (!(l13c0 == l13c1 &&
         l13c1 == l13d  &&
         l13c0 == l13d  )) {
     accum |= 1;
   }
   accum |= x.c[0].c[0].c[pc.identity[1]].a[0] - 42;
   accum |= x.c[0].c[0].c[pc.identity[1]].a[pc.identity[1]] - 43;
   accum |= x.c[0].c[0].c[pc.identity[1]].b - 44;
   accum |= int(x.c[0].c[0].c[pc.identity[1]].e[0][0] - 45);
   accum |= int(x.c[0].c[0].c[pc.identity[1]].e[0][1] - 47);
   accum |= int(x.c[0].c[0].c[pc.identity[1]].e[1][0] - 46);
   accum |= int(x.c[0].c[0].c[pc.identity[1]].e[1][1] - 48);
   f = x.c[0].c[0].c[pc.identity[1]].f;
   accum |= f.x - 49;
   accum |= f.y - 50;
   accum |= f.z - 51;
   uint64_t l14c0 = uint64_t(x.c[0].c[0].c[pc.identity[1]].c[0]);
   uint64_t l14c1 = uint64_t(x.c[0].c[0].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l14d  = uint64_t(x.c[0].c[0].c[pc.identity[1]].d);
   if (!(l14c0 == l14c1 &&
         l14c1 == l14d  &&
         l14c0 == l14d  )) {
     accum |= 1;
   }
   accum |= x.c[0].c[0].d.a[0] - 45;
   accum |= x.c[0].c[0].d.a[pc.identity[1]] - 46;
   accum |= x.c[0].c[0].d.b - 47;
   accum |= int(x.c[0].c[0].d.e[0][0] - 48);
   accum |= int(x.c[0].c[0].d.e[0][1] - 50);
   accum |= int(x.c[0].c[0].d.e[1][0] - 49);
   accum |= int(x.c[0].c[0].d.e[1][1] - 51);
   f = x.c[0].c[0].d.f;
   accum |= f.x - 52;
   accum |= f.y - 53;
   accum |= f.z - 54;
   uint64_t l15c0 = uint64_t(x.c[0].c[0].d.c[0]);
   uint64_t l15c1 = uint64_t(x.c[0].c[0].d.c[pc.identity[1]]);
   uint64_t l15d  = uint64_t(x.c[0].c[0].d.d);
   if (!(l15c0 == l15c1 &&
         l15c1 == l15d  &&
         l15c0 == l15d  )) {
     accum |= 1;
   }
   accum |= x.c[0].c[pc.identity[1]].a[0] - 15;
   accum |= x.c[0].c[pc.identity[1]].a[pc.identity[1]] - 16;
   accum |= x.c[0].c[pc.identity[1]].b - 17;
   accum |= int(x.c[0].c[pc.identity[1]].e[0][0] - 18);
   accum |= int(x.c[0].c[pc.identity[1]].e[0][1] - 20);
   accum |= int(x.c[0].c[pc.identity[1]].e[1][0] - 19);
   accum |= int(x.c[0].c[pc.identity[1]].e[1][1] - 21);
   f = x.c[0].c[pc.identity[1]].f;
   accum |= f.x - 22;
   accum |= f.y - 23;
   accum |= f.z - 24;
   uint64_t l5c0 = uint64_t(x.c[0].c[pc.identity[1]].c[0]);
   uint64_t l5c1 = uint64_t(x.c[0].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l5d  = uint64_t(x.c[0].c[pc.identity[1]].d);
   if (l5c0 == zero ||
       l5c1 == zero ||
       l5d  == zero ||
       l5c0 == l5c1 ||
       l5c1 == l5d  ||
       l5c0 == l5d  ) {
     accum |= 1;
   }
   accum |= x.c[0].c[pc.identity[1]].c[0].a[0] - 48;
   accum |= x.c[0].c[pc.identity[1]].c[0].a[pc.identity[1]] - 49;
   accum |= x.c[0].c[pc.identity[1]].c[0].b - 50;
   accum |= int(x.c[0].c[pc.identity[1]].c[0].e[0][0] - 51);
   accum |= int(x.c[0].c[pc.identity[1]].c[0].e[0][1] - 53);
   accum |= int(x.c[0].c[pc.identity[1]].c[0].e[1][0] - 52);
   accum |= int(x.c[0].c[pc.identity[1]].c[0].e[1][1] - 54);
   f = x.c[0].c[pc.identity[1]].c[0].f;
   accum |= f.x - 55;
   accum |= f.y - 56;
   accum |= f.z - 57;
   uint64_t l16c0 = uint64_t(x.c[0].c[pc.identity[1]].c[0].c[0]);
   uint64_t l16c1 = uint64_t(x.c[0].c[pc.identity[1]].c[0].c[pc.identity[1]]);
   uint64_t l16d  = uint64_t(x.c[0].c[pc.identity[1]].c[0].d);
   if (!(l16c0 == l16c1 &&
         l16c1 == l16d  &&
         l16c0 == l16d  )) {
     accum |= 1;
   }
   accum |= x.c[0].c[pc.identity[1]].c[pc.identity[1]].a[0] - 51;
   accum |= x.c[0].c[pc.identity[1]].c[pc.identity[1]].a[pc.identity[1]] - 52;
   accum |= x.c[0].c[pc.identity[1]].c[pc.identity[1]].b - 53;
   accum |= int(x.c[0].c[pc.identity[1]].c[pc.identity[1]].e[0][0] - 54);
   accum |= int(x.c[0].c[pc.identity[1]].c[pc.identity[1]].e[0][1] - 56);
   accum |= int(x.c[0].c[pc.identity[1]].c[pc.identity[1]].e[1][0] - 55);
   accum |= int(x.c[0].c[pc.identity[1]].c[pc.identity[1]].e[1][1] - 57);
   f = x.c[0].c[pc.identity[1]].c[pc.identity[1]].f;
   accum |= f.x - 58;
   accum |= f.y - 59;
   accum |= f.z - 60;
   uint64_t l17c0 = uint64_t(x.c[0].c[pc.identity[1]].c[pc.identity[1]].c[0]);
   uint64_t l17c1 = uint64_t(x.c[0].c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l17d  = uint64_t(x.c[0].c[pc.identity[1]].c[pc.identity[1]].d);
   if (!(l17c0 == l17c1 &&
         l17c1 == l17d  &&
         l17c0 == l17d  )) {
     accum |= 1;
   }
   accum |= x.c[0].c[pc.identity[1]].d.a[0] - 54;
   accum |= x.c[0].c[pc.identity[1]].d.a[pc.identity[1]] - 55;
   accum |= x.c[0].c[pc.identity[1]].d.b - 56;
   accum |= int(x.c[0].c[pc.identity[1]].d.e[0][0] - 57);
   accum |= int(x.c[0].c[pc.identity[1]].d.e[0][1] - 59);
   accum |= int(x.c[0].c[pc.identity[1]].d.e[1][0] - 58);
   accum |= int(x.c[0].c[pc.identity[1]].d.e[1][1] - 60);
   f = x.c[0].c[pc.identity[1]].d.f;
   accum |= f.x - 61;
   accum |= f.y - 62;
   accum |= f.z - 63;
   uint64_t l18c0 = uint64_t(x.c[0].c[pc.identity[1]].d.c[0]);
   uint64_t l18c1 = uint64_t(x.c[0].c[pc.identity[1]].d.c[pc.identity[1]]);
   uint64_t l18d  = uint64_t(x.c[0].c[pc.identity[1]].d.d);
   if (!(l18c0 == l18c1 &&
         l18c1 == l18d  &&
         l18c0 == l18d  )) {
     accum |= 1;
   }
   accum |= x.c[0].d.a[0] - 18;
   accum |= x.c[0].d.a[pc.identity[1]] - 19;
   accum |= x.c[0].d.b - 20;
   accum |= int(x.c[0].d.e[0][0] - 21);
   accum |= int(x.c[0].d.e[0][1] - 23);
   accum |= int(x.c[0].d.e[1][0] - 22);
   accum |= int(x.c[0].d.e[1][1] - 24);
   f = x.c[0].d.f;
   accum |= f.x - 25;
   accum |= f.y - 26;
   accum |= f.z - 27;
   uint64_t l6c0 = uint64_t(x.c[0].d.c[0]);
   uint64_t l6c1 = uint64_t(x.c[0].d.c[pc.identity[1]]);
   uint64_t l6d  = uint64_t(x.c[0].d.d);
   if (l6c0 == zero ||
       l6c1 == zero ||
       l6d  == zero ||
       l6c0 == l6c1 ||
       l6c1 == l6d  ||
       l6c0 == l6d  ) {
     accum |= 1;
   }
   accum |= x.c[0].d.c[0].a[0] - 57;
   accum |= x.c[0].d.c[0].a[pc.identity[1]] - 58;
   accum |= x.c[0].d.c[0].b - 59;
   accum |= int(x.c[0].d.c[0].e[0][0] - 60);
   accum |= int(x.c[0].d.c[0].e[0][1] - 62);
   accum |= int(x.c[0].d.c[0].e[1][0] - 61);
   accum |= int(x.c[0].d.c[0].e[1][1] - 63);
   f = x.c[0].d.c[0].f;
   accum |= f.x - 64;
   accum |= f.y - 65;
   accum |= f.z - 66;
   uint64_t l19c0 = uint64_t(x.c[0].d.c[0].c[0]);
   uint64_t l19c1 = uint64_t(x.c[0].d.c[0].c[pc.identity[1]]);
   uint64_t l19d  = uint64_t(x.c[0].d.c[0].d);
   if (!(l19c0 == l19c1 &&
         l19c1 == l19d  &&
         l19c0 == l19d  )) {
     accum |= 1;
   }
   accum |= x.c[0].d.c[pc.identity[1]].a[0] - 60;
   accum |= x.c[0].d.c[pc.identity[1]].a[pc.identity[1]] - 61;
   accum |= x.c[0].d.c[pc.identity[1]].b - 62;
   accum |= int(x.c[0].d.c[pc.identity[1]].e[0][0] - 63);
   accum |= int(x.c[0].d.c[pc.identity[1]].e[0][1] - 65);
   accum |= int(x.c[0].d.c[pc.identity[1]].e[1][0] - 64);
   accum |= int(x.c[0].d.c[pc.identity[1]].e[1][1] - 66);
   f = x.c[0].d.c[pc.identity[1]].f;
   accum |= f.x - 67;
   accum |= f.y - 68;
   accum |= f.z - 69;
   uint64_t l20c0 = uint64_t(x.c[0].d.c[pc.identity[1]].c[0]);
   uint64_t l20c1 = uint64_t(x.c[0].d.c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l20d  = uint64_t(x.c[0].d.c[pc.identity[1]].d);
   if (!(l20c0 == l20c1 &&
         l20c1 == l20d  &&
         l20c0 == l20d  )) {
     accum |= 1;
   }
   accum |= x.c[0].d.d.a[0] - 63;
   accum |= x.c[0].d.d.a[pc.identity[1]] - 64;
   accum |= x.c[0].d.d.b - 65;
   accum |= int(x.c[0].d.d.e[0][0] - 66);
   accum |= int(x.c[0].d.d.e[0][1] - 68);
   accum |= int(x.c[0].d.d.e[1][0] - 67);
   accum |= int(x.c[0].d.d.e[1][1] - 69);
   f = x.c[0].d.d.f;
   accum |= f.x - 70;
   accum |= f.y - 71;
   accum |= f.z - 72;
   uint64_t l21c0 = uint64_t(x.c[0].d.d.c[0]);
   uint64_t l21c1 = uint64_t(x.c[0].d.d.c[pc.identity[1]]);
   uint64_t l21d  = uint64_t(x.c[0].d.d.d);
   if (!(l21c0 == l21c1 &&
         l21c1 == l21d  &&
         l21c0 == l21d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].a[0] - 6;
   accum |= x.c[pc.identity[1]].a[pc.identity[1]] - 7;
   accum |= x.c[pc.identity[1]].b - 8;
   accum |= int(x.c[pc.identity[1]].e[0][0] - 9);
   accum |= int(x.c[pc.identity[1]].e[0][1] - 11);
   accum |= int(x.c[pc.identity[1]].e[1][0] - 10);
   accum |= int(x.c[pc.identity[1]].e[1][1] - 12);
   f = x.c[pc.identity[1]].f;
   accum |= f.x - 13;
   accum |= f.y - 14;
   accum |= f.z - 15;
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
   f = x.c[pc.identity[1]].c[0].f;
   accum |= f.x - 28;
   accum |= f.y - 29;
   accum |= f.z - 30;
   uint64_t l7c0 = uint64_t(x.c[pc.identity[1]].c[0].c[0]);
   uint64_t l7c1 = uint64_t(x.c[pc.identity[1]].c[0].c[pc.identity[1]]);
   uint64_t l7d  = uint64_t(x.c[pc.identity[1]].c[0].d);
   if (l7c0 == zero ||
       l7c1 == zero ||
       l7d  == zero ||
       l7c0 == l7c1 ||
       l7c1 == l7d  ||
       l7c0 == l7d  ) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[0].c[0].a[0] - 66;
   accum |= x.c[pc.identity[1]].c[0].c[0].a[pc.identity[1]] - 67;
   accum |= x.c[pc.identity[1]].c[0].c[0].b - 68;
   accum |= int(x.c[pc.identity[1]].c[0].c[0].e[0][0] - 69);
   accum |= int(x.c[pc.identity[1]].c[0].c[0].e[0][1] - 71);
   accum |= int(x.c[pc.identity[1]].c[0].c[0].e[1][0] - 70);
   accum |= int(x.c[pc.identity[1]].c[0].c[0].e[1][1] - 72);
   f = x.c[pc.identity[1]].c[0].c[0].f;
   accum |= f.x - 73;
   accum |= f.y - 74;
   accum |= f.z - 75;
   uint64_t l22c0 = uint64_t(x.c[pc.identity[1]].c[0].c[0].c[0]);
   uint64_t l22c1 = uint64_t(x.c[pc.identity[1]].c[0].c[0].c[pc.identity[1]]);
   uint64_t l22d  = uint64_t(x.c[pc.identity[1]].c[0].c[0].d);
   if (!(l22c0 == l22c1 &&
         l22c1 == l22d  &&
         l22c0 == l22d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[0].c[pc.identity[1]].a[0] - 69;
   accum |= x.c[pc.identity[1]].c[0].c[pc.identity[1]].a[pc.identity[1]] - 70;
   accum |= x.c[pc.identity[1]].c[0].c[pc.identity[1]].b - 71;
   accum |= int(x.c[pc.identity[1]].c[0].c[pc.identity[1]].e[0][0] - 72);
   accum |= int(x.c[pc.identity[1]].c[0].c[pc.identity[1]].e[0][1] - 74);
   accum |= int(x.c[pc.identity[1]].c[0].c[pc.identity[1]].e[1][0] - 73);
   accum |= int(x.c[pc.identity[1]].c[0].c[pc.identity[1]].e[1][1] - 75);
   f = x.c[pc.identity[1]].c[0].c[pc.identity[1]].f;
   accum |= f.x - 76;
   accum |= f.y - 77;
   accum |= f.z - 78;
   uint64_t l23c0 = uint64_t(x.c[pc.identity[1]].c[0].c[pc.identity[1]].c[0]);
   uint64_t l23c1 = uint64_t(x.c[pc.identity[1]].c[0].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l23d  = uint64_t(x.c[pc.identity[1]].c[0].c[pc.identity[1]].d);
   if (!(l23c0 == l23c1 &&
         l23c1 == l23d  &&
         l23c0 == l23d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[0].d.a[0] - 72;
   accum |= x.c[pc.identity[1]].c[0].d.a[pc.identity[1]] - 73;
   accum |= x.c[pc.identity[1]].c[0].d.b - 74;
   accum |= int(x.c[pc.identity[1]].c[0].d.e[0][0] - 75);
   accum |= int(x.c[pc.identity[1]].c[0].d.e[0][1] - 77);
   accum |= int(x.c[pc.identity[1]].c[0].d.e[1][0] - 76);
   accum |= int(x.c[pc.identity[1]].c[0].d.e[1][1] - 78);
   f = x.c[pc.identity[1]].c[0].d.f;
   accum |= f.x - 79;
   accum |= f.y - 80;
   accum |= f.z - 81;
   uint64_t l24c0 = uint64_t(x.c[pc.identity[1]].c[0].d.c[0]);
   uint64_t l24c1 = uint64_t(x.c[pc.identity[1]].c[0].d.c[pc.identity[1]]);
   uint64_t l24d  = uint64_t(x.c[pc.identity[1]].c[0].d.d);
   if (!(l24c0 == l24c1 &&
         l24c1 == l24d  &&
         l24c0 == l24d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].a[0] - 24;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].a[pc.identity[1]] - 25;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].b - 26;
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[0][0] - 27);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[0][1] - 29);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[1][0] - 28);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].e[1][1] - 30);
   f = x.c[pc.identity[1]].c[pc.identity[1]].f;
   accum |= f.x - 31;
   accum |= f.y - 32;
   accum |= f.z - 33;
   uint64_t l8c0 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[0]);
   uint64_t l8c1 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l8d  = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].d);
   if (l8c0 == zero ||
       l8c1 == zero ||
       l8d  == zero ||
       l8c0 == l8c1 ||
       l8c1 == l8d  ||
       l8c0 == l8d  ) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[0].a[0] - 75;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[0].a[pc.identity[1]] - 76;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[0].b - 77;
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[0].e[0][0] - 78);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[0].e[0][1] - 80);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[0].e[1][0] - 79);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[0].e[1][1] - 81);
   f = x.c[pc.identity[1]].c[pc.identity[1]].c[0].f;
   accum |= f.x - 82;
   accum |= f.y - 83;
   accum |= f.z - 84;
   uint64_t l25c0 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[0].c[0]);
   uint64_t l25c1 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[0].c[pc.identity[1]]);
   uint64_t l25d  = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[0].d);
   if (!(l25c0 == l25c1 &&
         l25c1 == l25d  &&
         l25c0 == l25d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].a[0] - 78;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].a[pc.identity[1]] - 79;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].b - 80;
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].e[0][0] - 81);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].e[0][1] - 83);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].e[1][0] - 82);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].e[1][1] - 84);
   f = x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].f;
   accum |= f.x - 85;
   accum |= f.y - 86;
   accum |= f.z - 87;
   uint64_t l26c0 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].c[0]);
   uint64_t l26c1 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l26d  = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]].d);
   if (!(l26c0 == l26c1 &&
         l26c1 == l26d  &&
         l26c0 == l26d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].d.a[0] - 81;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].d.a[pc.identity[1]] - 82;
   accum |= x.c[pc.identity[1]].c[pc.identity[1]].d.b - 83;
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].d.e[0][0] - 84);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].d.e[0][1] - 86);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].d.e[1][0] - 85);
   accum |= int(x.c[pc.identity[1]].c[pc.identity[1]].d.e[1][1] - 87);
   f = x.c[pc.identity[1]].c[pc.identity[1]].d.f;
   accum |= f.x - 88;
   accum |= f.y - 89;
   accum |= f.z - 90;
   uint64_t l27c0 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].d.c[0]);
   uint64_t l27c1 = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].d.c[pc.identity[1]]);
   uint64_t l27d  = uint64_t(x.c[pc.identity[1]].c[pc.identity[1]].d.d);
   if (!(l27c0 == l27c1 &&
         l27c1 == l27d  &&
         l27c0 == l27d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].d.a[0] - 27;
   accum |= x.c[pc.identity[1]].d.a[pc.identity[1]] - 28;
   accum |= x.c[pc.identity[1]].d.b - 29;
   accum |= int(x.c[pc.identity[1]].d.e[0][0] - 30);
   accum |= int(x.c[pc.identity[1]].d.e[0][1] - 32);
   accum |= int(x.c[pc.identity[1]].d.e[1][0] - 31);
   accum |= int(x.c[pc.identity[1]].d.e[1][1] - 33);
   f = x.c[pc.identity[1]].d.f;
   accum |= f.x - 34;
   accum |= f.y - 35;
   accum |= f.z - 36;
   uint64_t l9c0 = uint64_t(x.c[pc.identity[1]].d.c[0]);
   uint64_t l9c1 = uint64_t(x.c[pc.identity[1]].d.c[pc.identity[1]]);
   uint64_t l9d  = uint64_t(x.c[pc.identity[1]].d.d);
   if (l9c0 == zero ||
       l9c1 == zero ||
       l9d  == zero ||
       l9c0 == l9c1 ||
       l9c1 == l9d  ||
       l9c0 == l9d  ) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].d.c[0].a[0] - 84;
   accum |= x.c[pc.identity[1]].d.c[0].a[pc.identity[1]] - 85;
   accum |= x.c[pc.identity[1]].d.c[0].b - 86;
   accum |= int(x.c[pc.identity[1]].d.c[0].e[0][0] - 87);
   accum |= int(x.c[pc.identity[1]].d.c[0].e[0][1] - 89);
   accum |= int(x.c[pc.identity[1]].d.c[0].e[1][0] - 88);
   accum |= int(x.c[pc.identity[1]].d.c[0].e[1][1] - 90);
   f = x.c[pc.identity[1]].d.c[0].f;
   accum |= f.x - 91;
   accum |= f.y - 92;
   accum |= f.z - 93;
   uint64_t l28c0 = uint64_t(x.c[pc.identity[1]].d.c[0].c[0]);
   uint64_t l28c1 = uint64_t(x.c[pc.identity[1]].d.c[0].c[pc.identity[1]]);
   uint64_t l28d  = uint64_t(x.c[pc.identity[1]].d.c[0].d);
   if (!(l28c0 == l28c1 &&
         l28c1 == l28d  &&
         l28c0 == l28d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].d.c[pc.identity[1]].a[0] - 87;
   accum |= x.c[pc.identity[1]].d.c[pc.identity[1]].a[pc.identity[1]] - 88;
   accum |= x.c[pc.identity[1]].d.c[pc.identity[1]].b - 89;
   accum |= int(x.c[pc.identity[1]].d.c[pc.identity[1]].e[0][0] - 90);
   accum |= int(x.c[pc.identity[1]].d.c[pc.identity[1]].e[0][1] - 92);
   accum |= int(x.c[pc.identity[1]].d.c[pc.identity[1]].e[1][0] - 91);
   accum |= int(x.c[pc.identity[1]].d.c[pc.identity[1]].e[1][1] - 93);
   f = x.c[pc.identity[1]].d.c[pc.identity[1]].f;
   accum |= f.x - 94;
   accum |= f.y - 95;
   accum |= f.z - 96;
   uint64_t l29c0 = uint64_t(x.c[pc.identity[1]].d.c[pc.identity[1]].c[0]);
   uint64_t l29c1 = uint64_t(x.c[pc.identity[1]].d.c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l29d  = uint64_t(x.c[pc.identity[1]].d.c[pc.identity[1]].d);
   if (!(l29c0 == l29c1 &&
         l29c1 == l29d  &&
         l29c0 == l29d  )) {
     accum |= 1;
   }
   accum |= x.c[pc.identity[1]].d.d.a[0] - 90;
   accum |= x.c[pc.identity[1]].d.d.a[pc.identity[1]] - 91;
   accum |= x.c[pc.identity[1]].d.d.b - 92;
   accum |= int(x.c[pc.identity[1]].d.d.e[0][0] - 93);
   accum |= int(x.c[pc.identity[1]].d.d.e[0][1] - 95);
   accum |= int(x.c[pc.identity[1]].d.d.e[1][0] - 94);
   accum |= int(x.c[pc.identity[1]].d.d.e[1][1] - 96);
   f = x.c[pc.identity[1]].d.d.f;
   accum |= f.x - 97;
   accum |= f.y - 98;
   accum |= f.z - 99;
   uint64_t l30c0 = uint64_t(x.c[pc.identity[1]].d.d.c[0]);
   uint64_t l30c1 = uint64_t(x.c[pc.identity[1]].d.d.c[pc.identity[1]]);
   uint64_t l30d  = uint64_t(x.c[pc.identity[1]].d.d.d);
   if (!(l30c0 == l30c1 &&
         l30c1 == l30d  &&
         l30c0 == l30d  )) {
     accum |= 1;
   }
   accum |= x.d.a[0] - 9;
   accum |= x.d.a[pc.identity[1]] - 10;
   accum |= x.d.b - 11;
   accum |= int(x.d.e[0][0] - 12);
   accum |= int(x.d.e[0][1] - 14);
   accum |= int(x.d.e[1][0] - 13);
   accum |= int(x.d.e[1][1] - 15);
   f = x.d.f;
   accum |= f.x - 16;
   accum |= f.y - 17;
   accum |= f.z - 18;
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
   f = x.d.c[0].f;
   accum |= f.x - 37;
   accum |= f.y - 38;
   accum |= f.z - 39;
   uint64_t l10c0 = uint64_t(x.d.c[0].c[0]);
   uint64_t l10c1 = uint64_t(x.d.c[0].c[pc.identity[1]]);
   uint64_t l10d  = uint64_t(x.d.c[0].d);
   if (l10c0 == zero ||
       l10c1 == zero ||
       l10d  == zero ||
       l10c0 == l10c1 ||
       l10c1 == l10d  ||
       l10c0 == l10d  ) {
     accum |= 1;
   }
   accum |= x.d.c[0].c[0].a[0] - 93;
   accum |= x.d.c[0].c[0].a[pc.identity[1]] - 94;
   accum |= x.d.c[0].c[0].b - 95;
   accum |= int(x.d.c[0].c[0].e[0][0] - 96);
   accum |= int(x.d.c[0].c[0].e[0][1] - 98);
   accum |= int(x.d.c[0].c[0].e[1][0] - 97);
   accum |= int(x.d.c[0].c[0].e[1][1] - 99);
   f = x.d.c[0].c[0].f;
   accum |= f.x - 100;
   accum |= f.y - 101;
   accum |= f.z - 102;
   uint64_t l31c0 = uint64_t(x.d.c[0].c[0].c[0]);
   uint64_t l31c1 = uint64_t(x.d.c[0].c[0].c[pc.identity[1]]);
   uint64_t l31d  = uint64_t(x.d.c[0].c[0].d);
   if (!(l31c0 == l31c1 &&
         l31c1 == l31d  &&
         l31c0 == l31d  )) {
     accum |= 1;
   }
   accum |= x.d.c[0].c[pc.identity[1]].a[0] - 96;
   accum |= x.d.c[0].c[pc.identity[1]].a[pc.identity[1]] - 97;
   accum |= x.d.c[0].c[pc.identity[1]].b - 98;
   accum |= int(x.d.c[0].c[pc.identity[1]].e[0][0] - 99);
   accum |= int(x.d.c[0].c[pc.identity[1]].e[0][1] - 101);
   accum |= int(x.d.c[0].c[pc.identity[1]].e[1][0] - 100);
   accum |= int(x.d.c[0].c[pc.identity[1]].e[1][1] - 102);
   f = x.d.c[0].c[pc.identity[1]].f;
   accum |= f.x - 103;
   accum |= f.y - 104;
   accum |= f.z - 105;
   uint64_t l32c0 = uint64_t(x.d.c[0].c[pc.identity[1]].c[0]);
   uint64_t l32c1 = uint64_t(x.d.c[0].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l32d  = uint64_t(x.d.c[0].c[pc.identity[1]].d);
   if (!(l32c0 == l32c1 &&
         l32c1 == l32d  &&
         l32c0 == l32d  )) {
     accum |= 1;
   }
   accum |= x.d.c[0].d.a[0] - 99;
   accum |= x.d.c[0].d.a[pc.identity[1]] - 100;
   accum |= x.d.c[0].d.b - 101;
   accum |= int(x.d.c[0].d.e[0][0] - 102);
   accum |= int(x.d.c[0].d.e[0][1] - 104);
   accum |= int(x.d.c[0].d.e[1][0] - 103);
   accum |= int(x.d.c[0].d.e[1][1] - 105);
   f = x.d.c[0].d.f;
   accum |= f.x - 106;
   accum |= f.y - 107;
   accum |= f.z - 108;
   uint64_t l33c0 = uint64_t(x.d.c[0].d.c[0]);
   uint64_t l33c1 = uint64_t(x.d.c[0].d.c[pc.identity[1]]);
   uint64_t l33d  = uint64_t(x.d.c[0].d.d);
   if (!(l33c0 == l33c1 &&
         l33c1 == l33d  &&
         l33c0 == l33d  )) {
     accum |= 1;
   }
   accum |= x.d.c[pc.identity[1]].a[0] - 33;
   accum |= x.d.c[pc.identity[1]].a[pc.identity[1]] - 34;
   accum |= x.d.c[pc.identity[1]].b - 35;
   accum |= int(x.d.c[pc.identity[1]].e[0][0] - 36);
   accum |= int(x.d.c[pc.identity[1]].e[0][1] - 38);
   accum |= int(x.d.c[pc.identity[1]].e[1][0] - 37);
   accum |= int(x.d.c[pc.identity[1]].e[1][1] - 39);
   f = x.d.c[pc.identity[1]].f;
   accum |= f.x - 40;
   accum |= f.y - 41;
   accum |= f.z - 42;
   uint64_t l11c0 = uint64_t(x.d.c[pc.identity[1]].c[0]);
   uint64_t l11c1 = uint64_t(x.d.c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l11d  = uint64_t(x.d.c[pc.identity[1]].d);
   if (l11c0 == zero ||
       l11c1 == zero ||
       l11d  == zero ||
       l11c0 == l11c1 ||
       l11c1 == l11d  ||
       l11c0 == l11d  ) {
     accum |= 1;
   }
   accum |= x.d.c[pc.identity[1]].c[0].a[0] - 102;
   accum |= x.d.c[pc.identity[1]].c[0].a[pc.identity[1]] - 103;
   accum |= x.d.c[pc.identity[1]].c[0].b - 104;
   accum |= int(x.d.c[pc.identity[1]].c[0].e[0][0] - 105);
   accum |= int(x.d.c[pc.identity[1]].c[0].e[0][1] - 107);
   accum |= int(x.d.c[pc.identity[1]].c[0].e[1][0] - 106);
   accum |= int(x.d.c[pc.identity[1]].c[0].e[1][1] - 108);
   f = x.d.c[pc.identity[1]].c[0].f;
   accum |= f.x - 109;
   accum |= f.y - 110;
   accum |= f.z - 111;
   uint64_t l34c0 = uint64_t(x.d.c[pc.identity[1]].c[0].c[0]);
   uint64_t l34c1 = uint64_t(x.d.c[pc.identity[1]].c[0].c[pc.identity[1]]);
   uint64_t l34d  = uint64_t(x.d.c[pc.identity[1]].c[0].d);
   if (!(l34c0 == l34c1 &&
         l34c1 == l34d  &&
         l34c0 == l34d  )) {
     accum |= 1;
   }
   accum |= x.d.c[pc.identity[1]].c[pc.identity[1]].a[0] - 105;
   accum |= x.d.c[pc.identity[1]].c[pc.identity[1]].a[pc.identity[1]] - 106;
   accum |= x.d.c[pc.identity[1]].c[pc.identity[1]].b - 107;
   accum |= int(x.d.c[pc.identity[1]].c[pc.identity[1]].e[0][0] - 108);
   accum |= int(x.d.c[pc.identity[1]].c[pc.identity[1]].e[0][1] - 110);
   accum |= int(x.d.c[pc.identity[1]].c[pc.identity[1]].e[1][0] - 109);
   accum |= int(x.d.c[pc.identity[1]].c[pc.identity[1]].e[1][1] - 111);
   f = x.d.c[pc.identity[1]].c[pc.identity[1]].f;
   accum |= f.x - 112;
   accum |= f.y - 113;
   accum |= f.z - 114;
   uint64_t l35c0 = uint64_t(x.d.c[pc.identity[1]].c[pc.identity[1]].c[0]);
   uint64_t l35c1 = uint64_t(x.d.c[pc.identity[1]].c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l35d  = uint64_t(x.d.c[pc.identity[1]].c[pc.identity[1]].d);
   if (!(l35c0 == l35c1 &&
         l35c1 == l35d  &&
         l35c0 == l35d  )) {
     accum |= 1;
   }
   accum |= x.d.c[pc.identity[1]].d.a[0] - 108;
   accum |= x.d.c[pc.identity[1]].d.a[pc.identity[1]] - 109;
   accum |= x.d.c[pc.identity[1]].d.b - 110;
   accum |= int(x.d.c[pc.identity[1]].d.e[0][0] - 111);
   accum |= int(x.d.c[pc.identity[1]].d.e[0][1] - 113);
   accum |= int(x.d.c[pc.identity[1]].d.e[1][0] - 112);
   accum |= int(x.d.c[pc.identity[1]].d.e[1][1] - 114);
   f = x.d.c[pc.identity[1]].d.f;
   accum |= f.x - 115;
   accum |= f.y - 116;
   accum |= f.z - 117;
   uint64_t l36c0 = uint64_t(x.d.c[pc.identity[1]].d.c[0]);
   uint64_t l36c1 = uint64_t(x.d.c[pc.identity[1]].d.c[pc.identity[1]]);
   uint64_t l36d  = uint64_t(x.d.c[pc.identity[1]].d.d);
   if (!(l36c0 == l36c1 &&
         l36c1 == l36d  &&
         l36c0 == l36d  )) {
     accum |= 1;
   }
   accum |= x.d.d.a[0] - 36;
   accum |= x.d.d.a[pc.identity[1]] - 37;
   accum |= x.d.d.b - 38;
   accum |= int(x.d.d.e[0][0] - 39);
   accum |= int(x.d.d.e[0][1] - 41);
   accum |= int(x.d.d.e[1][0] - 40);
   accum |= int(x.d.d.e[1][1] - 42);
   f = x.d.d.f;
   accum |= f.x - 43;
   accum |= f.y - 44;
   accum |= f.z - 45;
   uint64_t l12c0 = uint64_t(x.d.d.c[0]);
   uint64_t l12c1 = uint64_t(x.d.d.c[pc.identity[1]]);
   uint64_t l12d  = uint64_t(x.d.d.d);
   if (l12c0 == zero ||
       l12c1 == zero ||
       l12d  == zero ||
       l12c0 == l12c1 ||
       l12c1 == l12d  ||
       l12c0 == l12d  ) {
     accum |= 1;
   }
   accum |= x.d.d.c[0].a[0] - 111;
   accum |= x.d.d.c[0].a[pc.identity[1]] - 112;
   accum |= x.d.d.c[0].b - 113;
   accum |= int(x.d.d.c[0].e[0][0] - 114);
   accum |= int(x.d.d.c[0].e[0][1] - 116);
   accum |= int(x.d.d.c[0].e[1][0] - 115);
   accum |= int(x.d.d.c[0].e[1][1] - 117);
   f = x.d.d.c[0].f;
   accum |= f.x - 118;
   accum |= f.y - 119;
   accum |= f.z - 120;
   uint64_t l37c0 = uint64_t(x.d.d.c[0].c[0]);
   uint64_t l37c1 = uint64_t(x.d.d.c[0].c[pc.identity[1]]);
   uint64_t l37d  = uint64_t(x.d.d.c[0].d);
   if (!(l37c0 == l37c1 &&
         l37c1 == l37d  &&
         l37c0 == l37d  )) {
     accum |= 1;
   }
   accum |= x.d.d.c[pc.identity[1]].a[0] - 114;
   accum |= x.d.d.c[pc.identity[1]].a[pc.identity[1]] - 115;
   accum |= x.d.d.c[pc.identity[1]].b - 116;
   accum |= int(x.d.d.c[pc.identity[1]].e[0][0] - 117);
   accum |= int(x.d.d.c[pc.identity[1]].e[0][1] - 119);
   accum |= int(x.d.d.c[pc.identity[1]].e[1][0] - 118);
   accum |= int(x.d.d.c[pc.identity[1]].e[1][1] - 120);
   f = x.d.d.c[pc.identity[1]].f;
   accum |= f.x - 121;
   accum |= f.y - 122;
   accum |= f.z - 123;
   uint64_t l38c0 = uint64_t(x.d.d.c[pc.identity[1]].c[0]);
   uint64_t l38c1 = uint64_t(x.d.d.c[pc.identity[1]].c[pc.identity[1]]);
   uint64_t l38d  = uint64_t(x.d.d.c[pc.identity[1]].d);
   if (!(l38c0 == l38c1 &&
         l38c1 == l38d  &&
         l38c0 == l38d  )) {
     accum |= 1;
   }
   accum |= x.d.d.d.a[0] - 117;
   accum |= x.d.d.d.a[pc.identity[1]] - 118;
   accum |= x.d.d.d.b - 119;
   accum |= int(x.d.d.d.e[0][0] - 120);
   accum |= int(x.d.d.d.e[0][1] - 122);
   accum |= int(x.d.d.d.e[1][0] - 121);
   accum |= int(x.d.d.d.e[1][1] - 123);
   f = x.d.d.d.f;
   accum |= f.x - 124;
   accum |= f.y - 125;
   accum |= f.z - 126;
   uint64_t l39c0 = uint64_t(x.d.d.d.c[0]);
   uint64_t l39c1 = uint64_t(x.d.d.d.c[pc.identity[1]]);
   uint64_t l39d  = uint64_t(x.d.d.d.d);
   if (!(l39c0 == l39c1 &&
         l39c1 == l39d  &&
         l39c0 == l39d  )) {
     accum |= 1;
   }
  uvec4 color = (accum != 0) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
