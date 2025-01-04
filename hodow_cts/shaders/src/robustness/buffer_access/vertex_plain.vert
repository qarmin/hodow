#version 440
precision highp float;
layout(location = 0) in vec4 position;

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = position;
}
