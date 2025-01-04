#version 460
#extension GL_ARB_shader_viewport_layer_array : enable
layout(quads, fractional_even_spacing, point_mode) in;
void main()
{
    const float xCoord = gl_TessCoord.x;
    const float yCoord = (1.0 - xCoord) * gl_TessCoord.y;
    const float width  = gl_in[2].gl_Position.x - gl_in[0].gl_Position.x;
    const float height = gl_in[1].gl_Position.y - gl_in[0].gl_Position.y;
    const float xPos   = gl_in[0].gl_Position.x + width * xCoord;
    const float yPos   = gl_in[0].gl_Position.y + height * yCoord;
    gl_Position = vec4(xPos, yPos, 0.0, 1.0);
    gl_PointSize = 1.0;
    gl_Layer = 0;
}
