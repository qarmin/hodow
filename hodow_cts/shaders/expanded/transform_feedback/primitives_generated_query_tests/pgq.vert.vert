#version 450
layout(location=0) in vec2 inPosition;
void main (void)
{
     gl_Position = vec4(inPosition, 0, 1);
}
