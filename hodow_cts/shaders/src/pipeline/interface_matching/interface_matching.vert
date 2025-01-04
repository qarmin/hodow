#version 450
layout(location = 0) in vec4 inPosition;
${vert_declarations}void main(void)
{
  gl_Position = inPosition;
${vert_operations}}
