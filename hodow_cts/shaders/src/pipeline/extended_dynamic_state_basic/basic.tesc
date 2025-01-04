#version 450
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
void main() {
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_TessLevelOuter[0] = 3.0;
  gl_TessLevelOuter[1] = 3.0;
  gl_TessLevelOuter[2] = 3.0;
  gl_TessLevelInner[0] = 3.0;
}
