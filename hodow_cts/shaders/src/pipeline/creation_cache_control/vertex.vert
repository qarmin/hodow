#version 310 es
layout(location = 0) in vec4 position;
layout(location = 0) out vec3 vertColor;
void main (void)
{
  gl_Position = position;
  vertColor = vec3(0.5, 0.25, 0.75);
}
