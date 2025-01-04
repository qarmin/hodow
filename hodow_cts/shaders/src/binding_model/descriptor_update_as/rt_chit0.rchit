#version 460

#extension GL_EXT_ray_tracing : require

hitAttributeEXT vec3 attribs;
layout(location = 0) rayPayloadInEXT vec3 hitValue;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;

void main()
{
  ivec3       pos      = ivec3(gl_LaunchIDEXT);
  ivec3       size     = ivec3(gl_LaunchSizeEXT);
  const float mult     = 1048576.0f;
  int         value    = int(round(mult * gl_HitTEXT));

  imageStore(result, pos, ivec4(value, 0, 0, 0));
}
