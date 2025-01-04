#version 450
#extension GL_EXT_multiview : enable
#extension GL_EXT_tessellation_shader : require
layout( quads, equal_spacing, ccw ) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = (1 - u) * (1 - v) * gl_in[0].gl_Position +(1 - u) * v * gl_in[1].gl_Position + u * (1 - v) * gl_in[2].gl_Position + u * v * gl_in[3].gl_Position;
    out_color = in_color[0]+ vec4(0.0, gl_ViewIndex * 0.10f, 0.0, 0.0);
}
