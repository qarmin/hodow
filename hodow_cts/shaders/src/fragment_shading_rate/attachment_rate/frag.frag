#version 450 core
#extension GL_EXT_fragment_shading_rate : enable
layout(set = 0, binding = 0) buffer Block { uint counter; } buf;
layout(location = 0) out uvec4 outColor;
void main()
{
  outColor.x = gl_ShadingRateEXT;
  outColor.y = 0;
  outColor.z = atomicAdd(buf.counter, 1);
  outColor.w = 0;
}
