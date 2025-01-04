#version 450

void main()
{
    const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
    const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
    gl_Position = vec4(x, y, 0.0, 1.0);
}
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
#version 450
layout(set=0, binding=0, std430) buffer BufferBlock { uint flag[]; } outBuffer;
layout(local_size_x=1, local_size_y=1, local_size_z=1) in;

void main()
{
  const uint index = gl_GlobalInvocationID.x + gl_GlobalInvocationID.y + gl_GlobalInvocationID.z;
  outBuffer.flag[index] = 2u;
}
