#version 310 es
layout(location = 0) in vec4 position;
layout(location = 0) out vec3 vertColor;
void main (void)
{
  gl_Position = position;
  vertColor = vec3(0.5, 0.25, 0.75);
}
#version 310 es
precision highp float;
layout(location = 0) in vec3 vertColor;
layout(location = 0) out vec4 outColor;
void main (void)
{
  const vec3 fragColor = vec3(0.125, 0.375, 0.625);
  outColor = vec4((fragColor + vertColor) * 0.5, 1.0);
}
#version 450
precision highp float;
layout (local_size_x = 64, local_size_y = 1, local_size_z = 1) in;
layout (std140, binding = 0) buffer buf { vec3 data[]; };
void main (void)
{
  data[gl_GlobalInvocationID.x] = vec3(0.5, 0.25, 0.75);
}
