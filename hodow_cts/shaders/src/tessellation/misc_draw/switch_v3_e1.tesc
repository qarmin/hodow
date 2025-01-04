#version 460
layout (vertices=3) out;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];
void main() {
    const float extraLevel = 1.0;
    gl_TessLevelInner[0] = 10.0 + extraLevel;
    gl_TessLevelInner[1] = 10.0 + extraLevel;
    gl_TessLevelOuter[0] = 50.0 + extraLevel;
    gl_TessLevelOuter[1] = 40.0 + extraLevel;
    gl_TessLevelOuter[2] = 30.0 + extraLevel;
    gl_TessLevelOuter[3] = 20.0 + extraLevel;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
