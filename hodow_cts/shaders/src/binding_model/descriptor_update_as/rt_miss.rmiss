#version 460

#extension GL_EXT_ray_tracing : require
layout(location = 0) rayPayloadInEXT vec3 hitValue;

layout(set = 0, binding = 0) uniform accelerationStructureEXT topLevelAS;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;

void main()
{
  uint  rayFlags = 0;
  uint  cullMask = 0xFF;
  float tmin     = 0.0;
  float tmax     = 9.0;
  vec3  origin   = vec3((float(gl_LaunchIDEXT.x) + 0.5f) / float(gl_LaunchSizeEXT.x), (float(gl_LaunchIDEXT.y) + 0.5f) / float(gl_LaunchSizeEXT.y), 0.0);
  vec3  direct   = vec3(0.0, 0.0, 1.0);

  traceRayEXT(topLevelAS, rayFlags, cullMask, 1, 0, 1, origin, tmin, direct, tmax, 0);
}
