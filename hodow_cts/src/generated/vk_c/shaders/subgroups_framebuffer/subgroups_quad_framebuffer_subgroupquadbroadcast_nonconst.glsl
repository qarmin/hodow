#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  int8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  int8_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  int8_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int8_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int8_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint8_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint8_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint8_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint8_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u8vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u8vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint8_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint8_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int8 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint8_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint8_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  int16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  int16_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  int16_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int16_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int16_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint16_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint16_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint16_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint16_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  int data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  int data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  int data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  ivec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    ivec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  int64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  int64_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  int64_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  int64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    int64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  i64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    i64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int64_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int64_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<int64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<int64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint64_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  uint64_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  uint64_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    uint64_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  u64vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    u64vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint64_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint64_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_int64 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<uint64_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<uint64_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  float16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  float16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  float16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  float16_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  float16_t data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  float16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  float16_t data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float16_t op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  f16vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    f16vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float16_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float16_t, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
#extension GL_EXT_shader_subgroup_extended_types_float16 : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float16_t, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float16_t, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  float data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  float data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  float data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  float data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  float data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  float data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  float data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    float op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<float, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<float, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  double data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  double data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  double data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  double data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  double data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  double data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  double data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    double op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  dvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    dvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<double, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<double, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<double, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<double, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<double, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<double, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<double, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<double, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bool data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bool op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec2 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec2 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec2 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec3 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec3 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec3 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec4 data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  bvec4 data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    bvec4 op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(location = 0) in highp vec4 in_position;
layout(location = 0) out float result;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<bool, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  result = float(tempRes);
  gl_Position = in_position;
  gl_PointSize = 1.0f;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<bool, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(isolines, equal_spacing, ccw ) in;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<bool, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = mix(gl_in[0].gl_Position, gl_in[1].gl_Position, gl_TessCoord.x);
  gl_PointSize = gl_in[0].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<bool, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(vertices = 2) out;
layout(location = 0) out float out_color[];
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<bool, 8> data[128];
};

void main (void)
{
  if (gl_InvocationID == 0)
  {
    gl_TessLevelOuter[0] = 1.0f;
    gl_TessLevelOuter[1] = 1.0f;
  }
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color[gl_InvocationID] = float(tempRes);
  gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_PointSize = gl_in[gl_InvocationID].gl_PointSize;
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<bool, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  EmitVertex();
  EndPrimitive();
}
#version 450
#extension GL_KHR_shader_subgroup_quad: enable
#extension GL_KHR_shader_subgroup_ballot: enable
#extension GL_EXT_long_vector : enable
layout(points) in;
layout(points, max_vertices = 1) out;
layout(location = 0) out float out_color;
layout(set = 0, binding = 0) uniform Buffer1
{
  vector<bool, 8> data[128];
};

void main (void)
{
  uint tempRes;
  uvec4 mask = subgroupBallot(true);
  tempRes = 1;
  for (int i=0; i<4; i++)  {
  vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], i);
  uint otherID = (gl_SubgroupInvocationID & ~0x3) + i;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  uint quadID = gl_SubgroupInvocationID >> 2;
  uint quadInvocation = gl_SubgroupInvocationID & 0x3;
  // Test lane ID that is only uniform in active lanes
  if (quadInvocation >= 2)
  {
    uint id = quadInvocation & ~1;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  // Test lane ID that is only quad uniform, not subgroup uniform
  {
    uint id = quadID & 0x3;
    vector<bool, 8> op = subgroupQuadBroadcast(data[gl_SubgroupInvocationID], id);
    uint otherID = 4*quadID + id;
  if (subgroupBallotBitExtract(mask, otherID) && op !=data[otherID])
    tempRes = 0;
  }
  out_color = float(tempRes);
  gl_Position = gl_in[0].gl_Position;
  gl_PointSize = gl_in[0].gl_PointSize;
  EmitVertex();
  EndPrimitive();
}
