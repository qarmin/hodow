#version 310 es
#extension GL_EXT_tessellation_shader : require
layout(triangles) in;
layout(location = 0) in highp vec4 tes_color[];
layout(location = 0) out mediump vec4 frag_color;
void main (void)
{
    frag_color = tes_color[0];
    gl_Position = gl_TessCoord.x * gl_in[0].gl_Position + gl_TessCoord.y * gl_in[1].gl_Position + gl_TessCoord.z * gl_in[2].gl_Position;
}
