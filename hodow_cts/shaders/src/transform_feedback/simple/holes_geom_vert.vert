#version 460
layout (location = 0) in vec4 inPos;



void main ()
{
    gl_Position  = inPos;
    gl_PointSize = 1.0;

}
