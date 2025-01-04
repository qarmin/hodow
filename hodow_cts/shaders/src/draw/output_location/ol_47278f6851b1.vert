#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in vec4 color_in0;
layout(location = 2) in vec4 color_in1;
layout(location = 0) out vec4 color_out0;
layout(location = 1) out vec4 color_out1;

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    color_out0 = color_in0;
    color_out1 = color_in1;
}
