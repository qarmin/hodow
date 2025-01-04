#version 460
#extension GL_EXT_tessellation_shader : require
layout(vertices=3) out;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
layout (location=0) in flat int instanceIdxIn[];
layout (location=0) out flat int instanceIdxOut[];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    instanceIdxOut[gl_InvocationID] = instanceIdxIn[gl_InvocationID];
    gl_TessLevelOuter[0] = 1.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 1.0;
    gl_TessLevelOuter[3] = 1.0;
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 1.0;
}
