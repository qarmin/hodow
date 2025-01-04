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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    temp = texture(texture0_1, vec2((c+0.25) / float(5), 0.25));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, vec2((c+0.25) / float(5), 0.25), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, vec2((c+0.25) / float(5), 0.25), 1.0, 1.0);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = ivec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
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
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
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
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
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
  temp_ql = int(textureQueryLevels(texture0_1));
  temp = ivec4(temp_ql);
  accum += abs(temp);
  vec2 lod = textureQueryLod(texture0_1, gl_FragCoord.xy);
  temp_ql = int(ceil(abs(lod.x) + abs(lod.y)));
  temp = ivec4(temp_ql);
  accum += abs(temp);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler3D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCubeArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
  vec2 lod = textureQueryLod(texture0_1, gl_FragCoord.xyz);
  temp_ql = int(ceil(abs(lod.x) + abs(lod.y)));
  temp = ivec4(temp_ql);
  accum += abs(temp);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, ivec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, ivec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xyz, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 123, 0)) temp = ivec4(0);
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
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = ivec4(ssbo0_1.val[c]);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 16;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec4(123);
    temp = ivec4(ssbo0_1.val[c]);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xyz, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 123, 0)) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    temp = ivec4(ssbo0_1.val[c]);
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
int refData[4] = {3, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec4(123);
    temp = ivec4(ssbo0_1.val[c]);
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
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xy, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 0, 0)) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
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
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec4 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = ivec4(ubo0_1.val[c]);
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
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
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
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
    if (c != 0) temp -= zzzz;
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
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
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMS texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMSArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage3D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xyz, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 123, 0)) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xyz, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 123, 0)) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec4(123);
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 16;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec4(123);
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec4(123);
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xyz, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 123, 0)) temp = ivec4(0);
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
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
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
int refData[4] = {3, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
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
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xy, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 0, 0)) temp = ivec4(0);
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
int refData[64] = {3, 5, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec4 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 0;
    temp = ivec4(ubo0_1.val[c]);
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
int refData[64] = {3, 5, 7, 9, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec4 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 1;
    temp = ivec4(ubo0_1.val[c]);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec4 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 16;
    temp = ivec4(ubo0_1.val[c]);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec4 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 2;
    temp = ivec4(ubo0_1.val[c]);
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
int refData[64] = {3, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec4 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 0;
    temp = ivec4(ubo0_1.val[c]);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler1DArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
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
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec2(0, 0), c); else temp = ivec4(0);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler2DMSArray texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += ivec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = ivec4(0);
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isampler3D texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCube texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform isamplerCube texture0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage1D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xxxx;
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimage1DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2D image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMS image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) uniform iimage2DMSArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(123)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
    else if (temp == zzzz) temp = ivec4(0);
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimageCube image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
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
    else temp = ivec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyxx;
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(rgba32i, set = 0, binding = 1) volatile uniform iimageCubeArray image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = ivec4(ssbo0_1.val[c]);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec4(123);
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = ivec4(123);
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xy, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xy, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[4] = {3, 5, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(expectedIB2.xy, 0, 0)) temp = ivec4(0);
    else if (c == inboundcoords && temp == ivec4(123, 123, 0, 0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) ssbo0_1.val[c] = ivec4(123);
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = ivec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = ivec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { ivec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; ivec4 val[]; } ssbo0_1_pad;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = ivec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else if (temp == ivec4(ivec4(123))) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(0,0,0,123)) temp = ivec4(0);
    else if (temp == ivec4(123,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(0,0,123,0)) temp = ivec4(0);
    else if (temp == ivec4(123,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(0,123,0,0)) temp = ivec4(0);
    else if (temp == ivec4(123,0,0,0)) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
    temp = ivec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = ivec4(ssbo0_1_pad.val.length());
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform iimageBuffer image0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, ivec4(123));
    temp = imageLoad(image0_1, c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = ivec4(0); else temp = ivec4(1);
    }
    else if (temp == zzzz) temp = ivec4(0);
    else temp = ivec4(1);
    accum += abs(temp);
  }
  ivec4 color = (accum != ivec4(0)) ? ivec4(0,0,0,0) : ivec4(1,0,0,1);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { ivec4 val[1024]; } ubo0_1;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 1;
    temp = ivec4(ubo0_1.val[c]);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(location = 0) in ivec4 attr;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(gl_VertexIndex * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 15;
    temp = attr;
    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp -= expectedIB; else temp -= zzzz;
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 0, 0, 0};
ivec4 zzzz = ivec4(0);
ivec4 zzzo = ivec4(0, 0, 0, 1);
ivec4 expectedIB;
layout(rgba32i, set = 0, binding = 0) uniform iimage2D image0_0;
layout(location = 0) in ivec4 attr;
void main()
{
  ivec4 accum = ivec4(0);
  ivec4 temp;
  int temp_ql;
  int inboundcoords, clampedLayer;
  ivec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(gl_VertexIndex * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = attr;
    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp -= expectedIB; else temp -= zzzz;
    accum += abs(temp);
  }
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1D texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    temp = texelFetch(texture0_1, c, 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    expectedIB2 = expectedIB;
    temp = texture(texture0_1, (c+0.25) / float(5));
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureLod(texture0_1, (c+0.25) / float(5), 0.0f);
    if (c >= 0 && c < inboundcoords)
        temp -= expectedIB2;
    else
        temp = uvec4((temp == zzzz || temp == zzzo) ? 0 : 1);
    accum += abs(temp);
    temp = textureGrad(texture0_1, (c+0.25) / float(5), 1.0, 1.0);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DMS texture0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
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
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
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
    int idx = smod(c * 4, 4);
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
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
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
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
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
    int idx = smod(c * 4, 4);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
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
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage2D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage2DMS image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec2(0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DMSArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, uvec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
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
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
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
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
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
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage3D image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimageCube image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimageCubeArray image0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
int refData[4] = {3, 5, 7, 9};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = uvec4(ssbo0_1.val[c]);
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
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.x, 0, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 0, 0, 0)) temp = uvec4(0);
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
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.x, 0, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 0, 0, 0)) temp = uvec4(0);
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
int refData[8] = {3, 5, 7, 9, 11, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.x, 0, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 0, 0, 0)) temp = uvec4(0);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 15;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xyz, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 123, 0)) temp = uvec4(0);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 15;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xyz, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 123, 0)) temp = uvec4(0);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 16;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xyz, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 123, 0)) temp = uvec4(0);
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
int refData[4] = {3, 5, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xy, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 0, 0)) temp = uvec4(0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = uvec4(ssbo0_1.val[c]);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uvec4 val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 2;
    temp = uvec4(ubo0_1.val[c]);
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
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_samplerless_texture_functions : enable
#extension GL_EXT_control_flow_attributes : enable
#extension GL_EXT_shader_image_load_formatted : enable
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[64] = {3, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uvec4 val[1024]; } ubo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 0;
    temp = uvec4(ubo0_1.val[c]);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
layout(local_size_x = 1, local_size_y = 1) in;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
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
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1D texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DMS texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < 4) temp -= expectedIB2; else temp = uvec4(0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DMSArray texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DMSArray texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler3D texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = uvec4(0);
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
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    if (c != 0) temp = texelFetch(texture0_1, ivec3(0, 0, 0), c); else temp = uvec4(0);
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
  temp_ql = uint(textureQueryLevels(texture0_1));
  temp = uvec4(temp_ql);
  accum += abs(temp);
  vec2 lod = textureQueryLod(texture0_1, gl_FragCoord.xyz);
  temp_ql = uint(ceil(abs(lod.x) + abs(lod.y)));
  temp = uvec4(temp_ql);
  accum += abs(temp);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
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
    else if (temp == zzzz) temp = uvec4(0);
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageCube image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimageCube image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 15;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xyz, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 123, 0)) temp = uvec4(0);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 16;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    temp = uvec4(ssbo0_1.val[c]);
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
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xy, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 0, 0)) temp = uvec4(0);
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
int refData[4] = {3, 5, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xy, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 0, 0)) temp = uvec4(0);
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
int refData[4] = {3, 5, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xy, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 0, 0)) temp = uvec4(0);
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = uvec4(ssbo0_1.val.length());
    accum += abs(temp);
    temp = uvec4(ssbo0_1_pad.val.length());
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 17};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
    temp = imageLoad(image0_1, c);
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
int refData[64] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uvec4 val[1024]; } ubo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 2;
    temp = uvec4(ubo0_1.val[c]);
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
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {3, 5, 7, 9};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1D texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler1DArray texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
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
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2DMSArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(c, 0, 0), 0, uvec4(123));
    inboundcoords = 11;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, c, 0), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, ivec3(0, 0, c), 0, uvec4(123));
    inboundcoords = 6;
    if (c < 0 || c >= 4) imageStore(image0_1, ivec3(0, 0, 0), c, uvec4(123));
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageCube image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
#extension GL_EXT_ray_tracing : require
uvec4 abs(uvec4 x) { return x; }
int smod(int a, int b) { if (a < 0) a += b*(abs(a)/b+1); return a%b; }
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
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
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 16;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.x, 0, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 0, 0, 0)) temp = uvec4(0);
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
int refData[68] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 68);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 16;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.x, 0, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 0, 0, 0)) temp = uvec4(0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xy, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 0, 0)) temp = uvec4(0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    temp = uvec4(ssbo0_1.val[c]);
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
int refData[64] = {3, 5, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uvec4 val[1024]; } ubo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 1;
    temp = uvec4(ubo0_1.val[c]);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uvec4 val[1024]; } ubo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = 0; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 15;
    temp = uvec4(ubo0_1.val[c]);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform utextureBuffer texbo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DMS texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
    inboundcoords = 5;
    temp = texelFetch(texture0_1, ivec2(c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = texelFetch(texture0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = texelFetch(texture0_1, ivec2(0, 0), c);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usampler2DArray texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform usamplerCube texture0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage1D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) expectedIB2 += uvec4(c, 0, 0, 0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimage1DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec2(0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz || temp == zzzo) temp = uvec4(0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2DMS image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
int refData[4] = {305419896, 591751049, 878082192, 1164413185};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
int refData[4] = {0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) volatile uniform uimage2DArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage2DMSArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB = zzzz;
    inboundcoords = 0;
    int paddedinboundcoords = 0;
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(c, 0, 0), 0, uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, c, 0), 0, uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, c), 0, uvec4(123));
    if (c < 0 || c >= 0) imageStore(image0_1, ivec3(0, 0, 0), c, uvec4(123));
    temp = imageLoad(image0_1, ivec3(c, 0, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, c, 0), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, c), 0);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
    accum += abs(temp);
    temp = imageSamples(image0_1).xxxx;
    accum += abs(temp);
    temp = imageLoad(image0_1, ivec3(0, 0, 0), c);
    expectedIB2 = expectedIB;
    if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    temp = imageSize(image0_1).xyzx;
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) volatile uniform uimage3D image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 11;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimageCube image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageCubeArray image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[0];
    expectedIB.y = refData[0+1];
    expectedIB.z = refData[0+2];
    expectedIB.w = refData[0+3];
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
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 5;
    temp = imageLoad(image0_1, ivec3(0, c, 0));
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(123)) temp = uvec4(0);
    else temp = uvec4(1);
    accum += abs(temp);
    inboundcoords = 6;
    temp = imageLoad(image0_1, ivec3(0, 0, c));
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = uvec4(ssbo0_1.val[c]);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 15;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xyz, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 123, 0)) temp = uvec4(0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 16;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 16;
    temp = uvec4(ssbo0_1.val[c]);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    temp = uvec4(ssbo0_1.val[c]);
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
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile readonly buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1050; c >= -1050; --c) {
    int idx = smod(c * 4, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.x, 0, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 0, 0, 0)) temp = uvec4(0);
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
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (temp == uvec4(uvec4(123))) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(0,0,0,123)) temp = uvec4(0);
    else if (temp == uvec4(123,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(0,0,123,0)) temp = uvec4(0);
    else if (temp == uvec4(123,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(0,123,0,0)) temp = uvec4(0);
    else if (temp == uvec4(123,0,0,0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xy, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 0, 0)) temp = uvec4(0);
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
int refData[12] = {3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1 { uvec4 val[]; } ssbo0_1;
layout(scalar, set = 0, binding = 1) volatile buffer sbodef0_1_pad { vec4 pad; uvec4 val[]; } ssbo0_1_pad;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 12);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 2;
    if (c < 0 || c >= inboundcoords) ssbo0_1.val[c] = uvec4(123);
    temp = uvec4(ssbo0_1.val[c]);
    expectedIB2 = expectedIB;
    if (c >= 0 && c < inboundcoords) {
       if (temp == expectedIB2) temp = uvec4(0); else temp = uvec4(1);
    }
    else if (temp == zzzz) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(expectedIB2.xy, 0, 0)) temp = uvec4(0);
    else if (c == inboundcoords && temp == uvec4(123, 123, 0, 0)) temp = uvec4(0);
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    if (c < 0 || c >= inboundcoords) imageStore(image0_1, c, uvec4(123));
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(rgba32ui, set = 0, binding = 1) uniform uimageBuffer image0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(c * 4, 4);
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
int refData[64] = {3, 5, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(scalar, set = 0, binding = 1) uniform ubodef0_1 { uvec4 val[1024]; } ubo0_1;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[dont_unroll]] for (int c = 1023; c >= 0; --c) {
    int idx = smod(c * 4, 64);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    int paddedinboundcoords = 16;
    inboundcoords = 0;
    temp = uvec4(ubo0_1.val[c]);
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
int refData[8] = {3, 5, 7, 9, 11, 13, 15, 0};
uvec4 zzzz = uvec4(0);
uvec4 zzzo = uvec4(0, 0, 0, 1);
uvec4 expectedIB;
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(location = 0) in uvec4 attr;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(gl_VertexIndex * 4, 8);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 1;
    temp = attr;
    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp -= expectedIB; else temp -= zzzz;
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
layout(rgba32ui, set = 0, binding = 0) uniform uimage2D image0_0;
layout(location = 0) in uvec4 attr;
void main()
{
  uvec4 accum = uvec4(0);
  uvec4 temp;
  uint temp_ql;
  int inboundcoords, clampedLayer;
  uvec4 expectedIB2;
  [[unroll]] for (int c = -10; c <= 10; ++c) {
    int idx = smod(gl_VertexIndex * 4, 4);
    expectedIB.x = refData[idx];
    expectedIB.y = refData[idx+1];
    expectedIB.z = refData[idx+2];
    expectedIB.w = refData[idx+3];
    inboundcoords = 0;
    temp = attr;
    if (gl_VertexIndex >= 0 && gl_VertexIndex < inboundcoords) temp -= expectedIB; else temp -= zzzz;
    accum += abs(temp);
  }
  uvec4 color = (accum != uvec4(0)) ? uvec4(0,0,0,0) : uvec4(1,0,0,1);
  imageStore(image0_0, ivec2(gl_VertexIndex % 8, gl_VertexIndex / 8), color);
  gl_PointSize = 1.0f;
  gl_Position = vec4(0.0f, 0.0f, 0.0f, 1.0f);
}
