#version 450
layout(isolines, point_mode) in;
void main()
{
    gl_Position = gl_in[0].gl_Position;
}
