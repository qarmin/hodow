#version 310 es
precision highp float;
layout(location = 0) in vec3 vertColor;
layout(location = 0) out vec4 outColor;
void main (void)
{
  const vec3 fragColor = vec3(0.125, 0.375, 0.625);
  outColor = vec4((fragColor + vertColor) * 0.5, 1.0);
}
