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
