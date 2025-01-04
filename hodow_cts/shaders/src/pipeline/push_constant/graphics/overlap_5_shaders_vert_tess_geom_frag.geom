#version 450
#extension GL_EXT_long_vector : enable
layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;
layout(push_constant) uniform Material
{
    layout(offset = 28) int unused1;
    layout(offset = 32) vec4 unused2;
    layout(offset = 48) vec4 color;
} matInst;
layout(location = 0) in highp vec4 color[];
layout(location = 0) out highp vec4 vtxColor;
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[];
out gl_PerVertex
{
    vec4 gl_Position;
};
void main()
{
    for(int i = 0; i < 3; i++)
    {
        gl_Position.xyz = gl_in[i].gl_Position.xyz/2.0;
        gl_Position.w = gl_in[i].gl_Position.w;
        vtxColor = color[i];
        vtxColor += matInst.color;
        EmitVertex();
    }
    EndPrimitive();
}
