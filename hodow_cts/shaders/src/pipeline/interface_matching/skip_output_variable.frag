#version 450
layout(location = 0) in vec4 v0;
layout(location = 2) in vec4 v2;
layout(location = 0) out vec4 fragColor;
void main (void)
{
  fragColor = v0 + v2;
}
