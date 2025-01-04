#version 430
layout(location = 0) in vec2 position_in;
layout(location = 1) in uvec2 color_in[3];
layout(location = 0) flat out uvec2 color_out[3];

void main()
{
    gl_Position = vec4(position_in, 0, 1);
    for (int i = 0; i < 3; i++)
        color_out[i] = color_in[i];
}
