#version 450
#extension GL_EXT_tessellation_shader : require
layout(isolines, equal_spacing) in;
layout(point_mode) in;
layout(location = 0) in vec4 in_color[];
layout(location = 0) out vec4 out_color;
void main (void)
{
    const float u = gl_TessCoord.x; // Position along the line
    const float v = gl_TessCoord.y; // Which line
    gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, u);
    gl_PointSize = 1.0;
    out_color = in_color[0];
}
