#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  int8_t data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i8vec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i8vec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i8vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<int8_t, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint8_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  uint8_t data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint8_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u8vec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u8vec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u8vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u8vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u8vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint8_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<uint8_t, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint8_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  int16_t data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i16vec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i16vec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i16vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<int16_t, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  uint16_t data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u16vec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u16vec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u16vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<uint16_t, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  int data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  ivec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  ivec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  ivec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  ivec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    ivec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<int, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  uint data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  uvec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  uvec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  uvec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<uint, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  int64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  int64_t data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    int64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i64vec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i64vec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  i64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  i64vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    i64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<int64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<int64_t, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<int64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  uint64_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  uint64_t data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    uint64_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u64vec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u64vec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  u64vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  u64vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    u64vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<uint64_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<uint64_t, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<uint64_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float16_t data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  float16_t data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float16_t op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  f16vec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  f16vec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  f16vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  f16vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    f16vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float16_t, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<float16_t, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float16_t, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  float data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  float data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    float op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<float, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<float, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<float, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  double data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  double data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    double op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  dvec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  dvec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  dvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  dvec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    dvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<double, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<double, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<double, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bool data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  bool data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bool op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec2 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  bvec2 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec2 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec3 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  bvec3 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec3 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  bvec4 data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  bvec4 data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    bvec4 op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(set = 0, binding = 0, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_VertexIndex] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  float pixelPosition = pixelSize/2.0f - 1.0f;
  gl_Position = vec4(float(gl_VertexIndex) * pixelSize + pixelPosition, 0.0f, 0.0f, 1.0f);
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices=1) out;
layout(set = 0, binding = 1, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID] = tempRes;
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines) in;
layout(set = 0, binding = 2, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveID * 2 + uint(gl_TessCoord.x + 0.5)] = tempRes;
  float pixelSize = 2.0f/1024.0f;
  gl_Position = gl_in[0].gl_Position + gl_TessCoord.x * pixelSize / 2.0f;
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(lines) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(set = 0, binding = 3, std430) buffer Buffer1
{
  uint result[];
};
layout(set = 0, binding = 4, std430) readonly buffer Buffer2
{
  vector<bool, 8> data[];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result[gl_PrimitiveIDIn] = tempRes;
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) out uint result;
layout(set = 0, binding = 4, std430) readonly buffer Buffer1
{
  vector<bool, 8> data[];
};
void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  uint sgSize = gl_SubgroupSize;
  uint sgInvocation = gl_SubgroupInvocationID;
  tempRes= 0x3;
  for (uint id = 0; id < sgSize; id++)
  {
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  // Test lane id that is only uniform across active lanes
  if (sgInvocation >= sgSize / 2)
  {
    uint id = sgInvocation & ~((sgSize / 2) - 1);
    vector<bool, 8> op = subgroupBroadcast(data[sgInvocation], id);
    if (subgroupBallotBitExtract(mask, id) && op != data[id])
        tempRes = 0;
  }
  result = tempRes;
}
