#version 460
#extension GL_EXT_ray_tracing : require
#extension GL_EXT_ray_query : require

layout(location = 0) rayPayloadInEXT vec3 hitValue;
hitAttributeEXT vec3 attribs;

layout(set = 0, binding = 0) uniform accelerationStructureEXT tlas;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;

void main()
{
  ivec3       pos      = ivec3(gl_LaunchIDEXT);
  ivec3       size     = ivec3(gl_LaunchSizeEXT);
  const float mult     = 1048576.0f;
  uint        rayFlags = 0;
  uint        cullMask = 0xFF;
  float       tmin     = 0.0;
  float       tmax     = 9.0;
  vec3        origin   = vec3((float(pos.x) + 0.5f) / float(size.x), (float(pos.y) + 0.5f) / float(size.y), 0.0);
  vec3        direct   = vec3(0.0, 0.0, 1.0);
  int         value    = 0;
  rayQueryEXT rayQuery;

  rayQueryInitializeEXT(rayQuery, tlas, rayFlags, cullMask, origin, tmin, direct, tmax);

  while(rayQueryProceedEXT(rayQuery))
  {
    if (rayQueryGetIntersectionTypeEXT(rayQuery, false) == gl_RayQueryCandidateIntersectionTriangleEXT)
    {
      const float t = rayQueryGetIntersectionTEXT(rayQuery, false);
      value = int(round(mult * t));
    }
  }

  imageStore(result, pos, ivec4(value, 0, 0, 0));
}
