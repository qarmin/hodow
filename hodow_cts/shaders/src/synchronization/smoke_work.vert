#version 310 es
precision mediump float;
layout (location = 0) in vec4 vertexPosition;
void main()
{
    gl_Position = vertexPosition;
}
