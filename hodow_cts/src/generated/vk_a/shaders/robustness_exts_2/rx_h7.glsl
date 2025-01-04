#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = uvec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = uvec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = uvec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = uvec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 63;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 63;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 1;
    temp = uvec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DMS texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 450 core
void main()
{
  gl_Position = vec4( 2.0*float(gl_VertexIndex&2) - 1.0, 4.0*(gl_VertexIndex&1)-1.0, 1.0 - 2.0 * float(gl_VertexIndex&1), 1);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usamplerCubeArray texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 0), ivec3(0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), uvec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), uint(10));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), uint(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 63;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint val[1024]; } ubo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 3;
    temp = uvec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint val[1024]; } ubo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 10;
    temp = uvec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1DArray texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 10);
    expectedIB2 += uvec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2D texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
  }
  temp_ql = uint(textureQueryLevels(texture0_1));
  temp = uvec4(temp_ql);
  accum += abs(temp);
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DArray texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyzx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyzx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyzx;
    accum += abs(temp);
  }
  temp_ql = uint(textureQueryLevels(texture0_1));
  temp = uvec4(temp_ql);
  accum += abs(temp);
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usamplerCube texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyxx;
    accum += abs(temp);
  }
  temp_ql = uint(textureQueryLevels(texture0_1));
  temp = uvec4(temp_ql);
  accum += abs(temp);
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimage1D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), uint(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(c, 0), uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, c), uint(10));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), 0, uint(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), 0, uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, uvec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec2(0, 0), c, uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), 0, uint(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), 0, uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, uvec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec2(0, 0), c, uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), uint(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimageCube image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), uint(10));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageCube image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 63;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 10;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = uvec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = uvec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DMSArray texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimage1D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), uvec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(c, 0), 0, uint(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec2(0, c), 0, uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, uvec4(123));
    if (c < 0 || c >= 4) imageAtomicAdd(image0_1, ivec2(0, 0), c, uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, uvec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(c, 0), 0, uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, c), 0, uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec2(0, 0), c, uint(10));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) volatile uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(c, 0, 0), uint(10));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, c, 0), uint(10));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, ivec3(0, 0, c), uint(10));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(c, 0, 0), uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, c, 0), uint(10));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    if (c < 0 || c >= 0) imageAtomicAdd(image0_1, ivec3(0, 0, c), uint(10));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageCube image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageCube image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), uvec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 63;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= inboundcoords) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) ssbo0_1.val[c] = uint(123);
    if (c < 0 || c >= 0) atomicAdd(ssbo0_1.val[c], uint(10));
    temp = uvec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uint(123), 0, 0, 0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = uvec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = uvec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(r32ui, set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    if (c < 0 || c >= inboundcoords) imageAtomicAdd(image0_1, c, uint(10));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint val[1024]; } ubo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 64;
    temp = uvec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(r32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1D texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, (c+0.25) / float(5));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, (c+0.25) / float(5), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, (c+0.25) / float(5), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xxxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xxxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xxxx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1D texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, (c+0.25) / float(5));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, (c+0.25) / float(5), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, (c+0.25) / float(5), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xxxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xxxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xxxx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) volatile uniform i64image2DMS u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
  int64_t data[];
} inBuffer;

void main(void)
{
  int gx = int(gl_GlobalInvocationID.x);
  int gy = int(gl_GlobalInvocationID.y);
  int gz = int(gl_GlobalInvocationID.z);
  uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
  imageStore(u_resultImage, ivec2(gx, gy), 0, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec2(gx, gy), 1, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec2(gx, gy), 2, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec2(gx, gy), 3, i64vec4(inBuffer.data[index]));
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMS texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64i, binding=0) volatile uniform i64image2DMSArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
  int64_t data[];
} inBuffer;

void main(void)
{
  int gx = int(gl_GlobalInvocationID.x);
  int gy = int(gl_GlobalInvocationID.y);
  int gz = int(gl_GlobalInvocationID.z);
  uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
  imageStore(u_resultImage, ivec3(gx, gy, gz), 0, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec3(gx, gy, gz), 1, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec3(gx, gy, gz), 2, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec3(gx, gy, gz), 3, i64vec4(inBuffer.data[index]));
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMSArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCube texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyxx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCubeArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 0), ivec3(0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64image1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64image2D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, i64vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64image2DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageCubeArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageCubeArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[68] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l, 131l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[68] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l, 131l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = i64vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = i64vec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = i64vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = i64vec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 10;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMSArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64image1D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image1D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image1D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image1D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image1D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64image1D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image1DArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image2D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image2D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image2DArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image2DArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image2DMSArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image2DMSArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64image2DMSArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64image3D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image3D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64image3D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64imageCube image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64imageCube image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageCube image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageCubeArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 63;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = i64vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = i64vec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[68] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l, 131l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 7l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 3;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 7l, 9l, 11l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 5;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 7;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCube texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyxx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image2D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image2D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64image2DMS image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image2DMSArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image2DMSArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageCube image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageCube image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageCubeArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageCubeArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64imageCubeArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 9l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 9l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 2;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 10;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCubeArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyzx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyzx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyzx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 0), ivec3(0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -3).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483644).xyzx;
    accum += abs(temp);
  }
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image1D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image1DArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image2D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64image2D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image2DMS image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image2DMS image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64image2DMS image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, i64vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image2DArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image2DMSArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, i64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += i64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = i64vec4(0);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64image3D image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64imageCube image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageCube image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform i64imageCubeArray image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), i64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), i64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 3;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 9l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 63;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 63;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = int64_t(123);
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(int64_t(123), 0, 0, 0)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { int64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; int64_t val[]; } ssbo0_1_pad;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = i64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
    temp = i64vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = i64vec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[68] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l, 131l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) volatile uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(r64i, set = 0, binding = 1) uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzo) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(set = 0, binding = 1) uniform i64imageBuffer image0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, i64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (temp == i64vec4(123)) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 2;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 7l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 3;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 7;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
i64vec4 zzzz = i64vec4(0);
i64vec4 zzzo = i64vec4(0, 0, 0, 1);
i64vec4 expectedIB;
layout(r64i, set = 0, binding = 0) uniform i64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { int64_t val[1024]; } ubo0_1;
void main()
{
  i64vec4 accum = i64vec4(0);
  i64vec4 temp;
  int64_t temp_ql;
  int inboundcoords, clampedLayer;
  i64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 10;
    temp = i64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = i64vec4(0); else temp = i64vec4(1);
    }
    else if (temp == zzzz) temp = i64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = i64vec4(0);
    else temp = i64vec4(1);
    accum += abs(temp);
  }
  i64vec4 color = (accum != i64vec4(0)) ? i64vec4(0,0,0,0) : i64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1DArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 10);
    expectedIB2 += uvec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) volatile uniform u64image2DMSArray u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
  int64_t data[];
} inBuffer;

void main(void)
{
  int gx = int(gl_GlobalInvocationID.x);
  int gy = int(gl_GlobalInvocationID.y);
  int gz = int(gl_GlobalInvocationID.z);
  uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
  imageStore(u_resultImage, ivec3(gx, gy, gz), 0, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec3(gx, gy, gz), 1, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec3(gx, gy, gz), 2, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec3(gx, gy, gz), 3, i64vec4(inBuffer.data[index]));
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DMSArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler3D texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usamplerCube texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyxx;
    accum += abs(temp);
  }
  temp_ql = uint(textureQueryLevels(texture0_1));
  temp = uvec4(temp_ql);
  accum += abs(temp);
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usamplerCubeArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483647).xyzx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyzx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyzx;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 0), ivec3(0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -3).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483644).xyzx;
    accum += abs(temp);
  }
  temp_ql = uint(textureQueryLevels(texture0_1));
  temp = uvec4(temp_ql);
  accum += abs(temp);
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64image1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (r64ui, binding=0) volatile uniform u64image2DMS u_resultImage;

layout(std430, binding = 1) buffer inputBuffer
{
  int64_t data[];
} inBuffer;

void main(void)
{
  int gx = int(gl_GlobalInvocationID.x);
  int gy = int(gl_GlobalInvocationID.y);
  int gz = int(gl_GlobalInvocationID.z);
  uint index = gx + (gy * gl_NumWorkGroups.x) + (gz *gl_NumWorkGroups.x * gl_NumWorkGroups.y);
  imageStore(u_resultImage, ivec2(gx, gy), 0, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec2(gx, gy), 1, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec2(gx, gy), 2, i64vec4(inBuffer.data[index]));
  imageStore(u_resultImage, ivec2(gx, gy), 3, i64vec4(inBuffer.data[index]));
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64image2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = u64vec4(0);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, u64vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, u64vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64image2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, u64vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64image2DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image2DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), u64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = u64vec4(0);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64image2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = u64vec4(0);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, u64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, u64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), u64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), u64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageCubeArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), u64vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 3;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint64_t(123);
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == u64vec4(uint64_t(123), 0, 0, 0)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[68] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l, 131l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 65;
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == u64vec4(uint64_t(123), 0, 0, 0)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint64_t(123);
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == u64vec4(uint64_t(123), 0, 0, 0)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 9;
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == u64vec4(uint64_t(123), 0, 0, 0)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, u64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 9l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, u64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {3l, 5l, 7l, 9l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, u64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[68] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l, 131l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 65;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, u64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 8;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, u64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, u64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, u64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, u64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[32] = {3l, 5l, 7l, 9l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint64_t val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 4;
    temp = u64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint64_t val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 64;
    inboundcoords = 63;
    temp = u64vec4(ubo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 63;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usamplerCube texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usamplerCubeArray texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5), 0.25), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 5;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(5), (c+0.25) / float(5), 0.25 / float(5), 0.25), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    temp -= expectedIB2;
    accum += abs(temp);
    inboundcoords = 6;
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec4(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6), 0.25), ivec3(0, 0, 0), ivec3(0, 0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image1D image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image1D image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, u64vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image1DArray image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64image1DArray image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64image1DArray image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image2D image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image2DMS image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = u64vec4(0);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image2DMS image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = u64vec4(0);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
uvec4 abs(uvec4 x) { return x; }
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {1311768467139281697l, 9468016793l, 14049315081l, 18630610969l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64image2DArray image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[0];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), u64vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), u64vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), u64vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
