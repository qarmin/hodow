#version 460
#extension GL_EXT_shader_8bit_storage : require
layout(local_size_x = 1) in;
layout(binding = 0, std430) buffer InOutBuf { uint8_t v[]; } inOutBuf;
void main()
{
  uint index = gl_WorkGroupID.x * 2;
  if (int(inOutBuf.v[index]) == 91)
    inOutBuf.v[index] = uint8_t(202);
}
#version 460
#extension GL_EXT_shader_16bit_storage : require
layout(local_size_x = 1) in;
layout(binding = 0, std430) buffer InOutBuf { uint16_t v[]; } inOutBuf;
void main()
{
  uint index = gl_WorkGroupID.x * 2;
  if (int(inOutBuf.v[index]) == 23387)
    inOutBuf.v[index] = uint16_t(51914);
}
#version 460
layout(local_size_x = 1) in;
layout(binding = 0, std430) buffer InOutBuf { uint v[]; } inOutBuf;
void main()
{
  uint index = gl_WorkGroupID.x * 2;
  if (int(inOutBuf.v[index]) == 1532713819u)
    inOutBuf.v[index] = 3402287818u;
}
