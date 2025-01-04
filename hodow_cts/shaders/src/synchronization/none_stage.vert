#version 450
layout(location = 0) in  vec4 inPosition;
layout(location = 0) out vec2 outUV;
void main(void)
{
  outUV = vec2(inPosition.x * 0.5 + 0.5, inPosition.y * 0.5 + 0.5);
  gl_Position = inPosition;
}
