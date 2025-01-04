#version 460
#extension GL_EXT_ray_query : require
#extension GL_EXT_ray_tracing : require

layout(set = 0, binding = 0) uniform accelerationStructureEXT tlas;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;

void testFunc(ivec3 pos, ivec3 size)
{
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

void main(void)
{
  const int   posId    = int(gl_VertexIndex / 3);
  const int   vertId   = int(gl_VertexIndex % 3);
  const ivec3 size     = ivec3(16, 16, 1);
  const ivec3 pos      = ivec3(posId % size.x, posId / size.x, 0);

  if (vertId == 0)
  {
    testFunc(pos, size);
  }
}
#version 460

void main(void)
{
}
#version 460

layout(location = 0) in vec4 in_position;
out gl_PerVertex
{
  vec4 gl_Position;
};

void main(void)
{
  gl_Position = in_position;
}
#version 460
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_ray_query : require

layout(set = 0, binding = 0) uniform accelerationStructureEXT tlas;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;

in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[];
layout(vertices = 3) out;
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];

void testFunc(ivec3 pos, ivec3 size)
{
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

void main(void)
{

  if (gl_InvocationID == 0)
  {
    const ivec3 size = ivec3(16, 16, 1);
    int index = int(gl_in[gl_InvocationID].gl_Position.z);
    int x = index % size.x;
    int y = index / size.y;
    const ivec3 pos = ivec3(x, y, 0);
    testFunc(pos, size);
  }

  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_TessLevelInner[0] = 1;
  gl_TessLevelInner[1] = 1;
  gl_TessLevelOuter[gl_InvocationID] = 1;
}
#version 460
#extension GL_EXT_tessellation_shader : require
layout(triangles, equal_spacing, ccw) in;

in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[];

void main(void)
{
  gl_Position = gl_in[0].gl_Position;
}
#version 460
#extension GL_EXT_tessellation_shader : require

in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[];
layout(vertices = 3) out;
out gl_PerVertex
{
  vec4 gl_Position;
} gl_out[];

void main(void)
{
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_TessLevelInner[0] = 1;
  gl_TessLevelInner[1] = 1;
  gl_TessLevelOuter[gl_InvocationID] = 1;
}
#version 460
#extension GL_EXT_tessellation_shader : require
#extension GL_EXT_ray_query : require

layout(set = 0, binding = 0) uniform accelerationStructureEXT tlas;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;

layout(triangles, equal_spacing, ccw) in;
in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[];

void testFunc(ivec3 pos, ivec3 size)
{
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

void main(void)
{
    const ivec3 size = ivec3(16, 16, 1);
    int index = int(gl_in[0].gl_Position.z);
    int x = index % size.x;
    int y = index / size.y;
    const ivec3 pos = ivec3(x, y, 0);
    testFunc(pos, size);
    gl_Position = gl_in[0].gl_Position;
}
#version 460

layout(location = 0) in vec4 in_position;

void main(void)
{
  gl_Position = in_position;
}
#version 460
#extension GL_EXT_ray_query : require

layout(triangles) in;
layout(points, max_vertices = 1) out;

layout(set = 0, binding = 0) uniform accelerationStructureEXT tlas;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;

void testFunc(ivec3 pos, ivec3 size)
{
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

void main(void)
{
  const int   posId    = int(gl_PrimitiveIDIn);
  const ivec3 size     = ivec3(16, 16, 1);
  const ivec3 pos      = ivec3(posId % size.x, posId / size.x, 0);

  testFunc(pos, size);
  gl_PointSize = 1.0;
}
#version 460
#extension GL_EXT_ray_query : require

layout(set = 0, binding = 0) uniform accelerationStructureEXT tlas;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;

void testFunc(ivec3 pos, ivec3 size)
{
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

void main(void)
{
  const ivec3 size     = ivec3(16, 16, 1);
  const ivec3 pos      = ivec3(int(gl_FragCoord.x - 0.5f), int(gl_FragCoord.y - 0.5f), 0);

  testFunc(pos, size);
}
#version 460
#extension GL_EXT_ray_query : require

layout(set = 0, binding = 0) uniform accelerationStructureEXT tlas;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;

void main()
{
  ivec3       pos      = ivec3(gl_WorkGroupID);
  ivec3       size     = ivec3(gl_NumWorkGroups);
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
#version 460
#extension GL_EXT_ray_tracing : require
#extension GL_EXT_ray_query : require

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
#version 460

#extension GL_EXT_ray_tracing : require

layout(location = 0) rayPayloadEXT vec3 hitValue;
layout(set = 2, binding = 0) uniform accelerationStructureEXT topLevelAS;

void main()
{
  uint  rayFlags = 0;
  uint  cullMask = 0xFF;
  float tmin     = 0.0;
  float tmax     = 9.0;
  vec3  origin   = vec3((float(gl_LaunchIDEXT.x) + 0.5f) / float(gl_LaunchSizeEXT.x), (float(gl_LaunchIDEXT.y) + 0.5f) / float(gl_LaunchSizeEXT.y), 0.0);
  vec3  direct   = vec3(0.0, 0.0, -1.0);
  traceRayEXT(topLevelAS, rayFlags, cullMask, 0, 0, 0, origin, tmin, direct, tmax, 0);
}
#version 460
#extension GL_EXT_ray_tracing : require
#extension GL_EXT_ray_query : require

hitAttributeEXT vec3 attribs;
layout(location = 0) rayPayloadInEXT vec3 hitValue;

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
#version 460
#extension GL_EXT_ray_tracing : require
hitAttributeEXT vec3 attribs;
layout(location = 0) rayPayloadInEXT vec3 hitValue;

void main()
{
}
#version 460
#extension GL_EXT_ray_tracing : require

layout(location = 0) rayPayloadInEXT vec3 hitValue;

void main()
{
}
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
#version 460
#extension GL_EXT_ray_tracing : require
#extension GL_EXT_ray_query : require
hitAttributeEXT vec3 hitAttribute;

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
  hitAttribute = vec3(0.0f, 0.0f, 0.0f);
  reportIntersectionEXT(1.0f, 0);
}
#version 460
#extension GL_EXT_ray_tracing : require
#extension GL_EXT_ray_query : require
layout(location = 0) rayPayloadInEXT vec3 hitValue;

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
#version 460

#extension GL_EXT_ray_tracing : require
#extension GL_EXT_ray_query : require

layout(location = 0) callableDataEXT float dummy;layout(set = 2, binding = 0) uniform accelerationStructureEXT topLevelAS;

void main()
{
  executeCallableEXT(0, 0);
}
#version 460

#extension GL_EXT_ray_tracing : require
#extension GL_EXT_ray_query : require
layout(location = 0) callableDataInEXT float dummy;

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
#version 460

#extension GL_EXT_ray_tracing : require

layout(location = 0) rayPayloadEXT vec3 hitValue;
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
#version 460

#extension GL_EXT_ray_tracing : require

layout(location = 0) rayPayloadEXT vec3 hitValue;
layout(set = 1, binding = 0, r32i) uniform iimage3D result;
layout(set = 2, binding = 0) uniform accelerationStructureEXT topLevelAS;

void main()
{
  uint  rayFlags = 0;
  uint  cullMask = 0xFF;
  float tmin     = 0.0;
  float tmax     = 9.0;
  vec3  origin   = vec3((float(gl_LaunchIDEXT.x) + 0.5f) / float(gl_LaunchSizeEXT.x), (float(gl_LaunchIDEXT.y) + 0.5f) / float(gl_LaunchSizeEXT.y), 0.0);
  vec3  direct   = vec3(0.0, 0.0, -1.0);

  traceRayEXT(topLevelAS, rayFlags, cullMask, 0, 0, 0, origin, tmin, direct, tmax, 0);
}
#version 460

#extension GL_EXT_ray_tracing : require

layout(location = 0) rayPayloadInEXT vec3 hitValue;
hitAttributeEXT vec3 attribs;

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
