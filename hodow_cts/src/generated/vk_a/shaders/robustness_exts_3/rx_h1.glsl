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
u64vec4 abs(u64vec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64image2DMSArray image0_1;
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
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
layout(r64ui, set = 0, binding = 1) uniform u64image3D image0_1;
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
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
layout(r64ui, set = 0, binding = 1) uniform u64image3D image0_1;
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
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
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
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
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
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
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
layout(r64ui, set = 0, binding = 1) uniform u64imageCubeArray image0_1;
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
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
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
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageCubeArray image0_1;
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
    else if (temp == zzzo) temp = u64vec4(0);
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
    else if (temp == zzzo) temp = u64vec4(0);
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
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[4] = {3l, 5l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    inboundcoords = 2;
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
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
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
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    expectedIB.w = 0;
    inboundcoords = 9;
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    inboundcoords = 10;
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
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    inboundcoords = 10;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint64_t(123);
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    if (c < 0 || c >= 0) ssbo0_1.val[c] = uint64_t(123);
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == u64vec4(uint64_t(123), 0, 0, 0)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = u64vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = u64vec4(ssbo0_1_pad.val.length());
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
int64_t refData[4] = {3l, 5l, 7l, 9l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64imageBuffer image0_1;
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
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
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
    inboundcoords = 5;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64imageBuffer image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64imageBuffer image0_1;
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
    expectedIB.w = 1;
    inboundcoords = 9;
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
int64_t refData[96] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l, 131l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint64_t val[1024]; } ubo0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 96);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 96;
    inboundcoords = 65;
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
int64_t refData[32] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint64_t val[1024]; } ubo0_1;
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
    inboundcoords = 8;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint64_t val[1024]; } ubo0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 1, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
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
int64_t refData[4] = {3l, 5l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
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
int64_t refData[4] = {3l, 5l, 7l, 9l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
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
int64_t refData[4] = {0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
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
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
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
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1D texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = uvec4(0);
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
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2D texture0_1;
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
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = uvec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
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
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DArray texture0_1;
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
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
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
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
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
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 5);
    expectedIB2 += uvec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
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
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_shader_image_int64 : require
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[8] = {-2023406815, 305419896, 878082201, 2, 1164413193, 3, 1450741785, 4};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler3D texture0_1;
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
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image1DArray image0_1;
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
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), u64vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
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
    temp = imageLoad(image0_1, ivec2(0, c));
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
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
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
#extension GL_EXT_ray_tracing : require
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64image2DMS image0_1;
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
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64image2DMSArray image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64image3D image0_1;
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
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64image3D image0_1;
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
    else if (temp == u64vec4(123)) temp = u64vec4(0);
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
    else if (temp == u64vec4(123)) temp = u64vec4(0);
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
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageCube image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64imageCubeArray image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), u64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
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
    temp = imageLoad(image0_1, ivec3(0, c, 0));
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
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[4] = {3l, 5l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    inboundcoords = 2;
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
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    inboundcoords = 5;
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    expectedIB.w = 0;
    inboundcoords = 64;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint64_t(123);
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 64;
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 7;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint64_t(123);
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[4] = {3l, 5l, 7l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
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
    inboundcoords = 3;
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
int64_t refData[4] = {3l, 5l, 7l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 3;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64imageBuffer image0_1;
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
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
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
    inboundcoords = 5;
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
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64imageBuffer image0_1;
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
    inboundcoords = 64;
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
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
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
    inboundcoords = 1;
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
int64_t refData[32] = {3l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uint64_t val[1024]; } ubo0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 1, 32);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
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
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
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
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1D texture0_1;
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
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = uvec4(0);
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
  temp_ql = uint(textureQueryLevels(texture0_1));
  temp = uvec4(temp_ql);
  accum += abs(temp);
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
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rg32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1DArray texture0_1;
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
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
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
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
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
layout(set = 0, binding = 1) uniform usampler2DMSArray texture0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64image1D image0_1;
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
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image1D image0_1;
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
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64image2D image0_1;
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
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64image2DMS image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64image2DMS image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image2DMS image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64image2DArray image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64image2DArray image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64image2DMSArray image0_1;
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
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += u64vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = u64vec4(0);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64imageCube image0_1;
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
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64imageCube image0_1;
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
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
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
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageCube image0_1;
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
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) volatile uniform u64imageCube image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), u64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
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
    temp = imageLoad(image0_1, ivec3(0, c, 0));
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
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64imageCubeArray image0_1;
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
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
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
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzo) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageCubeArray image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64imageCubeArray image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), u64vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), u64vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == u64vec4(123)) temp = u64vec4(0);
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
    else if (temp == u64vec4(123)) temp = u64vec4(0);
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
    else if (temp == u64vec4(123)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 63;
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    expectedIB.w = 0;
    inboundcoords = 9;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uint64_t(123);
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 0l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    inboundcoords = 10;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else if (temp == u64vec4(uint64_t(123), 0, 0, 0)) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = u64vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = u64vec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uint64_t val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uint64_t val[]; } ssbo0_1_pad;
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
    if (c < 0 || c >= 0) ssbo0_1.val[c] = uint64_t(123);
    temp = u64vec4(ssbo0_1.val[c], 0, 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
    temp = u64vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = u64vec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[4] = {3l, 5l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform u64imageBuffer image0_1;
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
int64_t refData[4] = {3l, 5l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
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
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(r64ui, set = 0, binding = 1) uniform u64imageBuffer image0_1;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 63;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
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
int64_t refData[12] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 0l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) volatile uniform u64imageBuffer image0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
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
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
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
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = u64vec4(0); else temp = u64vec4(1);
    }
    else if (temp == zzzz) temp = u64vec4(0);
    else temp = u64vec4(1);
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[64] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 17l, 19l, 21l, 23l, 25l, 27l, 29l, 31l, 33l, 35l, 37l, 39l, 41l, 43l, 45l, 47l, 49l, 51l, 53l, 55l, 57l, 59l, 61l, 63l, 65l, 67l, 69l, 71l, 73l, 75l, 77l, 79l, 81l, 83l, 85l, 87l, 89l, 91l, 93l, 95l, 97l, 99l, 101l, 103l, 105l, 107l, 109l, 111l, 113l, 115l, 117l, 119l, 121l, 123l, 125l, 127l, 129l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(location = 0) in uint64_t attr;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(gl_VertexIndex * 1, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 64;
    temp.x = attr;
    temp.y = 0l;
    temp.z = 0l;
    temp.w = 0l;
    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp.x -= expectedIB.x; else temp -= zzzz;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
int64_t refData[8] = {3l, 5l, 7l, 9l, 11l, 13l, 15l, 0l};
u64vec4 zzzz = u64vec4(0);
u64vec4 zzzo = u64vec4(0, 0, 0, 1);
u64vec4 expectedIB;
layout(r64ui, set = 0, binding = 0) uniform u64image2D image0_0;
layout(location = 0) in uint64_t attr;
void main()
{
  u64vec4 accum = u64vec4(0);
  u64vec4 temp;
  uint64_t temp_ql;
  int inboundcoords, clampedLayer;
  u64vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(gl_VertexIndex * 1, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = 0;
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 7;
    temp.x = attr;
    temp.y = 0l;
    temp.z = 0l;
    temp.w = 0l;
    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp.x -= expectedIB.x; else temp -= zzzz;
    accum += abs(temp);
  }
  u64vec4 color = (accum != u64vec4(0)) ? u64vec4(0,0,0,0) : u64vec4(1,0,0,1);
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
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler1DArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
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
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
  }
  temp_ql = float(textureQueryLevels(texture0_1));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 5);
    expectedIB2 += vec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform samplerCubeArray texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
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
  temp_ql = float(textureQueryLevels(texture0_1));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image1D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image2D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image2DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform imageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform imageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform imageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageCubeArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(expectedIB2.x, 0, 0, 0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(123, 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(expectedIB2.x, 0, 0, 0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(123, 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[68] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43, 1.8357e-43, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 32;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(expectedIB2.x, 0, 0, 0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(123, 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 3;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(expectedIB2.x, 0, 0, 0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(123, 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { vec2 val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 2;
    temp = vec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[64] = {4.2039e-45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { vec2 val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 0;
    temp = vec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { vec2 val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = vec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 32;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler1D texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, 0, c); else temp = vec4(0);
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
  temp_ql = float(textureQueryLevels(texture0_1));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec2 lod = textureQueryLod(texture0_1, gl_FragCoord.x);
  temp_ql = float(ceil(abs(lod.x) + abs(lod.y)));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler1DArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 10);
    expectedIB2 += vec4(clampedLayer, 0, 0, 0);
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
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DMS texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyxx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DMSArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DMSArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
    temp = textureSize(texture0_1).xyzx;
    accum += abs(temp);
    temp = textureSamples(texture0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler3D texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = vec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image1D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image1D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2DMS image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image2DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image3D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform image3D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform image3D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image3D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageCubeArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 32;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {4.2039e-45, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 0;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(expectedIB2.x, 0, 0, 0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(123, 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {4.2039e-45, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 0;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(expectedIB2.x, 0, 0, 0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(123, 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 32;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { vec2 val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 4;
    temp = vec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_FragCoord.x, gl_FragCoord.y), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler1DArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
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
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = vec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25)), 1.0, 1.0);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -1).xyxx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483646).xyxx;
    accum += abs(temp);
  }
  temp_ql = float(textureQueryLevels(texture0_1));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform samplerCube texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
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
  temp_ql = float(textureQueryLevels(texture0_1));
  temp = vec4(temp_ql);
  accum += abs(temp);
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform image1D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image1DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image2DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image2DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image2DMSArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image3D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(expectedIB2.x, 0, 0, 0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(123, 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(expectedIB2.x, 0, 0, 0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(123, 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[64] = {4.2039e-45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { vec2 val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 0;
    temp = vec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform sampler2DMSArray texture0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image1D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform image2D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), vec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), vec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform image2DMS image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = vec4(0);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) uniform image2DArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += vec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform image3D image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageCube image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {123, 234, 345, 456};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) volatile uniform imageCubeArray image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), vec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), vec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), vec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 32;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 3;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(expectedIB2.x, 0, 0, 0)) temp = vec4(0);
    else if (c == inboundcoords && temp == vec4(123, 0, 0, 0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (temp == vec4(vec2(123), 0, 0)) temp = vec4(0);
    else if (temp == vec4(0,123,0,0)) temp = vec4(0);
    else if (temp == vec4(123,0,0,0)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[12] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = vec2(123);
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { vec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; vec2 val[]; } ssbo0_1_pad;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = vec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
    temp = vec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = vec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(rg32f, set = 0, binding = 1) volatile uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 32;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[4] = {4.2039e-45, 7.00649e-45, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform imageBuffer image0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, vec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else if (temp == vec4(123)) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { vec2 val[1024]; } ubo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 1;
    temp = vec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzz) temp = vec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[64] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44, 2.66247e-44, 2.94273e-44, 3.22299e-44, 3.50325e-44, 3.78351e-44, 4.06377e-44, 4.34403e-44, 4.62428e-44, 4.90454e-44, 5.1848e-44, 5.46506e-44, 5.74532e-44, 6.02558e-44, 6.30584e-44, 6.5861e-44, 6.86636e-44, 7.14662e-44, 7.42688e-44, 7.70714e-44, 7.9874e-44, 8.26766e-44, 8.54792e-44, 8.82818e-44, 9.10844e-44, 9.3887e-44, 9.66896e-44, 9.94922e-44, 1.02295e-43, 1.05097e-43, 1.079e-43, 1.10703e-43, 1.13505e-43, 1.16308e-43, 1.1911e-43, 1.21913e-43, 1.24716e-43, 1.27518e-43, 1.30321e-43, 1.33123e-43, 1.35926e-43, 1.38729e-43, 1.41531e-43, 1.44334e-43, 1.47136e-43, 1.49939e-43, 1.52742e-43, 1.55544e-43, 1.58347e-43, 1.61149e-43, 1.63952e-43, 1.66755e-43, 1.69557e-43, 1.7236e-43, 1.75162e-43, 1.77965e-43, 1.80768e-43};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(set = 0, binding = 1) uniform textureBuffer texbo0_1;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 32;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = vec4(0); else temp = vec4(1);
    }
    else if (temp == zzzo) temp = vec4(0);
    else temp = vec4(1);
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
float refData[8] = {4.2039e-45, 7.00649e-45, 9.80909e-45, 1.26117e-44, 1.54143e-44, 1.82169e-44, 2.10195e-44, 2.38221e-44};
vec4 zzzz = vec4(0);
vec4 zzzo = vec4(0, 0, 0, 1);
vec4 expectedIB;
layout(rg32f, set = 0, binding = 0) uniform image2D image0_0;
layout(location = 0) in vec4 attr;
void main()
{
  vec4 accum = vec4(0);
  vec4 temp;
  float temp_ql;
  int inboundcoords, clampedLayer;
  vec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(gl_VertexIndex * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 4;
    temp = attr;
    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp -= expectedIB; else temp -= zzzo;
    accum += abs(temp);
  }
  vec4 color = (accum != vec4(0)) ? vec4(0,0,0,0) : vec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DArray texture0_1;
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
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
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
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
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
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 5);
    expectedIB2 += ivec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler3D texture0_1;
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
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
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
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
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
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzz;
    accum += abs(temp);
    temp = textureSize(texture0_1, 0).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, -2).xyzx;
    accum += abs(temp);
    temp = textureSize(texture0_1, 2147483645).xyzx;
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
  imageStore(image0_0, ivec2(gl_GlobalInvocationID.xy), color);
}
#version 460 core
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1D image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage1D image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) volatile uniform iimage1D image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage1DArray image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage1DArray image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2D image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMS image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage2DMS image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DArray image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMSArray image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage3D image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
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
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[4] = {3, 5, 7, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
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
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec2(123);
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.x, 0, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
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
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.x, 0, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 32;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 32;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec2(123);
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.x, 0, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
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
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec2(123);
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[4] = {3, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
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
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 0;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec2(123);
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.x, 0, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[4] = {3, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
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
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 0;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec2(123);
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.x, 0, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
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
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
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
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = ivec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = ivec4(ssbo0_1_pad.val.length());
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimageBuffer image0_1;
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
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageBuffer image0_1;
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
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[64] = {3, 5, 7, 9, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec2 val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 2;
    temp = ivec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec2 val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = ivec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform itextureBuffer texbo0_1;
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
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMS texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
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
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMS texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
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
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMS texture0_1;
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
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage2DArray image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimageCube image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) volatile uniform iimageCube image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[4] = {3, 5, 7, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec2(123);
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.x, 0, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.x, 0, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec2(123);
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.x, 0, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 5;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec2(123);
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) volatile uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) volatile uniform iimageBuffer image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[64] = {3, 5, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec2 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 2;
    temp = ivec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec2 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 32;
    temp = ivec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[64] = {3, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec2 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    int paddedinboundcoords = 32;
    inboundcoords = 1;
    temp = ivec4(ubo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c >= 0 && c < paddedinboundcoords && temp == expectedIB2) temp = ivec4(0);
    else temp = ivec4(1);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform itextureBuffer texbo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 2;
    temp = texelFetch(texbo0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
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
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 10);
    expectedIB2 += ivec4(clampedLayer, 0, 0, 0);
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
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
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
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25 / float(5)), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2(0.25 / float(11), (c+0.25) / float(11)), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMS texture0_1;
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
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
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25), ivec2(1.0, 0), ivec2(1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
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
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25), ivec2(0, 1.0), ivec2(0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp -= zzzo;
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
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzo;
    accum += abs(temp);
    expectedIB2 = expectedIB;
    clampedLayer = clamp(c, 0, 5);
    expectedIB2 += ivec4(clampedLayer, 0, 0, 0);
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)));
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), 0.0f);
    temp -= expectedIB2;
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25)), ivec2(0, 0), ivec2(0, 0));
    temp -= expectedIB2;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler3D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
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
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3((c+0.25) / float(5), 0.25 / float(5), 0.25 / float(5)), ivec3(1.0, 0, 0), ivec3(1.0, 0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
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
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(11), (c+0.25) / float(11), 0.25 / float(11)), ivec3(0, 1.0, 0), ivec3(0, 1.0, 0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec3(0.25 / float(6), 0.25 / float(6), (c+0.25) / float(6)), ivec3(0, 0, 1.0), ivec3(0, 0, 1.0));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
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
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(c, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, c), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec2(0, 0), c, ivec4(123));
    temp = imageLoad(image0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = ivec4(0);
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rg32i, set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), ivec4(123));
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), ivec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 1;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.x, 0, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 0, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 2;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec2 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec2 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 2, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 0;
    inboundcoords = 4;
    temp = ivec4(ssbo0_1.val[c], 0, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec2(123), 0, 0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rg32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 2, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = 0;
    expectedIB.w = 1;
    inboundcoords = 32;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzo) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_LaunchIDEXT.xy), color);
}
