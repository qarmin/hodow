#version 450
layout(set=0, binding=0, std430) readonly buffer Input
{
  uint v[];
} inBuffer;
layout(location = 0) out vec4 outColor;
void main()
{
  uint index = uint(gl_FragCoord.y) * 1024 + uint(gl_FragCoord.x);
  outColor = unpackUnorm4x8(inBuffer.v[index]);
}
