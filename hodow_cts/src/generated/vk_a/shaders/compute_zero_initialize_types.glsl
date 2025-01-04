#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared bool wg_mem0 = {};
shared bool wg_mem1 = {};
shared bool wg_mem2 = {};
shared bool wg_mem3 = {};
shared bool wg_mem4 = {};
shared bool wg_mem5 = {};
shared bool wg_mem6 = {};
shared bool wg_mem7 = {};
shared bool wg_mem8 = {};
shared bool wg_mem9 = {};
shared bool wg_mem10 = {};
void main() {
  a.a[0] = (int(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int(wg_mem5) ==  0) ? 0 : 1;
  a.a[6] = (int(wg_mem6) ==  0) ? 0 : 1;
  a.a[7] = (int(wg_mem7) ==  0) ? 0 : 1;
  a.a[8] = (int(wg_mem8) ==  0) ? 0 : 1;
  a.a[9] = (int(wg_mem9) ==  0) ? 0 : 1;
  a.a[10] = (int(wg_mem10) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared bvec2 wg_mem0 = {};
shared bvec2 wg_mem1 = {};
shared bvec2 wg_mem2 = {};
shared bvec2 wg_mem3 = {};
shared bvec2 wg_mem4 = {};
shared bvec2 wg_mem5 = {};
shared bvec2 wg_mem6 = {};
shared bvec2 wg_mem7 = {};
shared bvec2 wg_mem8 = {};
shared bvec2 wg_mem9 = {};
shared bvec2 wg_mem10 = {};
shared bvec2 wg_mem11 = {};
shared bvec2 wg_mem12 = {};
shared bvec2 wg_mem13 = {};
shared bvec2 wg_mem14 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[14 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[22 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[26 + gl_LocalInvocationID.x] = (int(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared bvec3 wg_mem0 = {};
shared bvec3 wg_mem1 = {};
shared bvec3 wg_mem2 = {};
shared bvec3 wg_mem3 = {};
shared bvec3 wg_mem4 = {};
shared bvec3 wg_mem5 = {};
shared bvec3 wg_mem6 = {};
shared bvec3 wg_mem7 = {};
shared bvec3 wg_mem8 = {};
shared bvec3 wg_mem9 = {};
shared bvec3 wg_mem10 = {};
shared bvec3 wg_mem11 = {};
shared bvec3 wg_mem12 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[15 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[21 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[27 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[33 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared bvec4 wg_mem0 = {};
shared bvec4 wg_mem1 = {};
shared bvec4 wg_mem2 = {};
shared bvec4 wg_mem3 = {};
shared bvec4 wg_mem4 = {};
shared bvec4 wg_mem5 = {};
shared bvec4 wg_mem6 = {};
shared bvec4 wg_mem7 = {};
shared bvec4 wg_mem8 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared uint32_t wg_mem0 = {};
shared uint32_t wg_mem1 = {};
shared uint32_t wg_mem2 = {};
shared uint32_t wg_mem3 = {};
shared uint32_t wg_mem4 = {};
shared uint32_t wg_mem5 = {};
shared uint32_t wg_mem6 = {};
shared uint32_t wg_mem7 = {};
shared uint32_t wg_mem8 = {};
void main() {
  a.a[0] = (int(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int(wg_mem5) ==  0) ? 0 : 1;
  a.a[6] = (int(wg_mem6) ==  0) ? 0 : 1;
  a.a[7] = (int(wg_mem7) ==  0) ? 0 : 1;
  a.a[8] = (int(wg_mem8) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared uvec2 wg_mem0 = {};
shared uvec2 wg_mem1 = {};
shared uvec2 wg_mem2 = {};
shared uvec2 wg_mem3 = {};
shared uvec2 wg_mem4 = {};
shared uvec2 wg_mem5 = {};
shared uvec2 wg_mem6 = {};
shared uvec2 wg_mem7 = {};
shared uvec2 wg_mem8 = {};
shared uvec2 wg_mem9 = {};
shared uvec2 wg_mem10 = {};
shared uvec2 wg_mem11 = {};
shared uvec2 wg_mem12 = {};
shared uvec2 wg_mem13 = {};
shared uvec2 wg_mem14 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[14 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[22 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[26 + gl_LocalInvocationID.x] = (int(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared uvec3 wg_mem0 = {};
shared uvec3 wg_mem1 = {};
shared uvec3 wg_mem2 = {};
shared uvec3 wg_mem3 = {};
shared uvec3 wg_mem4 = {};
shared uvec3 wg_mem5 = {};
shared uvec3 wg_mem6 = {};
shared uvec3 wg_mem7 = {};
shared uvec3 wg_mem8 = {};
shared uvec3 wg_mem9 = {};
shared uvec3 wg_mem10 = {};
shared uvec3 wg_mem11 = {};
shared uvec3 wg_mem12 = {};
shared uvec3 wg_mem13 = {};
shared uvec3 wg_mem14 = {};
shared uvec3 wg_mem15 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[15 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[21 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[27 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[33 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[39 + gl_LocalInvocationID.x] = (int(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[42 + gl_LocalInvocationID.x] = (int(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[45 + gl_LocalInvocationID.x] = (int(wg_mem15[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared uvec4 wg_mem0 = {};
shared uvec4 wg_mem1 = {};
shared uvec4 wg_mem2 = {};
shared uvec4 wg_mem3 = {};
shared uvec4 wg_mem4 = {};
shared uvec4 wg_mem5 = {};
shared uvec4 wg_mem6 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared int32_t wg_mem0 = {};
shared int32_t wg_mem1 = {};
shared int32_t wg_mem2 = {};
shared int32_t wg_mem3 = {};
shared int32_t wg_mem4 = {};
shared int32_t wg_mem5 = {};
shared int32_t wg_mem6 = {};
shared int32_t wg_mem7 = {};
shared int32_t wg_mem8 = {};
shared int32_t wg_mem9 = {};
shared int32_t wg_mem10 = {};
shared int32_t wg_mem11 = {};
shared int32_t wg_mem12 = {};
shared int32_t wg_mem13 = {};
shared int32_t wg_mem14 = {};
void main() {
  a.a[0] = (int(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int(wg_mem5) ==  0) ? 0 : 1;
  a.a[6] = (int(wg_mem6) ==  0) ? 0 : 1;
  a.a[7] = (int(wg_mem7) ==  0) ? 0 : 1;
  a.a[8] = (int(wg_mem8) ==  0) ? 0 : 1;
  a.a[9] = (int(wg_mem9) ==  0) ? 0 : 1;
  a.a[10] = (int(wg_mem10) ==  0) ? 0 : 1;
  a.a[11] = (int(wg_mem11) ==  0) ? 0 : 1;
  a.a[12] = (int(wg_mem12) ==  0) ? 0 : 1;
  a.a[13] = (int(wg_mem13) ==  0) ? 0 : 1;
  a.a[14] = (int(wg_mem14) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared ivec2 wg_mem0 = {};
shared ivec2 wg_mem1 = {};
shared ivec2 wg_mem2 = {};
shared ivec2 wg_mem3 = {};
shared ivec2 wg_mem4 = {};
shared ivec2 wg_mem5 = {};
shared ivec2 wg_mem6 = {};
shared ivec2 wg_mem7 = {};
shared ivec2 wg_mem8 = {};
shared ivec2 wg_mem9 = {};
shared ivec2 wg_mem10 = {};
shared ivec2 wg_mem11 = {};
shared ivec2 wg_mem12 = {};
shared ivec2 wg_mem13 = {};
shared ivec2 wg_mem14 = {};
shared ivec2 wg_mem15 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[14 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[22 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[26 + gl_LocalInvocationID.x] = (int(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem15[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared ivec3 wg_mem0 = {};
shared ivec3 wg_mem1 = {};
shared ivec3 wg_mem2 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared ivec4 wg_mem0 = {};
shared ivec4 wg_mem1 = {};
shared ivec4 wg_mem2 = {};
shared ivec4 wg_mem3 = {};
shared ivec4 wg_mem4 = {};
shared ivec4 wg_mem5 = {};
shared ivec4 wg_mem6 = {};
shared ivec4 wg_mem7 = {};
shared ivec4 wg_mem8 = {};
shared ivec4 wg_mem9 = {};
shared ivec4 wg_mem10 = {};
shared ivec4 wg_mem11 = {};
shared ivec4 wg_mem12 = {};
shared ivec4 wg_mem13 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[44 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[52 + gl_LocalInvocationID.x] = (int(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared uint8_t wg_mem0 = {};
shared uint8_t wg_mem1 = {};
shared uint8_t wg_mem2 = {};
shared uint8_t wg_mem3 = {};
shared uint8_t wg_mem4 = {};
void main() {
  a.a[0] = (int(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int(wg_mem4) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared u8vec2 wg_mem0 = {};
shared u8vec2 wg_mem1 = {};
shared u8vec2 wg_mem2 = {};
shared u8vec2 wg_mem3 = {};
shared u8vec2 wg_mem4 = {};
shared u8vec2 wg_mem5 = {};
shared u8vec2 wg_mem6 = {};
shared u8vec2 wg_mem7 = {};
shared u8vec2 wg_mem8 = {};
shared u8vec2 wg_mem9 = {};
shared u8vec2 wg_mem10 = {};
shared u8vec2 wg_mem11 = {};
shared u8vec2 wg_mem12 = {};
shared u8vec2 wg_mem13 = {};
shared u8vec2 wg_mem14 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[14 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[22 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[26 + gl_LocalInvocationID.x] = (int(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared u8vec3 wg_mem0 = {};
shared u8vec3 wg_mem1 = {};
shared u8vec3 wg_mem2 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared u8vec4 wg_mem0 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared int8_t wg_mem0 = {};
shared int8_t wg_mem1 = {};
shared int8_t wg_mem2 = {};
shared int8_t wg_mem3 = {};
shared int8_t wg_mem4 = {};
shared int8_t wg_mem5 = {};
shared int8_t wg_mem6 = {};
shared int8_t wg_mem7 = {};
void main() {
  a.a[0] = (int(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int(wg_mem5) ==  0) ? 0 : 1;
  a.a[6] = (int(wg_mem6) ==  0) ? 0 : 1;
  a.a[7] = (int(wg_mem7) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared i8vec2 wg_mem0 = {};
shared i8vec2 wg_mem1 = {};
shared i8vec2 wg_mem2 = {};
shared i8vec2 wg_mem3 = {};
shared i8vec2 wg_mem4 = {};
shared i8vec2 wg_mem5 = {};
shared i8vec2 wg_mem6 = {};
shared i8vec2 wg_mem7 = {};
shared i8vec2 wg_mem8 = {};
shared i8vec2 wg_mem9 = {};
shared i8vec2 wg_mem10 = {};
shared i8vec2 wg_mem11 = {};
shared i8vec2 wg_mem12 = {};
shared i8vec2 wg_mem13 = {};
shared i8vec2 wg_mem14 = {};
shared i8vec2 wg_mem15 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[14 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[22 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[26 + gl_LocalInvocationID.x] = (int(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem15[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared i8vec3 wg_mem0 = {};
shared i8vec3 wg_mem1 = {};
shared i8vec3 wg_mem2 = {};
shared i8vec3 wg_mem3 = {};
shared i8vec3 wg_mem4 = {};
shared i8vec3 wg_mem5 = {};
shared i8vec3 wg_mem6 = {};
shared i8vec3 wg_mem7 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[15 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[21 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared i8vec4 wg_mem0 = {};
shared i8vec4 wg_mem1 = {};
shared i8vec4 wg_mem2 = {};
shared i8vec4 wg_mem3 = {};
shared i8vec4 wg_mem4 = {};
shared i8vec4 wg_mem5 = {};
shared i8vec4 wg_mem6 = {};
shared i8vec4 wg_mem7 = {};
shared i8vec4 wg_mem8 = {};
shared i8vec4 wg_mem9 = {};
shared i8vec4 wg_mem10 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared uint16_t wg_mem0 = {};
shared uint16_t wg_mem1 = {};
shared uint16_t wg_mem2 = {};
shared uint16_t wg_mem3 = {};
shared uint16_t wg_mem4 = {};
shared uint16_t wg_mem5 = {};
shared uint16_t wg_mem6 = {};
shared uint16_t wg_mem7 = {};
shared uint16_t wg_mem8 = {};
shared uint16_t wg_mem9 = {};
shared uint16_t wg_mem10 = {};
shared uint16_t wg_mem11 = {};
shared uint16_t wg_mem12 = {};
void main() {
  a.a[0] = (int(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int(wg_mem5) ==  0) ? 0 : 1;
  a.a[6] = (int(wg_mem6) ==  0) ? 0 : 1;
  a.a[7] = (int(wg_mem7) ==  0) ? 0 : 1;
  a.a[8] = (int(wg_mem8) ==  0) ? 0 : 1;
  a.a[9] = (int(wg_mem9) ==  0) ? 0 : 1;
  a.a[10] = (int(wg_mem10) ==  0) ? 0 : 1;
  a.a[11] = (int(wg_mem11) ==  0) ? 0 : 1;
  a.a[12] = (int(wg_mem12) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared u16vec2 wg_mem0 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared u16vec3 wg_mem0 = {};
shared u16vec3 wg_mem1 = {};
shared u16vec3 wg_mem2 = {};
shared u16vec3 wg_mem3 = {};
shared u16vec3 wg_mem4 = {};
shared u16vec3 wg_mem5 = {};
shared u16vec3 wg_mem6 = {};
shared u16vec3 wg_mem7 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[15 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[21 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared u16vec4 wg_mem0 = {};
shared u16vec4 wg_mem1 = {};
shared u16vec4 wg_mem2 = {};
shared u16vec4 wg_mem3 = {};
shared u16vec4 wg_mem4 = {};
shared u16vec4 wg_mem5 = {};
shared u16vec4 wg_mem6 = {};
shared u16vec4 wg_mem7 = {};
shared u16vec4 wg_mem8 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared int16_t wg_mem0 = {};
shared int16_t wg_mem1 = {};
shared int16_t wg_mem2 = {};
shared int16_t wg_mem3 = {};
shared int16_t wg_mem4 = {};
shared int16_t wg_mem5 = {};
shared int16_t wg_mem6 = {};
shared int16_t wg_mem7 = {};
shared int16_t wg_mem8 = {};
void main() {
  a.a[0] = (int(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int(wg_mem5) ==  0) ? 0 : 1;
  a.a[6] = (int(wg_mem6) ==  0) ? 0 : 1;
  a.a[7] = (int(wg_mem7) ==  0) ? 0 : 1;
  a.a[8] = (int(wg_mem8) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared i16vec2 wg_mem0 = {};
shared i16vec2 wg_mem1 = {};
shared i16vec2 wg_mem2 = {};
shared i16vec2 wg_mem3 = {};
shared i16vec2 wg_mem4 = {};
shared i16vec2 wg_mem5 = {};
shared i16vec2 wg_mem6 = {};
shared i16vec2 wg_mem7 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[14 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared i16vec3 wg_mem0 = {};
shared i16vec3 wg_mem1 = {};
shared i16vec3 wg_mem2 = {};
shared i16vec3 wg_mem3 = {};
shared i16vec3 wg_mem4 = {};
shared i16vec3 wg_mem5 = {};
shared i16vec3 wg_mem6 = {};
shared i16vec3 wg_mem7 = {};
shared i16vec3 wg_mem8 = {};
shared i16vec3 wg_mem9 = {};
shared i16vec3 wg_mem10 = {};
shared i16vec3 wg_mem11 = {};
shared i16vec3 wg_mem12 = {};
shared i16vec3 wg_mem13 = {};
shared i16vec3 wg_mem14 = {};
shared i16vec3 wg_mem15 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[15 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[21 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[27 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[33 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[39 + gl_LocalInvocationID.x] = (int(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[42 + gl_LocalInvocationID.x] = (int(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[45 + gl_LocalInvocationID.x] = (int(wg_mem15[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared i16vec4 wg_mem0 = {};
shared i16vec4 wg_mem1 = {};
shared i16vec4 wg_mem2 = {};
shared i16vec4 wg_mem3 = {};
shared i16vec4 wg_mem4 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared uint64_t wg_mem0 = {};
shared uint64_t wg_mem1 = {};
shared uint64_t wg_mem2 = {};
shared uint64_t wg_mem3 = {};
shared uint64_t wg_mem4 = {};
shared uint64_t wg_mem5 = {};
shared uint64_t wg_mem6 = {};
shared uint64_t wg_mem7 = {};
shared uint64_t wg_mem8 = {};
shared uint64_t wg_mem9 = {};
void main() {
  a.a[0] = (int64_t(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int64_t(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int64_t(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int64_t(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int64_t(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int64_t(wg_mem5) ==  0) ? 0 : 1;
  a.a[6] = (int64_t(wg_mem6) ==  0) ? 0 : 1;
  a.a[7] = (int64_t(wg_mem7) ==  0) ? 0 : 1;
  a.a[8] = (int64_t(wg_mem8) ==  0) ? 0 : 1;
  a.a[9] = (int64_t(wg_mem9) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared u64vec2 wg_mem0 = {};
shared u64vec2 wg_mem1 = {};
shared u64vec2 wg_mem2 = {};
shared u64vec2 wg_mem3 = {};
shared u64vec2 wg_mem4 = {};
shared u64vec2 wg_mem5 = {};
shared u64vec2 wg_mem6 = {};
shared u64vec2 wg_mem7 = {};
shared u64vec2 wg_mem8 = {};
shared u64vec2 wg_mem9 = {};
shared u64vec2 wg_mem10 = {};
shared u64vec2 wg_mem11 = {};
shared u64vec2 wg_mem12 = {};
shared u64vec2 wg_mem13 = {};
shared u64vec2 wg_mem14 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[14 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int64_t(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int64_t(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[22 + gl_LocalInvocationID.x] = (int64_t(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[26 + gl_LocalInvocationID.x] = (int64_t(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int64_t(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared u64vec3 wg_mem0 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared u64vec4 wg_mem0 = {};
shared u64vec4 wg_mem1 = {};
shared u64vec4 wg_mem2 = {};
shared u64vec4 wg_mem3 = {};
shared u64vec4 wg_mem4 = {};
shared u64vec4 wg_mem5 = {};
shared u64vec4 wg_mem6 = {};
shared u64vec4 wg_mem7 = {};
shared u64vec4 wg_mem8 = {};
shared u64vec4 wg_mem9 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int64_t(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared int64_t wg_mem0 = {};
shared int64_t wg_mem1 = {};
shared int64_t wg_mem2 = {};
shared int64_t wg_mem3 = {};
shared int64_t wg_mem4 = {};
shared int64_t wg_mem5 = {};
void main() {
  a.a[0] = (int64_t(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int64_t(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int64_t(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int64_t(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int64_t(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int64_t(wg_mem5) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared i64vec2 wg_mem0 = {};
shared i64vec2 wg_mem1 = {};
shared i64vec2 wg_mem2 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared i64vec3 wg_mem0 = {};
shared i64vec3 wg_mem1 = {};
shared i64vec3 wg_mem2 = {};
shared i64vec3 wg_mem3 = {};
shared i64vec3 wg_mem4 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared i64vec4 wg_mem0 = {};
shared i64vec4 wg_mem1 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared float32_t wg_mem0 = {};
shared float32_t wg_mem1 = {};
shared float32_t wg_mem2 = {};
shared float32_t wg_mem3 = {};
shared float32_t wg_mem4 = {};
shared float32_t wg_mem5 = {};
shared float32_t wg_mem6 = {};
shared float32_t wg_mem7 = {};
shared float32_t wg_mem8 = {};
shared float32_t wg_mem9 = {};
shared float32_t wg_mem10 = {};
void main() {
  a.a[0] = (int(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int(wg_mem5) ==  0) ? 0 : 1;
  a.a[6] = (int(wg_mem6) ==  0) ? 0 : 1;
  a.a[7] = (int(wg_mem7) ==  0) ? 0 : 1;
  a.a[8] = (int(wg_mem8) ==  0) ? 0 : 1;
  a.a[9] = (int(wg_mem9) ==  0) ? 0 : 1;
  a.a[10] = (int(wg_mem10) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32vec2 wg_mem0 = {};
shared f32vec2 wg_mem1 = {};
shared f32vec2 wg_mem2 = {};
shared f32vec2 wg_mem3 = {};
shared f32vec2 wg_mem4 = {};
shared f32vec2 wg_mem5 = {};
shared f32vec2 wg_mem6 = {};
shared f32vec2 wg_mem7 = {};
shared f32vec2 wg_mem8 = {};
shared f32vec2 wg_mem9 = {};
shared f32vec2 wg_mem10 = {};
shared f32vec2 wg_mem11 = {};
shared f32vec2 wg_mem12 = {};
shared f32vec2 wg_mem13 = {};
shared f32vec2 wg_mem14 = {};
shared f32vec2 wg_mem15 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[14 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[22 + gl_LocalInvocationID.x] = (int(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[26 + gl_LocalInvocationID.x] = (int(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem15[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32vec3 wg_mem0 = {};
shared f32vec3 wg_mem1 = {};
shared f32vec3 wg_mem2 = {};
shared f32vec3 wg_mem3 = {};
shared f32vec3 wg_mem4 = {};
shared f32vec3 wg_mem5 = {};
shared f32vec3 wg_mem6 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[15 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32vec4 wg_mem0 = {};
shared f32vec4 wg_mem1 = {};
shared f32vec4 wg_mem2 = {};
shared f32vec4 wg_mem3 = {};
shared f32vec4 wg_mem4 = {};
shared f32vec4 wg_mem5 = {};
shared f32vec4 wg_mem6 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32mat2x2 wg_mem0 = {};
shared f32mat2x2 wg_mem1 = {};
shared f32mat2x2 wg_mem2 = {};
shared f32mat2x2 wg_mem3 = {};
shared f32mat2x2 wg_mem4 = {};
shared f32mat2x2 wg_mem5 = {};
shared f32mat2x2 wg_mem6 = {};
shared f32mat2x2 wg_mem7 = {};
shared f32mat2x2 wg_mem8 = {};
shared f32mat2x2 wg_mem9 = {};
shared f32mat2x2 wg_mem10 = {};
shared f32mat2x2 wg_mem11 = {};
shared f32mat2x2 wg_mem12 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 2;
  uint col = gl_LocalInvocationID.x / 2;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[44 + gl_LocalInvocationID.x] = (int(wg_mem11[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem12[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 6, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32mat2x3 wg_mem0 = {};
shared f32mat2x3 wg_mem1 = {};
shared f32mat2x3 wg_mem2 = {};
shared f32mat2x3 wg_mem3 = {};
shared f32mat2x3 wg_mem4 = {};
shared f32mat2x3 wg_mem5 = {};
shared f32mat2x3 wg_mem6 = {};
shared f32mat2x3 wg_mem7 = {};
shared f32mat2x3 wg_mem8 = {};
shared f32mat2x3 wg_mem9 = {};
shared f32mat2x3 wg_mem10 = {};
shared f32mat2x3 wg_mem11 = {};
shared f32mat2x3 wg_mem12 = {};
shared f32mat2x3 wg_mem13 = {};
shared f32mat2x3 wg_mem14 = {};
shared f32mat2x3 wg_mem15 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 2;
  uint col = gl_LocalInvocationID.x / 2;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[42 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[54 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[60 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[66 + gl_LocalInvocationID.x] = (int(wg_mem11[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int(wg_mem12[row][col]) ==  0) ? 0 : 1;
  a.a[78 + gl_LocalInvocationID.x] = (int(wg_mem13[row][col]) ==  0) ? 0 : 1;
  a.a[84 + gl_LocalInvocationID.x] = (int(wg_mem14[row][col]) ==  0) ? 0 : 1;
  a.a[90 + gl_LocalInvocationID.x] = (int(wg_mem15[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32mat2x4 wg_mem0 = {};
shared f32mat2x4 wg_mem1 = {};
shared f32mat2x4 wg_mem2 = {};
shared f32mat2x4 wg_mem3 = {};
shared f32mat2x4 wg_mem4 = {};
shared f32mat2x4 wg_mem5 = {};
shared f32mat2x4 wg_mem6 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 2;
  uint col = gl_LocalInvocationID.x / 2;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 6, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32mat3x2 wg_mem0 = {};
shared f32mat3x2 wg_mem1 = {};
shared f32mat3x2 wg_mem2 = {};
shared f32mat3x2 wg_mem3 = {};
shared f32mat3x2 wg_mem4 = {};
shared f32mat3x2 wg_mem5 = {};
shared f32mat3x2 wg_mem6 = {};
shared f32mat3x2 wg_mem7 = {};
shared f32mat3x2 wg_mem8 = {};
shared f32mat3x2 wg_mem9 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 3;
  uint col = gl_LocalInvocationID.x / 3;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[42 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[54 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 9, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32mat3x3 wg_mem0 = {};
shared f32mat3x3 wg_mem1 = {};
shared f32mat3x3 wg_mem2 = {};
shared f32mat3x3 wg_mem3 = {};
shared f32mat3x3 wg_mem4 = {};
shared f32mat3x3 wg_mem5 = {};
shared f32mat3x3 wg_mem6 = {};
shared f32mat3x3 wg_mem7 = {};
shared f32mat3x3 wg_mem8 = {};
shared f32mat3x3 wg_mem9 = {};
shared f32mat3x3 wg_mem10 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 3;
  uint col = gl_LocalInvocationID.x / 3;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[27 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[45 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[54 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[63 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[81 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[90 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 12, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32mat3x4 wg_mem0 = {};
shared f32mat3x4 wg_mem1 = {};
shared f32mat3x4 wg_mem2 = {};
shared f32mat3x4 wg_mem3 = {};
shared f32mat3x4 wg_mem4 = {};
shared f32mat3x4 wg_mem5 = {};
shared f32mat3x4 wg_mem6 = {};
shared f32mat3x4 wg_mem7 = {};
shared f32mat3x4 wg_mem8 = {};
shared f32mat3x4 wg_mem9 = {};
shared f32mat3x4 wg_mem10 = {};
shared f32mat3x4 wg_mem11 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 3;
  uint col = gl_LocalInvocationID.x / 3;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[60 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[84 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[108 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[120 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[132 + gl_LocalInvocationID.x] = (int(wg_mem11[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32mat4x2 wg_mem0 = {};
shared f32mat4x2 wg_mem1 = {};
shared f32mat4x2 wg_mem2 = {};
shared f32mat4x2 wg_mem3 = {};
shared f32mat4x2 wg_mem4 = {};
shared f32mat4x2 wg_mem5 = {};
shared f32mat4x2 wg_mem6 = {};
shared f32mat4x2 wg_mem7 = {};
shared f32mat4x2 wg_mem8 = {};
shared f32mat4x2 wg_mem9 = {};
shared f32mat4x2 wg_mem10 = {};
shared f32mat4x2 wg_mem11 = {};
shared f32mat4x2 wg_mem12 = {};
shared f32mat4x2 wg_mem13 = {};
shared f32mat4x2 wg_mem14 = {};
shared f32mat4x2 wg_mem15 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 4;
  uint col = gl_LocalInvocationID.x / 4;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[56 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[64 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[80 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[88 + gl_LocalInvocationID.x] = (int(wg_mem11[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int(wg_mem12[row][col]) ==  0) ? 0 : 1;
  a.a[104 + gl_LocalInvocationID.x] = (int(wg_mem13[row][col]) ==  0) ? 0 : 1;
  a.a[112 + gl_LocalInvocationID.x] = (int(wg_mem14[row][col]) ==  0) ? 0 : 1;
  a.a[120 + gl_LocalInvocationID.x] = (int(wg_mem15[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 12, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32mat4x3 wg_mem0 = {};
shared f32mat4x3 wg_mem1 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 4;
  uint col = gl_LocalInvocationID.x / 4;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 16, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f32mat4x4 wg_mem0 = {};
shared f32mat4x4 wg_mem1 = {};
shared f32mat4x4 wg_mem2 = {};
shared f32mat4x4 wg_mem3 = {};
shared f32mat4x4 wg_mem4 = {};
shared f32mat4x4 wg_mem5 = {};
shared f32mat4x4 wg_mem6 = {};
shared f32mat4x4 wg_mem7 = {};
shared f32mat4x4 wg_mem8 = {};
shared f32mat4x4 wg_mem9 = {};
shared f32mat4x4 wg_mem10 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 4;
  uint col = gl_LocalInvocationID.x / 4;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[64 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[80 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[112 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[128 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[144 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[160 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared float16_t wg_mem0 = {};
shared float16_t wg_mem1 = {};
shared float16_t wg_mem2 = {};
void main() {
  a.a[0] = (int(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int(wg_mem2) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16vec2 wg_mem0 = {};
shared f16vec2 wg_mem1 = {};
shared f16vec2 wg_mem2 = {};
shared f16vec2 wg_mem3 = {};
shared f16vec2 wg_mem4 = {};
shared f16vec2 wg_mem5 = {};
shared f16vec2 wg_mem6 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16vec3 wg_mem0 = {};
shared f16vec3 wg_mem1 = {};
shared f16vec3 wg_mem2 = {};
shared f16vec3 wg_mem3 = {};
shared f16vec3 wg_mem4 = {};
shared f16vec3 wg_mem5 = {};
shared f16vec3 wg_mem6 = {};
shared f16vec3 wg_mem7 = {};
shared f16vec3 wg_mem8 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[15 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[21 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16vec4 wg_mem0 = {};
shared f16vec4 wg_mem1 = {};
shared f16vec4 wg_mem2 = {};
shared f16vec4 wg_mem3 = {};
shared f16vec4 wg_mem4 = {};
shared f16vec4 wg_mem5 = {};
shared f16vec4 wg_mem6 = {};
shared f16vec4 wg_mem7 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16mat2x2 wg_mem0 = {};
shared f16mat2x2 wg_mem1 = {};
shared f16mat2x2 wg_mem2 = {};
shared f16mat2x2 wg_mem3 = {};
shared f16mat2x2 wg_mem4 = {};
shared f16mat2x2 wg_mem5 = {};
shared f16mat2x2 wg_mem6 = {};
shared f16mat2x2 wg_mem7 = {};
shared f16mat2x2 wg_mem8 = {};
shared f16mat2x2 wg_mem9 = {};
shared f16mat2x2 wg_mem10 = {};
shared f16mat2x2 wg_mem11 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 2;
  uint col = gl_LocalInvocationID.x / 2;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[44 + gl_LocalInvocationID.x] = (int(wg_mem11[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 6, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16mat2x3 wg_mem0 = {};
shared f16mat2x3 wg_mem1 = {};
shared f16mat2x3 wg_mem2 = {};
shared f16mat2x3 wg_mem3 = {};
shared f16mat2x3 wg_mem4 = {};
shared f16mat2x3 wg_mem5 = {};
shared f16mat2x3 wg_mem6 = {};
shared f16mat2x3 wg_mem7 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 2;
  uint col = gl_LocalInvocationID.x / 2;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[42 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16mat2x4 wg_mem0 = {};
shared f16mat2x4 wg_mem1 = {};
shared f16mat2x4 wg_mem2 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 2;
  uint col = gl_LocalInvocationID.x / 2;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 6, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16mat3x2 wg_mem0 = {};
shared f16mat3x2 wg_mem1 = {};
shared f16mat3x2 wg_mem2 = {};
shared f16mat3x2 wg_mem3 = {};
shared f16mat3x2 wg_mem4 = {};
shared f16mat3x2 wg_mem5 = {};
shared f16mat3x2 wg_mem6 = {};
shared f16mat3x2 wg_mem7 = {};
shared f16mat3x2 wg_mem8 = {};
shared f16mat3x2 wg_mem9 = {};
shared f16mat3x2 wg_mem10 = {};
shared f16mat3x2 wg_mem11 = {};
shared f16mat3x2 wg_mem12 = {};
shared f16mat3x2 wg_mem13 = {};
shared f16mat3x2 wg_mem14 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 3;
  uint col = gl_LocalInvocationID.x / 3;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[42 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[54 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[60 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[66 + gl_LocalInvocationID.x] = (int(wg_mem11[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int(wg_mem12[row][col]) ==  0) ? 0 : 1;
  a.a[78 + gl_LocalInvocationID.x] = (int(wg_mem13[row][col]) ==  0) ? 0 : 1;
  a.a[84 + gl_LocalInvocationID.x] = (int(wg_mem14[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 9, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16mat3x3 wg_mem0 = {};
shared f16mat3x3 wg_mem1 = {};
shared f16mat3x3 wg_mem2 = {};
shared f16mat3x3 wg_mem3 = {};
shared f16mat3x3 wg_mem4 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 3;
  uint col = gl_LocalInvocationID.x / 3;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[27 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 12, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16mat3x4 wg_mem0 = {};
shared f16mat3x4 wg_mem1 = {};
shared f16mat3x4 wg_mem2 = {};
shared f16mat3x4 wg_mem3 = {};
shared f16mat3x4 wg_mem4 = {};
shared f16mat3x4 wg_mem5 = {};
shared f16mat3x4 wg_mem6 = {};
shared f16mat3x4 wg_mem7 = {};
shared f16mat3x4 wg_mem8 = {};
shared f16mat3x4 wg_mem9 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 3;
  uint col = gl_LocalInvocationID.x / 3;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[60 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[84 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[108 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16mat4x2 wg_mem0 = {};
shared f16mat4x2 wg_mem1 = {};
shared f16mat4x2 wg_mem2 = {};
shared f16mat4x2 wg_mem3 = {};
shared f16mat4x2 wg_mem4 = {};
shared f16mat4x2 wg_mem5 = {};
shared f16mat4x2 wg_mem6 = {};
shared f16mat4x2 wg_mem7 = {};
shared f16mat4x2 wg_mem8 = {};
shared f16mat4x2 wg_mem9 = {};
shared f16mat4x2 wg_mem10 = {};
shared f16mat4x2 wg_mem11 = {};
shared f16mat4x2 wg_mem12 = {};
shared f16mat4x2 wg_mem13 = {};
shared f16mat4x2 wg_mem14 = {};
shared f16mat4x2 wg_mem15 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 4;
  uint col = gl_LocalInvocationID.x / 4;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[56 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[64 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[80 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[88 + gl_LocalInvocationID.x] = (int(wg_mem11[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int(wg_mem12[row][col]) ==  0) ? 0 : 1;
  a.a[104 + gl_LocalInvocationID.x] = (int(wg_mem13[row][col]) ==  0) ? 0 : 1;
  a.a[112 + gl_LocalInvocationID.x] = (int(wg_mem14[row][col]) ==  0) ? 0 : 1;
  a.a[120 + gl_LocalInvocationID.x] = (int(wg_mem15[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 12, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16mat4x3 wg_mem0 = {};
shared f16mat4x3 wg_mem1 = {};
shared f16mat4x3 wg_mem2 = {};
shared f16mat4x3 wg_mem3 = {};
shared f16mat4x3 wg_mem4 = {};
shared f16mat4x3 wg_mem5 = {};
shared f16mat4x3 wg_mem6 = {};
shared f16mat4x3 wg_mem7 = {};
shared f16mat4x3 wg_mem8 = {};
shared f16mat4x3 wg_mem9 = {};
shared f16mat4x3 wg_mem10 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 4;
  uint col = gl_LocalInvocationID.x / 4;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[60 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[84 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[108 + gl_LocalInvocationID.x] = (int(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[120 + gl_LocalInvocationID.x] = (int(wg_mem10[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 16, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f16mat4x4 wg_mem0 = {};
shared f16mat4x4 wg_mem1 = {};
shared f16mat4x4 wg_mem2 = {};
shared f16mat4x4 wg_mem3 = {};
shared f16mat4x4 wg_mem4 = {};
shared f16mat4x4 wg_mem5 = {};
shared f16mat4x4 wg_mem6 = {};
shared f16mat4x4 wg_mem7 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 4;
  uint col = gl_LocalInvocationID.x / 4;
  a.a[0 + gl_LocalInvocationID.x] = (int(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[64 + gl_LocalInvocationID.x] = (int(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[80 + gl_LocalInvocationID.x] = (int(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[112 + gl_LocalInvocationID.x] = (int(wg_mem7[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared float64_t wg_mem0 = {};
shared float64_t wg_mem1 = {};
shared float64_t wg_mem2 = {};
shared float64_t wg_mem3 = {};
shared float64_t wg_mem4 = {};
shared float64_t wg_mem5 = {};
shared float64_t wg_mem6 = {};
void main() {
  a.a[0] = (int64_t(wg_mem0) ==  0) ? 0 : 1;
  a.a[1] = (int64_t(wg_mem1) ==  0) ? 0 : 1;
  a.a[2] = (int64_t(wg_mem2) ==  0) ? 0 : 1;
  a.a[3] = (int64_t(wg_mem3) ==  0) ? 0 : 1;
  a.a[4] = (int64_t(wg_mem4) ==  0) ? 0 : 1;
  a.a[5] = (int64_t(wg_mem5) ==  0) ? 0 : 1;
  a.a[6] = (int64_t(wg_mem6) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64vec2 wg_mem0 = {};
shared f64vec2 wg_mem1 = {};
shared f64vec2 wg_mem2 = {};
shared f64vec2 wg_mem3 = {};
shared f64vec2 wg_mem4 = {};
shared f64vec2 wg_mem5 = {};
shared f64vec2 wg_mem6 = {};
shared f64vec2 wg_mem7 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[2 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[10 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[14 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 3, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64vec3 wg_mem0 = {};
shared f64vec3 wg_mem1 = {};
shared f64vec3 wg_mem2 = {};
shared f64vec3 wg_mem3 = {};
shared f64vec3 wg_mem4 = {};
shared f64vec3 wg_mem5 = {};
shared f64vec3 wg_mem6 = {};
shared f64vec3 wg_mem7 = {};
shared f64vec3 wg_mem8 = {};
shared f64vec3 wg_mem9 = {};
shared f64vec3 wg_mem10 = {};
shared f64vec3 wg_mem11 = {};
shared f64vec3 wg_mem12 = {};
shared f64vec3 wg_mem13 = {};
shared f64vec3 wg_mem14 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[3 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[15 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[21 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[27 + gl_LocalInvocationID.x] = (int64_t(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int64_t(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[33 + gl_LocalInvocationID.x] = (int64_t(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int64_t(wg_mem12[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[39 + gl_LocalInvocationID.x] = (int64_t(wg_mem13[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[42 + gl_LocalInvocationID.x] = (int64_t(wg_mem14[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64vec4 wg_mem0 = {};
shared f64vec4 wg_mem1 = {};
shared f64vec4 wg_mem2 = {};
shared f64vec4 wg_mem3 = {};
shared f64vec4 wg_mem4 = {};
shared f64vec4 wg_mem5 = {};
shared f64vec4 wg_mem6 = {};
shared f64vec4 wg_mem7 = {};
shared f64vec4 wg_mem8 = {};
shared f64vec4 wg_mem9 = {};
shared f64vec4 wg_mem10 = {};
shared f64vec4 wg_mem11 = {};
void main() {
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int64_t(wg_mem9[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int64_t(wg_mem10[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
  a.a[44 + gl_LocalInvocationID.x] = (int64_t(wg_mem11[gl_LocalInvocationID.x]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64mat2x2 wg_mem0 = {};
shared f64mat2x2 wg_mem1 = {};
shared f64mat2x2 wg_mem2 = {};
shared f64mat2x2 wg_mem3 = {};
shared f64mat2x2 wg_mem4 = {};
shared f64mat2x2 wg_mem5 = {};
shared f64mat2x2 wg_mem6 = {};
shared f64mat2x2 wg_mem7 = {};
shared f64mat2x2 wg_mem8 = {};
shared f64mat2x2 wg_mem9 = {};
shared f64mat2x2 wg_mem10 = {};
shared f64mat2x2 wg_mem11 = {};
shared f64mat2x2 wg_mem12 = {};
shared f64mat2x2 wg_mem13 = {};
shared f64mat2x2 wg_mem14 = {};
shared f64mat2x2 wg_mem15 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 2;
  uint col = gl_LocalInvocationID.x / 2;
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[4 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[20 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[28 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int64_t(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int64_t(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[44 + gl_LocalInvocationID.x] = (int64_t(wg_mem11[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int64_t(wg_mem12[row][col]) ==  0) ? 0 : 1;
  a.a[52 + gl_LocalInvocationID.x] = (int64_t(wg_mem13[row][col]) ==  0) ? 0 : 1;
  a.a[56 + gl_LocalInvocationID.x] = (int64_t(wg_mem14[row][col]) ==  0) ? 0 : 1;
  a.a[60 + gl_LocalInvocationID.x] = (int64_t(wg_mem15[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 6, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64mat2x3 wg_mem0 = {};
shared f64mat2x3 wg_mem1 = {};
shared f64mat2x3 wg_mem2 = {};
shared f64mat2x3 wg_mem3 = {};
shared f64mat2x3 wg_mem4 = {};
shared f64mat2x3 wg_mem5 = {};
shared f64mat2x3 wg_mem6 = {};
shared f64mat2x3 wg_mem7 = {};
shared f64mat2x3 wg_mem8 = {};
shared f64mat2x3 wg_mem9 = {};
shared f64mat2x3 wg_mem10 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 2;
  uint col = gl_LocalInvocationID.x / 2;
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[6 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[30 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[42 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[54 + gl_LocalInvocationID.x] = (int64_t(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[60 + gl_LocalInvocationID.x] = (int64_t(wg_mem10[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64mat2x4 wg_mem0 = {};
shared f64mat2x4 wg_mem1 = {};
shared f64mat2x4 wg_mem2 = {};
shared f64mat2x4 wg_mem3 = {};
shared f64mat2x4 wg_mem4 = {};
shared f64mat2x4 wg_mem5 = {};
shared f64mat2x4 wg_mem6 = {};
shared f64mat2x4 wg_mem7 = {};
shared f64mat2x4 wg_mem8 = {};
shared f64mat2x4 wg_mem9 = {};
shared f64mat2x4 wg_mem10 = {};
shared f64mat2x4 wg_mem11 = {};
shared f64mat2x4 wg_mem12 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 2;
  uint col = gl_LocalInvocationID.x / 2;
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[56 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[64 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int64_t(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[80 + gl_LocalInvocationID.x] = (int64_t(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[88 + gl_LocalInvocationID.x] = (int64_t(wg_mem11[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int64_t(wg_mem12[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 6, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64mat3x2 wg_mem0 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 3;
  uint col = gl_LocalInvocationID.x / 3;
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 9, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64mat3x3 wg_mem0 = {};
shared f64mat3x3 wg_mem1 = {};
shared f64mat3x3 wg_mem2 = {};
shared f64mat3x3 wg_mem3 = {};
shared f64mat3x3 wg_mem4 = {};
shared f64mat3x3 wg_mem5 = {};
shared f64mat3x3 wg_mem6 = {};
shared f64mat3x3 wg_mem7 = {};
shared f64mat3x3 wg_mem8 = {};
shared f64mat3x3 wg_mem9 = {};
shared f64mat3x3 wg_mem10 = {};
shared f64mat3x3 wg_mem11 = {};
shared f64mat3x3 wg_mem12 = {};
shared f64mat3x3 wg_mem13 = {};
shared f64mat3x3 wg_mem14 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 3;
  uint col = gl_LocalInvocationID.x / 3;
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[9 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[18 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[27 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[45 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[54 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[63 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[81 + gl_LocalInvocationID.x] = (int64_t(wg_mem9[row][col]) ==  0) ? 0 : 1;
  a.a[90 + gl_LocalInvocationID.x] = (int64_t(wg_mem10[row][col]) ==  0) ? 0 : 1;
  a.a[99 + gl_LocalInvocationID.x] = (int64_t(wg_mem11[row][col]) ==  0) ? 0 : 1;
  a.a[108 + gl_LocalInvocationID.x] = (int64_t(wg_mem12[row][col]) ==  0) ? 0 : 1;
  a.a[117 + gl_LocalInvocationID.x] = (int64_t(wg_mem13[row][col]) ==  0) ? 0 : 1;
  a.a[126 + gl_LocalInvocationID.x] = (int64_t(wg_mem14[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 12, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64mat3x4 wg_mem0 = {};
shared f64mat3x4 wg_mem1 = {};
shared f64mat3x4 wg_mem2 = {};
shared f64mat3x4 wg_mem3 = {};
shared f64mat3x4 wg_mem4 = {};
shared f64mat3x4 wg_mem5 = {};
shared f64mat3x4 wg_mem6 = {};
shared f64mat3x4 wg_mem7 = {};
shared f64mat3x4 wg_mem8 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 3;
  uint col = gl_LocalInvocationID.x / 3;
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[60 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[72 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[84 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64mat4x2 wg_mem0 = {};
shared f64mat4x2 wg_mem1 = {};
shared f64mat4x2 wg_mem2 = {};
shared f64mat4x2 wg_mem3 = {};
shared f64mat4x2 wg_mem4 = {};
shared f64mat4x2 wg_mem5 = {};
shared f64mat4x2 wg_mem6 = {};
shared f64mat4x2 wg_mem7 = {};
shared f64mat4x2 wg_mem8 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 4;
  uint col = gl_LocalInvocationID.x / 4;
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[8 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[40 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[56 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[64 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 12, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64mat4x3 wg_mem0 = {};
shared f64mat4x3 wg_mem1 = {};
shared f64mat4x3 wg_mem2 = {};
shared f64mat4x3 wg_mem3 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 4;
  uint col = gl_LocalInvocationID.x / 4;
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[12 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[24 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[36 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable
layout(local_size_x = 16, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A  { uint a[]; } a;
shared f64mat4x4 wg_mem0 = {};
shared f64mat4x4 wg_mem1 = {};
shared f64mat4x4 wg_mem2 = {};
shared f64mat4x4 wg_mem3 = {};
shared f64mat4x4 wg_mem4 = {};
shared f64mat4x4 wg_mem5 = {};
shared f64mat4x4 wg_mem6 = {};
shared f64mat4x4 wg_mem7 = {};
shared f64mat4x4 wg_mem8 = {};
shared f64mat4x4 wg_mem9 = {};
void main() {
  uint row = gl_LocalInvocationID.x % 4;
  uint col = gl_LocalInvocationID.x / 4;
  a.a[0 + gl_LocalInvocationID.x] = (int64_t(wg_mem0[row][col]) ==  0) ? 0 : 1;
  a.a[16 + gl_LocalInvocationID.x] = (int64_t(wg_mem1[row][col]) ==  0) ? 0 : 1;
  a.a[32 + gl_LocalInvocationID.x] = (int64_t(wg_mem2[row][col]) ==  0) ? 0 : 1;
  a.a[48 + gl_LocalInvocationID.x] = (int64_t(wg_mem3[row][col]) ==  0) ? 0 : 1;
  a.a[64 + gl_LocalInvocationID.x] = (int64_t(wg_mem4[row][col]) ==  0) ? 0 : 1;
  a.a[80 + gl_LocalInvocationID.x] = (int64_t(wg_mem5[row][col]) ==  0) ? 0 : 1;
  a.a[96 + gl_LocalInvocationID.x] = (int64_t(wg_mem6[row][col]) ==  0) ? 0 : 1;
  a.a[112 + gl_LocalInvocationID.x] = (int64_t(wg_mem7[row][col]) ==  0) ? 0 : 1;
  a.a[128 + gl_LocalInvocationID.x] = (int64_t(wg_mem8[row][col]) ==  0) ? 0 : 1;
  a.a[144 + gl_LocalInvocationID.x] = (int64_t(wg_mem9[row][col]) ==  0) ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(constant_id = 0) const uint specId0 = 1;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

shared uint wg_mem[specId0] = {};

void main() {
for (uint i = 0; i < specId0; ++i) {
  a.a[i] = wg_mem[i];
}
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(constant_id = 0) const uint specId0 = 1;
layout(constant_id = 1) const uint specId1 = 1;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

shared float wg_mem[specId0][specId1] = {};

void main() {
for (uint i = 0; i < specId0; ++i) {
  for (uint j = 0; j < specId1; ++j) {
    uint idx = i * specId1 + j;
    a.a[idx] = wg_mem[i][j] == 0.0f ? 0 : 1;
  }
}
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

struct Sa {
  uint a;
  uvec2 b;
  uvec3 c;
  uvec4 d;
  float e;
  vec2 f;
  vec3 g;
  vec4 h;
  bool i;
  bvec2 j;
  bvec3 k;
  bvec4 l;
};
shared Sa wg_mem = {};

void main() {
uint i = 0;
a.a[i++] = wg_mem.a;
a.a[i++] = wg_mem.b.x;
a.a[i++] = wg_mem.b.y;
a.a[i++] = wg_mem.c.x;
a.a[i++] = wg_mem.c.y;
a.a[i++] = wg_mem.c.z;
a.a[i++] = wg_mem.d.x;
a.a[i++] = wg_mem.d.y;
a.a[i++] = wg_mem.d.z;
a.a[i++] = wg_mem.d.w;
a.a[i++] = wg_mem.e == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.f.x == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.f.y == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.g.x == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.g.y == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.g.z == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.h.x == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.h.y == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.h.z == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.h.w == 0.0f ? 0 : 1;
a.a[i++] = wg_mem.i ? 1 : 0;
a.a[i++] = wg_mem.j.x ? 1 : 0;
a.a[i++] = wg_mem.j.y ? 1 : 0;
a.a[i++] = wg_mem.k.x ? 1 : 0;
a.a[i++] = wg_mem.k.y ? 1 : 0;
a.a[i++] = wg_mem.k.z ? 1 : 0;
a.a[i++] = wg_mem.l.x ? 1 : 0;
a.a[i++] = wg_mem.l.y ? 1 : 0;
a.a[i++] = wg_mem.l.z ? 1 : 0;
a.a[i++] = wg_mem.l.w ? 1 : 0;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(constant_id = 0) const uint specId0 = 1;
layout(constant_id = 1) const uint specId1 = 1;
layout(constant_id = 2) const uint specId2 = 1;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

struct Sa {
  uint a;
};
struct Sb {
  uvec2 a;
};
struct Sc {
  Sa a[specId0];
  Sb b[specId1];
};
shared Sc wg_mem[specId2] = {};

void main() {
uint idx = 0;
for (uint i = 0; i < specId2; ++i) {
  for (uint j = 0; j < specId0; ++j) {
    a.a[idx++] = wg_mem[i].a[j].a;
  }
  for (uint j = 0; j < specId1; ++j) {
    a.a[idx++] = wg_mem[i].b[j].a.x;
    a.a[idx++] = wg_mem[i].b[j].a.y;
  }
}
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(constant_id = 0) const uint specId0 = 1;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

struct Sa {
  f16vec2 a;
  float16_t b[specId0];
};
shared Sa wg_mem = {};

void main() {
uint idx = 0;
a.a[idx++] = floatBitsToUint(wg_mem.a.x) == 0 ? 0 : 1;
a.a[idx++] = floatBitsToUint(wg_mem.a.y) == 0 ? 0 : 1;
for (uint i = 0; i < specId0; ++i) {
  a.a[idx++] = floatBitsToUint(wg_mem.b[i]) == 0 ? 0 : 1;
}
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(constant_id = 0) const uint specId0 = 1;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

struct Sa {
  f64vec2 a;
  float64_t b[specId0];
};
shared Sa wg_mem = {};

void main() {
uint idx = 0;
a.a[idx++] = wg_mem.a.x == 0.0 ? 0 : 1;
a.a[idx++] = wg_mem.a.y == 0.0 ? 0 : 1;
for (uint i = 0; i < specId0; ++i) {
  a.a[idx++] = wg_mem.b[i] == 0.0 ? 0 : 1;
}
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(constant_id = 0) const uint specId0 = 1;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

struct Sa {
  i8vec2 a;
  int8_t b[specId0];
};
shared Sa wg_mem = {};

void main() {
uint idx = 0;
a.a[idx++] = wg_mem.a.x == 0 ? 0 : 1;
a.a[idx++] = wg_mem.a.y == 0 ? 0 : 1;
for (uint i = 0; i < specId0; ++i) {
  a.a[idx++] = wg_mem.b[i] == 0 ? 0 : 1;
}
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(constant_id = 0) const uint specId0 = 1;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

struct Sa {
  i16vec2 a;
  int16_t b[specId0];
};
shared Sa wg_mem = {};

void main() {
uint idx = 0;
a.a[idx++] = wg_mem.a.x == 0 ? 0 : 1;
a.a[idx++] = wg_mem.a.y == 0 ? 0 : 1;
for (uint i = 0; i < specId0; ++i) {
  a.a[idx++] = wg_mem.b[i] == 0 ? 0 : 1;
}
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(constant_id = 0) const uint specId0 = 1;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

struct Sa {
  i64vec2 a;
  int64_t b[specId0];
};
shared Sa wg_mem = {};

void main() {
uint idx = 0;
a.a[idx++] = wg_mem.a.x == 0 ? 0 : 1;
a.a[idx++] = wg_mem.a.y == 0 ? 0 : 1;
for (uint i = 0; i < specId0; ++i) {
  a.a[idx++] = wg_mem.b[i] == 0 ? 0 : 1;
}
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable


layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

struct Sa {
  float16_t a;
  float b;
  int8_t c;
  int16_t d;
  int e;
  int64_t f;
  float64_t g;
};
shared Sa wg_mem = {};

void main() {
uint idx = 0;
a.a[idx++] = floatBitsToUint(wg_mem.a) == 0 ? 0 : 1;
a.a[idx++] = floatBitsToUint(wg_mem.b) == 0 ? 0 : 1;
a.a[idx++] = uint(wg_mem.c);
a.a[idx++] = uint(wg_mem.d);
a.a[idx++] = uint(wg_mem.e);
a.a[idx++] = uint(wg_mem.f);
a.a[idx++] = wg_mem.g == 0.0 ? 0 : 1;
}
#version 450
#extension GL_EXT_null_initializer : enable
#extension GL_EXT_shader_explicit_arithmetic_types : enable

layout(constant_id = 0) const uint specId0 = 1;
layout(constant_id = 1) const uint specId1 = 1;
layout(constant_id = 2) const uint specId2 = 1;
layout(constant_id = 3) const uint specId3 = 1;
layout(constant_id = 4) const uint specId4 = 1;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0) buffer A { uint a[]; } a;

struct Sa {
  uint a;
};
struct Sb {
  Sa a[specId0];
  uint b;
};
struct Sc {
  Sb b[specId1];
  uint c;
};
struct Sd {
  Sc c[specId2];
  uint d;
};
struct Se {
  Sd d[specId3];
  uint e;
};
shared Se wg_mem[specId4] = {};

void main() {
uint idx = 0;
for (uint i1 = 0; i1 < specId4; ++i1) {
  a.a[idx++] = wg_mem[i1].e;
  for (uint i2 = 0; i2 < specId3; ++i2) {
    a.a[idx++] = wg_mem[i1].d[i2].d;
    for (uint i3 = 0; i3 < specId2; ++i3) {
      a.a[idx++] = wg_mem[i1].d[i2].c[i3].c;
      for (uint i4 = 0; i4 < specId1; ++i4) {
        a.a[idx++] = wg_mem[i1].d[i2].c[i3].b[i4].b;
        for (uint i5 = 0; i5 < specId0; ++i5) {
          a.a[idx++] = wg_mem[i1].d[i2].c[i3].b[i4].a[i5].a;
        }
      }
    }
  }
}
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(local_size_x = 128) in;
layout(set = 0, binding = 0) buffer A
{
    uint a[];
} a;

shared uint wg_mem = {};

void main()
{
    uint idx = gl_LocalInvocationID.x;

    if (gl_LocalInvocationIndex == 0)
    {
        wg_mem = 1;
    }

    barrier();
    a.a[idx] = wg_mem;
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(local_size_x = 8, local_size_y = 8, local_size_z = 2) in;
layout(set = 0, binding = 0) buffer A
{
    uint a[];
} a;

shared uint wg_mem = {};

void main()
{
    uint idx_z = gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y;
    uint idx_y = gl_LocalInvocationID.y * gl_WorkGroupSize.x;
    uint idx_x = gl_LocalInvocationID.x;
    uint idx = idx_x + idx_y + idx_z;

    if (gl_LocalInvocationIndex == 0)
    {
        wg_mem = 1;
    }

    barrier();

    a.a[idx] = wg_mem;
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(local_size_x = 8, local_size_y = 2, local_size_z = 8) in;
layout(set = 0, binding = 0) buffer A
{
    uint a[];
} a;

shared uint wg_mem = {};

void main()
{
    uint idx_z = gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y;
    uint idx_y = gl_LocalInvocationID.y * gl_WorkGroupSize.x;
    uint idx_x = gl_LocalInvocationID.x;
    uint idx = idx_x + idx_y + idx_z;

    if (gl_LocalInvocationIndex == 0)
    {
        wg_mem = 1;
    }

    barrier();

    a.a[idx] = wg_mem;
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(local_size_x = 2, local_size_y = 8, local_size_z = 8) in;
layout(set = 0, binding = 0) buffer A
{
    uint a[];
} a;

shared uint wg_mem = {};

void main()
{
    uint idx_z = gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y;
    uint idx_y = gl_LocalInvocationID.y * gl_WorkGroupSize.x;
    uint idx_x = gl_LocalInvocationID.x;
    uint idx = idx_x + idx_y + idx_z;

    if (gl_LocalInvocationIndex == 0)
    {
        wg_mem = 1;
    }

    barrier();

    a.a[idx] = wg_mem;
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(local_size_x = 8, local_size_y = 4, local_size_z = 4) in;
layout(set = 0, binding = 0) buffer A
{
    uint a[];
} a;

shared uint wg_mem = {};

void main()
{
    uint idx_z = gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y;
    uint idx_y = gl_LocalInvocationID.y * gl_WorkGroupSize.x;
    uint idx_x = gl_LocalInvocationID.x;
    uint idx = idx_x + idx_y + idx_z;

    if (gl_LocalInvocationIndex == 0)
    {
        wg_mem = 1;
    }

    barrier();

    a.a[idx] = wg_mem;
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(local_size_x = 4, local_size_y = 8, local_size_z = 4) in;
layout(set = 0, binding = 0) buffer A
{
    uint a[];
} a;

shared uint wg_mem = {};

void main()
{
    uint idx_z = gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y;
    uint idx_y = gl_LocalInvocationID.y * gl_WorkGroupSize.x;
    uint idx_x = gl_LocalInvocationID.x;
    uint idx = idx_x + idx_y + idx_z;

    if (gl_LocalInvocationIndex == 0)
    {
        wg_mem = 1;
    }

    barrier();

    a.a[idx] = wg_mem;
}
#version 450
#extension GL_EXT_null_initializer : enable

layout(local_size_x = 4, local_size_y = 4, local_size_z = 8) in;
layout(set = 0, binding = 0) buffer A
{
    uint a[];
} a;

shared uint wg_mem = {};

void main()
{
    uint idx_z = gl_LocalInvocationID.z * gl_WorkGroupSize.x * gl_WorkGroupSize.y;
    uint idx_y = gl_LocalInvocationID.y * gl_WorkGroupSize.x;
    uint idx_x = gl_LocalInvocationID.x;
    uint idx = idx_x + idx_y + idx_z;

    if (gl_LocalInvocationIndex == 0)
    {
        wg_mem = 1;
    }

    barrier();

    a.a[idx] = wg_mem;
}
