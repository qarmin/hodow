#version 450
#extension GL_EXT_long_vector : enable
layout (triangles) in;
layout(push_constant) uniform Material
{
    layout(offset = 56) vec2 color;
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main()
{
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
    vtxColor = gl_TessCoord.x * color[0] + gl_TessCoord.y * color[1] + gl_TessCoord.z * color[2];
    vtxColor.xy += matInst.color;
}
