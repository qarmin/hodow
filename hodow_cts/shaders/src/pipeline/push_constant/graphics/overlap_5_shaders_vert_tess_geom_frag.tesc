#version 450
#extension GL_EXT_long_vector : enable
layout (vertices = 3) out;
layout(push_constant) uniform Material
{
    layout(offset = 32) vec3 color;
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor[];
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
} gl_out[];
void main()
{
    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 2.0;
    gl_TessLevelOuter[2] = 2.0;
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
    vec4 outColor = color[gl_InvocationID];
    outColor.xyz += matInst.color;
    vtxColor[gl_InvocationID] = outColor;
}
