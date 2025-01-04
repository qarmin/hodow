#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, equal_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    const vec4 p1 = gl_in[0].gl_Position;
    const vec4 p2 = gl_in[1].gl_Position;
    const vec4 p3 = gl_in[2].gl_Position * 0.5 + gl_in[3].gl_Position * 0.5;
    gl_Position = (u * p1) + (v * p2) + (w * p3);
    gl_PointSize = 1.0;
    gl_Layer = 1;
}
