#version 450
layout(set=0, binding=0, std430) buffer BufferBlock { uint flag[]; } outBuffer;
layout(location=0) out vec4 outColor;

void main()
{
  const uint xCoord = uint(trunc(gl_FragCoord.x));
  const uint yCoord = uint(trunc(gl_FragCoord.y));
  outBuffer.flag[xCoord + yCoord] = 1u;
  outColor = vec4(0.0, 1.0, 0.0, 1.0);
}
