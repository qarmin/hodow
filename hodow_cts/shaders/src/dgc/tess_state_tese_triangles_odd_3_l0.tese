#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(triangles, fractional_odd_spacing, point_mode) in;
void main()
{
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    const float w = gl_TessCoord.z;
    gl_Position = (u * gl_in[0].gl_Position) + (v * gl_in[1].gl_Position) + (w * gl_in[2].gl_Position);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
